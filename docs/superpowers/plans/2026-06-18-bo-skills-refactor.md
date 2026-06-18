# bo-skills Skill Improvements Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix all issues identified in the thin-slicer skill review — rename all three skills to gerund form, improve thin-slicing's description/structure/correctness, and update documentation.

**Architecture:** All changes are in the `bo-skills` repo at `/Users/jabopiti/Projects/claude-skills/`. Each skill rename involves: renaming the directory, rebuilding the `.skill` ZIP, updating the `name` field in SKILL.md, and clearing/updating the plugin cache. After committing and pushing, the marketplace copy at `~/.claude/plugins/marketplaces/bo-skills/` needs a `git pull` and Claude Code restart to pick up changes.

**Tech Stack:** Bash (mv, zip), Markdown (skill files), Git

## Global Constraints

- Working directory: `/Users/jabopiti/Projects/claude-skills/` (the bo-skills repo)
- `.skill` files are ZIP archives with store (no) compression: `zip -r -0 <name>.skill <dir>/`
- After changes: commit + push; then `git pull` in `~/.claude/plugins/marketplaces/bo-skills/` and restart Claude Code
- Do not change any content in `skills/issue-tracker/` or `skills/farn-painter/` beyond the `name:` field in SKILL.md

---

### Task 1: Rename thin-slicer → thin-slicing (directory only; .skill rebuilt in Task 7 after content changes)

**Files:**
- Rename: `skills/thin-slicer/` → `skills/thin-slicing/`
- Delete: `skills/thin-slicer.skill` (new .skill built in Task 7 after all content edits)

- [ ] **Step 1: Rename the directory**

```bash
mv /Users/jabopiti/Projects/claude-skills/skills/thin-slicer /Users/jabopiti/Projects/claude-skills/skills/thin-slicing
```

- [ ] **Step 2: Delete the stale .skill file**

```bash
rm /Users/jabopiti/Projects/claude-skills/skills/thin-slicer.skill
```

- [ ] **Step 3: Verify**

```bash
ls /Users/jabopiti/Projects/claude-skills/skills/
```

Expected: `thin-slicing/` directory present; no `thin-slicer/` or `thin-slicer.skill`. No `thin-slicing.skill` yet (built in Task 7).

- [ ] **Step 4: Commit**

```bash
cd /Users/jabopiti/Projects/claude-skills
git add skills/thin-slicing/
git rm -r skills/thin-slicer.skill
git commit -m "feat: rename thin-slicer directory to thin-slicing"
```

---

### Task 2: Update thin-slicing/SKILL.md — name + description

**Files:**
- Modify: `skills/thin-slicing/SKILL.md` (frontmatter only)

- [ ] **Step 1: Update the `name` field and `description` in SKILL.md frontmatter**

Replace the current frontmatter (lines 1–11):

```yaml
---
name: thin-slicer
description: >
  Slice any product specification into thin, vertical, valuable slices according to a strict concept definition.
  Use when a user provides a PRD, epic, feature description, service blueprint, user story map, opportunity brief,
  RFC, jobs-to-be-done output, or any structured expression of product intent — and wants it broken into
  independently shippable, end-to-end slices. Trigger on phrases like "slice this spec", "break this into slices",
  "vertical slices", "what should we build first", "turn this PRD into stories", or any request to decompose
  a product document into deliverable increments. Also trigger when a user pastes a product document and asks
  what to build or how to sequence work.
---
```

With:

```yaml
---
name: thin-slicing
description: >
  Use when a user provides a PRD, epic, feature description, service blueprint, user story map, opportunity brief,
  RFC, jobs-to-be-done output, or any structured expression of product intent — and asks how to decompose or
  sequence it into deliverable increments. Trigger on phrases like "slice this spec", "break this into slices",
  "vertical slices", "what should we build first", "turn this PRD into stories", or any request to break a
  product document into shippable work. Also trigger when a user pastes a product document and asks what to
  build or how to sequence work.
---
```

- [ ] **Step 2: Verify**

```bash
head -12 /Users/jabopiti/Projects/claude-skills/skills/thin-slicing/SKILL.md
```

