# VRAM Budget & Memory Debug Guide

## Scope

Diagnosing and resolving GPU memory issues: OOM errors, KV cache allocation failures, and gpu-memory-utilization tuning for multi-model deployments on a single GPU.

---

## 1. Understanding gpu-memory-utilization

vLLM's `--gpu-memory-utilization` controls what **fraction of total GPU memory** vLLM will use. It does NOT mean "fraction of free memory."

```
Total VRAM:  24,564 MiB (RTX A5000)
--gpu-memory-utilization 0.05 → vLLM claims 1,228 MiB
--gpu-memory-utilization 0.10 → vLLM claims 2,456 MiB
--gpu-memory-utilization 0.90 → vLLM claims 22,108 MiB (default)
```

### The Math

vLLM allocates VRAM in this order:
1. **Model weights** — fixed cost, determined by model size and dtype
2. **Encoder cache** — for vision-language models (SigLIP, ViT, etc.)
3. **KV cache** — remaining budget after weights and encoder cache

```
KV cache memory = (gpu_memory_utilization * total_gpu_memory) - model_weights - encoder_cache - overhead
```

If KV cache memory goes negative → `ValueError: No available memory for the cache blocks`

---

## 2. Current VRAM Budget (Upwork Portfolio, RTX A5000 24GB)

| Service | Model | gpu-memory-util | Observed VRAM | Notes |
|---------|-------|-----------------|---------------|-------|
| Generation | granite-4.0-h-tiny Q8 (llama.cpp) | N/A | ~8 GB | llama.cpp manages its own memory |
| Embedding | granite-embedding-english-r2 (vLLM) | 0.02 | ~0.5 GB | Text-only, minimal KV cache |
| Docling | granite-docling-258M (vLLM) | 0.10 | ~2.5 GB | Vision encoder needs encoder cache |
| **Total** | | | **~12 GB** | **48% of 24GB** |

---

## 3. Diagnosing OOM / KV Cache Failures

### Symptom: "No available memory for the cache blocks"

```
ValueError: No available memory for the cache blocks.
Try increasing `gpu_memory_utilization` when initializing the engine.
```

### Step 1: Check actual VRAM usage

```bash
nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader
# Also check per-process:
nvidia-smi --query-compute-apps=pid,used_memory --format=csv,noheader
```

### Step 2: Check what vLLM reports

Look in the stdout log for:
```
Available KV cache memory: X.XX GiB
```

If this is negative, the model weights + encoder cache exceed the gpu-memory-utilization budget.

### Step 3: Check model memory in logs

```
Model loading took X.XX GiB memory and Y.YY seconds
Encoder cache will be initialized with a budget of N tokens
```

### Resolution Decision Tree

```
KV cache memory negative?
├── YES → Is it a vision-language model (Idefics3, LLaVA, etc.)?
│   ├── YES → Increase gpu-memory-utilization (0.05 → 0.10 or higher)
│   │         Vision encoders need encoder cache that eats into the budget
│   └── NO  → Model weights exceed the utilization budget
│             Increase gpu-memory-utilization or reduce max-model-len
│
└── NO (positive but small) → Reduce max-model-len to free KV cache
    Current: --max-model-len 4096 → try 2048 or 1024
```

---

## 4. Tuning gpu-memory-utilization for Multi-Model Setups

### Golden Rule

When running multiple models on one GPU, each vLLM instance should use the **minimum** `gpu-memory-utilization` that allows the model to start with enough KV cache for your workload.

### Calculation Approach

```
Step 1: Identify fixed costs
  - llama.cpp generation model: check nvidia-smi after it starts
  - CUDA context overhead: ~300-500 MiB per process

Step 2: For each vLLM instance:
  a. Start with model_size_gb / total_gpu_gb as the minimum
  b. Add 20-50% for KV cache
  c. Add 50-100% for vision encoders (if applicable)

Step 3: Verify total doesn't exceed 90% of GPU
  sum(all gpu-memory-utilization) + llama.cpp fraction < 0.90
```

### Example for RTX A5000 (24GB)

```
llama.cpp: ~8 GB = 33% of 24GB
Embedding: 0.02 (0.5GB) — text-only, tiny model
Docling:   0.10 (2.4GB) — vision encoder needs cache
                          Model: 0.49GB + encoder cache + KV

Total claimed: 33% + 2% + 10% = 45%
Actual used:   ~12GB / 24GB = 50%
Headroom:      ~12GB free for P1-P4 apps, future models
```

---

## 5. Vision-Language Models Need Special Attention

Models with vision encoders (Idefics3, LLaVA, Qwen-VL, etc.) have an additional memory cost that pure text models don't: **encoder cache**.

### How Encoder Cache Works

```
vLLM startup:
1. Load model weights → X GiB
2. Profile encoder cache → "Encoder cache will be initialized with a budget of N tokens,
                            and profiled with M image items of the maximum feature size"
3. Allocate KV cache from remaining budget
```

The encoder cache profiling actually runs a forward pass through the vision encoder with maximum-size images. This temporarily allocates GPU memory that must fit within the gpu-memory-utilization budget.

### Docling 258M Specifics

- Model weights: ~0.49 GiB
- Encoder cache profiling: ~1.0 GiB (SigLIP vision encoder)
- Minimum KV cache: ~0.1 GiB
- **Minimum gpu-memory-utilization: 0.07** (on 24GB GPU with no other processes)
- **Recommended: 0.10** (with generation model using ~8GB)

---

## 6. llama.cpp Memory Management

llama.cpp does NOT use `gpu-memory-utilization`. It loads layers to GPU based on `--n-gpu-layers`:

```bash
# Full GPU offload (all layers)
llama-server --n-gpu-layers 99 ...

# Check actual memory after loading
nvidia-smi --query-compute-apps=pid,used_memory --format=csv,noheader
```

### Context Size Impact

```bash
# --ctx-size controls maximum context window
# Larger = more VRAM for KV cache
--ctx-size 32768  # ~2-3 GB for a 7B model
--ctx-size 8192   # ~0.5-1 GB for a 7B model
```

If you need to free VRAM for other services, reduce `--ctx-size`.

---

## 7. Quick Diagnosis Script

```bash
#!/bin/bash
echo "=== GPU Memory ==="
nvidia-smi --query-gpu=memory.used,memory.total,memory.free --format=csv,noheader

echo ""
echo "=== Per-Process GPU Memory ==="
nvidia-smi --query-compute-apps=pid,process_name,used_memory --format=csv,noheader

echo ""
echo "=== Service Status ==="
supervisorctl status | grep -E "(RUNNING|FATAL|STARTING)"

echo ""
echo "=== KV Cache Reports (from logs) ==="
for svc in embedding docling; do
    echo "--- $svc ---"
    grep -i "available kv cache\|model loading took\|encoder cache" /workspace/logs/$svc/stdout.log 2>/dev/null | tail -3
done
```

---

## 8. Emergency VRAM Recovery

When a crashed process leaves GPU memory allocated:

```bash
# Find orphaned GPU processes
nvidia-smi --query-compute-apps=pid,process_name,used_memory --format=csv,noheader

# Kill orphans (be careful not to kill running services)
supervisorctl stop all
# Wait for GPU memory to release
sleep 5
nvidia-smi --query-gpu=memory.used --format=csv,noheader
# Should be near 0

# Restart services
supervisorctl start generation embedding docling chromadb nginx
```

If memory doesn't release after stopping all processes:
```bash
# Nuclear: reset the GPU
nvidia-smi --gpu-reset
# WARNING: This kills ALL GPU processes
```
