# Check Backlog

Use this workflow for a read-only review of backlog state.

## Purpose

- understand backlog size and health
- identify stale, blocked, or already-fixed items
- review priorities without making changes

## Read-Only Rules

- do not edit local backlog files
- do not comment on or modify GitHub issues
- do not change status or relevance metadata

## What To Review

- counts by `status`
- counts by `priority`
- oldest open items
- blocked items
- stale items
- items likely already fixed based on current repo context
- GitHub issues that no longer match local state in hybrid mode

## Expected Output

Produce a concise report with:

- overall backlog summary
- highest-priority actionable items
- items needing relevance reassessment
- mismatches between local and GitHub state
- suggested next items to consume

## Heuristics

During read-only review, it is acceptable to flag likely issues such as:

- a task references files that no longer exist
- a bug references behavior already covered by newer tests
- a GitHub issue is closed while the local item remains open
- a local item is done while the GitHub issue is still open

Flag these as observations only. Do not update the backlog from this workflow.
