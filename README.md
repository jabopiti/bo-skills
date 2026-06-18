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

## Installation via Claude Code marketplace

This repo is registered as a Claude Code marketplace. Add it once and all skills auto-update.

In any Claude Code session, ask Claude to add the marketplace:

```
Add the marketplace jabopiti/bo-skills
```

Then install the plugin:

```
Install plugin bo-skills from bo-skills marketplace
```

After restarting Claude Code, skills appear as `bo-skills:issue-tracker`, `bo-skills:thin-slicer`, etc.

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
