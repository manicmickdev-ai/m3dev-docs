# Model Routing & Server Startup Debug Guide

## Scope

Diagnosing issues where model inference servers (vLLM, llama.cpp) fail to start, load the wrong model, or aren't reachable through nginx.

---

## 1. Service Won't Start (supervisord FATAL)

### Diagnosis

```bash
# Check service status
supervisorctl status <service>

# Check stderr for the actual error
tail -100 /workspace/logs/<service>/stderr.log

# Check stdout for startup info
tail -50 /workspace/logs/<service>/stdout.log
```

### Common Causes

#### A. Model Not Found

**Symptom**: `OSError: <model> is not a local folder and is not a valid model identifier`

**Fix**: Verify model is downloaded and HF_HOME points to it:
```bash
# Check model cache
ls $HF_HOME/hub/models--<org>--<model>/

# Re-download if missing
HF_HOME=/workspace/models huggingface-cli download <org>/<model>
```

#### B. Wrong vLLM Flags

**Symptom**: `error: unrecognized arguments: --task embed`

**Context**: vLLM flag names change between versions:
| Version | Embedding Flag | Notes |
|---------|---------------|-------|
| 0.10.x | `--task embed` | Old syntax |
| 0.14.x+ | `--convert embed` | New syntax |
| 0.15.x | `--convert embed` | Current |

**Fix**: Match the flag to your installed vLLM version:
```bash
python3 -c "import vllm; print(vllm.__version__)"
```

#### C. Architecture Not Supported

**Symptom**: `ValueError: Model architectures ['SomeModel'] are not supported`

**Fix**: Check if the model architecture is in vLLM's registry:
```bash
python3 -c "from vllm.model_executor.models import ModelRegistry; print(len(ModelRegistry.models))"
```

If the model isn't supported, you need a different serving engine or a newer vLLM version.

#### D. Model Inspection Subprocess Crash

**Symptom**: `Model architectures ['<name>'] failed to be inspected`

This is different from "not supported" — the model IS in the registry but the import subprocess crashes. This is almost always a **package conflict** issue. See [package-conflict-analysis.md](package-conflict-analysis.md).

---

## 2. Service Running But Endpoint Unreachable

### Diagnosis

```bash
# Is the port open?
curl -s http://localhost:<port>/v1/models

# Is something else on that port?
ss -tlnp | grep <port>

# Is the service bound to the right interface?
# Check the command — must be --host 0.0.0.0, not --host 127.0.0.1
supervisorctl status <service>
grep "command=" /etc/supervisor/conf.d/portfolio.conf | grep <service>
```

### Common Causes

#### A. Port Conflict

**Symptom**: `Address already in use`

```bash
# Find what's using the port
ss -tlnp | grep <port>
# or
fuser <port>/tcp

# Kill the conflicting process
kill $(fuser <port>/tcp 2>/dev/null)
```

#### B. Service Still Initializing

vLLM can take 30-120 seconds to start (model loading, CUDA graph capture). Check:
```bash
# Watch stdout for progress
tail -f /workspace/logs/<service>/stdout.log
# Look for: "Application startup complete" or "Uvicorn running on"
```

#### C. Bound to Wrong Interface

If the command uses `--host 127.0.0.1` instead of `--host 0.0.0.0`, the service is only reachable from localhost (fine for native deployment, but not for Docker networking).

---

## 3. nginx Routing Issues

### Diagnosis

```bash
# Test direct (bypass nginx)
curl -s http://localhost:8001/v1/models

# Test through nginx
curl -s http://localhost:8888/v1/embeddings \
  -H "Authorization: Bearer $AUTH_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"model":"ibm-granite/granite-embedding-english-r2","input":"test"}'

# Check nginx error log
tail -50 /var/log/nginx/error.log
```

### Common Causes

#### A. Auth Token Mismatch

**Symptom**: `{"error":"unauthorized"}` (HTTP 401)

```bash
# Check what token nginx expects
grep AUTH_TOKEN /etc/nginx/nginx.conf

# Compare with your .env
grep AUTH_TOKEN /workspace/upwork-portfolio/.env
```

If they differ, the bootstrap script may have regenerated the token. Re-run the nginx config step.

#### B. Upstream Not Substituted (Docker → Native)

**Symptom**: `connect() failed (111: Connection refused)` to `embedding-server:8001`

In native deployment, Docker service names don't resolve. The bootstrap script should replace them:
```bash
# Check nginx config for unsubstituted Docker hostnames
grep -E '(embedding-server|llama-server|docling-server|rag-app)' /etc/nginx/nginx.conf
# All should be 127.0.0.1, not Docker service names
```

#### C. map_hash_bucket_size

**Symptom**: `could not build map_hash_max_size`

```bash
# Add to http block in nginx.conf:
map_hash_bucket_size 128;
```

---

## 4. llama.cpp Specific Issues

### GGUF File Not Found

```bash
# Find the actual GGUF path (it's inside HF cache snapshot dirs)
find /workspace/models -name "*.gguf" -type f

# The path includes a snapshot hash:
# /workspace/models/hub/models--<org>--<model>/snapshots/<hash>/<file>.gguf
```

### Wrong CUDA Architecture

**Symptom**: `CUDA error: no kernel image is available for execution on the device`

```bash
# Check your GPU's compute capability
nvidia-smi --query-gpu=compute_cap --format=csv,noheader
# RTX A5000 = 8.6, RTX 4090 = 8.9, etc.

# Rebuild with correct architecture
cmake -B build -S . -DGGML_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES=86
cmake --build build --config Release -j$(nproc) -- llama-server
```

### Model Alias Issues

**Symptom**: `model '<name>' not found` in API calls

llama.cpp requires `--alias` to set the model name returned by the API:
```bash
llama-server --model <path>.gguf --alias ibm-granite/granite-4.0-h-tiny ...
```

---

## 5. Verification Checklist

Run this after any model routing fix:

```bash
echo "=== Service Status ==="
supervisorctl status

echo "=== Generation ==="
curl -s http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"ibm-granite/granite-4.0-h-tiny","messages":[{"role":"user","content":"Say hello"}],"max_tokens":10}' \
  | python3 -m json.tool

echo "=== Embedding ==="
curl -s http://localhost:8001/v1/embeddings \
  -H "Content-Type: application/json" \
  -d '{"model":"ibm-granite/granite-embedding-english-r2","input":"test"}' \
  | python3 -c "import json,sys; d=json.load(sys.stdin); print(f'dims={len(d[\"data\"][0][\"embedding\"])}')"

echo "=== Docling ==="
curl -s http://localhost:8002/v1/models | python3 -m json.tool

echo "=== nginx ==="
curl -s http://localhost:8888/health

echo "=== VRAM ==="
nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader
```
