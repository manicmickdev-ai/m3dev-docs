# Official Claude Plugins Guide

> **Source:** `claude-plugins-official` marketplace
> **Total:** 28 plugins
> **Scope:** User (global)
> **Category:** Official Anthropic & Partner Plugins

---

## Overview

The official plugins suite provides core workflow automation, language intelligence, external integrations, and security tools built by Anthropic and official partners. These are the most stable, well-maintained plugins available.

---

## Plugin Index

### Development Workflow

#### `superpowers`
**Type:** Skills collection
**Purpose:** Core workflow orchestration — the meta-skill that manages how all other skills are used.

Skills provided:
| Skill | Trigger | Use When |
|-------|---------|----------|
| `brainstorming` | Before any creative work | Creating features, planning architecture |
| `writing-skills` | Creating/editing skills | Building new automation skills |
| `executing-plans` | Starting an approved plan | Executing multi-step implementation plans |
| `subagent-driven-development` | Independent parallel tasks | Running multiple agents simultaneously |
| `systematic-debugging` | Any bug/failure | Before proposing any fix |
| `test-driven-development` | Implementing features | Write tests first, then implementation |
| `verification-before-completion` | Before claiming "done" | Validate work before committing |
| `writing-plans` | Multi-step tasks | Planning before touching code |
| `using-git-worktrees` | Feature isolation | Working on isolated branches |
| `dispatching-parallel-agents` | 2+ independent tasks | Maximize parallel execution |
| `finishing-a-development-branch` | Implementation complete | Decide integration strategy |
| `requesting-code-review` | After completing features | Trigger code review workflow |
| `receiving-code-review` | Got review feedback | Process review suggestions |
| `using-superpowers` | Session start | Establishes skill discovery |

**Important:** Superpowers skills are checked BEFORE every action — even clarifying questions.

---

#### `feature-dev`
**Type:** Agents
**Purpose:** Guided feature development with codebase understanding and architecture focus.

Agents:
- `feature-dev:code-architect` — Analyze patterns, provide implementation blueprints
- `feature-dev:code-reviewer` — Review for bugs, security, quality, conventions
- `feature-dev:code-explorer` — Trace execution paths, map architecture layers

**Skill:** `/feature-dev` — Start guided feature development workflow

---

#### `code-review`
**Type:** Skill + Agent
**Purpose:** Systematic code review workflow.

- `/code-review:code-review` — Review a pull request using specialized agents
- Invokes `feature-dev:code-reviewer` and `pr-review-toolkit` agents

---

#### `code-simplifier`
**Type:** Agent
**Purpose:** Simplify recently written code for clarity and maintainability without changing behavior.

- `code-simplifier:code-simplifier` — Runs after coding tasks
- Focus: recent changes unless told otherwise
- Removes unnecessary complexity, improves readability

---

#### `commit-commands`
**Type:** Skills (slash commands)
**Purpose:** Streamline git commit workflow.

| Command | Action |
|---------|--------|
| `/commit` | Create a git commit with smart message generation |
| `/commit-push-pr` | Commit, push, and open a PR in one command |
| `/clean_gone` | Clean up local branches deleted from remote |

---

#### `pr-review-toolkit`
**Type:** Agents
**Purpose:** Comprehensive PR review using parallel specialized agents.

Agents:
| Agent | `subagent_type` | Reviews For |
|-------|----------------|-------------|
| Code Reviewer | `pr-review-toolkit:code-reviewer` | Style, guidelines, CLAUDE.md adherence |
| Type Design Analyzer | `pr-review-toolkit:type-design-analyzer` | Type safety, encapsulation, invariants |
| Comment Analyzer | `pr-review-toolkit:comment-analyzer` | Comment accuracy, technical debt |
| Silent Failure Hunter | `pr-review-toolkit:silent-failure-hunter` | Error handling, catch blocks, fallbacks |
| PR Test Analyzer | `pr-review-toolkit:pr-test-analyzer` | Test coverage, edge cases |
| Code Simplifier | `pr-review-toolkit:code-simplifier` | Code clarity after changes |
| Code Reviewer (superpowers) | `superpowers:code-reviewer` | Final validation against plan |

**Skill:** `/pr-review-toolkit:review-pr` — Run full PR review suite

---

### Language Intelligence

#### `typescript-lsp`
**Type:** MCP Server (Language Server Protocol)
**Purpose:** Real-time TypeScript language intelligence — type checking, hover info, go-to-definition, rename symbol, find references.

Activates automatically when working on `.ts` and `.tsx` files.

---

#### `pyright-lsp`
**Type:** MCP Server (Language Server Protocol)
**Purpose:** Python type checking and language intelligence using Pyright — the same engine VS Code uses.

