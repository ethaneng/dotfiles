---
name: consume-from-backlog
description: Reassess and action backlog items from the current repo's docs/backlog workflow, updating status and comments as needed
metadata:
  host: docs/backlog
  scope: repo-local
---

## What I do

- Use the current working repository's `docs/backlog/` directory as the canonical backlog workflow.
- Read `docs/backlog/schema.md` and `docs/backlog/consume-from-backlog.md` before acting.
- Reassess whether a backlog item is still relevant before implementation.
- Update local backlog files and GitHub issues when the selected backend requires it.

## Relevance-first workflow

1. Read the backlog item and its metadata.
2. Check whether the issue still exists, whether the codebase changed, and whether the item is already fixed, invalid, or superseded.
3. Record `last_relevance_check_at`, `relevance_status`, and `relevance_notes`.
4. Only then choose whether to implement, defer, block, or close the item.
5. Update `status`, `updated_at`, and any resolution metadata.

## Rules

- Never assume an old backlog item is still actionable.
- Preserve history; append status updates instead of erasing prior notes.
- If the backend is GitHub or hybrid, leave a factual issue update or comment when status meaningfully changes.
- If `docs/backlog/` is missing, report that clearly and do not invent an alternate backlog process.
