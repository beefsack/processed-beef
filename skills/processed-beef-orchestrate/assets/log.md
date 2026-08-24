# Log: <title>

Append-only. Append after a meaningful checkpoint: an accepted semantic unit,
verified partial result, blocker, pending user decision, unsuccessful host
attempt, `dispatch-invalid`, context handover, semantic or governance change, independent review
finding, commit, or approved plan change. Each entry records timestamp, role
and work unit and attempt, result, changed files or commit, verification, and
any discovery, blocker, or required decision. Include the dispatch status and
change-wide countable proxy when relevant. No narration, copied output, or
speculation.

## YYYY-MM-DD HH:MM

- Role / unit: <role> / <unit-id> / <attempt-id>
- Result: <result>
- Files / commit: <paths or hash>
- Verification: <evidence>
- Notes: <discovery, blocker, or required decision>
- Change-wide telemetry: <implementation dispatches, dispatch-invalids,
  pre-review corrections, finding-fix corrections, independent reviews,
  changed-kind resets, broad gates, Worker/Lead tool-call proxies, acceptance
  criteria moved, and no-progress streak, if relevant>
