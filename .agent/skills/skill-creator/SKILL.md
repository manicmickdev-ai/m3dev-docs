---
name: skill-creator
description: Generates new Agent Skills. Use this when the user asks to "create a skill" or "add a new capability" to the agent.
---

# Skill Creator

## Goal

Scaffold a new, fully compliant Agent Skill directory structure.

## Inputs Needed

   1. **Skill Name**: (kebab-case, e.g., `python-linter`)
   2. **Description**: A strong semantic trigger phrase describing when to use the skill.
   3. **Role**: Governance, Security, Architecture, Ops, or Debugging.

## Generation Steps

   1. Create directory: `.agent/skills/<skill-name>/`
   2. Create directory: `.agent/skills/<skill-name>/scripts/` (if executable logic is needed)
   3. Create file: `.agent/skills/<skill-name>/SKILL.md`
   4. **Populate Frontmatter**:

      ```yaml
      name: <skill-name>
      description: <description>
      ```

   5. **Populate Body**: Write a clear "Goal" and "Instructions" section based on the user's request.

## Example Usage

If user says "Create a skill to check for PEP8 compliance", generate a folder `python-pep8` with a `SKILL.md` that instructs the agent to run `flake8` on modified files.
