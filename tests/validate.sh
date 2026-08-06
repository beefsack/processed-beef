#!/bin/sh
# Validation gate for the processed-beef Agent Skills repository.
# Run from anywhere: the repo root is derived from the script location.
#
# Contract for skills/*/SKILL.md:
#   - `---` frontmatter containing exactly `name` and `description`
#   - frontmatter `name` equals the skill directory name
#   - at most 500 lines
#   - ASCII only
#   - every relative Markdown link resolves inside the skill directory
#   - the skill set collectively contains every invariant phrase:
#       exactly one subagent   (serial execution)
#       user approval          (governance)
#       150000                 (150k context limit)
set -u

repo_root=$(CDPATH= cd "$(dirname "$0")/.." && pwd)
skills_dir=$repo_root/skills
fail=0

error() {
    printf 'validate.sh: %s\n' "$*" >&2
    fail=1
}

# An empty repository is a release-gate failure: the package must ship skills.
if [ -z "$(find "$skills_dir" -name SKILL.md 2>/dev/null)" ]; then
    printf 'no skills found\n' >&2
    exit 1
fi

check_frontmatter() {
    file=$1
    skill_name=$2
    keys=$(awk '
        /^---/ { fm++; next }
        fm != 1 { next }
        /^[[:space:]]/ { next }
        /^[A-Za-z0-9_.-]+:/ {
            k = $0
            sub(/:.*/, "", k)
            print k
        }
    ' "$file")
    if [ -z "$keys" ]; then
        error "$skill_name: missing YAML frontmatter"
        return
    fi
    have_name=no
    have_description=no
    for k in $keys; do
        case $k in
            name) have_name=yes ;;
            description) have_description=yes ;;
            *) error "$skill_name: non-portable frontmatter key '$k'" ;;
        esac
    done
    [ "$have_name" = yes ] || error "$skill_name: missing 'name' frontmatter"
    [ "$have_description" = yes ] || error "$skill_name: missing 'description' frontmatter"

    name_val=$(awk '
        /^---/ { fm++; next }
        fm != 1 { next }
        /^name:[[:space:]]*/ {
            v = $0
            sub(/^name:[[:space:]]*/, "", v)
            print v
            exit
        }
    ' "$file")
    if [ "$name_val" != "$skill_name" ]; then
        error "$skill_name: frontmatter name '$name_val' does not match directory name"
    fi
}

check_lines() {
    file=$1
    skill_name=$2
    lines=$(wc -l < "$file")
    if [ "$lines" -gt 500 ]; then
        error "$skill_name: SKILL.md has $lines lines (limit 500)"
    fi
}

check_size() {
    file=$1
    skill_name=$2
    bytes=$(wc -c < "$file")
    if [ "$bytes" -gt 20000 ]; then
        error "$skill_name: SKILL.md has $bytes bytes (approximate 5000-token limit is 20000)"
    fi
}

check_ascii() {
    file=$1
    skill_name=$2
    if LC_ALL=C grep -n '[^ -~]' "$file" >/dev/null; then
        error "$skill_name: SKILL.md contains non-ASCII bytes"
    fi
}

check_links() {
    file=$1
    skill_name=$2
    dir=$(dirname "$file")
    links=$(awk '
        {
            while (match($0, /\]\([^)]*\)/)) {
                link = substr($0, RSTART + 2, RLENGTH - 3)
                print link
                $0 = substr($0, RSTART + RLENGTH)
            }
        }
    ' "$file")
    [ -n "$links" ] || return
    while IFS= read -r link; do
        case $link in
            '' | '#'* | 'http://'* | 'https://'* | 'mailto:'*) continue ;;
        esac
        target=$link
        case $target in
            *'#'*) target=${target%%'#'*} ;;
        esac
        [ -n "$target" ] || continue
        if [ ! -e "$dir/$target" ]; then
            error "$skill_name: relative link '$link' does not exist"
        fi
    done <<EOF
$links
EOF
}

check_portable_body() {
    skill_dir=$1
    skill_name=$2
    for token in 'CLAUDE_CODE_' 'subagent_depth' '.codex/' '.opencode/' \
        '.claude/agents' 'chat.subagents' 'invoke_subagent' 'runSubagent' 'Agent('; do
        if grep -Frq "$token" "$skill_dir"; then
            error "$skill_name: harness-specific token '$token' belongs in docs/integrations"
        fi
    done
}

