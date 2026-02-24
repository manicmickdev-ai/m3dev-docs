# Configuration Debug & Package Conflict Analysis Guide

Troubleshooting guides for GPU model serving, package conflicts, and infrastructure issues on RunPod GPU pods. Based on real incidents debugged across M3Dev projects.

## Documents

| Guide | When to Use |
|-------|-------------|
| [model-routing-debug.md](model-routing-debug.md) | vLLM/llama.cpp model servers won't start, wrong model loads, routing issues through nginx |
| [package-conflict-analysis.md](package-conflict-analysis.md) | pip dependency hell, stale files after upgrades, torch/vLLM/xformers version matrix |
| [vram-budget-debug.md](vram-budget-debug.md) | OOM errors, KV cache failures, gpu-memory-utilization tuning |
| [runpod-environment-debug.md](runpod-environment-debug.md) | Base image conflicts, supervisord issues, persistence across pod restarts |

## Quick Diagnosis Flowchart

```
Service won't start
  ├── Check: supervisorctl status <service>
  │     ├── FATAL → Check stderr log (see model-routing-debug.md)
  │     ├── STARTING (stuck) → Likely OOM (see vram-budget-debug.md)
  │     └── RUNNING but endpoint fails → Check port/routing (see model-routing-debug.md)
  │
  ├── Check: tail -50 /workspace/logs/<service>/stderr.log
  │     ├── ImportError → Package conflict (see package-conflict-analysis.md)
  │     ├── "No available memory for cache blocks" → VRAM (see vram-budget-debug.md)
  │     ├── "Model architectures [...] failed to be inspected" → torch stale files (see package-conflict-analysis.md)
  │     └── "CUDA out of memory" → VRAM (see vram-budget-debug.md)
  │
  └── Check: nvidia-smi
        ├── GPU processes using unexpected VRAM → Kill orphans
        └── No GPU processes → Driver/CUDA issue (see runpod-environment-debug.md)
```