Expected: `name: thin-slicing` on line 2; description starts with `Use when a user provides...` on line 3.

- [ ] **Step 3: Commit**

```bash
cd /Users/jabopiti/Projects/claude-skills
git add skills/thin-slicing/SKILL.md
git commit -m "fix: rewrite thin-slicing description as triggers-only (SDO compliance)"
```

---

### Task 3: Add "When NOT to use" section + run checklist to thin-slicing/SKILL.md

**Files:**
- Modify: `skills/thin-slicing/SKILL.md`

- [ ] **Step 1: Replace the current "# Thin Slicer" header block**

Find this block (currently lines 13–21):

```markdown
# Thin Slicer

Decompose a product specification into thin, vertical, valuable slices — independently shippable, end-to-end
increments that satisfy a strict 7-criterion definition.

**Reference files** (load when indicated):
- `references/slice-definition.md` — full criterion definitions, tests, and failure modes. Load before Phase 3.
- `references/output-templates.md` — slice file and overview file templates. Load before Phase 4.

---
```

Replace with:

```markdown
# Thin Slicing

Decompose a product specification into thin, vertical, valuable slices — independently shippable, end-to-end
increments that satisfy a strict 7-criterion definition.

**Reference files** (load when indicated):
- `references/slice-definition.md` — full criterion definitions, tests, and failure modes. Load before Phase 3.
- `references/output-templates.md` — slice file and overview file templates. Load before Phase 4.

## When NOT to use

- Pure technical refactors with no named user-facing capability (no user role, no deliverable outcome)
- Documents describing capabilities already live in production with no new work being requested
- A spec already at single-slice granularity: one user, one trigger, one outcome, one execution path
- Bug reports, ADRs, investigation briefs, or post-mortems — no new capability is being specified

## Run checklist

Copy and track your progress:

- [ ] Phase 0 — Re-run check (skip if no existing slices provided)
- [ ] Phase 1 — Input elicitation complete
- [ ] Phase 2 — Slicing approach defined
- [ ] Phase 3 Pass 1 — Intent + Desirability
- [ ] Phase 3 Pass 2 — Thin + Vertical + Independence
- [ ] Phase 3 Pass 3 — Value + Completeness
- [ ] Phase 4 — Output written

---
```

- [ ] **Step 2: Verify**

```bash
grep -n "When NOT to use\|Run checklist\|Phase 0 —" /Users/jabopiti/Projects/claude-skills/skills/thin-slicing/SKILL.md | head -10
```

Expected: all three strings appear in the file.

- [ ] **Step 3: Commit**

```bash
cd /Users/jabopiti/Projects/claude-skills
git add skills/thin-slicing/SKILL.md
git commit -m "feat: add 'when NOT to use' section and run checklist to thin-slicing"
```

---

### Task 4: Add Phase 0 flowchart to thin-slicing/SKILL.md

**Files:**
- Modify: `skills/thin-slicing/SKILL.md`

- [ ] **Step 1: Replace Step 0.2 — Detect mode**

Find this block (currently beginning at the "### Step 0.2 — Detect mode" heading):

```markdown
### Step 0.2 — Detect mode

Analyse the new input against the current slice set. Determine:

**Mode A — Extend:** New input describes capabilities not covered by any current slice.
Indicators: new user roles, new capability units, new system areas, explicit "add this feature" framing.

**Mode B — Revise:** New input changes, corrects, or removes something already covered by a current slice.
Indicators: changed requirements, updated scope, role renamed, friction redefined, explicit "change this" framing.

**Mixed:** New input contains both. Run Mode B first, then Mode A on the same pass — revisions must be stable before new slices are added to the dependency chain.

State the detected mode and the reasoning before proceeding.
```

Replace with:

