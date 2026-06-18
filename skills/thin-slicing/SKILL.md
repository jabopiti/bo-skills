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

# Thin Slicer

Decompose a product specification into thin, vertical, valuable slices — independently shippable, end-to-end
increments that satisfy a strict 7-criterion definition.

**Reference files** (load when indicated):
- `references/slice-definition.md` — full criterion definitions, tests, and failure modes. Load before Phase 3.
- `references/output-templates.md` — slice file and overview file templates. Load before Phase 4.

---

## Phase 0 — Re-run (existing slice set)

Skip this phase entirely if no existing slice files are provided. Proceed to Phase 1.

If existing slice files are provided alongside new input, this is a re-run. Execute Phase 0 before Phase 1.

### Step 0.1 — Reconstruct the slice set

Read all provided slice files. Extract from each:
- `slice_id`, `title`, `status`, `depends_on`, `superseded_by` (if present)

Discard any slice where `superseded_by` is populated — it is no longer canonical.
Build the current dependency graph from the remaining slices.

### Step 0.2 — Detect mode

Analyse the new input against the current slice set. Determine:

**Mode A — Extend:** New input describes capabilities not covered by any current slice.
Indicators: new user roles, new capability units, new system areas, explicit "add this feature" framing.

**Mode B — Revise:** New input changes, corrects, or removes something already covered by a current slice.
Indicators: changed requirements, updated scope, role renamed, friction redefined, explicit "change this" framing.

**Mixed:** New input contains both. Run Mode B first, then Mode A on the same pass — revisions must be stable before new slices are added to the dependency chain.

State the detected mode and the reasoning before proceeding.

### Step 0.3 — Mode A: Extend

Treat the new input as an additive spec. Run Phases 1–4 with these constraints:

- Existing slices are treated as live in production for independence evaluation — they are not re-evaluated.
- New slice IDs continue the existing sequence (e.g. if current slices end at 004, new slices start at 005).
- New slices must be inserted into the dependency chain at the correct position — not appended blindly at the end.
- Update `slices-overview.md`: add new slices to the index, extend the dependency chain, append to the iteration log.

### Step 0.4 — Mode B: Revise

**Identify affected slices:**
For each change in the new input, determine which current slices are affected.
A slice is affected if the change touches its problem statement, scope, execution path, or any dependency it relies on.
Cascade: if a slice is affected, check whether slices that depend on it are also affected.

**For each affected slice:**

1. Run the three iteration passes (Phases 3) on the affected slice with the new input applied.
2. If the revised slice differs from the original in any field → apply the supersession pattern:
   - Add `superseded_by: "{new-slice-id}"` to the original slice's YAML. Do not change any other field.
   - Produce a new canonical file: `slice-{NNN}-v{N}-{kebab-case-title}.md` where NNN is the original ID and N is the next version number.
   - New file must include:
     - `supersedes: "{original-slice-id}"` in YAML
     - `change_summary` field in YAML: one sentence stating what changed and why
   - All slices that `depends_on` the original slice must be checked — update their `depends_on` to reference the new canonical ID.
3. If the revised slice is identical to the original after passes → no supersession. Record in the iteration log that the slice was reviewed and unchanged.

**Update `slices-overview.md`:**
- Replace superseded entries in the slice index with the new canonical slice.
- Update the dependency chain to reflect new IDs.
- Add a revision entry to the iteration log: what changed, which slices were superseded, which were reviewed and unchanged.

---

## Phase 1 — Input Elicitation

### Step 1.1 — Extract from input

Before asking anything, extract from the full input (document, pasted text, attachments combined):

- Named user roles (any person type described as having a goal or problem)
- System or product boundary (what is explicitly in or out of scope)
- Existing live capabilities (anything described as already working or in production)
- Tech/architecture context (stack, existing components, integration points, environment)
- Design/UX context (flows, wireframes, interaction patterns, constraints)

### Step 1.2 — Identify gaps

| Input | Required | If missing after extraction |
|---|---|---|
| Product spec | Yes | Block — cannot proceed |
| System/product boundary | Yes | Ask once; if still absent → hard-block (see 1.3) |
| Primary user role(s) | Yes | Ask once; if still absent → infer from context, flag assumption |
| Tech/architecture context | Recommended | Infer where possible; mark affected evaluations as unverified in slice files |
| Design/UX context | Recommended | Infer usability; flag as limitation in overview |

