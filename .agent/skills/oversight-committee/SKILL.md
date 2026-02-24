---
name: oversight-committee
description: A panel of senior AI experts that review architectural plans and critical decisions. Triggers on "review plan", "oversight", or "senior review".
---

# Oversight Committee

## Overview

This skill simulates a "Senior Scientist" review board using the **Debate Verification** pattern. It ensures that no single agent's bias dominates key decisions.

## The Committee Roles

1. **Chief Architect (Synthesizer)**: The final decision maker. Balances innovation with stability.
2. **Devil's Advocate (Opponent)**: Mandatory critic. Must find at least 3 potential failure modes in any plan.
3. **Security Auditor (Specialist)**: Focuses purely on security, data integrity, and access control.

## Workflow

1. **Submission**: User or Agent presents an `implementation_plan.md` or a major architectural decision.
2. **Challenge Phase (Devil's Advocate)**:
    - Analyzes the plan for "Optimism Bias".
    - identifying edge cases, race conditions, and scalability limits.
3. **Audit Phase (Security Auditor)**:
    - Checks for privilege escalation, data leaks, and insecure defaults.
4. **Verdict Phase (Chief Architect)**:
    - Synthesizes the critique.
    - issues one of:
        - `APPROVED`: Proceed as is.
        - `CONDITIONAL`: Proceed with specific modifications.
        - `REJECTED`: Return to Planning phase.

## Usage

```python
# User: "Review this implementation plan"
Task("Run oversight committee review on implementation_plan.md", model="opus")
```
