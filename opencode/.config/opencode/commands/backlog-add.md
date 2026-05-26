---
description: Add a new item to the current repo backlog
agent: build
---
Load the `add-to-backlog` skill and follow the workflow hosted in the current working repository's `docs/backlog/` directory.

User request:

$ARGUMENTS

Requirements:

- Read `docs/backlog/schema.md` and `docs/backlog/add-to-backlog.md` first.
- Support `local`, `github`, or `hybrid` backends based on the request or the clearest default.
- Capture branch, commit, dirty worktree state, affected paths, and enough context for later reassessment.
- If `docs/backlog/` is missing, report that and offer to initialize it instead of inventing a different process.
