# Consume From Backlog

Use this workflow when picking up an existing backlog item to reassess it, act on it, or close it out.

## First Principle

Do not assume the backlog item is still valid. Relevance assessment comes before implementation.

## Relevance Checklist

Before taking action, check:

- whether the issue still reproduces in the current codebase
- whether the affected files or behavior have changed since `created_from_commit`
- whether tests, docs, or code already resolved the issue
- whether the linked GitHub issue is already closed or superseded
- whether current product or application context makes the task obsolete

## Relevance Outcomes

After reassessment, set one of:

- `still_relevant`
- `already_fixed`
- `context_changed`
- `needs_human_review`
- `invalid`

Record the rationale in `relevance_notes` and update `last_relevance_check_at`.

## Action Paths

### Still Relevant

- Set `status` to `in_review` or `in_progress`.
- Perform the work.
- Update `Action Notes` and `Status Updates` with what changed.

### Already Fixed

- Set `relevance_status: already_fixed`.
- Set `status: done` if the intended outcome is satisfied.
- Record the commit, PR, or evidence when available.

### Context Changed

- Set `relevance_status: context_changed`.
- Mark `status: stale` or `superseded` depending on the evidence.
- Point to the replacement item, doc, issue, or code path when known.

### Needs Human Review

- Set `relevance_status: needs_human_review`.
- Set `status: blocked` if progress cannot continue safely.
- Add a concise note describing the unknowns.

### Invalid

- Set `relevance_status: invalid`.
- Set `status: invalid`.
- Explain why the original assumption was wrong.

## Update Rules

- Always update `updated_at`.
- Preserve earlier notes; append new notes rather than overwriting history.
- If the backend is GitHub or hybrid, add a comment or body update describing the reassessment.
- If work resolves the item, record `resolution_commit`, `resolution_pr`, and `closed_at` when known.

## Minimum Status Update

Every consume action should leave behind:

- latest relevance decision
- evidence used
- current status
- next step or closure reason
