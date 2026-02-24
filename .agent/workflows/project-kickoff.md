---
description: The "Day 0" standard template for initiating the agentic workflow.
---

# Project Kickoff Workflow

Use this workflow to initialize a new project from raw documentation. This is the **Primary Entry Point**.

## Phase 1: Ingest & Analyze (The Analyst)

**Trigger**: User says "Analyze project for kickoff".

1. **Run Intake**: Execute `project-intake` skill.
2. **Output**: `project_definition.md` and `task.md` are created.

## Phase 2: Agreement (The Handshake)

1. **Review**: Present the definition and task list to the User.
2. **Iterate**: If the user wants changes, update the docs or the plan.
3. **Approval**: User confirms "Looks good" or "Proceed".

## Phase 3: Project Launch (The Automation)

1. **Engage Ecosystem**:
    - If Approved, trigger the `master-development-cycle`.
    - Or dispatch `loki-mode` for full autonomy.
2. **Constraint**:
    - Build until **RunPod Integration** is required.
    - **PAUSE**: Request human intervention for sensitive infrastructure keys or manual provisioning if `runpod-deployer` cannot authenticate.

## Phase 4: Ongoing Optimization

- Once launched, the `oversight-committee` and `documentation-enforcer` take over governance.
