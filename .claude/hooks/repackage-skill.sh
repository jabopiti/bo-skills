#!/bin/bash
# PostToolUse hook: repackage .skill ZIP when a skill source file is edited.
# Receives tool JSON payload on stdin.
set -euo pipefail

file=$(jq -r '.tool_input.file_path // empty' 2>/dev/null) || exit 0
[[ -n "$file" ]] || exit 0

# Only act on files inside skills/<name>/... (not the .skill ZIPs themselves)
[[ "$file" =~ .*/skills/([^/]+)/.+ ]] || exit 0
skill="${BASH_REMATCH[1]}"

repo=$(git -C "$(dirname "$file")" rev-parse --show-toplevel 2>/dev/null) || exit 0
skills_dir="$repo/skills"
[[ -d "$skills_dir/$skill" ]] || exit 0

cd "$skills_dir"
zip -r "${skill}.skill" "${skill}/" -q
echo "Repackaged ${skill}.skill"
