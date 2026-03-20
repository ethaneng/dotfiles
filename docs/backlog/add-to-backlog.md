# Add To Backlog

Use this workflow when you discover work that should be captured without interrupting the current task.

## Inputs To Gather

- Short title.
- Summary of the issue, task, or follow-up.
- Backend choice: `local`, `github`, or `hybrid`.
- Current repo context.
- Optional evidence such as paths, logs, links, and screenshots.

## Required Capture Context

At creation time, capture:

- current branch
- current commit SHA
- whether the worktree is dirty
- affected files or areas when known
- why this is being deferred

## Backend Rules

### Local

- Create a Markdown file in `docs/backlog/items/` using `templates/item.md`.
- Assign the next available backlog ID.
- Use a filename like `BL-0001-short-slug.md`.

### GitHub

- Create a GitHub issue in the current repository or configured backlog repository.
- Include the same metadata in the issue body under a `Metadata` section.
- Apply repo-appropriate labels such as `backlog`, `bug`, `task`, or `follow-up`.

### Hybrid

- Create both the local item and the GitHub issue.
- Cross-link them with `github_issue`, `github_url`, and a local file link in the issue body.

## Creation Steps

1. Read `docs/backlog/schema.md`.
2. Determine backend.
3. Gather git metadata from the current repository.
4. Create the item in the selected backend.
5. Add enough context that another agent can understand the issue later.
6. Set `status: open` unless there is a stronger reason to use another status.
7. Set `updated_at` to the creation timestamp.

## Notes To Include

- what was observed
- why it is not being addressed now
- how to verify it later
- what code, screen, command, or behavior was involved

## Do Not

- silently drop important context
- create vague one-line items that cannot be reassessed later
- mark an item `in_progress` unless active work is starting now
- assume a GitHub issue alone contains enough metadata unless the metadata section is present
