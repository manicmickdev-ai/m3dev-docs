# Planning With Files Plugin Guide

> **Plugin:** `planning-with-files@OthmanAdi/planning-with-files`
> **Version:** v2.11.0 (latest: v2.16.0)
> **Scope:** User (global)
> **Category:** Task Planning & Session Management

---

## Overview

Planning With Files implements **Manus-style file-based task planning** — the same approach used by the AI agent company Meta acquired for $2 billion. Instead of keeping plans only in Claude's context window, it writes plans to actual files on disk, enabling:

- **Session persistence** — plans survive context resets and `/clear` commands
- **Session recovery** — automatically re-syncs after context fills up
- **Transparent progress** — human-readable task state at all times
- **Complex task decomposition** — structured multi-phase execution

---

## How It Works

When you start a plan, three files are created in your working directory:

| File | Purpose |
|------|---------|
| `task_plan.md` | Master task list with phases, steps, and status |
| `findings.md` | Research and context gathered during execution |
| `progress.md` | Execution log with timestamps and session tracking |

These files persist between conversations, so when your context fills up:
1. Run `/clear` (or context auto-compacts)
2. New session starts and hooks detect existing planning files
3. Claude reads the files and resumes exactly where you left off

---

## Slash Commands

### `/plan` (or `/planning-with-files:plan`)
Start a new planning session for a complex task.

**What it creates:**
```
task_plan.md     ← Your task breakdown with phases
findings.md      ← Research notes (empty to start)
progress.md      ← Session log
```

**Example usage:**
```
/plan Build a REST API for the m3dev inference platform with authentication,
rate limiting, and model routing
```

### `/plan:status` (or `/planning-with-files:status`)
Show current planning status at a glance — phases, progress, and any logged errors.

**Output includes:**
- Current phase and active task
- Completed vs. pending tasks
- Any errors logged during execution
- Session recovery information if applicable

---

## Hooks (Auto-Activated)

Planning With Files installs three hooks that run automatically in every session:

### PreToolUse Hook
- Runs before each tool call
- Writes current task state to `progress.md`
- Ensures progress is captured even if session crashes

### PostToolUse Hook
- Runs after each tool call
- Updates task status based on tool results
- Captures errors or blockers to `findings.md`

### Stop Hook
- Runs when Claude is about to stop responding
- Saves final state to planning files
- Generates session recovery checkpoint

---

## Session Recovery

When context fills and you run `/clear`:

1. New session starts
2. SessionStart hook checks `~/.claude/projects/` for recent planning files
3. Detects when files were last updated
4. Extracts conversation that happened after last save
5. Shows **catchup report** summarizing what was accomplished

**To maximize context before clearing:**
```json
{ "autoCompact": false }
```
Add to your `~/.claude/settings.json` to disable auto-compact.

---

## File Structure (Active Planning Session)

```
your-project/
├── task_plan.md         ← PHASE 1: Setup [IN PROGRESS]
│                           ├── [✓] Install dependencies
│                           ├── [→] Configure database
│                           └── [ ] Set up auth
├── findings.md          ← Database: using PostgreSQL 15
│                           API shape: REST with JWT auth
│                           Blockers: none
└── progress.md          ← [2026-02-24 10:32] Started Phase 1
                            [2026-02-24 10:45] Completed: install deps
                            [2026-02-24 10:47] Working on: configure DB
```

---

## Supported Platforms

| Platform | Status |
|----------|--------|
| Claude Code | ✅ Full Support (Plugin + SKILL.md) |
| Cursor | ✅ Full Support |
| Gemini CLI | ✅ Full Support |
| GitHub Copilot | ✅ Full Support |
| Kiro | ✅ Full Support (Steering Files) |
| Windsurf | ✅ Full Support |
| VS Code Continue | ✅ Full Support |
| OpenCode | ✅ Full Support |
| 15 platforms total | ✅ Supported |

---

## M3Dev Use Cases

### Large Feature Development
```
/plan Implement the RunPod autoscaling system with:
- API endpoint monitoring
- Cost-based scaling decisions
- Slack notifications
- Integration tests
```

### Multi-Stage Research
```
/plan Research and prototype the best inference stack for:
- 70B parameter models
- <2s latency target
- Cost under $0.001/token
```

### Infrastructure Projects
```
/plan Set up the complete M3Dev MLOps pipeline:
Phase 1: Experiment tracking with W&B
Phase 2: Model registry and versioning
Phase 3: Automated deployment pipeline
Phase 4: Monitoring and alerting
```

---

## Tips

- **Use for tasks with 5+ steps** — simpler tasks don't need file-based tracking
- **Review `task_plan.md`** at start of new sessions to reorient quickly
- **Check `findings.md`** for accumulated research — avoids re-doing work
- **`/plan:status`** gives a quick summary without reading all files
- Planning files are git-committable — useful for team coordination

---

## Compatibility Notes

The hooks run in every Claude Code session. They add minimal overhead (<100ms per tool call) but do write to disk on every tool use. If you notice slowdowns on very large projects with many files, this is the likely cause — you can temporarily disable by removing the hooks from settings.
