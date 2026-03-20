# GitHub Mapping

Use this document when the backlog backend includes GitHub issues.

## Recommended Labels

- `backlog`
- `bug`
- `task`
- `follow-up`
- `blocked`
- `stale`

Use project-specific labels in addition to these when helpful.

## Recommended Issue Body Shape

```md
## Summary

Short description of the issue or deferred work.

## Context

- Why it was captured
- What area is affected
- How to verify it later

## Metadata

- backlog_id: BL-0001
- status: open
- backend: github
- repo: owner/repo
- created_at: 2026-03-20T12:00:00Z
- created_from_branch: feat/example
- created_from_commit: abcdef1234567890abcdef1234567890abcdef12
- created_from_dirty_worktree: false
- priority: medium
- tags: bug, follow-up

## Evidence

- Logs, links, screenshots, or paths
```

## Local To GitHub Mapping

- `id` -> `backlog_id` line in issue body
- `title` -> issue title
- `status` -> metadata line and optional labels
- `backend` -> metadata line
- `repo` -> metadata line
- `paths` -> context or evidence section
- `links` -> context or evidence section
- `github_issue` -> issue number in local file
- `github_url` -> issue URL in local file

## Commenting Rules

When a backlog item is reassessed or actioned:

- add a GitHub comment for important status changes
- include evidence for `already_fixed`, `invalid`, or `superseded`
- mention commit or PR references when available
- keep comments short and factual

## Hybrid Consistency Rules

- local file and issue should share the same backlog ID
- status changes should be reflected in both places
- if one side cannot be updated, record the mismatch in the other place when possible
