# State: <title>

Created before the next dispatch once a second Lead succession occurs on the
change or any Expanded trigger fires. A fresh Lead is succession
only: it continues the same major unit until accepted, externally blocked, or
its return threshold, never ordinary scheduling for a plan unit,
correction, or commit.

- Current major unit / attempt: <unit-id/attempt-id>
- Completed units: <unit-ids>
- Blockers: <blockers>
- Next dispatch: <next Lead objective>

## Evidence Snapshot

| Work kind | Scope | Read authorization | Mutate authorization | Evidence |
|---|---|---|---|---|
| <read or mutate> | <approved scope> | <authority / scope / expiry> | <authority / scope / expiry, or none> | <reference> |

- Source snapshot: <identifier / timestamp / scope>
- Output correspondence: <output reference linked to the source snapshot>
- Post-latest-change freshness: <observation>
- Scoped candidate inventory: <approved scope; each candidate classified as tracked or untracked>
- Warning baseline: <informational only; cannot mask failed assertions, nonzero commands, missing output, or unmet live-safety prerequisites>
- Preservation: <one container maximum; manifest paths, reason, owner, retention, deadline, cleanup owner, and cleanup disposition; irreversible deletion or overwrite of untracked data escalates to the Orchestrator and must not proceed on brief authorization alone>

Semantic-attempt and correction counts belong to the semantic unit and are
inherited, never reset by succession. Mechanical events before approved semantic
source changes or a target live scenario or intended mutation do not increment
them. A third semantic attempt, second
pre-review correction, second finding-fix correction for one finding set, or
second independent review trips its class's breaker. The change-wide ledger also
survives succession: a second changed-kind reset, or three semantic attempts
without a progress credit, parks and escalates.

| Unit | Semantic attempts | Pre-review corrections | Finding-fix corrections | Independent reviews |
|---|---:|---:|---:|---:|
| <unit-id> | 2 | 1 | 0 | 0 |

| Implementation dispatches | Semantic attempts | Dispatch-invalids | Changed-kind resets | Acceptance criteria moved | No-progress streak |
|---:|---:|---:|---:|---:|---:|
| 0 | 0 | 0 | 0 | 0 | 0 |
