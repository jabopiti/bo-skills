# bo-skills

## Packaging
The `.skill` ZIP is auto-repackaged by `.claude/hooks/repackage-skill.sh` whenever a skill
source file is edited — no manual `zip` step needed.

Before pushing, bump version in both `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`.
Commit and push — the plugin auto-updates via `gitCommitSha` tracking on next session start.

## GitHub Projects API
Built-in project workflows (Workflows tab) can be read via GraphQL (`project.workflows`)
but cannot be enabled or configured via API — UI only. The only workflow mutation is
`deleteProjectV2Workflow`. Don't attempt scripted workflow setup.
