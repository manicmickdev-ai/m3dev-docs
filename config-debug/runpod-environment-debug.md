# RunPod Environment Debug Guide

## Scope

Diagnosing issues specific to RunPod GPU pods: base image conflicts, supervisord lifecycle, persistence across restarts, and cold-start recovery.

---

## 1. Base Image Conflicts

### The Core Problem

RunPod base images ship with pre-installed Python packages (torch, transformers, etc.) at specific versions. When you install newer versions, pip overlays the new files but **does not remove orphaned files from the old installation**. This creates a hybrid environment where old and new code coexist.

### Identifying Your Base Image

```bash
# Check the base image tag
cat /etc/runpod/base_image 2>/dev/null || echo "No base image tag found"

# Check pre-installed torch version (the one from the base image)
# Look at file timestamps — old files have dates from the base image build
ls -la /usr/local/lib/python3.11/dist-packages/torch/version.py
# Compare with:
python3 -c "import torch; print(torch.__version__)"
```

### Common Base Image Issues

| Issue | Symptom | Fix |
|-------|---------|-----|
| Stale torch files | ImportError in torch._inductor | Delete orphaned files (see package-conflict-analysis.md) |
| Old CUDA toolkit | `CUDA error: invalid device function` | Use matching base image or install CUDA toolkit |
| Pre-installed transformers | Version conflicts with vLLM | `pip install --force-reinstall transformers` |
| System blinker package | `pip install` dependency resolution fails | `pip install --ignore-installed blinker` |

### Recommended Base Images

| Image | torch | CUDA | Python | Notes |
|-------|-------|------|--------|-------|
| `runpod/pytorch:2.9.1-py3.11-cuda12.8.0-devel-ubuntu22.04` | 2.9.1 | 12.8 | 3.11 | Best for vLLM 0.15.x |
| `runpod/pytorch:2.8.0-py3.11-cuda12.4.0-devel-ubuntu22.04` | 2.8.0 | 12.4 | 3.11 | For vLLM 0.14.x |

**Tip**: When creating a new pod, choose a base image whose torch version matches your target vLLM version. This eliminates stale file issues entirely.

---

## 2. supervisord Lifecycle

### Config Location

```
/etc/supervisor/supervisord.conf     # Main config
/etc/supervisor/conf.d/portfolio.conf # Our service definitions
```

### Common Commands

```bash
# Status of all services
supervisorctl status

# Restart a single service
supervisorctl restart embedding

# Stop all, then start specific ones
supervisorctl stop all
supervisorctl start generation embedding docling chromadb nginx

# Reload config after editing .conf files
supervisorctl reread   # Detect changes
supervisorctl update   # Apply changes (restarts affected services)

# Tail logs in real-time
supervisorctl tail -f embedding stderr
```

### Service States

| State | Meaning | Action |
|-------|---------|--------|
| RUNNING | Healthy, pid shown | Verify endpoint responds |
| STARTING | Initializing (within startsecs) | Wait — vLLM can take 30-120s |
| FATAL | Crashed, exceeded startretries | Check stderr log for root cause |
| STOPPED | Intentionally stopped or autostart=false | `supervisorctl start <name>` |
| BACKOFF | Crashing and retrying | Check stderr log, fix issue, then restart |

### STARTING But Never Reaches RUNNING

If a service stays in STARTING longer than `startsecs` (default 30s for vLLM services), it will be killed and retried. vLLM with CUDA graph capture can legitimately take 60-90 seconds.

**Fix**: Increase `startsecs` in the supervisor config:
```ini
[program:docling]
startsecs=90    # Allow 90 seconds for startup
startretries=3  # Try 3 times before giving up
```

### FATAL Loop

If a service hits `startretries` limit, it goes FATAL and stops retrying.

```bash
# Check what happened
tail -100 /workspace/logs/<service>/stderr.log

# After fixing the issue, clear the FATAL state
supervisorctl clear <service>
supervisorctl start <service>
```

### supervisord Itself Isn't Running

```bash
# Check if supervisord is alive
pgrep -x supervisord

# If not, start it
supervisord -c /etc/supervisor/supervisord.conf

# Wait, then load our config
sleep 2
supervisorctl reread
supervisorctl update
```

