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

Attempt counts belong to the semantic unit and are inherited, never reset by
succession. A third attempt, a second correction round, or a second independent
review on one unit trips a circuit breaker. List a unit only once one of its
counts exceeds 1; absence means all counts are 1 or lower.

| Unit | Attempts | Corrections | Independent reviews |
|---|---|---|---|
| <unit-id> | 2 | 1 | 0 |
