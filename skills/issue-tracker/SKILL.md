---
name: issue-tracker
description: Use when creating a new GitHub issue, picking up an existing issue to implement, closing or updating an issue, or when you discover deferred work, a bug, or a gap that needs documenting. Invoke before any issue-related action — do not create, update, or close issues without reading this skill first. Also triggers on phrases like "log this", "track this", "file an issue for", "pick up issue #N", "what issues are open", or "document this for later".
---

# Issue Tracker

Manages the full lifecycle of GitHub issues and the project kanban board. Works in any repo set up with the standard Bo. issue workflow.

## First: check setup

Look for `.claude/issue-config.json` in the current repo root.

- **Found** → read it for the project ID and all field/option IDs, then proceed below.
- **Not found** → this repo isn't set up yet. Read `references/setup.md` and complete setup before doing anything else.

All commands below use values from `issue-config.json`. Read that file once at the start of the session and reuse the values throughout.

---

## Status lifecycle

| Status | Meaning |
|--------|---------|
| **Backlog** | Filed, not yet ready to start — default for all new issues |
| **Ready** | All open questions resolved, decisions recorded, description complete — safe to implement |
| **In progress** | Being actively worked on in the current session |
| **In review** | PR open awaiting merge, or high-risk change awaiting explicit user sign-off |
| **Done** | PR merged, or issue closed without a PR |

Never move directly from **In progress → Done** if a PR was opened — it must pass through **In review**.

---

## Creating an issue

Use when deferring work, documenting a discovered bug or gap, or when asked to file a new issue.

**1. Create the issue** using the task template (GitHub will load it automatically):
```bash
gh issue create --repo <owner>/<repo>
```

Template sections: Gap/Problem · Complexity · Risk · Files likely touched · Depends on · Before coding · Open Questions · Decisions · Acceptance criteria.

Required at filing: **Gap/Problem** and **Acceptance Criteria** (rough draft is fine). All other sections can be left blank if unknown. Post research findings and decisions as **issue comments** — never edit the original issue body after filing, to preserve a timestamped trail.

**2. Add to the board and set Complexity + Risk:**
```bash
ITEM_ID=$(gh project item-add <project_number> --owner <owner> \
  --url <issue-url> --format json | jq -r '.id')

gh project item-edit --project-id <project_id> --id $ITEM_ID \
  --field-id <fields.Complexity.id> \
  --single-select-option-id <fields.Complexity.options.<value>>

gh project item-edit --project-id <project_id> --id $ITEM_ID \
  --field-id <fields.Risk.id> \
  --single-select-option-id <fields.Risk.options.<value>>
```

Status defaults to Backlog — no need to set it explicitly.

---

## Moving an issue to Ready

An issue is Ready when ALL of these are true:
- "Before coding" research is complete, with findings posted as an issue comment
- All Open Questions are answered and struck through or removed from the issue body
- All key Decisions are recorded in the Decisions section of the issue
- The description is complete — no blanks that would block implementation
- Dependencies are closed or confirmed not blocking
- If Risk is `high`: the user has explicitly signed off

```bash
gh project item-edit --project-id <project_id> --id <item_id> \
  --field-id <fields.Status.id> \
  --single-select-option-id <fields.Status.options.Ready>
```

---

## Picking up an issue

1. Read the full issue and all referenced files before forming a plan:
   ```bash
   gh issue view <N> --repo <owner>/<repo>
   ```
2. Confirm "Before coding" research is done — if not, complete it and post findings as a comment first.
3. Confirm dependencies are closed.
4. If Risk is `high`, use AskUserQuestion to get explicit sign-off before writing any code.
5. Set Status → In progress:
   ```bash
   gh project item-edit --project-id <project_id> --id <item_id> \
     --field-id <fields.Status.id> \
     --single-select-option-id <fields.Status.options.In progress>
   ```
6. Implement. Commit with `Closes #N` in the commit or PR body.
7. Open a PR, then set Status → In review:
   ```bash
   gh project item-edit --project-id <project_id> --id <item_id> \
     --field-id <fields.Status.id> \
     --single-select-option-id <fields.Status.options.In review>
   ```

---

## Closing an issue

After the PR is merged (or closing without a PR):
```bash
gh issue close <N> --repo <owner>/<repo>

gh project item-edit --project-id <project_id> --id <item_id> \
  --field-id <fields.Status.id> \
  --single-select-option-id <fields.Status.options.Done>
```

---

## Dropping an issue (won't fix)

```bash
gh issue close <N> --repo <owner>/<repo> --reason "not planned"
# Add a comment explaining why
```
Then set Status → Done on the board.

---

## Bundling issues

Before starting work, check "Files likely touched" across open issues. Heavy overlap means co-implement and close both with `Closes #A, Closes #B` in the PR body.

---

## Looking up a board item ID

```bash
gh project item-list <project_number> --owner <owner> --format json \
  | jq -r '.items[] | select(.content.url=="<issue-url>") | .id'
```