### Step 1.3 — Ask in one batch

If any inputs are missing after extraction, ask all missing questions in a single message.
Include required and recommended gaps together — mark recommended ones as optional.
Format as a numbered list. State specifically why each input is needed and what it affects.

**After the user responds:**
- System/product boundary still absent → stop. State what cannot be produced without it and why. Do not proceed.
- User roles still absent → infer from context, record as assumption, proceed.
- Tech/architecture context still absent → proceed; mark verticality and independence evaluations as `unverified` in all affected slice files.
- Design/UX context still absent → proceed; flag usability evaluations as inferred in the overview.

---

## Phase 2 — Slicing Approach

Define and record the approach before slicing:

1. **Identify capability units** — distinct user-facing capabilities in the spec. A capability unit is a coherent action a named user can take that produces a named outcome.
2. **Map dependencies** — which capabilities require others to exist first? Capabilities with no dependencies are candidate first slices.
3. **Propose slice order** — sequence must reflect the dependency graph, not feature priority alone.
4. **State split decisions** — which capabilities will become nested slices? Split when a capability cannot be made thin, vertical, and independent as a single slice.

Record this approach in the overview iteration log, then proceed immediately to Phase 3. No confirmation gate.

> Token note: One sentence per capability, dependency chain as a simple ordered list. No full slice content here.

---

## Phase 3 — Iteration Passes

Load `references/slice-definition.md` now.

Run three passes over the full slice set. **Remediation limit: 2 rewrites per slice per pass.** If a slice still fails after 2 rewrites, accept the failure, flag the slice, and continue. Flagging is a last resort — the iteration log must show what was attempted.

---

### Pass 1 — Intent + Desirability

**Focus:** Problem statement quality, outcome statement quality, named role specificity and desirability.

For each slice:

1. **Problem statement** — apply the specificity checklist: named role, named context, named friction.
   - Role is generic ("users", "customers") → rewrite using roles extracted from input; if none extractable → use best inference, record as assumption, flag.
   - Context or friction missing or vague → rewrite with what is known; flag if genuinely unknowable.

2. **Outcome statement** — must name a product-level outcome and a specific capability. If vague or missing → rewrite.

3. **Desirability** — would this named role, in this named situation, seek the capability unprompted?
   If no → the problem statement describes the wrong problem. Rewrite. If it fails after 2 rewrites → flag as Intent failure.

**Remediation limit:** 2 rewrites per slice.

---

### Pass 2 — Thin + Vertical + Independence

**Focus:** Scope minimality, full execution path integrity, dependency resolution.

For each slice:

1. **Thinness** — for each item in scope: "does removing this break the core behaviour?"
   If no → remove it. Record in `explicitly_excluded` with rationale (see output rules).
   Check for horizontal anti-patterns ("data model only", "API contract only") → restructure as full-path slice or split into prerequisite + slice.

2. **Verticality** — trace the execution path from user trigger to user outcome. Name every layer.
   If any layer is deferred, mocked, or stubbed:
   - Attempt 1: thin the scope until the full path is implementable end-to-end.
   - Attempt 2: split — extract the incomplete layer as a prerequisite slice.
   - Still unresolvable → flag as Vertical failure.
   If tech/architecture context was absent from input → mark verticality evaluation as `unverified` in the slice YAML.

3. **Independence** — list all dependencies. For each: is this currently live in production?
   If not → bring into scope (check thinness first) or create a prerequisite slice.
   Explicit check: "UI done, backend to follow" pattern → always split. Never accept as a single slice.
   If tech/architecture context was absent from input → mark independence evaluation as `unverified` in the slice YAML.

4. **Prerequisite slices created in this pass:**
   - Collect all newly created prerequisite slices as a batch.
   - Run a dependency sort: identify any internal dependencies between slices in the batch.
   - Order so no slice depends on an unprocessed slice in the same batch.
   - Add to the working slice set in sorted order.
   - Re-enter each from Pass 1. Subject to all passes and all remediation limits.

