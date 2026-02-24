---
description: The core RARV (Reason, Act, Reflect, Verify) cycle for all development tasks.
---

# Master Development Cycle (RARV)

This workflow implements the "Trinity" architecture's core loop: **Reason -> Act -> Reflect -> Verify**. It is the foundation for all other workflows.

## 1. Reason (The Planning Phase)

**Goal:** deeply understand the problem before touching code.

- **Step 1.1: Context Retrieval**
  - Use `notebooklm` skill to query project documentation and architectural decisions.
  - *Command:* `python scripts/run.py ask_question.py --question "How does the <feature> architecture work?"`
- **Step 1.2: Research & Design**
  - If complex (>3 files), use `implementation-planner` skill to create `implementation_plan.md`.
  - *Command:* Create `implementation_plan.md` with "Proposed Changes" and "Verification Plan".
- **Step 1.3: Committee Review (Oversight)**
  - If task is **Critical** or **Complex**, invoke `oversight-committee`.
  - *Command:* `Run oversight committee review`
  - **GATE**: Do not proceed until `APPROVED`.

## 2. Act (The Execution Phase)

**Goal:** Execute the plan with precision, utilizing agent orchestration.

- **Step 2.1: Select Orchestration Strategy**
  - **Simple Task** (1 file/fix): Execute directly.
  - **Complex Task** (>1 file, new feature): Use `subagent-driven-development` or `loki-mode`.
  - **Multiple Independent Failures**: Use `dispatching-parallel-agents`.
- **Step 2.2: Implementation**
  - Create/Edit files according to the plan.
  - **CRITICAL**: Use `database-schema-validator` if touching SQL.

## 3. Reflect (The Review Phase)

**Goal:** Self-correction and quality control.

- **Step 3.1: Code Review**
  - Before testing, read your own diffs.
  - Does it match the `implementation_plan.md`?
  - Did you follow the `rules.md`?

## 4. Verify (The Testing Phase)

**Goal:** Prove it works with durable artifacts.

- **Step 4.1: Automated Verification**
  - Run unit tests: `npm test` or `pytest`.
  - Fix failures using the `automated-debugging` workflow.
- **Step 4.2: Manual Verification**
  - Capture screenshots if UI changed.
  - Verify against the "Verification Plan" from Phase 1.
- **Step 4.3: Secure Commit**
  - Use `git-commit-formatter` to generate the commit message.
  - *Constraint:* Never commit broken code.
- **Step 4.4: MRP Gate (Handoff Readiness)**
  - Run `documentation-enforcer` to ensure maintainability.
  - Update `task.md` to mark item as `[x]`.

---
**Next Steps:**

- If successful: Mark task complete in `task.md`.
- If failed: Enter `automated-debugging` workflow.
