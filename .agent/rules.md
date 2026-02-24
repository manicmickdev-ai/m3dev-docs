# Operational Rules

1. **Security**: Before executing any shell command that deletes files or changes system configuration, you MUST activate the `terminal-guard` skill.
2. **Governance**: When asking to commit changes, you MUST use the `git-commit-formatter` skill. Do not generate commit messages without it.
3. **Architecture**: Do not write code for complex features without first creating a plan using the `implementation-planner` skill.
4. **Oversight**: All tasks marked 'Critical' or 'Complex' MUST be approved by the `oversight-committee` before Execution.
5. **Maintainability**: You NEVER complete a task without updating `task.md` and ensuring complex code is commented (MRI Standard). Use `documentation-enforcer` to verify.
6. **Initialization**: Always start a new project by running the `project-kickoff` workflow to establish the `project_definition.md`.
