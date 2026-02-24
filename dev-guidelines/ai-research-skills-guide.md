# AI Research Skills Plugin Guide

> **Plugin:** `ai-research-skills@Orchestra-Research/AI-Research-SKILLs`
> **Scope:** User (global)
> **Category:** Specialized AI/ML Research Assistance

---

## Overview

The AI Research Skills plugin provides 14 specialized skill sets covering the complete AI/ML engineering stack — from model architecture and training to deployment, evaluation, and safety. Each skill acts as an expert consultant that activates contextually when you're working on related tasks.

This is the **most relevant plugin suite for M3Dev projects** given the AI infrastructure, ML model deployment, and GPU compute focus of the work.

---

## Installed Skills (14 Categories)

### 1. Inference Serving
**Activation:** When serving, deploying, or optimizing LLM inference

| Sub-skill | Purpose |
|-----------|---------|
| `vllm` | High-throughput LLM serving with PagedAttention and continuous batching |
| `sglang` | Structured generation with RadixAttention prefix caching |
| `tensorrt-llm` | NVIDIA TensorRT optimization for maximum throughput |
| `llama-cpp` | CPU/Apple Silicon/consumer GPU inference without NVIDIA hardware |

**M3Dev Relevance:** Critical for RunPod deployments and inference endpoint optimization.

---

### 2. RAG (Retrieval-Augmented Generation)
**Activation:** When building vector search, embeddings, or document retrieval systems

| Sub-skill | Purpose |
|-----------|---------|
| `chroma` | Open-source embedding database |
| `faiss` | Efficient similarity search and clustering |
| `pinecone` | Managed vector database for production |
| `qdrant` | High-performance vector similarity search engine |
| `sentence-transformers` | 5000+ pretrained models for embeddings |

---

### 3. Optimization
**Activation:** When quantizing models or reducing memory footprint

| Sub-skill | Purpose |
|-----------|---------|
| `awq` | Activation-aware 4-bit quantization (3x speedup) |
| `bitsandbytes` | 8-bit/4-bit quantization (50-75% memory reduction) |
| `flash-attention` | 2-4x attention speedup, 10-20x memory reduction |
| `gguf` | GGUF format for CPU/GPU inference via llama.cpp |
| `gptq` | Post-training 4-bit quantization |
| `hqq` | Half-Quadratic Quantization (no calibration data needed) |

**M3Dev Relevance:** Essential for running larger models on limited VRAM budgets on RunPod.

---

### 4. Fine-Tuning
**Activation:** When fine-tuning or adapting models to custom datasets

| Sub-skill | Purpose |
|-----------|---------|
| `axolotl` | YAML-based fine-tuning for 100+ models with LoRA/QLoRA |
| `llama-factory` | WebUI no-code fine-tuning platform |
| `peft` | LoRA, QLoRA, and 25+ parameter-efficient methods |
| `unsloth` | 2-5x faster training, 50-80% less memory |

---

### 5. Safety & Alignment
**Activation:** When implementing content filtering, guardrails, or safety systems

| Sub-skill | Purpose |
|-----------|---------|
| `constitutional-ai` | Anthropic's self-improvement training method |
| `llamaguard` | Meta's 7-8B moderation model (6 safety categories) |
| `nemo-guardrails` | NVIDIA runtime safety framework with jailbreak detection |
| `prompt-guard` | Meta's 86M prompt injection/jailbreak detector |

---

### 6. Model Architecture
**Activation:** When implementing custom architectures or training from scratch

| Sub-skill | Purpose |
|-----------|---------|
| `litgpt` | Lightning AI's LitGPT — 20+ pretrained architectures |
| `mamba` | State-space model with O(n) vs Transformer O(n²) complexity |
| `nanogpt` | Educational GPT in ~300 lines, reproduces GPT-2 |
| `rwkv` | RNN+Transformer hybrid with linear time, infinite context |
| `torchtitan` | PyTorch-native distributed pretraining with 4D parallelism |

---

### 7. Distributed Training
**Activation:** When training across multiple GPUs or nodes

| Sub-skill | Purpose |
|-----------|---------|
| `accelerate` | Simplest distributed training — 4 lines to add support |
| `deepspeed` | ZeRO optimization stages, pipeline parallelism |
| `megatron-core` | NVIDIA Megatron for 2B-462B parameter models |
| `pytorch-fsdp2` | PyTorch FSDP2 with correct init and mixed precision |
| `pytorch-lightning` | High-level Trainer with automatic DDP/FSDP |
| `ray-train` | Multi-cloud distributed training orchestration |

**M3Dev Relevance:** Key for multi-GPU RunPod cluster training jobs.

---

### 8. Evaluation
**Activation:** When benchmarking or evaluating model quality

