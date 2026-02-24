---
name: implementation-planner
description: Creates a detailed step-by-step plan for complex features. Use this skill BEFORE writing code for any multi-file change or major feature.
---

# Implementation Planner

This skill creates a structured `implementation_plan.md` to guide complex development tasks.

## When to Use

- Starting a new feature (e.g., "Add user authentication")
- Major refactoring
- Multi-file migrations
- Anything requiring >3 separate tool calls

## Plan Structure

Create a file named `implementation_plan.md` with the following sections:

1. **Goal**: One sentence summary of what will be achieved.
2. **Proposed Changes**:
    - List of files to create/modify.
    - Brief description of changes for each file.
3. **Verification Plan**:
    - How will we know it works? (e.g., "Run `npm test`", "Manual check of login page").
4. **Risk Analysis**:
    - What could break?
    - breaking changes?

## Workflow

1. **Draft**: Use `write_to_file` to create `implementation_plan.md`.
2. **Review**: Ask user to review via `notify_user` (optional but recommended for high risk).
3. **Execute**: Follow the plan step-by-step.
