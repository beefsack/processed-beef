#!/bin/sh
# Structural release gate for the processed-beef Agent Skills repository.
set -u

repo_root=$(CDPATH= cd "$(dirname "$0")/.." && pwd)
fail=0

error() {
    printf 'validate.sh: %s\n' "$*" >&2
    fail=1
}

check_frontmatter() {
    file=$1
    skill_name=$2
    keys=$(awk '
        /^---/ { fm++; next }
        fm != 1 { next }
        /^[[:space:]]/ { next }
        /^[A-Za-z0-9_.-]+:/ {
            key = $0
            sub(/:.*/, "", key)
            print key
        }
    ' "$file")

    have_name=no
    have_description=no
    for key in $keys; do
        case $key in
            name) have_name=yes ;;
            description) have_description=yes ;;
            *) error "$skill_name: non-portable frontmatter key '$key'" ;;
        esac
    done
    [ "$have_name" = yes ] || error "$skill_name: missing name frontmatter"
    [ "$have_description" = yes ] || error "$skill_name: missing description frontmatter"

    name_value=$(awk '
        /^---/ { fm++; next }
        fm != 1 { next }
        /^name:[[:space:]]*/ {
            value = $0
            sub(/^name:[[:space:]]*/, "", value)
            print value
            exit
        }
    ' "$file")
    [ "$name_value" = "$skill_name" ] || \
        error "$skill_name: frontmatter name '$name_value' does not match directory"
}

check_ascii() {
    file=$1
    label=$2
    if LC_ALL=C grep -n '[^ -~]' "$file" >/dev/null; then
        error "$label: contains non-ASCII bytes"
    fi
}

check_links() {
    file=$1
    skill_name=$2
    directory=$(dirname "$file")
    links=$(awk '
        {
            while (match($0, /\]\([^)]*\)/)) {
                print substr($0, RSTART + 2, RLENGTH - 3)
                $0 = substr($0, RSTART + RLENGTH)
            }
        }
    ' "$file")
    [ -n "$links" ] || return

    while IFS= read -r link; do
        case $link in
            ''|'#'*|'http://'*|'https://'*|'mailto:'*) continue ;;
        esac
        target=${link%%'#'*}
        case $target in
            /*|'../'*|*'/../'*|*'/..')
                error "$skill_name: relative link '$link' escapes the skill directory"
                continue
                ;;
        esac
        [ -z "$target" ] || [ -e "$directory/$target" ] || \
            error "$skill_name: relative link '$link' does not exist"
    done <<EOF
$links
EOF
}

check_portability() {
    file=$1
    skill_name=$2
    for token in 'CLAUDE_CODE_' 'subagent_depth' '.codex/' '.opencode/' \
        '.claude/agents' 'chat.subagents' 'invoke_subagent' 'runSubagent' 'Agent('; do
        if grep -Fq "$token" "$file"; then
            error "$skill_name: host-specific token '$token' belongs in integration docs"
        fi
    done
}

skill_files=$(git -C "$repo_root" ls-files 'skills/*/SKILL.md')
if [ -z "$skill_files" ]; then
    printf 'no skills found\n' >&2
    exit 1
fi

for relative_file in $skill_files; do
    file=$repo_root/$relative_file
    skill_directory=$(dirname "$file")
    skill_name=$(basename "$skill_directory")
    lines=$(wc -l < "$file")
    bytes=$(wc -c < "$file")

    check_frontmatter "$file" "$skill_name"
    [ "$lines" -le 120 ] || error "$skill_name: $lines lines exceeds 120"
    [ "$bytes" -le 12000 ] || error "$skill_name: $bytes bytes exceeds 12000"
    check_ascii "$file" "$skill_name"
    check_links "$file" "$skill_name"
    check_portability "$file" "$skill_name"
done

total_skill_bytes=0
skill_payload_files=$(git -C "$repo_root" ls-files skills)
for relative_file in $skill_payload_files; do
    [ ! -f "$repo_root/$relative_file" ] || \
        total_skill_bytes=$((total_skill_bytes + $(wc -c < "$repo_root/$relative_file")))
done

[ "$total_skill_bytes" -le 24000 ] || \
    error "installed skill payload is $total_skill_bytes bytes; limit is 24000"

for required in VISION.md docs/learnings.md; do
    [ -f "$repo_root/$required" ] || error "missing $required"
done

markdown_files=$(git -C "$repo_root" ls-files --cached --others --exclude-standard '*.md')
for relative_file in $markdown_files; do
    [ ! -f "$repo_root/$relative_file" ] || \
        check_ascii "$repo_root/$relative_file" "$relative_file"
done

if ! node --no-warnings "$repo_root/tests/opencode-plugin.mjs"; then
    error "OpenCode plugin contract failed"
fi

exit "$fail"
