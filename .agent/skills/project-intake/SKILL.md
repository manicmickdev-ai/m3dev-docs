---
name: project-intake
description: "The Analyst". specialized in analyzing the `docs/` folder to generate the initial `project_definition.md` and `task.md` for a new project.
---

# Project Intake Skill

## Overview

This skill acts as the "Day 0" analyst. It scans the provided documentation (`docs/` folder) and synthesizes the core project parameters into structured governance documents.

## Inputs

- `docs/` folder containing PRDs, specs, or raw notes.
- Optional: `images/` folder for architectural diagrams.

## Outputs

1. **`project_definition.md`**: The source of truth. Includes Goal, Architecture, Tech Stack, and Constraints.
2. **`task.md`**: High-level phases for the initial roadmap.

## Workflow

1. **Scan**: Recursively read all files in `docs/`.
2. **Synthesize**:
    - Identify the goal ("What are we building?").
    - Extract tech stack ("What tools are we using?").
    - Note constraints ("What must we NOT do?").
3. **Generate**: Write the definition and task files.

## Usage

```python
# User: "Analyze project for kickoff"
Task("Run project intake analysis on docs folder", model="opus")
```
