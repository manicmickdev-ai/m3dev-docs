# M3Dev Docs

Operational documentation, dev guidelines, research, and automation resources for the M3Dev AI infrastructure platform.

---

## Repository Structure

```
m3dev-docs/
├── dev-guidelines/          # Plugin operational guides and development standards
├── research/                # Technical research and analysis reports
├── config-debug/            # Debugging notes for infrastructure issues
├── scripts/                 # Utility and automation scripts
├── .agent/                  # Custom Claude Code skills, workflows, and rules
└── skills/                  # Submodule: antigravity-awesome-skills library
```

---

## Dev Guidelines

Operational and functionality documentation for the full Claude Code plugin ecosystem (50 plugins).

| File | Description |
|------|-------------|
| [`M3DEV_DEVELOPMENT_GUIDELINES.md`](dev-guidelines/M3DEV_DEVELOPMENT_GUIDELINES.md) | Core M3Dev development standards and conventions |
| [`official-plugins-guide.md`](dev-guidelines/official-plugins-guide.md) | All 28 official Claude plugins: skills, MCP servers, hooks, agents |
| [`voltagent-subagents-guide.md`](dev-guidelines/voltagent-subagents-guide.md) | 94 VoltAgent specialist agents across 6 domains with invocation patterns |
| [`ai-research-skills-guide.md`](dev-guidelines/ai-research-skills-guide.md) | 14 AI/ML skill categories covering the full ML engineering stack |
| [`ui-ux-pro-max-guide.md`](dev-guidelines/ui-ux-pro-max-guide.md) | Design intelligence: 67 styles, 96 palettes, 57 fonts, 13 stacks |
| [`planning-with-files-guide.md`](dev-guidelines/planning-with-files-guide.md) | Manus-style file-based task planning with session recovery |

---

## Research

| File | Description |
|------|-------------|
| [`research/plugins/plugin-ecosystem-report.md`](research/plugins/plugin-ecosystem-report.md) | Comprehensive analysis of all 50 installed plugins with M3Dev relevance matrix, tier rankings, and team onboarding playbook |

---

## Config Debug

Debugging notes and analysis for infrastructure issues:

- `model-routing-debug.md` — Model routing configuration issues
- `vram-budget-debug.md` — VRAM allocation and budget analysis
- `package-conflict-analysis.md` — Python package conflict resolution
- `runpod-environment-debug.md` — RunPod environment debugging

---

## Scripts

- `RunPod_Persistence.sh` — RunPod pod persistence and environment setup script

---

## Agent Resources (`.agent/`)

Custom Claude Code automation resources:

### Skills
Local custom skills extending Claude's capabilities:

| Skill | Purpose |
|-------|---------|
| `database-schema-validator` | Validate database schema changes |
| `dispatching-parallel-agents` | Orchestrate parallel agent execution |
| `documentation-enforcer` | Enforce documentation standards |
| `executing-plans` | Execute multi-step implementation plans |
| `failure-postmortem` | Structured failure analysis |
| `git-commit-formatter` | Enforce commit message standards |
| `implementation-planner` | Plan feature implementations |
| `loki-mode` | Autonomous agent mode |
| `notebooklm` | NotebookLM integration |
| `oversight-committee` | Multi-agent review system |
| `project-intake` | Structured project onboarding |
| `runpod-deployer` | RunPod deployment automation |
| `skill-creator` | Create new Claude skills |
| `subagent-driven-development` | Subagent orchestration patterns |
| `terminal-guard` | Terminal command safety guardrails |

### Workflows
Documented automation workflows:

- `master-development-cycle.md` — Full development cycle from intake to deployment
- `feature-implementation.md` — Feature development workflow
- `project-kickoff.md` — New project setup process
- `project-handoff.md` — Project handoff documentation
- `oversight-review.md` — Code and architecture review process
- `automated-debugging.md` — Systematic debugging workflow

---

## Skills Submodule

The `skills/` directory is a submodule tracking the [antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills) library — a curated collection of Claude Code skills.

```bash
# Clone with submodules
git clone --recurse-submodules https://github.com/manicmickdev-ai/m3dev-docs.git

# Update submodule to latest
git submodule update --remote skills
```

---

## Related Repositories

| Repo | Description |
|------|-------------|
| [m3dev_ecosystem](https://github.com/manicmickdev-ai/m3dev_ecosystem) | Core M3Dev platform — FastAPI backend, Next.js frontend, PostgreSQL/pgvector, vLLM GPU inference, Helm/K8s deployment |
| [antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills) | Community Claude Code skills library (tracked as `skills/` submodule) |
