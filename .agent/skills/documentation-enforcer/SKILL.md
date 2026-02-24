---
name: documentation-enforcer
description: Validates that code changes include necessary documentation (Merge-Readiness Pack). Use checking for 'handoff' readiness or before completing 'Complex' tasks.
---

# Documentation Enforcer

## Overview

This skill ensures that no code is left behind without its "Strategic Documentation". It validates the **Merge-Readiness Pack (MRP)**.

## The Merge-Readiness Pack (MRP)

A task is ONLY complete if it has:

1. **Code**: The working implementation.
2. **Plan**: An up-to-date `implementation_plan.md` matching the final code.
3. **Comments**: Docstrings for all classes and complex functions (>10 lines).
4. **Artifacts**: Screenshots or logs verifying the change, referenced in `walkthrough.md`.
5. **Tracking**: The item marked as `[x]` in `task.md`.

## Workflow

1. **Inspection**:
    - Scans modified files for comment density.
    - Checks for `implementation_plan.md` existence and recency.
    - Checks `task.md` for completion status.
2. **Validation**:
    - Fails if `implementation_plan.md` is missing for complex features.
    - Fails if new complex functions lack docstrings.
    - Warns if no artifacts are found.
3. **Report**:
    - Generates a "Readiness Score" (0-100%).
    - Lists missing MRP elements.

## Usage

```python
# Agent: "Am I done?"
Task("Run documentation enforcer to validate MRP", model="sonnet")
```