```markdown
### Step 0.2 — Detect mode

Analyse the new input against the current slice set using the decision tree below, then state the detected mode and reasoning before proceeding.

```dot
digraph mode_detection {
  rankdir=TB;
  "Existing slices provided?" [shape=diamond];
  "Skip Phase 0 → proceed to Phase 1" [shape=box];
  "Input adds capabilities\nnot in any current slice?" [shape=diamond];
  "Input revises/corrects\nan existing covered slice?" [shape=diamond];
  "Mode A — Extend" [shape=box];
  "Mode B — Revise" [shape=box];
  "Mode Mixed — B first, then A" [shape=box];

  "Existing slices provided?" -> "Skip Phase 0 → proceed to Phase 1" [label="no"];
  "Existing slices provided?" -> "Input adds capabilities\nnot in any current slice?" [label="yes"];
  "Input adds capabilities\nnot in any current slice?" -> "Input revises/corrects\nan existing covered slice?" [label="yes"];
  "Input adds capabilities\nnot in any current slice?" -> "Mode B — Revise" [label="no"];
  "Input revises/corrects\nan existing covered slice?" -> "Mode Mixed — B first, then A" [label="yes"];
  "Input revises/corrects\nan existing covered slice?" -> "Mode A — Extend" [label="no"];
}
\```

**Mode A — Extend:** New input describes capabilities not covered by any current slice.
Indicators: new user roles, new capability units, new system areas, explicit "add this feature" framing.

**Mode B — Revise:** New input changes, corrects, or removes something already covered by a current slice.
Indicators: changed requirements, updated scope, role renamed, friction redefined, explicit "change this" framing.

**Mixed:** New input contains both. Run Mode B first, then Mode A — revisions must be stable before new slices are added to the dependency chain.
```

- [ ] **Step 2: Verify**

```bash
grep -n "digraph mode_detection\|Mode Mixed\|rankdir" /Users/jabopiti/Projects/claude-skills/skills/thin-slicing/SKILL.md
```

Expected: all three strings present.

- [ ] **Step 3: Commit**

```bash
cd /Users/jabopiti/Projects/claude-skills
git add skills/thin-slicing/SKILL.md
git commit -m "feat: add flowchart to Phase 0 mode detection"
```

---

### Task 5: Add parallelism note + pass ordering fix + flags-additive note to thin-slicing/SKILL.md

**Files:**
- Modify: `skills/thin-slicing/SKILL.md`

- [ ] **Step 1: Add parallelism note and move token discipline to Phase 3 intro**

Find this block at the start of Phase 3 (currently):

```markdown
## Phase 3 — Iteration Passes

Load `references/slice-definition.md` now.

Run three passes over the full slice set. **Remediation limit: 2 rewrites per slice per pass.** If a slice still fails after 2 rewrites, accept the failure, flag the slice, and continue. Flagging is a last resort — the iteration log must show what was attempted.
```

Replace with:

```markdown
## Phase 3 — Iteration Passes

Load `references/slice-definition.md` now.

**Token discipline for this phase:**
- Approach summary (Phase 2): one sentence per capability. No full slice content.
- Within passes: one sentence per finding per slice. Do not restate criterion definitions inline.
- Do not repeat the slicing approach in the overview beyond the iteration log entry.

> **Parallelism:** Within each pass, slices are independent of each other — evaluate them simultaneously. Collect all pass results before proceeding to the next pass.

Run three passes over the full slice set. **Remediation limit: 2 rewrites per slice per pass.** If a slice still fails after 2 rewrites, accept the failure, flag the slice, and continue. Flagging is a last resort — the iteration log must show what was attempted.
```

- [ ] **Step 2: Fix Pass 2 Step 4 — add explicit pause instruction**

Find this block inside "### Pass 2 — Thin + Vertical + Independence", step 4:

```markdown
4. **Prerequisite slices created in this pass:**
   - Collect all newly created prerequisite slices as a batch.
   - Run a dependency sort: identify any internal dependencies between slices in the batch.
   - Order so no slice depends on an unprocessed slice in the same batch.
   - Add to the working slice set in sorted order.
   - Re-enter each from Pass 1. Subject to all passes and all remediation limits.
```

Replace with:

```markdown
4. **Prerequisite slices created in this pass:**
   - Collect all newly created prerequisite slices as a batch.
   - Run a dependency sort: identify any internal dependencies between slices in the batch.
   - Order so no slice depends on an unprocessed slice in the same batch.
   - Add to the working slice set in sorted order.
   - **Pause Pass 2 on remaining original slices.** Complete Pass 1 and Pass 2 for all prerequisite slices before continuing Pass 2 on any remaining original slices. Do not interleave original slices with prerequisites mid-pass.
   - Subject to all passes and all remediation limits.
```

