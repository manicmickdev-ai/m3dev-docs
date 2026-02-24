---
name: failure-postmortem
description: root cause analysis for errors. Use this when a command fails, a build breaks, or tests fail.
---

# Failure Postmortem Analysis

## Goal

Turn errors into learning by performing a structured Root Cause Analysis (RCA).

## Analysis Protocol

When an error occurs, do NOT immediately try to fix it. Follow these steps:

   1. **Log Capture**: Read the full stderr and stdout output.
   2. **Hypothesis Generation**:

* What was the expected outcome?
* What was the actual outcome?
* Identify the exact line of code or configuration causing the divergence.

   1. **Knowledge Base Check**: Check `docs/troubleshooting.md` (if it exists) to see if this error is a known issue.
   2. **Proposed Fix**: formulate a fix strategy.
   3. **Documentation**: After fixing, if the error was non-trivial, append a summary to `docs/troubleshooting.md` in the format: `[Error Message] -> <Cause> -> <Fix>`.

## Output Format

Present your analysis to the user:
> 🛑 Failure Detected
>
> * **Error**:
> * **Root Cause**: [Explanation]
> * **Proposed Fix**: [Action plan]
> * **Proceed with fix?**
