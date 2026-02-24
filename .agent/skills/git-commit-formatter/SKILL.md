---
name: git-commit-formatter
description: Generates a structured Git commit message following Conventional Commits standards. Use this when the user asks to commit changes or save work.
---

# Git Commit Formatter

## Goal

Generate a git commit message that strictly adheres to the Conventional Commits specification.

## Usage Process

1. **Analyze Changes**: Run `git diff --staged` to see what has changed. If nothing is staged, ask the user if they want to stage all changes (`git add .`).
2. **Determine Type**: Classify the change into one of the following types:
   * `feat`: A new feature
   * `fix`: A bug fix
   * `docs`: Documentation only changes
   * `style`: Changes that do not affect the meaning of the code (white-space, formatting, etc)
   * `refactor`: A code change that neither fixes a bug nor adds a feature
   * `perf`: A code change that improves performance
   * `test`: Adding missing tests or correcting existing tests
   * `chore`: Changes to the build process or auxiliary tools and libraries
3. **Determine Scope**: (Optional) The module or file affected (e.g., auth, api, ui).
4. **Draft Message**: Format the message as: `type(scope): description`
   * Description must be lowercase and imperative (e.g., "add", not "added").
5. **Present to User**: Show the commit message in a code block and ask for confirmation to execute `git commit -m "..."`.

## Constraints

* Do not use generic messages like "update code".
* Do not execute the commit without user confirmation.