**Remediation limit:** 2 restructures per slice (thinning or splitting each count as one restructure).

---

### Pass 3 — Value + Completeness

**Focus:** Usable and Valuable layers, acceptance criteria quality, specification completeness.

For each slice:

1. **Usable** — could a user unfamiliar with internals trigger the capability, understand the outcome, and know what to do next — without guidance?
   Evaluate by inference from the spec, tech context, and design/UX context extracted from input.
   If design/UX context was absent → evaluate from spec inference; record in the overview that usability was inferred, not verified against design artefacts.
   If scope is too thin to support usability → consider adding a minimal UI affordance (subject to thinness test in Pass 2).

2. **Valuable** — state explicitly what the user can now do or stop doing as a direct result of this slice being live.
   "Nothing yet — this is foundational" → slice fails. Restructure as a prerequisite slice that is itself valuable, or expand scope until value exists.

3. **Acceptance criteria** — minimum one criterion per scope item. Format: Given / When / Then.
   Must be verifiable by a non-author without access to the author or internal context.
   If design/UX context absent → note that the usability criterion cannot be fully verified without design input.

4. **Specification completeness** — every criterion answerable yes/no with no open TBDs?
   If not → resolve from available inputs; flag as Specification failure only if genuinely unresolvable.

**Remediation limit:** 2 rewrites per slice.

---

## Phase 4 — Output

Load `references/output-templates.md` now.

### Step 4.1 — Write slice files

For each slice, produce a file using Template A.
File naming: `slice-{NNN}-{kebab-case-title}.md` (zero-padded to 3 digits, ordered by delivery sequence).

**Output rules:**

- `explicitly_excluded` — required for every slice. Must name at least one excluded item with a one-sentence rationale explaining why removing it does not break core behaviour. OR state: "Scope was already minimal on first read — no items removed." Empty or "N/A" is not acceptable.
- `verification_status` — include in YAML only when tech/architecture context was absent from input. Value: `"unverified — tech/architecture context absent from input"`. Signals that verticality and independence evaluations in this slice are based on inference, not verified context.
- `flags_and_compromises` — required for every flagged slice. Must name the criterion, describe what was attempted across passes, and state why it could not be resolved.
- `depends_on` — list slice IDs, not capability names. Empty array if no dependencies.

### Step 4.2 — Write the overview file

Produce `slices-overview.md` using Template B.

**Dependency chain format** — one entry per slice, in delivery order:
```
- Slice {ID} "{Title}": depends on [{ID list} | none] — {one sentence: why this dependency exists or why the slice is independent}.
```

**Required sections:**
- Slice index — every slice: ID, title, status, dependencies
- Dependency chain — structured list in delivery order using the format above
- Assumptions made — every inference: what was missing from input, what was inferred, which slices are affected
- Limitations and compromises — every flagged slice: criterion, what was attempted, consequence for the consuming team. If all slices valid → state that explicitly.
- Iteration log — one bullet per pass summarising what changed

### Step 4.3 — Present output

State: total slices produced, valid count, flagged count.
If any flagged — name the criterion and one-sentence reason before the user opens the files.

---

## Failure handling

**A slice is flagged when** it fails one or more criteria after all passes and all remediation attempts, and the failure is irresolvable without input the user cannot or will not provide. The iteration log must show what was attempted — a slice with an empty log entry must not be flagged.

| Failure | Remediation before flagging |
|---|---|
| Scope too broad | Strip to minimum; move removed items to a follow-on slice |
| Stub in execution path | Thin until full path is buildable; or split prerequisite |
| "Foundational" value claim | Restructure as prerequisite slice that is itself valuable |
| Generic user role | Infer from context; record as assumption; flag only if not inferrable |
| Missing prerequisite | Create prerequisite slice; sort into dependency chain |
| Open TBDs in acceptance criteria | Resolve from available inputs; flag only if truly unresolvable |

---

## Token discipline

- Load reference files only when the phase requires them.
- Phase 2 summary: one sentence per capability, no full slice content.
- Do not restate the criterion list inside slice files — the definition lives in the reference file.
- Do not repeat the slicing approach in the overview beyond the iteration log entry.