check_invariants() {
    for phrase in 'exactly one subagent' 'user approval' '150000'; do
        if ! grep -rq "$phrase" "$skills_dir"; then
            error "no skill contains invariant phrase '$phrase'"
        fi
    done
}

check_process_conventions() {
    if grep -R -E -q --exclude-dir=.git --exclude-dir=node_modules 'VISION[.]md' "$repo_root"; then
        error "process guidance still references an obsolete startup document"
    fi

    for file in \
        "$repo_root/README.md" \
        "$repo_root/docs/architecture.md" \
        "$repo_root/skills/processed-beef/SKILL.md" \
        "$repo_root/skills/processed-beef-orchestrate/SKILL.md" \
        "$repo_root/skills/processed-beef-work-unit/SKILL.md" \
        "$repo_root/skills/processed-beef-orchestrate/assets/agent-process.md" \
        "$repo_root/skills/processed-beef-orchestrate/references/scheduling.md"; do
        if ! grep -Fq 'docs/principles.md' "$file"; then
            error "${file#"$repo_root"/}: missing canonical principles path"
        fi
    done

    for file in \
        "$repo_root/README.md" \
        "$repo_root/docs/architecture.md" \
        "$repo_root/skills/processed-beef/SKILL.md" \
        "$repo_root/skills/processed-beef-orchestrate/SKILL.md" \
        "$repo_root/skills/processed-beef-orchestrate/assets/agent-process.md"; do
        if ! grep -Fq 'docs/backlog.md' "$file" || ! grep -Fq 'docs/decisions.md' "$file"; then
            error "${file#"$repo_root"/}: missing canonical governance or backlog path"
        fi
    done

    for file in \
        "$repo_root/README.md" \
        "$repo_root/docs/architecture.md" \
        "$repo_root/skills/processed-beef-orchestrate/SKILL.md" \
        "$repo_root/skills/processed-beef-work-unit/SKILL.md" \
        "$repo_root/skills/processed-beef-orchestrate/assets/agent-process.md" \
        "$repo_root/skills/processed-beef-orchestrate/references/scheduling.md" \
        "$repo_root/docs/integrations/antigravity.md" \
        "$repo_root/docs/integrations/claude-code.md" \
        "$repo_root/docs/integrations/codex.md" \
        "$repo_root/docs/integrations/opencode.md" \
        "$repo_root/docs/integrations/vscode.md"; do
        if ! grep -Fq 'wc -c' "$file" || ! grep -Fq 'one token' "$file" || ! grep -Fq '127500' "$file"; then
            error "${file#"$repo_root"/}: missing reproducible context fallback"
        fi
    done
}

# Contract for the Lead-owned major-unit lifecycle (2026-08-05-lead-lifecycle).
# Focused literal phrase checks against the canonical role skills and
# orchestration references. Deliberately not a full-document snapshot. The
# archived 2026-08-02-terminal-handover-boundaries record is guarded separately
# by Git inspection, not a hard-coded commit hash.
check_lifecycle_contract() {
    while IFS='|' read -r file phrase; do
        case $file in '') continue ;; esac
        if ! grep -Fq "$phrase" "$repo_root/$file"; then
            error "lifecycle: '$phrase' not found in $file"
        fi
    done <<EOF
