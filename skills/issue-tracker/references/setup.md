# Tracker Setup

Sets up the standard Bo. issue workflow in a new repo: creates the GitHub Project board, configures fields, copies the issue template, and writes `.claude/issue-config.json`.

Run this once per repo. After setup the tracker skill reads the config file and needs no further `gh` discovery calls.

---

## Prerequisites

- `gh auth status` confirms the `project` scope is granted. If not: `gh auth refresh -s project`
- You are in the repo's local directory.

---

## Step 1 — Create the project board

```bash
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
OWNER=$(echo $REPO | cut -d/ -f1)

PROJECT_NUMBER=$(gh project create --owner "@me" \
  --title "$(echo $REPO | cut -d/ -f2) Kanban" \
  --format json | jq -r '.number')

echo "Project number: $PROJECT_NUMBER"

# Link the board to the repo so issues can be added
gh project link $PROJECT_NUMBER --owner "@me" --repo $REPO
```

---

## Step 2 — Remove default fields and create standard ones

GitHub creates a default Status field with options (Todo / In Progress / Done). Delete it and create the standard Bo. fields.

```bash
# Get default Status field ID and delete it
DEFAULT_STATUS_ID=$(gh project field-list $PROJECT_NUMBER --owner "@me" \
  --format json | jq -r '.fields[] | select(.name=="Status") | .id')

gh project field-delete --id $DEFAULT_STATUS_ID --owner "@me"

# Create Status with standard options
gh project field-create $PROJECT_NUMBER --owner "@me" \
  --name "Status" --data-type "SINGLE_SELECT" \
  --single-select-options "Backlog,Ready,In progress,In review,Done"

# Create Complexity field
gh project field-create $PROJECT_NUMBER --owner "@me" \
  --name "Complexity" --data-type "SINGLE_SELECT" \
  --single-select-options "XS,S,M,L,XL"

# Create Risk field
gh project field-create $PROJECT_NUMBER --owner "@me" \
  --name "Risk" --data-type "SINGLE_SELECT" \
  --single-select-options "low,medium,high"
```

---

## Step 3 — Copy the issue template

```bash
mkdir -p .github/ISSUE_TEMPLATE

# Copy from skill bundle — adjust path to match your tracker skill install location
SKILL_DIR=$(dirname "$0")/..
cp "$SKILL_DIR/assets/task-template.yml" .github/ISSUE_TEMPLATE/task-template.yml
```

If the skill bundle path isn't available, copy [`task-template.yml`](../assets/task-template.yml) manually to `.github/ISSUE_TEMPLATE/task-template.yml`.

---

## Step 4 — Generate issue-config.json

Query the board for all field and option IDs, then write the config file.

```bash
mkdir -p .claude

FIELDS_JSON=$(gh project field-list $PROJECT_NUMBER --owner "@me" --format json)
PROJECT_ID=$(gh project list --owner "@me" --format json \
  | jq -r ".projects[] | select(.number==$PROJECT_NUMBER) | .id")

python3 - <<EOF
import json, sys

fields = json.loads('''$FIELDS_JSON''')['fields']
project_id = '$PROJECT_ID'
project_number = $PROJECT_NUMBER
owner = '$OWNER'
repo = '$REPO'.split('/')[1]

config = {
    "owner": owner,
    "repo": repo,
    "project_id": project_id,
    "project_number": project_number,
    "fields": {}
}

for f in fields:
    if f['name'] in ('Status', 'Complexity', 'Risk'):
        options = {opt['name']: opt['id'] for opt in (f.get('options') or [])}
        config['fields'][f['name']] = {
            "id": f['id'],
            "options": options
        }

with open('.claude/issue-config.json', 'w') as out:
    json.dump(config, out, indent=2)
    out.write('\n')

print('Written: .claude/issue-config.json')
print(json.dumps(config, indent=2))
EOF
```

---

## Step 5 — Add the tracker trigger to CLAUDE.md

Add this line to the repo's `CLAUDE.md` (create the file if it doesn't exist):

```
When creating, picking up, or closing a GitHub issue, or when documenting discovered or deferred work: invoke the `tracker` skill.
```

---

## Step 6 — Commit and verify

```bash
git add .github/ISSUE_TEMPLATE/task-template.yml .claude/issue-config.json CLAUDE.md
git commit -m "chore: set up Bo. issue workflow (tracker skill)"
```

Verify by running `cat .claude/issue-config.json` — it should show Status, Complexity, and Risk fields with populated option IDs. Setup is complete.