---

## 3. Persistence Across Pod Restarts

### What Survives a Pod Stop/Start

| Location | Persists? | Notes |
|----------|-----------|-------|
| `/workspace/` | YES | RunPod persistent volume |
| `/root/` | NO | Ephemeral — reset on restart |
| `/etc/` | NO | Config files must be regenerated |
| `/usr/local/lib/python3.11/dist-packages/` | NO | pip packages must be reinstalled |
| `/tmp/` | NO | Ephemeral |
| `/var/lib/postgresql/` | NO (default) | Must symlink to /workspace |

### What Must Be on /workspace

```
/workspace/
├── models/              # HF model cache (10+ GB, never re-download)
│   └── hub/
│       ├── models--ibm-granite--granite-4.0-h-tiny-GGUF/
│       ├── models--ibm-granite--granite-embedding-english-r2/
│       └── models--ibm-granite--granite-docling-258M/
├── data/
│   ├── postgres/        # PostgreSQL data directory
│   └── chromadb/        # ChromaDB index data
├── logs/                # Service logs (survives for debugging)
│   ├── generation/
│   ├── embedding/
│   ├── docling/
│   └── ...
├── llama.cpp/           # Built binary (avoid rebuilding)
│   └── build/bin/llama-server
└── upwork-portfolio/    # Git repo
    └── .env             # Generated secrets
```

### Cold-Start Recovery Checklist

After a pod restart, run this diagnostic:

```bash
echo "=== 1. Persistent Volume ==="
ls /workspace/ && echo "Volume: OK" || echo "Volume: MISSING"

echo "=== 2. Models ==="
ls /workspace/models/hub/ 2>/dev/null | wc -l
echo "model directories found"

echo "=== 3. llama.cpp Binary ==="
ls /workspace/llama.cpp/build/bin/llama-server 2>/dev/null && echo "Binary: OK" || echo "Binary: NEEDS REBUILD"

echo "=== 4. Git Repo ==="
git -C /workspace/upwork-portfolio log --oneline -1 2>/dev/null || echo "Repo: NEEDS CLONE"

echo "=== 5. .env ==="
ls /workspace/upwork-portfolio/.env 2>/dev/null && echo ".env: OK" || echo ".env: NEEDS GENERATION"

echo "=== 6. Python Packages ==="
python3 -c "import vllm; print(f'vllm: {vllm.__version__}')" 2>/dev/null || echo "vllm: NEEDS INSTALL"

echo "=== 7. PostgreSQL ==="
pg_isready -U postgres 2>/dev/null && echo "PostgreSQL: RUNNING" || echo "PostgreSQL: NEEDS START"

echo "=== 8. supervisord ==="
pgrep -x supervisord > /dev/null && echo "supervisord: RUNNING" || echo "supervisord: NEEDS START"
```

### Running bootstrap-native.sh After Restart