skills/processed-beef-orchestrate/SKILL.md|succession only, never ordinary scheduling for a plan
skills/processed-beef-orchestrate/references/scheduling.md|A brief that conflicts with any of them is not dispatched
skills/processed-beef-orchestrate/references/scheduling.md|ephemeral attempt ID (\`unit-01/attempt-02\`); attempts never rename the semantic
skills/processed-beef-work-unit/SKILL.md|This Worker never delegates
skills/processed-beef-orchestrate/SKILL.md|exactly one same-scope correction round
skills/processed-beef-orchestrate/references/scheduling.md|counted, non-resumable host attempts
skills/processed-beef-orchestrate/references/scheduling.md|\`host-unknown reconciliation\`
skills/processed-beef-orchestrate/references/scheduling.md|A unit is never fragmented into a separate commit-only Worker
skills/processed-beef-orchestrate/references/verification.md|security, authorization, migration, destructive behavior, public contracts
skills/processed-beef-orchestrate/SKILL.md|actual selected role against its configured role
docs/integrations/opencode.md|injects a \`task: deny\` default
skills/processed-beef-orchestrate/references/scheduling.md|\`Status\` as its first field
EOF

    if grep -Fq '`complete`' "$repo_root/skills/processed-beef-work-unit/SKILL.md"; then
        error "lifecycle: work-unit skill presents \`complete\` as a report status"
    fi
}

# Contract for delegation economics (2026-08-07-delegation-economics).
# Focused literal phrase checks against the canonical role skills and
# orchestration references. Deliberately not a full-document snapshot.
check_delegation_economics_contract() {
    while IFS='|' read -r file phrase; do
        case $file in '') continue ;; esac
        if ! grep -Fq "$phrase" "$repo_root/$file"; then
            error "delegation-economics: '$phrase' not found in $file"
        fi
    done <<EOF
skills/processed-beef-orchestrate/references/scheduling.md|Decide delegation for a unit before loading any of its material
skills/processed-beef-orchestrate/references/scheduling.md|has forfeited that unit's
skills/processed-beef-orchestrate/references/scheduling.md|the rejection leaves the cost unpaid
skills/processed-beef-orchestrate/references/scheduling.md|correction budget is per checkpoint, not per unit
skills/processed-beef-orchestrate/references/scheduling.md|A unit is never fragmented into a separate commit-only Worker
skills/processed-beef-work-unit/SKILL.md|A \`checkpoint\` return is a pause report, not a handover
skills/processed-beef-orchestrate/references/verification.md|independent review was not possible
skills/processed-beef-orchestrate/SKILL.md|does not perform raw extraction
skills/processed-beef-orchestrate/references/artifacts.md|never fragmented into a separate commit-only Worker
EOF
}

# Contract for delegation economics follow-up (2026-08-07).
# Focused literal phrase checks against the canonical role skills and
# orchestration references. Deliberately not a full-document snapshot.
check_delegation_economics_followup_contract() {
    while IFS='|' read -r file phrase; do
        case $file in '') continue ;; esac
        if ! grep -Fq "$phrase" "$repo_root/$file"; then
            error "delegation-economics-followup: '$phrase' not found in $file"
        fi
    done <<EOF
skills/processed-beef-orchestrate/SKILL.md|out of Lead context beyond the diff and evidence
skills/processed-beef-orchestrate/SKILL.md|and neither does the Lead beyond the diff and
skills/processed-beef-orchestrate/references/scheduling.md|bound by the same rule as a host-triggered rejection
skills/processed-beef-orchestrate/references/scheduling.md|the same as change units
skills/processed-beef-orchestrate/references/scheduling.md|does not rediscover them
skills/processed-beef-orchestrate/references/scheduling.md|a Lead's byte typically costs more than a Worker's
skills/processed-beef-work-unit/SKILL.md|has no diff to fall back on
skills/processed-beef-orchestrate/SKILL.md|Model tiers track role cost
skills/processed-beef-orchestrate/SKILL.md|returned for a pre-start split
skills/processed-beef-orchestrate/SKILL.md|all other Orchestrator interaction is with
skills/processed-beef-orchestrate/SKILL.md|is a narrow exception, not the default
skills/processed-beef-orchestrate/SKILL.md|Host reconciliation is the Lead's only other direct-extraction right
skills/processed-beef-orchestrate/references/scheduling.md|judges a unit too large and cleanly separable
skills/processed-beef-orchestrate/references/scheduling.md|This covers code and file changes, test and command runs, documentation
skills/processed-beef-orchestrate/references/governance.md|Escalation tracks decision blast radius
skills/processed-beef-orchestrate/references/governance.md|a project dependency such
skills/processed-beef-orchestrate/references/governance.md|put a complex or ambiguous technical question to the
skills/processed-beef-work-unit/SKILL.md|with the dispatching Lead only, never the Orchestrator or user directly
EOF
}

for skill in "$skills_dir"/*/; do
    skill_name=$(basename "$skill")
    file=$skill/SKILL.md
    if [ ! -f "$file" ]; then
        error "$skill_name: missing SKILL.md"
        continue
    fi
    check_frontmatter "$file" "$skill_name"
    check_lines "$file" "$skill_name"
    check_size "$file" "$skill_name"
    check_ascii "$file" "$skill_name"
    check_links "$file" "$skill_name"
    check_portable_body "$skill" "$skill_name"
done

markdown_files=$(find "$repo_root" -type f -name '*.md' -not -path '*/.git/*')
for file in $markdown_files; do
    check_ascii "$file" "${file#"$repo_root"/}"
done

check_invariants
check_process_conventions
check_lifecycle_contract
check_delegation_economics_contract
check_delegation_economics_followup_contract

if ! node "$repo_root/tests/opencode-plugin.mjs"; then
    error "OpenCode plugin contract failed"
fi

exit "$fail"
