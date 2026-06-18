# bo-skills

## Packaging
After editing any skill source files, regenerate the `.skill` ZIP artifact:
```bash
cd skills && zip -r <skill-name>.skill <skill-name>/
```
Then bump version in both `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`.
Commit and push — the plugin auto-updates via `gitCommitSha` tracking on next session start.

## GitHub Projects API
Built-in project workflows (Workflows tab) can be read via GraphQL (`project.workflows`)
but cannot be enabled or configured via API — UI only. The only workflow mutation is
`deleteProjectV2Workflow`. Don't attempt scripted workflow setup.
