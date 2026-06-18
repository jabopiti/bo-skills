# bo-skills

A collection of shareable [Claude Code](https://claude.ai/code) skills by [Jacob Lueg Tiedemann](https://jbpt.de).

Skills extend Claude Code with domain-specific workflows and knowledge — loaded on demand, not on every session. This repo contains general-purpose skills that work across any project.

---

## Skills

### issue-tracker
**GitHub issue lifecycle manager**

Handles the full workflow for GitHub Issues backed by a project kanban board: filing new issues, picking them up, tracking status through Backlog → Ready → In progress → In review → Done, and closing them. Reads board configuration from a small JSON file in the repo — no hardcoded IDs, works with any repo you set it up in.

Includes a first-run **setup mode** that creates the GitHub Project board, adds the standard fields, copies the issue template, and writes the config file — one invocation to onboard any new repo.

**Triggers:** "file an issue for this", "pick up issue #N", "log this for later", "what issues are open", "track this", "document this gap"

→ [`skills/issue-tracker/`](skills/issue-tracker/)

---

### thin-slicer
**Product decomposition skill**

Breaks any product specification — PRD, epic, feature brief, RFC — into thin, vertical, independently shippable slices. Applies a strict 7-criterion definition of "thin" to prevent scope creep and keep each slice genuinely deliverable on its own.

**Triggers:** "slice this spec", "break this into thin slices", "decompose this feature", "make this vertical"

→ [`skills/thin-slicer/`](skills/thin-slicer/)

---

### farn-painter
**Farn design system — colors and typography**

Applies the [Farn design system's](https://farn.jbpt.de) color palette and typefaces to any HTML/CSS artifact, slide, prototype, or visual output. Covers both light and dark mode accents, the full type scale (Fraunces · Instrument Sans · JetBrains Mono), and a ready-to-paste CSS snippet.

**Triggers:** "apply farn styling", "use farn colors", "style this with the farn design system"

→ [`skills/farn-painter/`](skills/farn-painter/)

---

## Installation

This repo is a Claude Code marketplace. Install it once — skills auto-update from GitHub whenever Claude Code refreshes.

**Step 1 — Add the marketplace**

Open any Claude Code session and ask:

> Add the marketplace `jabopiti/bo-skills`

Claude will clone the repo and register it as the `bo-skills` marketplace.

**Step 2 — Install the plugin**

In the same session, ask:

> Install the `bo-skills` plugin from the `bo-skills` marketplace

Claude will write the plugin entry and populate the local cache.

**Step 3 — Restart Claude Code**

Skills are loaded at startup. After restarting, they appear in the available skills list as `bo-skills:issue-tracker`, `bo-skills:thin-slicer`, and `bo-skills:farn-painter`.

**On a new machine** — repeat steps 1–3. The marketplace and cache are local-only; everything else is in this repo.

---

## Setting up issue-tracker in a new repo

The issue-tracker skill detects whether a repo is configured and walks you through setup if not. In any repo without `.claude/issue-config.json`:

1. Invoke the `issue-tracker` skill (or ask Claude to "set up issue management for this repo")
2. It reads the setup reference and runs the full setup: creates the GitHub Project board, adds Status / Complexity / Risk fields with standard options, copies the issue template, and writes `.claude/issue-config.json`
3. Done — all future `issue-tracker` invocations in that repo read from the config file directly

The issue template is at [`skills/issue-tracker/assets/task-template.yml`](skills/issue-tracker/assets/task-template.yml) and is copied to `.github/ISSUE_TEMPLATE/` during setup.

---

## Adding skills to this repo

Each skill lives in `skills/<skill-name>/` and requires at minimum a `SKILL.md` with a `name` and `description` in its frontmatter. Reference files and assets go in `references/` and `assets/` subdirectories.

See the [skill-creator plugin](https://github.com/anthropics/claude-plugins-official) for a guided workflow for building and evaluating new skills.

---

## License

[MIT](LICENSE) — use freely, attribution appreciated.