| Sub-skill | Purpose |
|-----------|---------|
| `bigcode-evaluation-harness` | Code generation: HumanEval, MBPP, MultiPL-E, 15+ benchmarks |
| `lm-evaluation-harness` | 60+ academic benchmarks (MMLU, GSM8K, TruthfulQA) |
| `nemo-evaluator` | 100+ benchmarks from 18+ harnesses |

---

### 9. Multimodal
**Activation:** When working with vision, audio, or multi-modal AI systems

| Sub-skill | Purpose |
|-----------|---------|
| `audiocraft` | Text-to-music (MusicGen) and text-to-sound (AudioGen) |
| `blip-2` | Vision-language bridge between frozen image encoders and LLMs |
| `clip` | Zero-shot image classification and cross-modal retrieval |
| `llava` | Visual instruction tuning for image-based chat |
| `segment-anything` | Zero-shot image segmentation foundation model |
| `stable-diffusion` | Text-to-image generation via HuggingFace |
| `whisper` | 99-language speech recognition and transcription |

---

### 10. Prompt Engineering
**Activation:** When building structured LLM pipelines or optimizing prompts

| Sub-skill | Purpose |
|-----------|---------|
| `dspy` | Declarative AI systems with automatic prompt optimization |
| `guidance` | Control LLM output with regex/grammars, guarantee valid JSON |
| `instructor` | Pydantic-validated structured extraction with retry |
| `outlines` | Guaranteed JSON/XML/code structure during generation |

---

### 11. Agents
**Activation:** When building multi-agent systems or AI orchestration

| Sub-skill | Purpose |
|-----------|---------|
| `autogpt` | Autonomous agent platform for continuous agents |
| `crewai` | Multi-agent collaboration framework |
| `langchain` | LLM app framework with agents, chains, RAG |
| `llamaindex` | Data framework for RAG and document ingestion |

---

### 12. MLOps
**Activation:** When tracking experiments or managing model lifecycle

| Sub-skill | Purpose |
|-----------|---------|
| `mlflow` | Experiment tracking, model registry, deployment |
| `tensorboard` | Training visualization, debug histograms, comparison |
| `weights-and-biases` | Real-time experiment tracking and optimization |

---

### 13. Infrastructure
**Activation:** When provisioning cloud GPU resources for ML workloads

| Sub-skill | Purpose |
|-----------|---------|
| `lambda-labs` | Reserved/on-demand GPU cloud for ML training |
| `modal` | Serverless GPU cloud for ML workloads |
| `skypilot` | Multi-cloud orchestration with automatic cost optimization |

**M3Dev Relevance:** Directly relevant to RunPod infrastructure decisions.

---

### 14. Emerging Techniques
**Activation:** When exploring cutting-edge optimization methods

| Sub-skill | Purpose |
|-----------|---------|
| `knowledge-distillation` | Compress models from teacher to student |
| `long-context` | RoPE, YaRN, ALiBi for extending context windows |
| `model-merging` | Combine multiple fine-tuned models with mergekit |
| `model-pruning` | Wanda and SparseGPT for size reduction |
| `moe-training` | Mixture of Experts with DeepSpeed/HuggingFace |
| `speculative-decoding` | Medusa/lookahead for faster inference |

---

## How Skills Activate

Skills activate **automatically** based on context — no explicit invocation needed. When you say:
- "Set up vLLM for inference" → `inference-serving:vllm` activates
- "Quantize this model to 4-bit" → `optimization:awq` or `gptq` activates
- "Fine-tune on my dataset" → `fine-tuning:peft` activates

You can also invoke explicitly:
```
/inference-serving:vllm help me set up batching
/optimization:flash-attention optimize my attention layer
```

---

## M3Dev Priority Matrix

| Priority | Skills | Use Case |
|----------|--------|----------|
| **Critical** | `inference-serving`, `optimization` | RunPod production deployments |
| **High** | `distributed-training`, `fine-tuning` | Custom model training |
| **High** | `rag`, `agents` | AI application development |
| **Medium** | `mlops`, `evaluation` | Model quality and lifecycle |
| **Medium** | `prompt-engineering` | LLM pipeline optimization |
| **As-needed** | `safety-alignment`, `multimodal` | Specialized use cases |
| **Research** | `model-architecture`, `emerging-techniques` | Experimental work |

---

## Quick Reference

```bash
# Check which inference server to use for your GPU
/inference-serving:vllm "A100 80GB, need max throughput for Llama-3 70B"

# Quantize a model for smaller VRAM footprint
/optimization:awq "quantize mistral 7b to 4-bit"

# Set up LoRA fine-tuning
/fine-tuning:peft "add LoRA to my training script"

# Track experiments
/mlops:weights-and-biases "set up experiment tracking"
```