The bootstrap script is idempotent — safe to re-run:
- Skips model downloads if cached
- Skips llama.cpp build if binary exists
- Skips .env generation if file exists
- Skips PostgreSQL creation if database exists
- Always regenerates nginx config and supervisord config (they're ephemeral)

```bash
cd /workspace/upwork-portfolio
bash bootstrap-native.sh
```

---

## 4. Network & Port Issues on RunPod

### RunPod Proxy URLs

External access uses RunPod's proxy:
```
https://<pod-id>-<port>.proxy.runpod.net/
```

Example: `https://i6lc4457qgr642-8888.proxy.runpod.net/health`

### Port Exposure

RunPod only exposes ports you configure in the pod template. Default exposed ports:
- 8888 (Jupyter/custom)
- 22 (SSH)

If your service runs on a different port, either:
1. Route through nginx on :8888 (recommended)
2. Add the port to the pod template's exposed ports list

### SSH Access

```bash
# Standard SSH
ssh -i ~/.ssh/id_ed25519 <pod-id>-<session-id>@ssh.runpod.io

# With port forwarding (access remote services locally)
ssh -L 8001:localhost:8001 -i ~/.ssh/id_ed25519 <pod-id>-<session-id>@ssh.runpod.io
# Now curl http://localhost:8001/v1/models hits the pod
```

### SSH Heredoc Pattern

For running multiple commands in a single SSH session:
```bash
ssh -tt -i ~/.ssh/id_ed25519 <user>@ssh.runpod.io << 'CMDS'
supervisorctl status
nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader
exit
CMDS
```

**Important**: Use `<< 'CMDS'` (quoted) to prevent local shell expansion. Use `-tt` to force TTY allocation.

---

## 5. apt Lock Issues

### Symptom

```
E: Could not get lock /var/lib/dpkg/lock-frontend
```

RunPod pods often have background apt processes running at startup.

### Fix

```bash
# Wait for existing apt to finish (up to 2 minutes)
timeout 120 bash -c 'while fuser /var/lib/dpkg/lock-frontend > /dev/null 2>&1; do sleep 2; done'

# If that times out, force release (use with caution)
rm -f /var/lib/dpkg/lock-frontend
rm -f /var/lib/dpkg/lock
rm -f /var/cache/apt/archives/lock
dpkg --configure -a
```

---

## 6. GPU Driver Issues

### Check Driver Status

```bash
nvidia-smi
# Should show driver version, CUDA version, GPU model, temperature, memory

# If nvidia-smi fails:
ls /dev/nvidia*          # Check device nodes exist
cat /proc/driver/nvidia/version  # Check kernel module
```

### Common GPU Issues on RunPod

| Issue | Symptom | Fix |
|-------|---------|-----|
| Driver mismatch | `CUDA initialization: CUDA driver version is insufficient` | Use a base image matching the pod's driver |
| GPU not visible | `RuntimeError: No CUDA GPUs are available` | Check `CUDA_VISIBLE_DEVICES` isn't set wrong |
| GPU memory leak | Memory used but no processes shown | `nvidia-smi --gpu-reset` (kills everything) |
| ECC errors | Random CUDA errors, silent corruption | Check `nvidia-smi -q -d ECC` — request pod migration |

---

## 7. Full Environment Diagnostic Script

Save as `/workspace/scripts/diagnose-environment.sh`:

```bash
#!/bin/bash
echo "============================================"
echo "  RunPod Environment Diagnostic"
echo "  $(date)"
echo "============================================"

echo ""
echo "=== Pod Info ==="
echo "Hostname: ${RUNPOD_POD_HOSTNAME:-unknown}"
echo "GPU:      ${RUNPOD_GPU_NAME:-unknown}"

echo ""
echo "=== GPU ==="
nvidia-smi --query-gpu=name,driver_version,memory.used,memory.total,temperature.gpu --format=csv,noheader 2>/dev/null || echo "GPU: UNAVAILABLE"

echo ""
echo "=== GPU Processes ==="
nvidia-smi --query-compute-apps=pid,process_name,used_memory --format=csv,noheader 2>/dev/null || echo "No GPU processes"

echo ""
echo "=== Python Packages ==="
python3 -c "
import sys; print(f'Python: {sys.version}')
import torch; print(f'torch:  {torch.__version__} (CUDA: {torch.version.cuda})')
import vllm; print(f'vllm:   {vllm.__version__}')
" 2>/dev/null || echo "Package import FAILED"

echo ""
echo "=== Persistent Volume ==="
du -sh /workspace/models/ 2>/dev/null || echo "Models dir: MISSING"
du -sh /workspace/data/ 2>/dev/null || echo "Data dir: MISSING"

echo ""
echo "=== Services ==="
supervisorctl status 2>/dev/null || echo "supervisord: NOT RUNNING"

echo ""
echo "=== Endpoints ==="
for port in 8000 8001 8002 8010 8888; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$port/health 2>/dev/null || \
             curl -s -o /dev/null -w "%{http_code}" http://localhost:$port/v1/models 2>/dev/null || \
             echo "000")
    echo "  :$port → HTTP $STATUS"
done

echo ""
echo "=== Disk Usage ==="
df -h /workspace | tail -1
echo "============================================"
```
