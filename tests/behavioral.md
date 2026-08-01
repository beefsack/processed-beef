# Behavioral Record

Pressure record for the processed-beef skill set. Each scenario was observed
with the skill guidance absent (RED) and present (GREEN) to confirm the skills
change behavior under pressure. This is an observation record, not a guarantee
of behavior.

## Scenario 1 - Entry (processed-beef)

| Run | Observed behavior |
|---|---|
| RED | Proposed dispatching parallel agents to work the session and skipped the setup steps (no role, model, or context-limit report, no environment checks), proceeding straight to work. |
| GREEN | Stopped and reported when orchestration setup could not complete (nested subagent depth two unavailable) instead of improvising, and enforced serial execution: exactly one subagent at a time, no parallelization in any mode. |

## Scenario 2 - Worker (processed-beef-work-unit)

| Run | Observed behavior |
|---|---|
| RED | Faced ambiguous timeout semantics and guessed one reading instead of reporting it, then claimed the unit complete without running or providing tests. |
| GREEN | Returned `decision-needed` without making any edits, treating competing readings of the brief as underspecified and never choosing itself. |

## Scenario 3 - Orchestration Baseline (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Mostly complied because inherited local rules aligned with the process, but prematurely proposed reverting a suspicious Worker result before inspecting the actual changes, and lacked the exact configured-limit behavior (no 85% handover). |
| GREEN | Inspected the actual diff, files, and evidence first and let the diff decide, and wrote `handover.md` and stopped at 85% of the configured context limit. |
