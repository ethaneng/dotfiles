# Backlog Schema

Backlog items use YAML frontmatter followed by freeform Markdown notes.

## Required Fields

```yaml
id: BL-0001
title: Short action-oriented title
status: open
backend: local
repo: owner/repo
created_at: 2026-03-20T12:00:00Z
created_from_branch: feat/example
created_from_commit: abcdef1234567890abcdef1234567890abcdef12
```

## Recommended Fields

```yaml
priority: medium
tags:
  - bug
source: user-report
paths:
  - src/example.ts
links:
  - https://github.com/owner/repo/issues/123
created_from_dirty_worktree: false
github_issue: 123
github_url: https://github.com/owner/repo/issues/123
last_relevance_check_at: 2026-03-20T12:30:00Z
relevance_status: still_relevant
relevance_notes: Confirmed bug still reproduces on main.
resolution_commit: fedcba9876543210fedcba9876543210fedcba98
resolution_pr: 456
closed_at: 2026-03-20T13:00:00Z
updated_at: 2026-03-20T13:00:00Z
```

## Field Definitions

- `id`: Stable backlog identifier. Use a repo-local identifier such as `BL-0001`.
- `title`: Short summary of the work item.
- `status`: Current backlog state.
- `backend`: `local`, `github`, or `hybrid`.
- `repo`: Repository slug, usually `owner/repo` or a local repo name if no remote exists.
- `created_at`: ISO-8601 UTC timestamp.
- `created_from_branch`: Branch name at capture time.
- `created_from_commit`: Commit SHA at capture time.
- `priority`: `low`, `medium`, `high`, or a repo-specific extension.
- `tags`: Short labels for grouping.
- `source`: Where the item came from, such as `user-report`, `code-review`, `incident`, or `follow-up`.
- `paths`: Files or directories likely involved.
- `links`: Relevant URLs, docs, issues, or PRs.
- `created_from_dirty_worktree`: Whether the worktree had uncommitted changes when captured.
- `github_issue`: Numeric GitHub issue number when applicable.
- `github_url`: Full GitHub issue URL when applicable.
- `last_relevance_check_at`: Last time the item was reassessed.
- `relevance_status`: Current relevance outcome.
- `relevance_notes`: Short rationale for the latest relevance decision.
- `resolution_commit`: Commit that resolved the item, if known.
- `resolution_pr`: PR that resolved the item, if known.
- `closed_at`: ISO-8601 UTC timestamp when marked complete, invalid, or superseded.
- `updated_at`: ISO-8601 UTC timestamp of the latest edit.

## Status Semantics

- `open`: Captured and not yet being worked.
- `in_review`: Under investigation or being reassessed.
- `in_progress`: Actively being worked.
- `blocked`: Cannot proceed without external input or dependency.
- `stale`: May no longer matter, but not yet invalidated.
- `done`: Completed and no longer actionable.
- `invalid`: Not actionable because the premise is wrong or obsolete.
- `superseded`: Replaced by another item, issue, or change.

## Relevance Semantics

- `still_relevant`: Work remains valid and actionable.
- `already_fixed`: Current code or released changes already solved it.
- `context_changed`: The system changed enough that the original framing is outdated.
- `needs_human_review`: Not enough confidence to close or action automatically.
- `invalid`: The item was based on incorrect assumptions.

## Markdown Body Structure

Use these sections after frontmatter.

```md
## Summary

## Context

## Evidence

## Action Notes

## Status Updates
```

The body does not need to stay rigid, but status and relevance updates should remain easy to scan.
