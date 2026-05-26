---
name: check-backlog
description: Read and summarize backlog state from the current repo's docs/backlog workflow without making changes
metadata:
  host: docs/backlog
  scope: repo-local
---

## What I do

- Use the current working repository's `docs/backlog/` directory as the canonical backlog workflow.
- Read `docs/backlog/schema.md` and `docs/backlog/check-backlog.md` before reviewing items.
- Summarize local backlog items, GitHub issues, or both, depending on the backlog backend in use.
- Stay strictly read-only.

## Reporting focus

- counts by status and priority
- blocked and stale items
- items likely already fixed
- hybrid mismatches between local files and GitHub issues
- the next best candidates to consume

## Rules

- Do not edit backlog files.
- Do not comment on or update GitHub issues.
- Treat observations about stale or already-fixed items as suggestions until a consume workflow confirms them.
- If `docs/backlog/` is missing, report that clearly rather than improvising a different structure.
