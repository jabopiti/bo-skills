# Output Templates

## Contents

- [Template A — Individual Slice File](#template-a--individual-slice-file)
- [Template B — Overview File](#template-b--overview-file)

---

## Template A — Individual Slice File

File naming: `slice-{NNN}-{kebab-case-title}.md`
Example: `slice-001-delegate-assignment.md`

---

```markdown
---
slice_id: "{NNN}"
title: "{Slice title}"
status: "{valid | flagged}"
criteria_failures: []       # list criterion names if flagged; empty if valid
depends_on: []              # slice IDs of prerequisite slices; empty if none
verification_status: null   # set to "unverified — tech/architecture context absent from input" if applicable; otherwise omit
superseded_by: null         # set to new canonical slice ID if this slice has been revised; otherwise omit
supersedes: null            # set to original slice ID if this is a revised slice; otherwise omit
change_summary: null        # one sentence: what changed and why. Required if supersedes is set; otherwise omit
---

# {Slice title}

## Intent

**Problem statement:** {Named role} cannot {accomplish specific goal} when {specific context} because {specific gap or friction}.

**Outcome statement:** This slice contributes to {outcome} by enabling {specific capability}.

## Scope

{Concise bullet list of what is in scope — minimum viable set only.}

**Explicitly excluded:** {At least one named item with a one-sentence rationale: "[Item] — removing this does not break core behaviour because [reason]." If nothing was excluded: "Scope was already minimal on first read — no items removed."}

## Execution path

{Step-by-step trace from user trigger to user outcome. Each step must be real, no stubs or mocks.}

1. User triggers: {trigger action}
2. {Layer}: {what happens}
3. {Layer}: {what happens}
4. User receives: {outcome}

## Value

- **Desirable:** {Named user type} would seek this capability because {specific reason}.
- **Usable:** A user can {trigger action}, receive {outcome}, and knows to {next action} — without guidance.
- **Valuable:** After this slice is live, {named role} can now {specific capability} / no longer needs to {specific friction}.

## Acceptance criteria

{Written so a non-author can verify independently, without access to the author or internal context.}

- [ ] Given {precondition}, when {action}, then {outcome}.
- [ ] Given {precondition}, when {action}, then {outcome}.
- [ ] ...

## Delivery gate

- [ ] Deployed to production-equivalent environment
- [ ] Demonstrated to at least one external stakeholder (user, customer, or business owner)

## Flags and compromises

{Leave empty if slice fully passes all criteria. If flagged: name the criterion, explain why it could not be met, and what was attempted.}
```

---

## Template B — Overview File

File naming: `slices-overview.md`

---

```markdown
---
generated_from: "{source document title or description}"
total_slices: {N}
valid_slices: {N}
flagged_slices: {N}
---

# Slice Overview

## Source

{One-sentence description of the input document and its scope.}

## Slicing intent

{Why this document was sliced this way — the approach taken, the order chosen, and the dependency chain rationale.}

## Slice index

| ID | Title | Status | Depends on |
|---|---|---|---|
| 001 | {Title} | ✅ valid | — |
| 002 | {Title} | ✅ valid | 001 |
| 003 | {Title} | ⚠️ flagged | 001, 002 |

## Dependency chain

{One entry per slice in delivery order. Format:}

- Slice {ID} "{Title}": depends on [{ID list} | none] — {one sentence: why this dependency exists or why the slice is independent}.

## Assumptions made

{List any assumptions the skill made when input was incomplete. Each assumption names the missing input, what was inferred, and where it affects the slices.}

- **{Missing input}:** Assumed {inference}. Affects slices: {IDs}.

## Limitations and compromises

{Honest account of where the slices fall short and why. This section must be populated if any slice is flagged. If all slices are valid, state that explicitly.}

### {Slice ID} — {criterion that failed}
{What was attempted across iteration cycles. Why the criterion could not be met. What the consequence is for the team consuming this output.}

## Iteration log

{Brief record of what changed across passes — useful context for agents revisiting or extending the slice set.}

Initial run entries:
- **Pass 1 (Intent + Desirability):** {What was rewritten or flagged}
- **Pass 2 (Thin + Vertical + Independence):** {What was stripped, restructured, or split}
- **Pass 3 (Value + Completeness):** {What acceptance criteria were added or tightened}

Re-run entries (append; do not overwrite prior entries):
- **Re-run {date or sequence number} — Mode {A | B | Mixed}:** {What changed in the new input. Which slices were superseded. Which slices were reviewed and found unchanged. Which new slices were added.}
```
