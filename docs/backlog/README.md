# Backlog

This directory defines a tool-agnostic backlog workflow for capturing work without derailing the current task. It supports local Markdown files, GitHub issues, or a hybrid of both.

## Goals

- Capture bugs, issues, and follow-up work quickly.
- Preserve creation context so later agents can tell whether an item is still relevant.
- Support local and GitHub-backed backlog stores with the same operating model.
- Let later agents reassess, action, and update backlog items safely.

## Source Of Truth

- Canonical workflow docs live in `docs/backlog/` in the current working repository.
- Local backlog items live in `docs/backlog/items/`.
- GitHub-backed backlog items live as issues in the repository configured for the current project.
- Hybrid items may exist in both places and should cross-reference one another.

## Workflows

- `add-to-backlog.md` defines how to capture new work.
- `consume-from-backlog.md` defines how to reassess, action, and update existing work.
- `check-backlog.md` defines read-only backlog review.
- `schema.md` defines the shared metadata model.
- `github.md` defines GitHub issue conventions and mapping.
- `templates/item.md` is the starting point for local Markdown items.

## Operating Rules

- Always read `docs/backlog/schema.md` before creating or updating items.
- Prefer preserving history over deleting backlog entries.
- When consuming an item, reassess relevance before taking action.
- Record what changed, why the status changed, and what evidence was used.
- If an item was fixed incidentally, mark it accordingly instead of silently removing it.

## Recommended Status Values

- `open`
- `in_review`
- `in_progress`
- `blocked`
- `stale`
- `done`
- `invalid`
- `superseded`

## Recommended Relevance Outcomes

- `still_relevant`
- `already_fixed`
- `context_changed`
- `needs_human_review`
- `invalid`
