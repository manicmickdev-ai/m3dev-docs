# M3Dev Claude Plugin Ecosystem Report

**Date**: 2026-02-24
**Author**: Claude Code (Opus 4.6)
**Scope**: Full plugin inventory analysis, configuration, and team replicability assessment

---

## Executive Summary

This report documents the complete Claude Code plugin ecosystem configured for M3Dev development operations. The stack was built to support a **Sovereign Enterprise RAG SaaS platform** (FastAPI + Next.js + PostgreSQL/pgvector + vLLM), an **educational React SPA** (Credit Consulting), and a **4-project GPU portfolio** (Upwork), with a design goal of replicability when onboarding additional staff.

**Final Configuration**: 50 plugins across 5 marketplaces, organized into 4 functional tiers.

---

## Table of Contents

1. [Plugin Inventory](#plugin-inventory)
2. [Marketplace Configuration](#marketplace-configuration)
3. [Tier 1: Foundation (Official Plugins)](#tier-1-foundation)
4. [Tier 2: AI/ML Research Skills](#tier-2-aiml-research-skills)
5. [Tier 3: Specialized Subagents](#tier-3-specialized-subagents)
6. [Tier 4: Design & Planning](#tier-4-design--planning)
7. [Evaluated & Declined Plugins](#evaluated--declined-plugins)
8. [Project Relevance Matrix](#project-relevance-matrix)
9. [Development Lifecycle Coverage](#development-lifecycle-coverage)
10. [Team Onboarding Playbook](#team-onboarding-playbook)
11. [Risk Assessment](#risk-assessment)
12. [Maintenance Schedule](#maintenance-schedule)

---

## Plugin Inventory

### By the Numbers

| Metric | Count |
|--------|-------|
| Total plugins installed | 50 |
| Marketplaces configured | 5 |
| Official (anthropics) plugins | 28 |
| AI Research Skills plugins | 14 |
| VoltAgent Subagent plugins | 6 |
| UI/UX Design plugins | 1 |
| Planning plugins | 1 |

### Complete Plugin List

| # | Plugin | Marketplace | Version | Purpose |
|---|--------|-------------|---------|---------|
| 1 | agent-sdk-dev | claude-plugins-official | 99e11d959269 | Claude Agent SDK development |
| 2 | atlassian | claude-plugins-official | 63e369036b13 | Jira/Confluence integration |
| 3 | claude-code-setup | claude-plugins-official | 1.0.0 | Automation recommendations |
| 4 | claude-md-management | claude-plugins-official | 1.0.0 | CLAUDE.md file management |
| 5 | code-review | claude-plugins-official | 99e11d959269 | 5-agent parallel code review |
| 6 | code-simplifier | claude-plugins-official | 1.0.0 | Code clarity refinement |
| 7 | commit-commands | claude-plugins-official | 99e11d959269 | Git commit/push/PR workflows |
| 8 | context7 | claude-plugins-official | 99e11d959269 | Live documentation retrieval |
| 9 | feature-dev | claude-plugins-official | 99e11d959269 | 7-phase feature development |
| 10 | frontend-design | claude-plugins-official | 99e11d959269 | Frontend UI generation |
| 11 | github | claude-plugins-official | 99e11d959269 | GitHub MCP integration |
| 12 | greptile | claude-plugins-official | 99e11d959269 | Codebase-aware PR review |
| 13 | hookify | claude-plugins-official | 99e11d959269 | Custom hook creation |
| 14 | huggingface-skills | claude-plugins-official | 1.0.0 | HuggingFace Hub operations |
| 15 | learning-output-style | claude-plugins-official | 99e11d959269 | Educational output mode |
| 16 | linear | claude-plugins-official | 99e11d959269 | Linear project management |
| 17 | playwright | claude-plugins-official | 99e11d959269 | Browser automation/testing |
| 18 | plugin-dev | claude-plugins-official | 99e11d959269 | Plugin creation toolkit |
| 19 | pr-review-toolkit | claude-plugins-official | 99e11d959269 | 6-agent PR review suite |
| 20 | pyright-lsp | claude-plugins-official | 1.0.0 | Python type checking LSP |
| 21 | ralph-loop | claude-plugins-official | 99e11d959269 | Autonomous iteration loops |
| 22 | security-guidance | claude-plugins-official | 99e11d959269 | 9-pattern security monitoring |
| 23 | sentry | claude-plugins-official | 1.0.0 | Error tracking integration |
| 24 | serena | claude-plugins-official | 99e11d959269 | Language server protocol |
| 25 | supabase | claude-plugins-official | 99e11d959269 | Supabase database integration |
| 26 | superpowers | claude-plugins-official | 4.3.1 | TDD, planning, subagent orchestration |
| 27 | typescript-lsp | claude-plugins-official | 1.0.0 | TypeScript type checking LSP |
| 28 | vercel | claude-plugins-official | 1.0.0 | Vercel deployment |
| 29 | agents | ai-research-skills | 8a14d269df6f | LangChain, LlamaIndex, CrewAI |
| 30 | distributed-training | ai-research-skills | 8a14d269df6f | DeepSpeed, FSDP, Megatron-Core |
| 31 | emerging-techniques | ai-research-skills | 8a14d269df6f | Distillation, MoE, pruning |
| 32 | evaluation | ai-research-skills | 8a14d269df6f | lm-evaluation-harness, benchmarks |
| 33 | fine-tuning | ai-research-skills | 8a14d269df6f | Axolotl, LLaMA-Factory, PEFT |
| 34 | inference-serving | ai-research-skills | 8a14d269df6f | vLLM, TensorRT-LLM, llama.cpp, SGLang |
| 35 | infrastructure | ai-research-skills | 8a14d269df6f | Modal, Lambda Labs, SkyPilot |
| 36 | mlops | ai-research-skills | 8a14d269df6f | W&B, MLflow, TensorBoard |
| 37 | model-architecture | ai-research-skills | 8a14d269df6f | LitGPT, Mamba, NanoGPT |
| 38 | multimodal | ai-research-skills | 8a14d269df6f | CLIP, Whisper, LLaVA, Stable Diffusion |
| 39 | optimization | ai-research-skills | 8a14d269df6f | Flash Attention, GPTQ, AWQ, GGUF |
| 40 | prompt-engineering | ai-research-skills | 8a14d269df6f | DSPy, Instructor, Guidance |
| 41 | rag | ai-research-skills | 8a14d269df6f | ChromaDB, FAISS, Pinecone, Qdrant |
| 42 | safety-alignment | ai-research-skills | 8a14d269df6f | LlamaGuard, NeMo Guardrails |
| 43 | voltagent-core-dev | voltagent-subagents | 1.0.1 | Backend/frontend/fullstack agents |
| 44 | voltagent-data-ai | voltagent-subagents | 1.0.1 | Data/ML/LLM specialist agents |
| 45 | voltagent-dev-exp | voltagent-subagents | 1.0.1 | CLI, docs, DX optimization agents |
| 46 | voltagent-infra | voltagent-subagents | 1.0.1 | K8s, Docker, Terraform, cloud agents |
| 47 | voltagent-lang | voltagent-subagents | 1.0.1 | Python, TypeScript, Go, Rust agents |
| 48 | voltagent-qa-sec | voltagent-subagents | 1.0.1 | Security, testing, QA agents |
| 49 | ui-ux-pro-max | ui-ux-pro-max-skill | 2.0.1 | 67 styles, 96 palettes, design intelligence |
| 50 | planning-with-files | planning-with-files | 2.11.0 | Persistent markdown-based planning |

---

## Marketplace Configuration

### Configured Marketplaces

| Marketplace ID | Source | Plugins Available | Plugins Installed |
|---------------|--------|-------------------|-------------------|
| claude-plugins-official | anthropics/claude-code | 31 | 28 |
| ai-research-skills | Orchestra-Research/AI-Research-SKILLs | 21 | 14 |
| voltagent-subagents | VoltAgent/awesome-claude-code-subagents | 10 | 6 |
| ui-ux-pro-max-skill | nextlevelbuilder/ui-ux-pro-max-skill | 1 | 1 |
| planning-with-files | OthmanAdi/planning-with-files | 1 | 1 |

### Not-Installed from Available Marketplaces

These plugins are available but were intentionally not installed:

**AI Research Skills (7 not installed)**:
- `tokenization` — HuggingFace Tokenizers. Low priority; tokenization is handled by model serving layer.
- `data-processing` — NeMo Curator, Ray Data. Not relevant to current data pipeline (PostgreSQL + pgvector).
- `post-training` — TRL, GRPO. Could be installed later for IBM Granite customization.
- `observability` — LangSmith, Phoenix. Already have Prometheus/Grafana/Sentry.
- `ml-paper-writing` — LaTeX templates. Not needed for current business focus.
- `ideation` — Research brainstorming. Superpowers brainstorming skill covers this.
- `mechanistic-interpretability` — TransformerLens, SAELens. Niche research focus not aligned with SaaS product.

**VoltAgent Subagents (4 not installed)**:
- `voltagent-domains` — Blockchain, IoT, gaming. Not relevant to M3Dev stack.
- `voltagent-biz` — Product management, scrum. Covered by existing planning workflow.
- `voltagent-meta` — Multi-agent orchestration. Superpowers subagent dispatch handles this.
- `voltagent-research` — Market research, trend forecasting. Not a development need.

---

## Tier 1: Foundation (Official Plugins)

These 28 plugins form the base development platform. Every developer must have these enabled.

### Core Workflow

| Plugin | Role in Cycle | Key Commands/Skills |
|--------|---------------|---------------------|
| **superpowers** | Workflow discipline | `/brainstorming`, `/writing-plans`, `/executing-plans`, `/subagent-driven-development`, `/test-driven-development`, `/systematic-debugging`, `/verification-before-completion` |
| **feature-dev** | Feature development | `/feature-dev` — 7-phase guided development |
| **code-review** | Quality assurance | `/code-review` — 5 parallel Sonnet agents |
| **pr-review-toolkit** | PR validation | `/review-pr` — type design, comments, silent failures, test coverage, code quality, simplification |
| **commit-commands** | Git operations | `/commit`, `/commit-push-pr`, `/clean_gone` |
| **code-simplifier** | Refactoring | Auto-triggered after code changes |
| **ralph-loop** | Autonomous iteration | `/ralph-loop` — continuous autonomous development |

### Code Intelligence

| Plugin | Role | M3Dev Relevance |
|--------|------|-----------------|
| **context7** | Live documentation | Next.js 16 + React 19 + FastAPI — all fast-moving frameworks |
| **pyright-lsp** | Python type checking | Backend: FastAPI + SQLAlchemy type enforcement |
| **typescript-lsp** | TypeScript checking | Frontend: Next.js strict mode |
| **serena** | Language server | Cross-language code intelligence |

### Integrations

| Plugin | Service | M3Dev Relevance |
|--------|---------|-----------------|
| **github** | GitHub MCP | Main repo: manicmickdev-ai/m3dev_ecosystem |
| **greptile** | Codebase-aware review | PR reviews with repo context |
| **sentry** | Error tracking | Production error monitoring |
| **vercel** | Deployment | Credit Consulting deployment target |
| **supabase** | Database | Potential future migration target |
| **atlassian** | Jira/Confluence | Client project management |
| **linear** | Project management | Alternative to Jira for internal projects |
| **playwright** | Browser automation | E2E testing for frontend |
| **huggingface-skills** | HuggingFace Hub | Model management, dataset operations |

### Development Support

| Plugin | Role |
|--------|------|
| **security-guidance** | Monitors 9 security patterns (OWASP top 10) |
| **hookify** | Custom hook creation for workflow enforcement |
| **claude-md-management** | CLAUDE.md auditing and improvement |
| **claude-code-setup** | Automation recommendations |
| **plugin-dev** | 8-phase plugin creation toolkit |
| **agent-sdk-dev** | Claude Agent SDK development |
| **learning-output-style** | Educational output mode |
| **frontend-design** | Generic frontend UI generation |

---

## Tier 2: AI/ML Research Skills

These 14 plugins provide deep domain knowledge for the AI/ML infrastructure that powers M3Dev.

### Direct Stack Relevance

| Plugin | Skills | Why It Matters |
|--------|--------|----------------|
| **inference-serving** | vLLM, TensorRT-LLM, llama.cpp, SGLang | M3Dev runs 8 Granite models on vLLM. Direct production expertise. |
| **rag** | ChromaDB, FAISS, Pinecone, Qdrant, Sentence Transformers | Core product: RAG-as-a-Service with pgvector embeddings. Upwork P1 uses ChromaDB. |
| **optimization** | Flash Attention, bitsandbytes, GPTQ, AWQ, GGUF, HQQ | GPU memory management on RTX PRO 4500 (32GB) and RTX A5000 (24GB). |
| **safety-alignment** | LlamaGuard, NeMo Guardrails, Prompt Guard | M3Dev runs IBM Granite Guardian 3.3-8B for content safety. |
| **agents** | LangChain, LlamaIndex, CrewAI, AutoGPT | Upwork P1 uses LlamaIndex. BeeAI framework integration planned. |

### Infrastructure & Training

| Plugin | Skills | Why It Matters |
|--------|--------|----------------|
| **fine-tuning** | Axolotl, LLaMA-Factory, PEFT, Unsloth | Future: custom Granite model fine-tuning for regulated industries. |
| **distributed-training** | DeepSpeed, FSDP, Accelerate, Megatron-Core | Multi-GPU training when scaling beyond single pod. |
| **model-architecture** | LitGPT, Mamba, NanoGPT | Understanding model internals for optimization decisions. |
| **infrastructure** | Modal, Lambda Labs, SkyPilot | Alternatives to RunPod for GPU compute cost optimization. |

### Evaluation & Operations

| Plugin | Skills | Why It Matters |
|--------|--------|----------------|
| **evaluation** | lm-evaluation-harness, benchmarks | Validating model quality for Tier 1/Tier 2 SLAs. |
| **mlops** | W&B, MLflow, TensorBoard | Training experiment tracking and model versioning. |
| **prompt-engineering** | DSPy, Instructor, Guidance, Outlines | Structured output generation for RAG responses. |
| **multimodal** | CLIP, Whisper, LLaVA, Stable Diffusion | Upwork P4 (multimodal pipeline). Vision 3.3-2B integration. |
| **emerging-techniques** | Knowledge distillation, MoE, speculative decoding | Future optimizations for cost reduction and latency. |

---

## Tier 3: Specialized Subagents

These 6 VoltAgent plugins provide 70+ domain-specific subagents that operate in isolated context windows.

| Plugin | Agent Count | Key Agents | M3Dev Relevance |
|--------|------------|------------|-----------------|
| **voltagent-core-dev** | ~12 | backend-developer, frontend-developer, fullstack-developer, api-designer | Core development for both backend (FastAPI) and frontend (Next.js) |
| **voltagent-lang** | ~27 | python-pro, typescript-pro, golang-pro, rust-engineer | Python 3.11 backend, TypeScript frontend. Go/Rust for future services. |
| **voltagent-infra** | ~16 | kubernetes-specialist, docker-expert, terraform-engineer, devops-engineer | K8s/Helm deployment, Docker Compose orchestration, RunPod management |
| **voltagent-qa-sec** | ~14 | security-auditor, penetration-tester, code-reviewer, qa-expert | CI/CD security pipeline (TruffleHog, Bandit, Trivy). Multi-tenant RLS audit. |
| **voltagent-data-ai** | ~12 | data-engineer, ML-engineer, LLM-architect, MLOps-specialist | pgvector pipeline, vLLM model management, embedding optimization |
| **voltagent-dev-exp** | ~13 | documentation-writer, CLI-tool-builder, DX-optimizer | Makefile tooling, CLAUDE.md management, developer onboarding |

### Usage Pattern

Subagents are invoked via the Task tool when domain expertise is needed:
```
Task(subagent_type="voltagent-infra:kubernetes-specialist", prompt="...")
```

They run in isolated context windows — no risk of polluting the main conversation with domain-specific token overhead.

---

## Tier 4: Design & Planning

### ui-ux-pro-max (v2.0.1)

**Command**: `/ui-ux-pro-max [request]`

| Capability | Details |
|-----------|---------|
| UI Styles | 67 styles including Glassmorphism (Credit Consulting theme) |
| Color Palettes | 96 industry-specific — SaaS, Healthcare, Finance, Legal (all M3Dev target verticals) |
| Font Pairings | 57 with Google Fonts integration |
| Chart Types | 25 for dashboards (M3Dev admin dashboard, Credit Consulting interactive charts) |
| Frameworks | React, Next.js, Tailwind, shadcn/ui, Radix UI — exact M3Dev stack |
| Design Rules | 100 industry-specific + 99 UX/accessibility guidelines |

**M3Dev Relevance**: Directly applicable to:
- M3Dev marketing pages (industry-specific palettes for Legal/Healthcare/Defense/Finance)
- Admin dashboard redesign (chart types, SaaS design patterns)
- Credit Consulting UI polish (glassmorphism, educational design patterns)
- Upwork portfolio demos (professional presentation quality)

### planning-with-files (v2.11.0)

**Commands**: `/plan`, `/status`, `/planning` (or `/start`)

| Feature | Details |
|---------|---------|
| Planning Files | `task_plan.md`, `findings.md`, `progress.md` |
| Hooks | PreToolUse (re-reads plan), Stop (verifies completion), PostToolUse (maintains focus) |
| Recovery | Automatic session recovery from context clears |

**M3Dev Relevance**: Complements Superpowers' inter-session planning with intra-session focus discipline. The hook-driven re-reading of plans before major decisions prevents goal drift during long sessions — particularly valuable for M3Dev's complex multi-service architecture.

---

## Evaluated & Declined Plugins

These plugins were analyzed and deliberately excluded from the stack.

| Plugin | Repo | Reason for Exclusion |
|--------|------|---------------------|
| **everything-claude-code** | affaan-m/everything-claude-code | Skill name collisions with Superpowers (both define `brainstorming`, `writing-plans`, `code-review`). Running both causes unpredictable skill resolution. |
| **claude-task-master** | eyaltoledano/claude-task-master | MIT + Commons Clause restricts commercial resale. Superpowers planning + built-in TaskCreate/TaskUpdate covers same ground. |
| **claude-mem** | thedotmack/claude-mem | AGPL-3.0 license restricts derivative works. Heavy SQLite + ChromaDB dependency. Potential conflicts with built-in auto-memory. |
| **claude-code-templates** | davila7/claude-code-templates | Template configs would fight existing 56+ commit conventions (Conventional Commits, ruff/black/mypy, specific Makefile targets). |
| **claude-flow** | ruvnet/claude-flow | 503 open issues. Full orchestration platform is overkill. Performance claims need verification. Superpowers handles multi-agent well. |
| **agent-browser** | vercel-labs/agent-browser | Redundant with installed Playwright plugin. Only 6 weeks old with 226 open issues. |
| **daily.dev** | dailydotdev/daily | Not a Claude Code plugin. Standalone browser extension for developer news. |
| **composio-skills** | ComposioHQ/awesome-claude-skills | External API dependency. Most relevant integrations (GitHub, Jira, Sentry) already covered by official plugins. Revisit when scaling. |
| **wshobson/agents** | wshobson/agents | 72-plugin marketplace is too broad. VoltAgent subagents provide better focused coverage with less token overhead. |

---

## Project Relevance Matrix

How each plugin tier maps to active projects:

| Plugin | M3Dev Ecosystem | Credit Consulting | Upwork Portfolio | Client Work |
|--------|:-:|:-:|:-:|:-:|
| **Tier 1: Superpowers** | High | High | High | High |
| **Tier 1: Code Review** | High | Medium | Medium | High |
| **Tier 1: Context7** | High | Medium | Medium | Medium |
| **Tier 1: Security** | High | Low | Medium | High |
| **Tier 1: Vercel** | Low | High | Low | Medium |
| **Tier 1: Playwright** | Medium | High | Low | Medium |
| **Tier 1: HuggingFace** | High | Low | High | Low |
| **Tier 2: inference-serving** | High | — | High | — |
| **Tier 2: rag** | High | — | High (P1) | — |
| **Tier 2: optimization** | High | — | High | — |
| **Tier 2: safety-alignment** | High | — | Low | — |
| **Tier 2: fine-tuning** | Medium | — | Low | — |
| **Tier 2: multimodal** | Medium | — | High (P4) | — |
| **Tier 3: voltagent-infra** | High | Low | Medium | Medium |
| **Tier 3: voltagent-lang** | High | Medium | High | High |
| **Tier 3: voltagent-qa-sec** | High | Medium | Medium | High |
| **Tier 3: voltagent-core-dev** | High | Medium | High | High |
| **Tier 4: ui-ux-pro-max** | High | High | Medium | Medium |
| **Tier 4: planning-with-files** | High | Medium | High | Medium |

---

## Development Lifecycle Coverage

How the plugin stack covers each phase of the M3Dev development lifecycle:

### 1. Planning & Design
| Phase | Plugin(s) | How |
|-------|-----------|-----|
| Requirements gathering | superpowers (`/brainstorming`) | Socratic design conversations before coding |
| Task decomposition | superpowers (`/writing-plans`) | Structured implementation plans |
| Session focus | planning-with-files (`/plan`, `/planning`) | Hook-driven plan re-reading |
| UI/UX design | ui-ux-pro-max (`/ui-ux-pro-max`) | Industry-specific design guidance |
| Architecture review | voltagent-core-dev (api-designer) | API contract design, data flow |

### 2. Implementation
| Phase | Plugin(s) | How |
|-------|-----------|-----|
| Feature development | feature-dev (`/feature-dev`) | 7-phase guided implementation |
| TDD workflow | superpowers (`/test-driven-development`) | RED-GREEN-REFACTOR cycles |
| Parallel execution | superpowers (`/subagent-driven-development`) | Multi-agent task dispatch |
| Autonomous iteration | ralph-loop (`/ralph-loop`) | Continuous development loop |
| Live docs | context7 | Current API docs for Next.js, FastAPI, SQLAlchemy |
| Type safety | pyright-lsp, typescript-lsp | Real-time type checking |

### 3. AI/ML Development
| Phase | Plugin(s) | How |
|-------|-----------|-----|
| Model serving | inference-serving | vLLM configuration, performance tuning |
| RAG pipeline | rag | ChromaDB, pgvector, embedding optimization |
| Model optimization | optimization | Flash Attention, quantization (GPTQ/AWQ) |
| Safety guardrails | safety-alignment | LlamaGuard, NeMo Guardrails config |
| Training | fine-tuning, distributed-training | Axolotl, FSDP for Granite customization |
| Evaluation | evaluation | Benchmark harness for model validation |

### 4. Quality Assurance
| Phase | Plugin(s) | How |
|-------|-----------|-----|
| Code review | code-review, pr-review-toolkit | 5+6 parallel review agents |
| Security scanning | security-guidance, voltagent-qa-sec | OWASP patterns + penetration testing |
| E2E testing | playwright | Browser automation for frontend |
| Code simplification | code-simplifier | Automatic refactoring suggestions |
| Debugging | superpowers (`/systematic-debugging`) | Root cause analysis methodology |

### 5. Deployment & Operations
| Phase | Plugin(s) | How |
|-------|-----------|-----|
| Git workflow | commit-commands | Conventional Commits, branch cleanup |
| PR creation | greptile, pr-review-toolkit | Codebase-aware review + specialized agents |
| Vercel deploy | vercel | Credit Consulting deployment |
| K8s/Helm deploy | voltagent-infra (kubernetes-specialist) | Helm chart review, K8s troubleshooting |
| Docker operations | voltagent-infra (docker-expert) | Compose file optimization |
| Error monitoring | sentry | Production error triage |
| Model monitoring | mlops | W&B, MLflow experiment tracking |

### 6. Documentation & Maintenance
| Phase | Plugin(s) | How |
|-------|-----------|-----|
| CLAUDE.md management | claude-md-management | Audit and improve project docs |
| Plugin development | plugin-dev | Create custom plugins |
| Hook management | hookify | Enforce workflow rules |
| Automation | claude-code-setup | Recommend new automations |

---

## Team Onboarding Playbook

### Replication Steps for New Developers

#### Step 1: Install Claude Code
```bash
# Install Claude Code CLI
npm install -g @anthropic-ai/claude-code
```

#### Step 2: Add Marketplaces
```bash
claude plugin marketplace add anthropics/claude-code
claude plugin marketplace add Orchestra-Research/AI-Research-SKILLs
claude plugin marketplace add VoltAgent/awesome-claude-code-subagents
claude plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill
claude plugin marketplace add OthmanAdi/planning-with-files
```

#### Step 3: Install Core Plugins (All Developers)
```bash
# Official plugins (auto-installed with marketplace)
# Superpowers workflow
claude plugin install superpowers@claude-plugins-official --scope user

# Planning discipline
claude plugin install planning-with-files@planning-with-files --scope user

# Design intelligence
claude plugin install ui-ux-pro-max@ui-ux-pro-max-skill --scope user

# Core VoltAgent subagents
claude plugin install voltagent-core-dev@voltagent-subagents --scope user
claude plugin install voltagent-lang@voltagent-subagents --scope user
claude plugin install voltagent-qa-sec@voltagent-subagents --scope user
claude plugin install voltagent-dev-exp@voltagent-subagents --scope user
```

#### Step 4: Install Role-Specific Plugins

**Backend / AI Engineer**:
```bash
claude plugin install inference-serving@ai-research-skills --scope user
claude plugin install rag@ai-research-skills --scope user
claude plugin install optimization@ai-research-skills --scope user
claude plugin install safety-alignment@ai-research-skills --scope user
claude plugin install fine-tuning@ai-research-skills --scope user
claude plugin install agents@ai-research-skills --scope user
claude plugin install voltagent-data-ai@voltagent-subagents --scope user
claude plugin install voltagent-infra@voltagent-subagents --scope user
```

**Frontend Engineer**:
```bash
# ui-ux-pro-max already installed in Step 3
# Playwright already in official plugins
# Additional context7 for React/Next.js docs already in official
```

**DevOps / Infrastructure**:
```bash
claude plugin install voltagent-infra@voltagent-subagents --scope user
claude plugin install infrastructure@ai-research-skills --scope user
claude plugin install distributed-training@ai-research-skills --scope user
```

#### Step 5: Configure Global MCP Servers
```bash
# RunPod (all developers with GPU access)
claude mcp add-json --scope user runpod '{"type":"stdio","command":"npx","args":["-y","@runpod/mcp-server@latest"],"env":{"RUNPOD_API_KEY":"<TEAM_API_KEY>"}}'
```

#### Step 6: Verify Installation
```bash
claude plugin list                    # Should show all installed plugins
claude plugin marketplace list        # Should show 5 marketplaces
claude mcp list                       # Should show RunPod + any project MCPs
```

### Role-Based Plugin Matrix

| Plugin | All Devs | Backend/AI | Frontend | DevOps |
|--------|:--------:|:----------:|:--------:|:------:|
| superpowers | Yes | Yes | Yes | Yes |
| planning-with-files | Yes | Yes | Yes | Yes |
| ui-ux-pro-max | Yes | — | Yes | — |
| voltagent-core-dev | Yes | Yes | Yes | Yes |
| voltagent-lang | Yes | Yes | Yes | — |
| voltagent-qa-sec | Yes | Yes | Yes | Yes |
| voltagent-dev-exp | Yes | Yes | Yes | Yes |
| inference-serving | — | Yes | — | — |
| rag | — | Yes | — | — |
| optimization | — | Yes | — | — |
| safety-alignment | — | Yes | — | — |
| voltagent-infra | — | Yes | — | Yes |
| voltagent-data-ai | — | Yes | — | — |

---

## Risk Assessment

### License Risks

| Risk | Affected Plugins | Mitigation |
|------|-----------------|------------|
| None | All 50 installed plugins use MIT or Apache 2.0 | No commercial restrictions |
| Declined AGPL | claude-mem, daily.dev | Excluded from stack |
| Declined Commons Clause | claude-task-master | Excluded from stack |

### Token Budget Impact

| Tier | Est. System Prompt Addition | Notes |
|------|----------------------------|-------|
| Tier 1 (Official) | ~15-20K tokens | Already baseline — no change |
| Tier 2 (AI Research) | ~8-12K tokens | Skills are invoked on-demand, minimal idle overhead |
| Tier 3 (VoltAgent) | ~4-6K tokens | Subagents run in isolated context windows |
| Tier 4 (Design + Planning) | ~3-5K tokens | Lightweight skill definitions |
| **Total estimated** | **~30-43K tokens** | Well within Opus 200K context window |

### Conflict Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| Superpowers vs planning-with-files `/plan` command | Low | planning-with-files uses `/planning` as primary; scope overlap is minimal |
| VoltAgent code-reviewer vs official code-review | Low | Different invocation mechanisms (subagent vs slash command) |
| Multiple AI research skills loaded simultaneously | Medium | Only relevant skills load per session; unused skills have zero overhead |

### Maintenance Risks

| Marketplace | Update Frequency | Risk |
|------------|-----------------|------|
| claude-plugins-official | Weekly (Anthropic team) | Very Low |
| ai-research-skills | Monthly (Orchestra Research) | Low |
| voltagent-subagents | Monthly (VoltAgent) | Low |
| ui-ux-pro-max-skill | Monthly | Low |
| planning-with-files | Bi-weekly | Low |

---

## Maintenance Schedule

### Weekly
- Check for official plugin updates: `claude plugin update <plugin>@claude-plugins-official`

### Monthly
- Update third-party marketplaces: `claude plugin marketplace refresh`
- Review new plugins in each marketplace for relevance
- Audit which AI research skills are actually being used

### Quarterly
- Re-evaluate declined plugins (especially composio-skills as team grows)
- Review marketplace landscape for new entrants at https://claudemarketplaces.com/
- Update this report with new findings

### On Staff Hire
- Execute Team Onboarding Playbook (Section 10)
- Create role-specific install script from the commands above
- Verify new developer's plugin list matches the role matrix

---

## Appendix: Installation Commands (Quick Reference)

### Add All Marketplaces
```bash
claude plugin marketplace add anthropics/claude-code
claude plugin marketplace add Orchestra-Research/AI-Research-SKILLs
claude plugin marketplace add VoltAgent/awesome-claude-code-subagents
claude plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill
claude plugin marketplace add OthmanAdi/planning-with-files
```

### Install All 22 Non-Official Plugins
```bash
# AI Research Skills (14)
for plugin in inference-serving rag optimization fine-tuning safety-alignment \
  model-architecture distributed-training evaluation multimodal prompt-engineering \
  agents mlops infrastructure emerging-techniques; do
  claude plugin install "$plugin@ai-research-skills" --scope user
done

# VoltAgent Subagents (6)
for plugin in voltagent-core-dev voltagent-lang voltagent-infra \
  voltagent-qa-sec voltagent-data-ai voltagent-dev-exp; do
  claude plugin install "$plugin@voltagent-subagents" --scope user
done

# Design & Planning (2)
claude plugin install ui-ux-pro-max@ui-ux-pro-max-skill --scope user
claude plugin install planning-with-files@planning-with-files --scope user
```

### Verify Installation
```bash
claude plugin list 2>&1 | grep -c "enabled"
# Expected: 50
```

---

*Report generated from analysis of 16 candidate plugins across 9 marketplaces, evaluated against the M3Dev development ecosystem (3 active projects, 5 tech stacks, 2 GPU pods).*
