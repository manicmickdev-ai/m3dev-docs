# Package Conflict Analysis Guide

## Scope

Diagnosing and resolving Python package conflicts on RunPod GPU pods, particularly between torch, vLLM, xformers, flashinfer, and CUDA libraries. Based on real incidents from the Granite model migration.

---

## 1. The #1 Problem: Stale Files After pip Upgrade

### What Happens

When pip installs a new version of a package (e.g., torch 2.9.1 over torch 2.5.0), it **only overwrites files that exist in the new wheel**. Files that were in the old version but removed in the new version **remain on disk**.

This is not a bug — it's how pip works. But it causes silent failures when old code references APIs that no longer exist.

### Real Example: torch._inductor.kernel.unpack_mixed_mm

**Timeline**:
1. RunPod base image ships with torch ~2.5 (Sept 2024 vintage)
2. `pip install vllm==0.15.1` pulls torch 2.9.1
3. torch 2.9.1 overwrites most files but `unpack_mixed_mm.py` was **deleted** in 2.9.1
4. The old `unpack_mixed_mm.py` remains, importing `mm_configs` and `mm_options` from `mm_common`
5. torch 2.9.1's `mm_common.py` only has `mm_grid` and `mm_args` — crash

**Import chain that triggers it**:
```
vLLM model inspection subprocess
  → importlib.import_module("modernbert")
  → attention layers → linear.py → utils.py → _aiter_ops.py
  → deep_gemm.py: @torch.compile(dynamic=True, ...)
  → torch._inductor.compile_fx
  → lowering.py dynamically imports all kernel submodules
  → imports STALE unpack_mixed_mm.py
  → ImportError: cannot import name 'mm_configs' from 'torch._inductor.kernel.mm_common'
```

### How to Detect Stale Files

```bash
# Check if a file belongs to the installed package
pip show -f torch | grep <filename>
# If empty → file is NOT part of the current installation = stale

# Find files older than the current installation
REFERENCE=$(pip show -f torch | grep "Location:" | awk '{print $2}')
find $REFERENCE/torch/_inductor/ -name "*.py" -not -newer $REFERENCE/torch/_inductor/kernel/mm_common.py

# Nuclear option: compare installed files vs actual files
pip show -f torch | tail -n +4 | sed 's/^ *//' > /tmp/expected_files.txt
find $REFERENCE/torch/ -name "*.py" -printf "%P\n" > /tmp/actual_files.txt
comm -13 <(sort /tmp/expected_files.txt) <(sort /tmp/actual_files.txt) | head -20
```

### How to Fix

```bash
# Delete the specific stale file
rm -f /usr/local/lib/python3.11/dist-packages/torch/_inductor/kernel/unpack_mixed_mm.py
rm -f /usr/local/lib/python3.11/dist-packages/torch/_inductor/kernel/__pycache__/unpack_mixed_mm.cpython-311.pyc

# Verify the fix
python3 -c "import torch._inductor; print('OK')"
python3 -c "from vllm.model_executor.models import ModelRegistry; print(f'{len(ModelRegistry.models)} models')"
```

### Prevention

Add stale file cleanup to your bootstrap script **after** pip installs:
```bash
pip install vllm==0.15.1
# Clean known stale files from RunPod base images
rm -f /usr/local/lib/python3.11/dist-packages/torch/_inductor/kernel/unpack_mixed_mm.py
rm -f /usr/local/lib/python3.11/dist-packages/torch/_inductor/kernel/__pycache__/unpack_mixed_mm.cpython-311.pyc
```

---

## 2. torch / vLLM / xformers / flashinfer Version Matrix

These four packages have tight coupling. Mismatched versions cause crashes.

### Known Working Combinations (as of Feb 2026)

| vLLM | torch | xformers | flashinfer | CUDA | Notes |
|------|-------|----------|------------|------|-------|
| 0.15.1 | 2.9.1+cu128 | 0.0.32.post1 | 0.6.1 | 12.8 | Current production. xformers warns about torch 2.8 but works. |
| 0.14.1 | 2.8.0 | 0.0.29.post3 | 0.2.3 | 12.4 | Previous stable. |
| 0.10.2 | 2.6.0 | 0.0.29 | — | 12.4 | Older. |

### How to Check Your Versions

```bash
python3 -c "
import torch; print(f'torch: {torch.__version__}')
import vllm; print(f'vllm: {vllm.__version__}')
try:
    import xformers; print(f'xformers: {xformers.__version__}')
except: print('xformers: not installed')
try:
    import flashinfer; print(f'flashinfer: {flashinfer.__version__}')
except: print('flashinfer: not installed')
print(f'CUDA: {torch.version.cuda}')
print(f'GPU available: {torch.cuda.is_available()}')
"
```

### Common Conflicts

#### torch / flashinfer ABI Mismatch

**Symptom**: `std::bad_alloc` or segfault on any vLLM operation

flashinfer is compiled against a specific torch ABI. If you change torch versions, flashinfer crashes.

```bash
# Check what torch version flashinfer was compiled for
python3 -c "import flashinfer; print(flashinfer.__version__)"
# If this crashes with std::bad_alloc → ABI mismatch

# Fix: reinstall flashinfer for your torch version
pip install flashinfer --force-reinstall --no-deps
# Or if that doesn't work, install from source
```

#### xformers / torch Version Warning

**Symptom**: `UserWarning: xformers requires torch==2.8.0 but found 2.9.1`

This is usually a **warning**, not an error. vLLM will fall back to other attention backends. Safe to ignore unless you see actual attention computation errors.

#### vLLM Import Pollution

**Symptom**: vLLM's pip install pulls in unexpected torch version