- [ ] **Step 3: Add flags-are-additive note to the Failure handling section**

Find the failure handling table (starts with `| Failure | Remediation before flagging |`). After the closing `|` of the table, add:

```markdown

**Flags are additive.** A slice flagged in Pass 1 still proceeds through Pass 2 and Pass 3 — each pass evaluates different criteria independently. A flag does not end evaluation for that slice.
```

- [ ] **Step 4: Remove the old Token discipline section at the bottom (do this AFTER Step 1 has added the new version)**

Find and delete this section at the end of the file (it has been superseded by the Phase 3 intro block added in Step 1):

```markdown
## Token discipline

- Load reference files only when the phase requires them.
- Phase 2 summary: one sentence per capability, no full slice content.
- Do not restate the criterion list inside slice files — the definition lives in the reference file.
- Do not repeat the slicing approach in the overview beyond the iteration log entry.
```

- [ ] **Step 5: Verify**

```bash
grep -n "Parallelism\|Pause Pass 2\|Flags are additive\|Token discipline" /Users/jabopiti/Projects/claude-skills/skills/thin-slicing/SKILL.md
```

Expected: all four strings appear, and "Token discipline" appears once only (in Phase 3 intro, not at the bottom).

- [ ] **Step 6: Commit**

```bash
cd /Users/jabopiti/Projects/claude-skills
git add skills/thin-slicing/SKILL.md
git commit -m "feat: add parallelism note, pass ordering fix, flags-additive clarification, move token discipline to Phase 3"
```

---

### Task 6: Add ToC to both reference files

**Files:**
- Modify: `skills/thin-slicing/references/slice-definition.md`
- Modify: `skills/thin-slicing/references/output-templates.md`

- [ ] **Step 1: Add ToC to slice-definition.md**

After the first line (`# Slice Definition — Full Reference`), insert:

```markdown

## Contents

- [Criterion 1 — Intent](#criterion-1--intent)
- [Criterion 2 — Thin](#criterion-2--thin)
- [Criterion 3 — Vertical](#criterion-3--vertical)
- [Criterion 4 — Valuable](#criterion-4--valuable)
- [Criterion 5 — Independent](#criterion-5--independent)
- [Criterion 6 — Complete (specification)](#criterion-6--complete-specification)
- [Criterion 7 — Complete (delivery)](#criterion-7--complete-delivery)
- [Failure modes to watch](#failure-modes-to-watch)

---

```

- [ ] **Step 2: Add ToC to output-templates.md**

After the first line (`# Output Templates`), insert:

```markdown

## Contents

- [Template A — Individual Slice File](#template-a--individual-slice-file)
- [Template B — Overview File](#template-b--overview-file)

---

```

- [ ] **Step 3: Verify**

```bash
head -15 /Users/jabopiti/Projects/claude-skills/skills/thin-slicing/references/slice-definition.md
head -10 /Users/jabopiti/Projects/claude-skills/skills/thin-slicing/references/output-templates.md
```

Expected: both files show a `## Contents` section with links immediately after the title.

- [ ] **Step 4: Commit**

```bash
cd /Users/jabopiti/Projects/claude-skills
git add skills/thin-slicing/references/
git commit -m "feat: add table of contents to thin-slicing reference files"
```

---

### Task 7: Rebuild thin-slicing.skill with all content changes

After all content edits to `skills/thin-slicing/`, the `.skill` ZIP must be rebuilt to include the updated files.

**Files:**
- Rebuild: `skills/thin-slicing.skill`

- [ ] **Step 1: Delete the existing .skill file**

```bash
rm /Users/jabopiti/Projects/claude-skills/skills/thin-slicing.skill
```

- [ ] **Step 2: Rebuild the ZIP**

```bash
cd /Users/jabopiti/Projects/claude-skills/skills
zip -r -0 thin-slicing.skill thin-slicing/
```

- [ ] **Step 3: Verify the ZIP contains updated content**

