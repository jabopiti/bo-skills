# claude-skills

A collection of shareable [Claude Code](https://claude.ai/code) skills by [Jacob Lueg Tiedemann](https://jbpt.de).

Skills extend Claude Code with domain-specific workflows and knowledge — loaded on demand, not on every session. This repo contains general-purpose skills that work across any project.

---

## Skills

### tracker
**GitHub issue lifecycle manager**

Handles the full workflow for GitHub Issues backed by a project kanban board: filing new issues, picking them up, tracking status through Backlog → Ready → In progress → In review → Done, and closing them. Reads board configuration from a small JSON file in the repo — no hardcoded IDs, works with any repo you set it up in.

Includes a first-run **setup mode** that creates the GitHub Project board, adds the standard fields, copies the issue template, and writes the config file — one invocation to onboard any new repo.

**Triggers:** "file an issue for this", "pick up issue #N", "log this for later", "what issues are open", "track this", "document this gap"

→ [`skills/tracker/`](skills/tracker/)

---

### thin-slicer
**Product decomposition skill**

Breaks any product specification — PRD, epic, feature brief, RFC — into thin, vertical, independently shippable slices. Applies a strict 7-criterion definition of "thin" to prevent scope creep and keep each slice genuinely deliverable on its own.

**Triggers:** "slice this spec", "break this into thin slices", "decompose this feature", "make this vertical"

→ [`skills/thin-slicer/`](skills/thin-slicer/)

---

### bo-brander *(in progress → farn-design-system)*
Visual brand skill. Currently specific to Bo.'s design system — being reworked as a generic, reusable design system skill (`farn-design-system`). Not ready for general use yet.

---

## Installation

Skills are packaged as a Claude Code plugin under the `skills` namespace (`skills@jabopiti`).

**1. Clone this repo**

```bash
git clone https://github.com/jabopiti/claude-skills ~/path/to/claude-skills
```

**2. Create the plugin cache entry**

```bash
mkdir -p ~/.claude/plugins/cache/jabopiti/skills
ln -sf ~/path/to/claude-skills ~/.claude/plugins/cache/jabopiti/skills/1.0.0
```

**3. Register the plugin**

Add this entry to `~/.claude/plugins/installed_plugins.json` inside the `"plugins"` object:

```json
"skills@jabopiti": [
  {
    "scope": "user",
    "installPath": "/absolute/path/to/.claude/plugins/cache/jabopiti/skills/1.0.0",
    "version": "1.0.0",
    "installedAt": "2026-01-01T00:00:00.000Z",
    "lastUpdated": "2026-01-01T00:00:00.000Z"
  }
]
```

**4. Restart Claude Code**

Skills will appear in the available skills list as `skills:tracker`, `skills:thin-slicer`, etc.

> **On a new machine** — re-run steps 1–3. The symlink is local-only; everything else is in git.

---

## Setting up tracker in a new repo

The tracker skill detects whether a repo is configured and walks you through setup if not. In any repo without `.claude/issue-config.json`:

1. Invoke the `tracker` skill (or ask Claude to "set up issue management for this repo")
2. It reads [`skills/tracker/references/setup.md`](skills/tracker/references/setup.md) and runs the full setup: creates the GitHub Project board, adds Status / Complexity / Risk fields with standard options, copies the issue template, and writes `.claude/issue-config.json`
3. Done — all future `tracker` invocations in that repo read from the config file directly

The issue template is at [`skills/tracker/assets/task-template.yml`](skills/tracker/assets/task-template.yml) and is copied to `.github/ISSUE_TEMPLATE/` during setup.

---

## Adding skills to this repo

Each skill lives in `skills/<skill-name>/` and requires at minimum a `SKILL.md` with a `name` and `description` in its frontmatter. Reference files and assets go in `references/` and `assets/` subdirectories.

See the [skill-creator plugin](https://github.com/anthropics/claude-plugins-official) for a guided workflow for building and evaluating new skills.

---

## License

[MIT](LICENSE) — use freely, attribution appreciated.
