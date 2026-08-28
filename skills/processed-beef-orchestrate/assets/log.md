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
- Work-kind ledger entry: <read or mutate / approved scope / evidence>
- Source snapshot: <identifier / timestamp / scope>
- Output correspondence: <output reference linked to the source snapshot>
- Post-latest-change freshness: <observation>
- Candidate inventory: <scoped candidates classified as tracked or untracked>
- Read authorization: <authority / scope / expiry>
- Mutate authorization: <authority / scope / expiry, or none>
- Warning baseline: <informational only; cannot mask failed assertions, nonzero commands, missing output, or unmet live-safety prerequisites>
- Preservation: <one container maximum; manifest paths, reason, owner, retention, deadline, cleanup owner, and cleanup disposition; irreversible deletion or overwrite of untracked data escalates to the Orchestrator and must not proceed on brief authorization alone>
- Notes: <discovery, blocker, or required decision>
- Change-wide telemetry: <implementation dispatches, semantic attempts, dispatch-invalids,
  pre-review corrections, finding-fix corrections, independent reviews,
  changed-kind resets, broad gates, Worker/Lead tool-call proxies, acceptance
  criteria moved, and no-progress streak, if relevant>
