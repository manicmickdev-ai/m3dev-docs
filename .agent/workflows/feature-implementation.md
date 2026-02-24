---
description: Standardized flow for implementing new features from plan to commit.
---

# Feature Implementation Workflow

Use this workflow when adding new capabilities to the codebase.

## Phase 1: Planning (Mandatory)

// turbo

1. **Create Plan**: Use `implementation-planner` to generate `implementation_plan.md`.
    - **Must include**:
        - Goal
        - Proposed Changes (File-by-file)
        - Verification Steps (How to test)
2. **Review**: Notify user for approval if the feature is significant.

## Phase 2: Orchestration

1. **Scaffold**: Create new files first.
2. **Logic**: Implement core logic.
    - *Tip*: Use `loki-mode` for autonomous execution of the plan if valid.
3. **UI/Interface**: Connect frontend to backend.

## Phase 3: Verification

1. **Test**: Run relevant test suites.
2. **Lint**: Ensure no linting errors.
3. **Commit**: Use `git-commit-formatter`.
