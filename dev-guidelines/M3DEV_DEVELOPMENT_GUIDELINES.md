# M3Dev Development Guidelines

Global reference for development conventions, session management, and operational rules across all M3Dev projects. This document is the canonical source — project-level `CLAUDE.md` files inherit from these standards.

**Last Updated**: 2026-02-24
**Maintained By**: Mickey / M3Dev team

---

## 1. Workspace Structure

```
m3dev/                              # Workspace root
├── m3dev_ecosystem/                # Primary product codebase (git repo)
│   └── CLAUDE.md                   # Project-specific guidance
├── m3dev/                          # Business docs, knowledge base, agent skills
│   ├── .agent/                     # Agent rules (rules.md) + 42 skills
│   │   └── skills/                 # Skill implementations (notebooklm, terminal-guard, etc.)
│   ├── automation/skills/          # Community skills collection (Antigravity, 131 skills)
│   └── docs/                       # Business docs, research, passdowns, legal
│       ├── knowledge_base/         # RAG-ready markdown from 16 NotebookLM notebooks
│       └── Current_Docs/           # Postmortems, passdowns, revenue models
├── clients/                        # Client project folders
├── docs/                           # Shared documentation
│   ├── dev-guidelines/             # THIS DIRECTORY — global standards
│   ├── research/                   # Research notes
│   └── scripts/                    # Utility scripts (RunPod_Persistence.sh)
└── upwork_portfolio/               # Upwork portfolio project (git repo)
    └── CLAUDE.md                   # Project-specific guidance
```

### Key Principle

Each git repository has its own `CLAUDE.md` at the root. That file documents project-specific build commands, architecture, and conventions. This global document covers cross-project standards.

---

## 2. Session Management & Passdowns

### Purpose

Technical passdowns are the primary mechanism for continuity between development sessions. Every session that makes meaningful progress MUST produce a passdown. A passdown is a self-contained "state of the world" document that lets a new session (human or AI) pick up exactly where the last one left off.

### File Location

Each project has its own passdown directory:

| Project | Passdown Directory |
|---------|-------------------|
| Upwork Portfolio | `upwork_portfolio/passdown/` |
| M3Dev Ecosystem | `m3dev_ecosystem/docs/passdowns/` |

### Naming Convention

```
YYYY-MM-DD_session<NN>-descriptive-name.md
```

- Session numbers are sequential per project, zero-padded to 2 digits
- Descriptive name uses lowercase kebab-case
- Examples:
  - `2026-02-23_session01-plan-review-and-revision.md`
  - `2026-02-24_session04-granite-migration-vllm-debugging.md`

### Required Sections

Every passdown MUST include these sections (see passdown README for full template):

1. **Header** — Date, session number, description, handoff target, status
2. **Executive Summary** — 2-3 sentence overview of what happened
3. **Status Summary** — What's Working / What's Broken / What's Pending
4. **Architecture State** — Running services, GPU allocation, ports, software versions
5. **File Locations** — Files created/modified, key configs, log locations
6. **Commits This Session** — Hash + message table
7. **Debugging Notes** — Issues encountered, what was tried, root causes found
8. **Verification Commands** — Runnable commands to check current state
9. **Next Steps** — Prioritized numbered list of what to do next
10. **Quick Reference** — URLs, key commands, VRAM/RAM state

### Session Prompt Files

For seamless handoff, create a companion prompt file in `passdown/passdown-prompts/`:

```
passdown/passdown-prompts/YYYY-MM-DD_session<NN>-prompt.md
```

This file contains a self-contained system prompt that can be pasted into the first message of a new Claude Code session. It should include:

- Context (what project, where it lives)
- Pointer to the full passdown file
- Current state summary (what's working, what's broken)
- Explicit task list for the new session
- Reference configs and verification commands
- Conventions reminder

### Rules

1. **Always write a passdown at session end** — even for short sessions
2. **Never assume the next session has context** — passdowns must be self-contained
3. **Include verification commands** — the next session should be able to validate state
4. **Commit passdowns to git** — they are part of the project record
5. **Reference prior passdowns** — link to earlier sessions when context is relevant
6. **Include debugging history** — what was tried and why it failed saves hours

---

## 3. Git Conventions

### Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>: <description>
```

| Type | Usage |
|------|-------|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `chore` | Build, CI, dependencies, tooling |
| `refactor` | Code change that neither fixes nor adds |
| `test` | Adding or updating tests |
| `perf` | Performance improvement |

- Subject line: imperative mood, lowercase, no period, under 72 chars
- Body (optional): explain WHY, not WHAT
- Examples:
  - `feat: add embedding and docling routes to nginx`
  - `fix: pin vllm==0.15.1 and add stale torch file cleanup`
  - `docs: update CLAUDE.md for Granite model stack`

### Branch Strategy

- `main` is the primary branch for all projects
- Feature branches: `feat/<descriptive-name>`
- Fix branches: `fix/<descriptive-name>`
- Always create PRs for non-trivial changes

### What NOT to Commit

- `.env` files (use `.env.example` as template)
- Credentials, API keys, SSH keys
- Model weights (`.gguf`, `.safetensors`, `.bin`)
- `__pycache__/`, `.pyc`
- `.claude/` directory
- Large binary files

---

## 4. Code Conventions

### Python

- **Version**: 3.11 (match RunPod base images)
- **Framework**: FastAPI for APIs, Streamlit for dashboards
- **Linting**: `ruff check`
- **Formatting**: `ruff format`
- **Testing**: `pytest`
- **Type hints**: Use for function signatures, not required for local variables
- **Base images**: `python:3.11-slim` for Docker

### Health Endpoints

Every service MUST expose:

```
GET /health → {"status": "ok", ...}
```

Additional fields are optional but encouraged (e.g., model name, version, uptime).

### Environment Variables

- Use `.env.example` as the template with placeholder values
- Bootstrap scripts generate real secrets
- Access via `os.environ` or Pydantic `BaseSettings`
- Never hardcode secrets

### Authentication

- Bearer token via `AUTH_TOKEN` environment variable
- Enforced at nginx layer (not in individual services)
- `/health` endpoints are always unauthenticated
- Model endpoints (`/v1/`) are rate-limited but unauthenticated (for demo access)

---

## 5. RunPod Operations

### SSH Access

```bash
ssh -i ~/.ssh/id_ed25519 <pod-id>@ssh.runpod.io
```

For scripted/automated commands, use heredoc format:
```bash
ssh -tt -i ~/.ssh/id_ed25519 <pod-id>@ssh.runpod.io << 'CMDS'
your commands here
exit
CMDS
```

### Persistence

- **Persistent volume**: `/workspace/` (survives pod stops/restarts)
- **Models**: `/workspace/models/`
- **Data**: `/workspace/data/` (chromadb, postgres)
- **Logs**: `/workspace/logs/<service>/stdout.log` and `stderr.log`
- **Repo clone**: `/workspace/<project-name>/`

### Process Management

Native deployments use `supervisord`:

```bash
supervisorctl status              # Check all services
supervisorctl restart <service>   # Restart a service
supervisorctl tail -f <service>   # Follow logs
supervisorctl start <service>     # Start a stopped service
supervisorctl stop <service>      # Stop a service
```

### Known RunPod Pitfalls

1. **Stale torch files** — When upgrading torch via pip on a RunPod base image, pip does not delete files removed in the new version. Always clean up stale files after torch upgrades:
   ```bash
   find /usr/local/lib/python3.11/dist-packages/torch/_inductor/ \
     -name "*.py" -not -newer <reference-file> -delete
   ```

2. **apt lock on boot** — RunPod pods sometimes have background apt processes on boot. Use `timeout 120 bash -c 'while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do sleep 2; done'` before apt commands.

3. **Docker-in-Docker** — Not reliably available on GPU pods. Prefer native (supervisord) deployment.

4. **CUDA architecture** — CMake native detection may fail in containers. Hardcode `CUDA_ARCHITECTURES` for your GPU:
   - RTX A5000: `86`
   - RTX 4090: `89`
   - RTX PRO 4500 (Blackwell): `120`

---

## 6. CLAUDE.md Standards

Every git repository must have a `CLAUDE.md` at its root. This file is automatically read by Claude Code on session start.

### Required Sections

1. **What This Is** — One-paragraph project description
2. **Commands** — Build, test, lint, deploy commands
3. **Architecture** — Service topology, networking, GPU budget
4. **Conventions** — Git, Python, auth, persistence
5. **Key Files** — The 5-10 most important files and what they do

### Maintenance Rules

- Update `CLAUDE.md` whenever architecture changes
- Keep it under 150 lines (concise, not exhaustive)
- Focus on cross-cutting concerns that require reading multiple files to understand
- Don't duplicate information that's obvious from the code itself

---

## 7. Documentation Hierarchy

```
CLAUDE.md (per repo)           — Claude Code onboarding, architecture, commands
passdown/*.md                  — Session state, debugging notes, next steps
docs/plans/*.md                — Design documents, implementation plans
README.md (per repo)           — Human-readable project overview (for GitHub)
docs/dev-guidelines/ (global)  — THIS DOCUMENT — cross-project standards
```

### When to Write What

| Document | When | Audience |
|----------|------|----------|
| CLAUDE.md | Architecture changes | Claude Code (AI) |
| Passdown | End of every session | Next session (AI or human) |
| Design doc | Before complex features | Review before implementation |
| README.md | Project milestones | External viewers (Upwork clients, GitHub) |
| Dev guidelines | Convention changes | All developers across projects |

---

## 8. Security Rules

1. **Never commit secrets** — API keys, tokens, passwords, SSH keys
2. **Credential files live outside git repos**:
   - `m3dev/keys.txt` — RunPod API key, SSH key
   - `m3dev/locks.txt` — Supabase URL, JWT, service key
3. **Bootstrap scripts generate secrets** — via `python3 -c "import secrets; print(secrets.token_urlsafe(32))"`
4. **Use `.env.example` templates** — with placeholder values, never real credentials
5. **Auth at nginx layer** — Individual services trust internal network
6. **Rate limiting** — Enforced at nginx for all public endpoints

---

## 9. Agent Operational Rules

From `m3dev/.agent/rules.md`:

1. Use `terminal-guard` skill before destructive shell commands
2. Use `git-commit-formatter` skill for all commits
3. Use `implementation-planner` before complex features
4. Critical/Complex tasks require `oversight-committee` approval
5. Update `task.md` and comment code (MRI Standard) using `documentation-enforcer`
6. Run `project-kickoff` workflow for new projects

### Skill Library Locations

| Collection | Path | Count |
|-----------|------|-------|
| M3Dev agent skills | `m3dev/.agent/skills/` | 42 skills |
| Community skills (Antigravity) | `m3dev/automation/skills/` | 131 skills |
| Shared docs mirror | `docs/skills/` | Mirror of above |

---

## 10. Project Registry

| Project | Repo Path | Status | Stack |
|---------|-----------|--------|-------|
| M3Dev Ecosystem | `m3dev_ecosystem/` | Active (V0.2) | FastAPI + Next.js + PostgreSQL + vLLM + BeeAI |
| Upwork Portfolio | `upwork_portfolio/` | Active (Phase 1) | FastAPI + LlamaIndex + ChromaDB + Granite + llama.cpp |
| Client: ADAT Sweets | `clients/adat-sweets/` | — | — |
| Client: G2GLV | `clients/g2glv/` | — | — |

---

## 11. Model Stack Reference (Current)

### Upwork Portfolio (RTX A5000, 24GB)

| Service | Model | Server | VRAM |
|---------|-------|--------|------|
| Generation | granite-4.0-h-tiny (Q8 GGUF) | llama.cpp | ~7.9GB |
| Embedding | granite-embedding-english-r2 | vLLM 0.15.1 | ~0.5GB |
| Docling | granite-docling-258M | vLLM 0.15.1 | ~1GB |

### M3Dev Ecosystem (RTX PRO 4500 Blackwell)

| Service | Model | Server | Notes |
|---------|-------|--------|-------|
| Generation | granite-4.0-h-tiny | llama.cpp | vLLM doesn't support granitemoehybrid |
| Embedding | granite-embedding-english-r2 | vLLM 0.15.1 | `--convert embed` flag |
| Docling | granite-docling-258M | vLLM 0.15.1 | — |

### vLLM Flags Reference

| Flag | When to Use |
|------|-------------|
| `--convert embed` | Required for embedding models in vLLM 0.15.1 (NOT `--task embed`) |
| `--dtype float16` | Embedding models |
| `--dtype bfloat16` | Docling / generation models |
| `--gpu-memory-utilization` | Set low (0.02-0.05) for small models to avoid over-allocation |
| `--max-model-len` | Match model's expected input length |
| `--enforce-eager` | Only if torch.compile causes issues (prefer fixing root cause) |
| `--trust-remote-code` | Only for models that require it (check model card) |