Activates automatically on `.py` files. Provides:
- Type error detection
- Import resolution
- Completion suggestions
- Hover type information

---

### Documentation & Knowledge

#### `context7`
**Type:** MCP Server
**Purpose:** Fetch up-to-date library documentation and code examples from Context7's curated documentation index.

Tools provided:
- `resolve-library-id` — Find Context7 ID for any library
- `query-docs` — Fetch current documentation with code examples

**Usage:** Automatically invoked when working with unfamiliar libraries or needing current API reference.

```
# Example: Get latest vLLM documentation
/context7 how do I set up vLLM with multi-GPU
```

---

#### `serena`
**Type:** MCP Server
**Purpose:** Symbol-aware code search and navigation using language server capabilities.

Provides semantic code search beyond simple text search:
- Find all references to a symbol
- Navigate to type definitions
- Understand call hierarchies

---

### External Integrations

#### `github`
**Type:** MCP Server
**Purpose:** Direct GitHub API integration for repository operations.

Capabilities:
- Read/manage issues and PRs
- Search repositories and code
- Manage branches and releases
- Access GitHub Actions and workflows

---

#### `greptile`
**Type:** MCP Server
**Purpose:** AI-powered code review and codebase understanding via Greptile's API.

Tools:
- `list_merge_requests` / `list_pull_requests` — List PRs with filtering
- `get_merge_request` — Get PR details with review analysis
- `list_merge_request_comments` — Get all comments (Greptile + human)
- `trigger_code_review` — Trigger Greptile AI review
- `search_greptile_comments` — Search across review comments
- `list_custom_context` / `create_custom_context` — Manage custom rules

---

#### `linear`
**Type:** MCP Server
**Purpose:** Linear project management integration.

- Create, update, and query issues
- Manage project cycles and sprints
- Link code changes to Linear issues

---

#### `atlassian`
**Type:** Skills
**Purpose:** Jira + Confluence integration for enterprise project management.

Skills:
- `/atlassian:capture-tasks-from-meeting-notes` — Convert meeting notes to Jira tasks
- `/atlassian:spec-to-backlog` — Convert Confluence specs to Jira backlog
- `/atlassian:search-company-knowledge` — Search Confluence + Jira
- `/atlassian:triage-issue` — Triage bug reports and find duplicates
- `/atlassian:generate-status-report` — Generate Jira status → Confluence report

---

#### `sentry`
**Type:** MCP + Skills
**Purpose:** Sentry error tracking and observability integration.

Skills:
- `/sentry:seer` — Natural language queries about your Sentry environment
- `/sentry:sentry-setup-tracing` — Set up performance monitoring
- `/sentry:sentry-setup-ai-monitoring` — AI agent monitoring setup
- `/sentry:sentry-setup-metrics` — Custom metrics setup
- `/sentry:sentry-setup-logging` — Structured logging setup
- `/sentry:sentry-code-review` — Analyze and resolve Sentry PR comments

---

#### `supabase`
**Type:** MCP Server
**Purpose:** Direct Supabase database and backend integration.

- Query and mutate Postgres data
- Manage auth users and policies
- Deploy edge functions
- Monitor database performance

---

#### `vercel`
**Type:** MCP + Skills
**Purpose:** Vercel deployment integration.

Skills:
- `/vercel:deploy` — Deploy current project to Vercel
- `/vercel:logs` — View deployment logs
- `/vercel:setup` — Configure Vercel CLI and project

---

#### `huggingface-skills`
**Type:** Skills + Agent
**Purpose:** HuggingFace Hub operations and ML experiment tooling.

Skills:
- `/huggingface-skills:hugging-face-cli` — Hub operations via `hf` CLI
- `/huggingface-skills:hugging-face-trackio` — Track experiments with Trackio
- `/huggingface-skills:hugging-face-model-trainer` — Train/fine-tune models
- `/huggingface-skills:hugging-face-datasets` — Create and manage datasets
- `/huggingface-skills:hugging-face-jobs` — Run workloads on HF Jobs
- `/huggingface-skills:hugging-face-evaluation` — Add evaluation results to model cards
- `/huggingface-skills:hugging-face-paper-publisher` — Publish research papers

Agent: `huggingface-skills:AGENTS` — General HuggingFace operations agent

**M3Dev Relevance:** Key for publishing models to Hub and running training jobs.

---

### Testing & Browser Automation

#### `playwright`
**Type:** MCP Server
**Purpose:** Browser automation for web testing and scraping.

Tools: `browser_navigate`, `browser_click`, `browser_type`, `browser_snapshot`, `browser_take_screenshot`, `browser_evaluate`, `browser_network_requests`, and more.

**Usage:**
```
# Run automated browser test
Use playwright to navigate to localhost:3000 and verify the login flow
```

---