```bash
cd /tmp && unzip -p /Users/jabopiti/Projects/claude-skills/skills/thin-slicing.skill thin-slicing/SKILL.md | head -15
```

Expected: shows `name: thin-slicing` and the updated triggers-only description.

- [ ] **Step 4: Commit**

```bash
cd /Users/jabopiti/Projects/claude-skills
git add skills/thin-slicing.skill
git commit -m "chore: rebuild thin-slicing.skill with all content improvements"
```

---

### Task 8: Rename issue-tracker → tracking-issues

**Files:**
- Rename: `skills/issue-tracker/` → `skills/tracking-issues/`
- Modify: `skills/tracking-issues/SKILL.md` (name field only)
- Delete: `skills/issue-tracker.skill`
- Create: `skills/tracking-issues.skill`

- [ ] **Step 1: Rename the directory**

```bash
mv /Users/jabopiti/Projects/claude-skills/skills/issue-tracker /Users/jabopiti/Projects/claude-skills/skills/tracking-issues
```

- [ ] **Step 2: Update the `name` field in SKILL.md**

In `skills/tracking-issues/SKILL.md`, change line 2 from:
```yaml
name: issue-tracker
```
to:
```yaml
name: tracking-issues
```

- [ ] **Step 3: Rebuild the .skill ZIP**

```bash
rm /Users/jabopiti/Projects/claude-skills/skills/issue-tracker.skill
cd /Users/jabopiti/Projects/claude-skills/skills
zip -r -0 tracking-issues.skill tracking-issues/
```

- [ ] **Step 4: Verify**

```bash
ls /Users/jabopiti/Projects/claude-skills/skills/
grep "^name:" /Users/jabopiti/Projects/claude-skills/skills/tracking-issues/SKILL.md
```

Expected: `tracking-issues/` and `tracking-issues.skill` present, no `issue-tracker*` entries; name field shows `tracking-issues`.

- [ ] **Step 5: Commit**

```bash
cd /Users/jabopiti/Projects/claude-skills
git add skills/tracking-issues/ skills/tracking-issues.skill
git rm skills/issue-tracker.skill
git commit -m "feat: rename issue-tracker to tracking-issues"
```

---

### Task 9: Rename farn-painter → styling-with-farn

**Files:**
- Rename: `skills/farn-painter/` → `skills/styling-with-farn/`
- Modify: `skills/styling-with-farn/SKILL.md` (name field only)
- Delete: `skills/farn-painter.skill`
- Create: `skills/styling-with-farn.skill`

- [ ] **Step 1: Rename the directory**

```bash
mv /Users/jabopiti/Projects/claude-skills/skills/farn-painter /Users/jabopiti/Projects/claude-skills/skills/styling-with-farn
```

- [ ] **Step 2: Update the `name` field in SKILL.md**

In `skills/styling-with-farn/SKILL.md`, change line 2 from:
```yaml
name: farn-painter
```
to:
```yaml
name: styling-with-farn
```

- [ ] **Step 3: Rebuild the .skill ZIP**

```bash
rm /Users/jabopiti/Projects/claude-skills/skills/farn-painter.skill
cd /Users/jabopiti/Projects/claude-skills/skills
zip -r -0 styling-with-farn.skill styling-with-farn/
```

- [ ] **Step 4: Verify**

```bash
ls /Users/jabopiti/Projects/claude-skills/skills/
grep "^name:" /Users/jabopiti/Projects/claude-skills/skills/styling-with-farn/SKILL.md
```

Expected: `styling-with-farn/` and `styling-with-farn.skill` present, no `farn-painter*` entries.

- [ ] **Step 5: Commit**

```bash
cd /Users/jabopiti/Projects/claude-skills
git add skills/styling-with-farn/ skills/styling-with-farn.skill
git rm skills/farn-painter.skill
git commit -m "feat: rename farn-painter to styling-with-farn"
```

---

### Task 10: Update README.md, plugin.json, and marketplace.json with new skill names

**Files:**
- Modify: `README.md`
- Modify: `.claude-plugin/plugin.json`
- Modify: `.claude-plugin/marketplace.json`

- [ ] **Step 1: Update README.md**

