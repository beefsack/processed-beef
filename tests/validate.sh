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

    # Return thresholds are single-sourced. Only the two role skills and the
    # scheduling reference may state the numbers; every other document
    # describes and links, so a threshold change is a three-file edit rather
    # than a twelve-file sweep with drift risk.
    for file in \
        "$repo_root/README.md" \
        "$repo_root/docs/architecture.md" \
        "$repo_root/skills/processed-beef-orchestrate/assets/agent-process.md" \
        "$repo_root/docs/integrations/antigravity.md" \
        "$repo_root/docs/integrations/claude-code.md" \
        "$repo_root/docs/integrations/codex.md" \
        "$repo_root/docs/integrations/opencode.md" \
        "$repo_root/docs/integrations/vscode.md"; do
        normalized=$(tr '\n' ' ' < "$file" | tr -s ' ')
        if printf '%s' "$normalized" | grep -Eq 'own tool calls, whichever comes first|targets completion in about'; then
            error "${file#"$repo_root"/}: restates single-sourced return thresholds"
        fi
    done

    # `blocked` must not be overloaded with a terminal meaning: `handover` is
    # the only terminal status.
    if grep -rEl "handover even (if|when) its status is|handover even when reported as" \
        "$repo_root/skills" "$repo_root/docs" "$repo_root/README.md" \
        --exclude-dir=archive >/dev/null 2>&1; then
        error "a document still describes \`blocked\` as a terminal handover"
    fi
}


# Per-change contract checks retire by rule. A change's literal phrase checks
# guard it for the current release cycle only; once its behavior is recorded in
# tests/behavioral.md, the function is deleted rather than kept. These checks
# can detect wording, never behavior, and accumulating them makes the skill set
# impossible to simplify: the checks for 2026-08-05-lead-lifecycle,
# 2026-08-07-delegation-economics and its follow-up, and
# 2026-08-08-context-and-safety-hardening were retired under this rule on
# 2026-08-17. Structural checks above are permanent.

# Contract for circuit breakers and revised return thresholds
# (2026-08-17-circuit-breakers) and process overhead reduction
# (2026-08-17-overhead-reduction).
check_circuit_breakers_contract() {
    while IFS='|' read -r file phrase; do
        case $file in '') continue ;; esac
        if ! tr '\n' ' ' < "$repo_root/$file" | tr -s ' ' | grep -Fq "$phrase"; then
            error "circuit-breakers: '$phrase' not found in $file"
        fi
    done <<EOF
skills/processed-beef-orchestrate/SKILL.md|Attempt accounting belongs to the semantic unit, not to the agent
skills/processed-beef-orchestrate/SKILL.md|a third attempt on one unit
skills/processed-beef-orchestrate/SKILL.md|is not a reset and does not clear the breaker
skills/processed-beef-orchestrate/SKILL.md|Fix-forward covers defects discovered after an honest acceptance
skills/processed-beef-orchestrate/references/scheduling.md|A threshold is a scheduling boundary, not an evidence-validity boundary
skills/processed-beef-orchestrate/references/scheduling.md|a relabeled brief for the same objective does not start a new count
skills/processed-beef-orchestrate/references/verification.md|One independent review per unit
skills/processed-beef-orchestrate/references/verification.md|A rising test count is not acceptance progress
skills/processed-beef-orchestrate/references/verification.md|the classification comes from what the command does, not from its name
skills/processed-beef-orchestrate/references/artifacts.md|once a second Lead succession occurs on the change or any Expanded trigger
skills/processed-beef-work-unit/SKILL.md|leave the same failure class
skills/processed-beef-work-unit/SKILL.md|Do not attempt a third variation
skills/processed-beef-orchestrate/references/governance.md|It does not approve plan record-keeping
skills/processed-beef-orchestrate/references/artifacts.md|The plan has two surfaces
skills/processed-beef-orchestrate/references/scheduling.md|\`handover\` is the only terminal one
skills/processed-beef-work-unit/SKILL.md|\`handover\` is the only terminal status
skills/processed-beef-orchestrate/references/scheduling.md|the applicable \`docs/principles.md\` clauses stated in the brief
skills/processed-beef-work-unit/SKILL.md|The brief states the applicable \`docs/principles.md\` clauses
skills/processed-beef-orchestrate/SKILL.md|once one of those counts exceeds 1
EOF

    # The revised thresholds must be stated identically everywhere they appear.
    for file in \
        "$repo_root/README.md" \
        "$repo_root/docs/architecture.md" \
        "$repo_root/skills/processed-beef/SKILL.md" \
        "$repo_root/skills/processed-beef-orchestrate/SKILL.md" \
        "$repo_root/skills/processed-beef-work-unit/SKILL.md" \
        "$repo_root/skills/processed-beef-orchestrate/assets/agent-process.md" \
        "$repo_root/skills/processed-beef-orchestrate/references/scheduling.md" \
        "$repo_root/docs/integrations/antigravity.md" \
        "$repo_root/docs/integrations/claude-code.md" \
        "$repo_root/docs/integrations/codex.md" \
        "$repo_root/docs/integrations/opencode.md" \
        "$repo_root/docs/integrations/vscode.md"; do
        normalized=$(tr '\n' ' ' < "$file" | tr -s ' ')
        if printf '%s' "$normalized" | grep -Eq 'about 30 of its own tool calls|about 50 of its own tool calls|hands over after about 20 dispatches'; then
            error "${file#"$repo_root"/}: stale return threshold wording"
        fi
    done
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
check_circuit_breakers_contract

if ! node "$repo_root/tests/opencode-plugin.mjs"; then
    error "OpenCode plugin contract failed"
fi

exit "$fail"
