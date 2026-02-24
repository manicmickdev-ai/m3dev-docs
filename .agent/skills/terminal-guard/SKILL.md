---
name: terminal-guard
description: Security guardrail. Use this skill BEFORE executing any high-risk terminal command (deletion, database drops, cloud resource termination) to validate safety.
---

# Terminal Policy Guard

## Goal

Prevent accidental data loss or system damage by enforcing a "pause-and-verify" protocol for destructive actions.

## Trigger Conditions

Activate this skill if the planned action involves:

* **Deletion**: `rm`, `del`, `unlink` (especially with recursive flags `-rf`)
* **System Config**: `chmod`, `chown`, modifying `/etc/`
* **Database Destructive**: `DROP TABLE`, `FLUSH DB`, `DELETE FROM` (without WHERE)
* **Cloud Termination**: `terraform destroy`, `docker system prune`

## Verification Protocol

Before running the command, perform these checks:

1. **Scope Check**: Ensure the target path is strictly within the current workspace directory.
   * **CRITICAL**: Reject commands targeting `~`, `/`, `../`, or system root.
2. **Context Check**: Is this a bulk deletion? If deleting >5 files, verify this was explicitly requested.
3. **User Approval Request**:
   You must stop and ask the user: "I am about to execute a destructive command: ``. This will permanently remove data. Please confirm this is correct."

## Safe Command Alternatives

* Instead of `rm -rf`, suggest moving files to a `_trash/` folder first.
* Instead of `DROP TABLE`, suggest renaming the table to `_backup_table`.