Apply these exact replacements (all occurrences):

```bash
cd /Users/jabopiti/Projects/claude-skills

# Section headers
sed -i '' 's/### thin-slicer/### thin-slicing/g' README.md
sed -i '' 's/### issue-tracker/### tracking-issues/g' README.md
sed -i '' 's/### farn-painter/### styling-with-farn/g' README.md

# Directory links
sed -i '' 's|skills/thin-slicer/|skills/thin-slicing/|g' README.md
sed -i '' 's|skills/issue-tracker/|skills/tracking-issues/|g' README.md
sed -i '' 's|skills/farn-painter/|skills/styling-with-farn/|g' README.md

# Skill invocation names in backticks
sed -i '' 's/`bo-skills:thin-slicer`/`bo-skills:thin-slicing`/g' README.md
sed -i '' 's/`bo-skills:issue-tracker`/`bo-skills:tracking-issues`/g' README.md
sed -i '' 's/`bo-skills:farn-painter`/`bo-skills:styling-with-farn`/g' README.md
sed -i '' 's/`thin-slicer`/`thin-slicing`/g' README.md
sed -i '' 's/`issue-tracker`/`tracking-issues`/g' README.md
sed -i '' 's/`farn-painter`/`styling-with-farn`/g' README.md

# Section title "Setting up issue-tracker..."
sed -i '' 's/## Setting up issue-tracker/## Setting up tracking-issues/g' README.md

# Prose references
sed -i '' 's/The issue-tracker skill/The tracking-issues skill/g' README.md
```

- [ ] **Step 2: Update plugin.json description**

In `.claude-plugin/plugin.json`, change:
```json
"description": "Shareable Claude skills by Jacob Lueg Tiedemann — issue-tracker (GitHub issue workflow), thin-slicer (product decomposition), and more."
```
to:
```json
"description": "Shareable Claude skills by Jacob Lueg Tiedemann — tracking-issues (GitHub issue workflow), thin-slicing (product decomposition), and more."
```

- [ ] **Step 3: Update marketplace.json description**

In `.claude-plugin/marketplace.json`, change:
```json
"description": "Shareable Claude skills — issue-tracker, thin-slicer, and more"
```
to:
```json
"description": "Shareable Claude skills — tracking-issues, thin-slicing, and more"
```

- [ ] **Step 4: Verify no old names remain**

```bash
grep -c "thin-slicer\|issue-tracker\|farn-painter" /Users/jabopiti/Projects/claude-skills/README.md
grep -c "thin-slicer\|issue-tracker\|farn-painter" /Users/jabopiti/Projects/claude-skills/.claude-plugin/plugin.json
grep -c "thin-slicer\|issue-tracker\|farn-painter" /Users/jabopiti/Projects/claude-skills/.claude-plugin/marketplace.json
```

Expected: all three commands return `0`.

- [ ] **Step 5: Commit**

```bash
cd /Users/jabopiti/Projects/claude-skills
git add README.md .claude-plugin/plugin.json .claude-plugin/marketplace.json
git commit -m "docs: update all skill name references after rename"
```

---

### Task 11: Sync marketplace + push

- [ ] **Step 1: Push all commits**

```bash
cd /Users/jabopiti/Projects/claude-skills
git push
```

- [ ] **Step 2: Pull in the marketplace copy**

```bash
cd /Users/jabopiti/.claude/plugins/marketplaces/bo-skills
git pull
```

- [ ] **Step 3: Clear the plugin cache so renamed skills are picked up**

```bash
rm -rf /Users/jabopiti/.claude/plugins/cache/bo-skills/
```

- [ ] **Step 4: Verify cache is cleared**

```bash
ls /Users/jabopiti/.claude/plugins/cache/ | grep bo-skills
```

Expected: no output (cache directory removed; will regenerate on next Claude Code restart).

- [ ] **Step 5: Restart Claude Code**

Restart the Claude Code app to trigger cache regeneration from the updated marketplace.

After restart, verify the new skill names appear:

Ask Claude: "What bo-skills skills are available?" — expected answer includes `tracking-issues`, `thin-slicing`, `styling-with-farn`.
