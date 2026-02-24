---
description: Formal review process by the Oversight Committee.
---

# Oversight Committee Review Workflow

Use this workflow for all **Complex** or **Critical** tasks before moving to Execution.

## 1. Preparation

- Ensure `implementation_plan.md` is complete.
- Ensure all relevant context (files, docs) is cited.

## 2. Committee Session

**Trigger**: Invoke `oversight-committee` skill.

**Prompt Template**:
> "Acting as the Oversight Committee (Chief Architect, Devil's Advocate, Security Auditor), please review the attached `implementation_plan.md`.
>
> 1. **Devil's Advocate**: List 3 reasons why this might fail.
> 2. **Security Auditor**: Identify any security risks.
> 3. **Chief Architect**: Provide the final verdict (APPROVED, CONDITIONAL, REJECTED) and the rationale."

## 3. Resolution

- **IF APPROVED**: Proceed to Execution (Act phase).
- **IF CONDITIONAL**: Update the plan with requested changes, then auto-proceed.
- **IF REJECTED**:
  - Do NOT proceed.
  - Return to Reasoning phase.
  - Fix the fundamental flaws.
  - Request a new review.
