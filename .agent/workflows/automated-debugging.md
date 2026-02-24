---
description: Systematic process for diagnosing and fixing errors using parallel agents.
---

# Automated Debugging Workflow

Use this workflow when tests fail, builds break, or runtime errors occur.

## Phase 1: Analysis (Postmortem)

1. **Trigger**: Code failure or test failure.
2. **Action**: Use `failure-postmortem` skill.
    - Analyze stdout/stderr.
    - Search knowledge base (`notebooklm` or `docs/`).
    - Formulate hypothesis.
3. **Output**: A clear definition of the root cause.

## Phase 2: Strategy Selection

- **Scenario A: Single Root Cause**
  - Proceed to Phase 3 (Direct Fix).
- **Scenario B: Multiple Independent Fallures**
  - *Example*: 3 different test files failing for different reasons.
  - **Action**: Use `dispatching-parallel-agents` skill.
  - Dispatch one agent per failure.

## Phase 3: Execution & Verification

1. **Apply Fix**: Modify code to resolve the specific root cause.
    - *Constraint*: Do not "shotgun debug" (randomly changing things).
2. **Verify Fix**: Run the specific test case that failed.
    - *Command*: `pytest path/to/test.py::test_name`
3. **Regression Test**: Run the full suite to ensure no side effects.

## Phase 4: Learning

1. **Update Docs**: If the error was obscure, add it to `docs/troubleshooting.md`.