vLLM pins specific torch versions. If you install vLLM after torch, it may downgrade torch.

```bash
# Always install vLLM FIRST, then verify torch version
pip install vllm==0.15.1
python3 -c "import torch; print(torch.__version__)"
# If wrong, force-reinstall torch:
pip install torch==2.9.1 --force-reinstall --no-deps
```

---

## 3. Debugging Import Errors

### Strategy: Binary Search the Import Chain

When you see `ImportError` or `ModuleNotFoundError`, trace it:

```bash
# Start with the top-level import
python3 -c "import vllm"

# If that works, go deeper
python3 -c "from vllm.model_executor.models import ModelRegistry"

# If that works but the subprocess fails, test the subprocess directly
python3 -m vllm.model_executor.models.registry

# The subprocess may trigger different import paths (e.g., @torch.compile decorators)
```

### The Subprocess Problem

vLLM uses a **subprocess** to inspect model architectures. This subprocess runs in a fresh Python process that:
- Does NOT inherit `TORCH_COMPILE_DISABLE` from the parent (unless in `/etc/environment`)
- Does NOT respect `--enforce-eager` (that's an engine flag, not an import flag)
- DOES trigger `@torch.compile()` decorators during import

This is why fixes that work in interactive Python may fail when vLLM starts.

### Tracing the Full Import Chain

```bash
# Use Python's verbose import flag to see every import
python3 -v -c "from vllm.model_executor.models import ModelRegistry" 2>&1 | grep -i "error\|import"

# Or trace a specific module
python3 -c "
import importlib, traceback
try:
    importlib.import_module('torch._inductor.kernel.unpack_mixed_mm')
except Exception as e:
    traceback.print_exc()
"
```

---

## 4. Environment Variable Gotchas

### Variables That DON'T Propagate to Subprocesses

| Variable | Set In | Reaches Subprocess? |
|----------|--------|-------------------|
| `TORCH_COMPILE_DISABLE=1` | supervisord env | NO — vLLM's model inspection subprocess doesn't inherit it |
| `CUDA_VISIBLE_DEVICES` | supervisord env | YES |
| `HF_HOME` | supervisord env | YES |
| `VLLM_WORKER_MULTIPROC_METHOD` | supervisord env | YES |

**Why**: vLLM's model inspection subprocess is launched via `multiprocessing` with `spawn` method, which starts a fresh Python process. Environment variables ARE inherited, but `TORCH_COMPILE_DISABLE` only prevents explicit `torch.compile()` calls — it doesn't prevent the inductor from being imported when `@torch.compile` decorators are encountered during module loading.

### Setting System-Wide Environment Variables

```bash
# This works for ALL processes (but requires pod restart or new shells)
echo 'TORCH_COMPILE_DISABLE=1' >> /etc/environment

# This works for the current shell and children
export TORCH_COMPILE_DISABLE=1

# In supervisord config:
environment=KEY="value",KEY2="value2"
```

---

## 5. Quick Diagnosis Script

Save this as `/workspace/scripts/diagnose-packages.sh`:

```bash
#!/bin/bash
echo "=== Package Versions ==="
python3 -c "
import torch; print(f'torch:      {torch.__version__}')
import vllm; print(f'vllm:       {vllm.__version__}')
try:
    import xformers; print(f'xformers:   {xformers.__version__}')
except: print('xformers:   NOT INSTALLED')
try:
    import flashinfer; print(f'flashinfer: {flashinfer.__version__}')
except Exception as e: print(f'flashinfer: BROKEN ({e})')
print(f'CUDA:       {torch.version.cuda}')
print(f'GPU:        {torch.cuda.is_available()}')
"

echo ""
echo "=== Stale File Check ==="
TORCH_DIR=$(python3 -c "import torch; print(torch.__path__[0])")
echo "torch location: $TORCH_DIR"

# Check for known stale files
for f in "$TORCH_DIR/_inductor/kernel/unpack_mixed_mm.py"; do
    if [ -f "$f" ]; then
        echo "STALE: $f"
        pip show -f torch | grep "$(basename $f)" || echo "  (not in torch wheel = confirmed stale)"
    fi
done

echo ""
echo "=== vLLM Model Registry ==="
python3 -c "
try:
    from vllm.model_executor.models import ModelRegistry
    print(f'Model registry: {len(ModelRegistry.models)} architectures loaded')
except Exception as e:
    print(f'FAILED: {e}')
"

echo ""
echo "=== torch.compile Test ==="
python3 -c "
try:
    import torch._inductor
    print('torch._inductor: OK')
except Exception as e:
    print(f'torch._inductor: BROKEN ({e})')
"
```

---

## 6. Nuclear Options

When package conflicts are too deep to untangle:

### Option A: Clean pip reinstall

```bash
pip install --force-reinstall --no-deps torch==2.9.1
pip install --force-reinstall vllm==0.15.1
# Then clean stale files
find $(python3 -c "import torch; print(torch.__path__[0])") -name "*.py" | while read f; do
    pip show -f torch | grep -q "$(echo $f | sed 's|.*/torch/||')" || echo "ORPHAN: $f"
done
```

### Option B: Fresh pod from clean base image

Use `runpod/pytorch:2.9.1-py3.11-cuda12.8.0-devel-ubuntu22.04` as the base template. This eliminates ALL stale file issues from mixed torch installations. Then run `bootstrap-native.sh` from scratch.

### Option C: Virtual environment isolation

```bash
python3 -m venv /workspace/venv-vllm
source /workspace/venv-vllm/bin/activate
pip install vllm==0.15.1
# Clean environment, no base image contamination
```

This is heavier (downloads everything fresh) but guarantees no stale files.
