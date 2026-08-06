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
| GREEN | Inspected the actual diff, files, and evidence first and let the diff decide, then conservatively counted raw bytes one-to-one and returned through the appropriate terminal boundary before the 85% context limit. |

## Scenario 4 - Mechanical Staging Delegation (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-06/07 in a brdgme session, under the skills as they read before this change: a Lead given a multi-file mechanical git staging and commit-composition unit self-executed it directly instead of delegating the mechanical staging to a Worker, burning 127 tool calls (121 bash), $5.52, and 19.7M cache-read tokens in one session on hunk-splitting and staging work that was the most delegable work in the session. |
| GREEN | Pending future observation under the delegation-economics guidance. |

## Scenario 5 - Unreviewed Production Fix (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-06/07 in a brdgme session, under the skills as they read before this change: a Lead given a diagnosis-and-fix unit wrote the production fix itself rather than dispatching a Worker to implement it, and no independent review was performed, leaving 261 lines of production code written across two files with zero independent review. |
| GREEN | Pending future observation under the delegation-economics guidance. |

## Scenario 6 - Repeated Narrowing Instead of Delegation (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-06/07 in a brdgme session, under the skills as they read before this change: a role whose command output was rejected or too large for its context re-ran it repeatedly with narrower filters instead of dispatching a Worker to load and curate the material once, making four successive expensive CI-log extractions hunting one failure line instead of delegating the extraction. |
| GREEN | Pending future observation under the delegation-economics guidance. |

## Scenario 7 - Duplicated Corpus Loading (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-06/07 in a brdgme session, under the skills as they read before this change: a Lead loaded a tracker corpus to plan work and then its dispatched Worker independently loaded the same corpus again to perform the edit, duplicating the load cost instead of the Lead scoping from paths and reviewing the returned diff, with the Lead doing 22 reads of the corpus and the Worker doing 18 reads and 16 greps of the same corpus. |
| GREEN | Pending future observation under the delegation-economics guidance. |

Note: a related but distinct variant - the Lead skipping delegation entirely
rather than duplicating a Worker's load (0 Task calls, 158,473 bytes read
directly) - was observed RED on 2026-08-07; see Scenario 8.

## Scenario 8 - Lead Direct-Read Ownership of a Read-Only Corpus (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-07 in a brdgme session: a Lead briefed to audit two large tracker files (186,611 and 162,677 bytes) under the skills as they read after the delegation-economics guidance landed made 0 child-session dispatches (task tool calls: 0) and instead self-paginated 11 direct reads totalling at least 158,473 bytes, exceeding the skill's own 127,500-byte ceiling, driving cache_read to 2,069,716 tokens and cost to $0.9238 versus a same-session Orchestrator baseline of 230,314 cache_read tokens and $0.8042 for comparable oversight work. |
| GREEN | Pending future observation under the specifiability test, corpus-ownership, and Late Size Discovery extensions above. |

## Scenario 9 - Direct Test-Run Execution Instead of Delegation (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-07 in a brdgme session: both the Lead and the Orchestrator ran `sh tests/validate.sh` directly via the Bash tool multiple times across the session instead of dispatching a Worker, despite `references/scheduling.md`'s delegation-decision list naming build, test, lint, and format iterate-until-green loops as a mandatory delegation trigger. |
| GREEN | Pending future observation under the delegable-categories clause and cost-tier rationale added in this follow-up. |
