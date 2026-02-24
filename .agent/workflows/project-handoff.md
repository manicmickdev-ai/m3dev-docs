---
description: A checklist workflow for transferring ownership or completing a milestone.
---

# Project Handoff Workflow

Use this workflow when handing off the project to another team or completing a major milestone (`v1.0`).

## 1. MRP Validation (Automated)

**Command**: `Run documentation enforcer`

- Ensure Readiness Score is 100%.
- **Fix**: Add missing comments or update plans if failed.

## 2. Knowledge Transfer

**Goal**: Capture "Tribal Knowledge" that isn't in the code.

- **Action**: Create `docs/handoff_notes.md`.
- **Content**:
  - "Gotchas": Weird bugs or edge cases encountered.
  - "Why": Why receiving specific architectural decisions (refer to `oversight-committee` findings).
  - "How to Run": Verify `README.md` is copy-paste executable.

## 3. Clean Up

- **Action**: Archive old artifacts.
- Move completed items in `task.md` to an archive file `docs/completed_tasks.md` (optional).
- Ensure no `.env` files with real secrets are committed.

## 4. Final Sign-off

- **Trigger**: Oversight Committee Review of the Handoff Package.
- **Verdict**: If approved, the project is officially handed off.
