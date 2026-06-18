# Slice Definition — Full Reference

A **thin, vertical, valuable slice** is the smallest unit of working software a real user can interact with, that solves a specific problem end-to-end, and can be shipped independently.

A slice is valid only if it satisfies **all** criteria below. Failing any single criterion makes it invalid.

---

## Criterion 1 — Intent

Two mandatory statements before any scope is defined.

### 1a. Problem statement
> Format: `[Named role] cannot [accomplish specific goal] when [specific context] because [specific gap or friction].`

**Specificity checklist — all three required:**
- Named role (not "user" or "customer")
- Named context (specific moment, trigger, or condition — not "when using the system")
- Named friction (specific gap — not "it doesn't work well")

❌ Fails: "Users cannot complete their task when the system is slow because of performance issues."
✅ Passes: "A warehouse operative cannot confirm a partial delivery when the expected quantity field is locked to the purchase order, because the system does not allow partial acceptance without supervisor override."

### 1b. Outcome statement
> Format: `This slice contributes to [outcome] by enabling [specific capability].`

**Rubric:** An agent must identify who, what, when, and why from the problem statement alone — without any other context.

---

## Criterion 2 — Thin

Contains only what is strictly necessary to make the capability work end-to-end. Every element of scope must be required for core behaviour.

**Test for each item in scope:** Does removing this break the core behaviour described in the intent? If no → remove it.

Thin applies to **scope**, not to layers. A thin slice still traverses all relevant layers — with minimum viable scope at each.

❌ Anti-pattern: "Just the data model for now." — horizontal, not thin.
✅ Correct: "Basic search with one filter type, implemented across all layers from UI to data retrieval."

---

## Criterion 3 — Vertical

Covers the full execution path from user trigger to user outcome. Every layer the capability requires must be real and live in a production-equivalent environment — no stubs, mocks, or placeholders.

**Test at each step:** Is this real code running real logic in a production-equivalent environment?

"All layers" = all layers *this capability requires*, not every layer in the system.

❌ Anti-pattern: UI wired up with hardcoded backend responses. Looks end-to-end. Is not vertical.

---

## Criterion 4 — Valuable

All three layers required. Failing any one fails the criterion.

### 4a. Desirable
A specific, real user type would seek this capability unprompted.
**Test:** Can you name the user type? "Users" or "customers" fails.

### 4b. Usable
A real user can complete the interaction without confusion, external help, or workarounds, at the level of scope delivered.
**Test:** Would a user unfamiliar with internals be able to trigger the capability, understand the outcome, and know what to do next — without guidance?

### 4c. Valuable
The capability achieves something meaningful: a goal advanced, a problem resolved, or a friction removed.
**Test:** State what the user can now do, or stop doing, as a direct result of this slice being live. "Nothing yet — this is foundational" fails.

---

## Criterion 5 — Independent

Deployable and demonstrable without any other unreleased slice being complete.

A slice may not assume the existence of any capability not currently live in production. Missing capabilities must either be included in this slice's scope (subject to thinness) or delivered first as a prerequisite slice that independently satisfies all criteria.

**No infrastructure exceptions.**

**Test for each dependency:** Is this currently live in production? If not → in scope or prerequisite slice.

**Nesting:** Independence evaluated at each level separately. Neither parent nor child inherits from the other.

---

## Criterion 6 — Complete (specification)

Both conditions required:
- Every criterion above answerable yes/no with no open questions or TBDs
- Explicit acceptance criteria present, verifiable by a non-author without access to the author or internal context

**Nesting:** Evaluated independently at each level.

---

## Criterion 7 — Complete (delivery)

- Deployed to a production-equivalent environment
- Demonstrated to at least one real external stakeholder (user, customer, or business owner) — not solely the delivery team

> Note: Criterion 7 is a delivery gate, not a specification gate. The skill evaluates through Criterion 6. Criterion 7 is noted in slice output as a delivery requirement.

---

## Failure modes to watch

| Pattern | Fails |
|---|---|
| "Just the data model" | Vertical, Valuable |
| "Improve the X experience" | Thin, Intent |
| "UI done, backend to follow" | Vertical, Independent |
| Scope includes audit trails, history, expiry on first pass | Thin |
| Generic user role ("users", "customers") | Intent, Valuable (Desirable) |
| Prerequisite assumed to exist | Independent |
