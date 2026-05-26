---
description: Read and summarize backlog status for the current repo
agent: plan
---
Load the `check-backlog` skill and follow the workflow hosted in the current working repository's `docs/backlog/` directory.

User request:

$ARGUMENTS

Requirements:

- Read `docs/backlog/schema.md` and `docs/backlog/check-backlog.md` first.
- Stay read-only.
- Summarize counts by status and priority, stale or blocked items, likely already-fixed items, and any local or GitHub mismatches.
- If `docs/backlog/` is missing, report that and do not invent a different process.
