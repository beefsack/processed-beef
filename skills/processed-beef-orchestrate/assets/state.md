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

Implementation-attempt and correction counts belong to the semantic unit and are
inherited, never reset by succession. A third implementation attempt, second
pre-review correction, second finding-fix correction for one finding set, or
second independent review trips its class's breaker. The change-wide ledger also
survives succession: a second changed-kind reset, or three implementation
dispatches without an acceptance criterion moving, parks and escalates.

| Unit | Implementation attempts | Pre-review corrections | Finding-fix corrections | Independent reviews |
|---|---:|---:|---:|---:|
| <unit-id> | 2 | 1 | 0 | 0 |

| Implementation dispatches | Dispatch-invalids | Changed-kind resets | Acceptance criteria moved | No-progress streak |
|---:|---:|---:|---:|---:|
| 0 | 0 | 0 | 0 | 0 |