### Code Quality & Development Tools

#### `frontend-design`
**Type:** Skill
**Purpose:** Create distinctive, production-grade frontend interfaces with high design quality.

- `/frontend-design:frontend-design` — Guided frontend design workflow
- Complements `ui-ux-pro-max` with implementation focus

---

#### `agent-sdk-dev`
**Type:** Agents + Skill
**Purpose:** Build and verify Claude Agent SDK applications.

Agents:
- `agent-sdk-dev:agent-sdk-verifier-py` — Verify Python Agent SDK apps
- `agent-sdk-dev:agent-sdk-verifier-ts` — Verify TypeScript Agent SDK apps

Skill: `/agent-sdk-dev:new-sdk-app` — Scaffold a new Agent SDK application

---

#### `plugin-dev`
**Type:** Skills + Agents
**Purpose:** Claude Code plugin development workflow.

Skills:
- `/plugin-dev:create-plugin` — End-to-end plugin creation
- `/plugin-dev:skill-development` — Create new skills
- `/plugin-dev:hook-development` — Create PreToolUse/PostToolUse hooks
- `/plugin-dev:mcp-integration` — Add MCP server integration
- `/plugin-dev:plugin-settings` — Configure plugin settings storage
- `/plugin-dev:command-development` — Create slash commands
- `/plugin-dev:agent-development` — Create new agents
- `/plugin-dev:plugin-structure` — Scaffold plugin structure

Agents:
- `plugin-dev:skill-reviewer` — Review skill quality
- `plugin-dev:agent-creator` — Generate agent configurations
- `plugin-dev:plugin-validator` — Validate plugin structure

---

#### `claude-code-setup`
**Type:** Skill
**Purpose:** Analyze codebase and recommend Claude Code automations.

- `/claude-code-setup:claude-automation-recommender` — Scan project and suggest hooks, subagents, skills, plugins

---

#### `claude-md-management`
**Type:** Skills + Agent
**Purpose:** Manage and maintain CLAUDE.md project context files.

Skills:
- `/claude-md-management:revise-claude-md` — Update CLAUDE.md with session learnings
- `/claude-md-management:claude-md-improver` — Audit and improve CLAUDE.md quality

---

### Security

#### `security-guidance`
**Type:** Hook
**Purpose:** Security review hook that runs on every file read.

- Triggers on potentially malicious code patterns
- Blocks write operations on files with dangerous patterns (e.g., `exec(` in documentation)
- Provides analysis guidance: can analyze but won't improve malware

**Note:** This hook can block writes in agent contexts if documentation files contain code samples with sensitive patterns. Main session has override capability.

---

#### `hookify`
**Type:** Skills
**Purpose:** Create and manage Claude Code hooks to prevent unwanted behaviors.

Skills:
- `/hookify` — Analyze conversation for behaviors to prevent
- `/hookify:list` — List all configured hookify rules
- `/hookify:configure` — Enable/disable rules interactively
- `/hookify:writing-rules` — Create new hookify rules

---

### Project Management

#### `ralph-loop`
**Type:** Skills
**Purpose:** Ralph Loop task management system.

Skills:
- `/ralph-loop:ralph-loop` — Start Ralph Loop in current session
- `/ralph-loop:help` — Explain Ralph Loop plugin
- `/ralph-loop:cancel-ralph` — Cancel active loop

---

#### `learning-output-style`
**Type:** System Hook
**Purpose:** Modify Claude's output style to combine interactive learning with educational explanations.

Automatically active. Provides:
- `★ Insight` blocks with educational content
- User contribution requests for meaningful code decisions
- Balance of explanation with task completion

---

## Daily Workflow Integration

### Starting a Session
```
1. superpowers:using-superpowers  → Auto-loaded
2. planning-with-files hooks      → Auto-loaded (session recovery)
3. security-guidance hook         → Auto-loaded
4. typescript-lsp / pyright-lsp   → Auto-loaded per file type
```

### Feature Development Flow
```
/feature-dev           → Explore → Architect → Review cycle
/commit                → Smart commit with message generation
/pr-review-toolkit:review-pr → Full PR review before merge
```

### Code Quality Checks
```
code-simplifier        → Auto-invoked after writing code
code-reviewer          → Auto-invoked at completion
verification-before-completion → Before claiming done
```

### External Integrations
```
github MCP             → Issue/PR management
linear MCP             → Task tracking
sentry MCP             → Error monitoring
supabase MCP           → Database operations
vercel skills          → Deployment
```

---

## Plugin Configuration Reference

All official plugins are enabled globally in `~/.claude/settings.json` under `enabledPlugins`. They require no per-project configuration.

MCP servers (greptile, github, supabase, linear, serena) may require API keys set as environment variables or configured via their respective setup commands.
