---
description: Reassess and action a backlog item in the current repo
agent: build
---
Load the `consume-from-backlog` skill and follow the workflow hosted in the current working repository's `docs/backlog/` directory.

User request:

$ARGUMENTS

Requirements:

- Read `docs/backlog/schema.md` and `docs/backlog/consume-from-backlog.md` first.
- Reassess relevance before doing implementation work.
- Check whether the issue still exists, was already fixed, became stale, or was superseded.
- Update backlog status, relevance metadata, and comments or issue updates when the backend requires it.
- If `docs/backlog/` is missing, report that and do not invent a different process.
