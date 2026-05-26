---
name: add-to-backlog
description: Capture deferred work in the current repo's docs/backlog workflow using local files, GitHub issues, or both
metadata:
  host: docs/backlog
  scope: repo-local
---

## What I do

- Use the current working repository's `docs/backlog/` directory as the canonical backlog workflow.
- Read `docs/backlog/schema.md` and `docs/backlog/add-to-backlog.md` before creating anything.
- Support `local`, `github`, and `hybrid` backlog backends.
- Capture creation metadata such as branch, commit, dirty worktree state, affected paths, and supporting context.

## How to work

1. Confirm the current repository contains `docs/backlog/`.
2. Read the schema and add workflow docs.
3. Gather the title, summary, backend, and current git metadata.
4. For local items, create a Markdown file in `docs/backlog/items/` using the template.
5. For GitHub items, create an issue that includes the metadata section described in `docs/backlog/github.md`.
6. For hybrid items, create both and cross-link them.
7. Leave enough context that another agent can reassess the item later.

## Rules

- Treat `docs/backlog/` in the working repo as the source of truth for the process.
- Do not invent schema fields when existing ones are enough.
- Do not silently skip creation metadata.
- If `docs/backlog/` is missing, report that clearly and offer to initialize it instead of improvising a different structure.
