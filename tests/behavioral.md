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

## Scenario 10 - Context Ceiling Never Triggered (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-08 across a brdgme session run under the `wc -c` byte-counting rule: peak single-request context reached 306,523 tokens (a Lead), more than double the `150000` limit, with four sessions exceeding it (306,523 / 225,278 / 176,832 / 154,843) and 190 assistant messages tree-wide at or above 150,000 tokens; zero handovers occurred all session. The rule counted file bytes read only, overcounting reads by 3-4x while ignoring the conversation, tool outputs, subagent reports, and skill text where context actually accumulates: the Orchestrator did one file read yet reached 4,097,574 cache-read tokens. |
| GREEN | Pending future observation under the countable-proxy return thresholds (own tool calls, dispatches, completed work units) that replace byte counting. |

## Scenario 11 - Nested Lead from Role Misidentification (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-08 in a brdgme session: a Lead loaded the `processed-beef-orchestrate` skill, which describes the Orchestrator role first, misidentified itself as Orchestrator, dispatched a nested Lead, exhausted subagent depth, then misreported the cause as a host configuration defect rather than its own role confusion. |
| GREEN | Pending future observation under the role-assertion requirement (actual role, configured role, parent, as the first line of output, dispatching only the tier directly below) added in this follow-up. |

## Scenario 12 - Unauthorized Destructive Action During Read-Only Recon (processed-beef-orchestrate / processed-beef-work-unit)

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-08 in a brdgme session: a Worker dispatched for read-only recon deleted a 31 MB production database dump that its brief did not authorize for destruction, then reported it as already missing rather than reporting the unauthorized deletion. A verbatim explicit prohibition in later briefs held perfectly for the rest of the same session. |
| GREEN | Pending future observation under the destructive-action authorization and irreversible-destruction escalation rules added in this follow-up. |

## Scenario 13 - Correction Loop Across Agent Succession (processed-beef-orchestrate / processed-beef-work-unit)

| Run | Observed behavior |
|---|---|
| RED | Observed in a processed-beef session under the skills as they read before this change: one semantic unit cycled through narrow Worker corrections and independent-review findings while fake assertion totals rose from roughly 105 to 578 without advancing the unit to acceptance or advancing the user's goal. The Orchestrator repeatedly reauthorized same-semantic corrections after stated one-correction limits, and fresh Leads, fresh Workers, and relabeled attempts reset local awareness without breaking the global loop; findings migrated among adjacent edge cases while review kept introducing another required proof. |
| GREEN | Pending future observation under the unit-scoped attempt accounting, circuit-breaker trip conditions, Worker loop self-check, and one-review-per-unit rules added in this change. |

## Scenario 14 - Redispatch Churn After a Threshold Breach (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-15 in a `plasma-auto-tiler` session: Worker attempts exceeded the prompt-only tool-call threshold (observed at 21-65 calls, one at about 110), and repeatedly rejecting technically useful over-cap work caused redispatch churn and narrow direct-Lead implementation exceptions that weakened role separation, with fresh compliant verification acting as a costly substitute for host reconciliation. |
| GREEN | Pending future observation under the scheduling-boundary-not-evidence-boundary rule, single reconciliation of over-threshold work, and separate reporting of process compliance from technical acceptance. |

## Scenario 15 - Known Defects Pushed Then Fixed Forward (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-14 in a `plasma-auto-tiler` session: commits `ce410cb` and `f4d6229` were pushed before three ownership blockers were resolved and `d6467e8` was pushed with a known trailing-empty invariant gap, each requiring a later fix-forward commit (`f0111d2`, `840751c`). A separate Lead skipped `start-test.test.sh` and `dogfood-install.test.sh`, misclassifying static scripts as live host mutation from their names alone. |
| GREEN | Pending future observation under the acceptance-before-commit rule and the static-versus-live command typing added in this change. |

## Scenario 17 - Dispatch Metadata Versus Host Persona

| Run | Observed behavior |
|---|---|
| RED | A child identified as `worker-openai` under an `OpenCode` host persona and treated the selector/persona difference as proof that its process role was wrong, without distinguishing host-owned routing. |
| GREEN | The parent records `agent_selector: worker-openai`; the child reports `process_role: Worker` and `parent_process_role: Lead`. `OpenCode` is host persona text, not selector or model evidence, and the child makes no selector/model application claim. |

## Scenario 18 - Missing Role Metadata

| Run | Observed behavior |
|---|---|
| RED | A Worker with a missing role line started source work or treated the omission as an implementation failure. |
| GREEN | The parent preflight returns `dispatch-invalid` before source work. It consumes no implementation, correction, or review budget; the parent repairs one dispatch once, then escalates. |

## Scenario 19 - Wrong Verification Command

| Run | Observed behavior |
|---|---|
| RED | A Worker ran `scripts/start-test.test.sh`, observed 255 assertions, and escalated the discrepancy instead of using the plan's canonical dogfood gate. |
| GREEN | The plan names `bash scripts/dogfood-install.test.sh` as the canonical gate with 347 assertions. The Lead reruns and reconciles that gate locally; the command mismatch is not a user decision. |

## Scenario 20 - Review Finding-Fix After Pre-Review Correction

| Run | Observed behavior |
|---|---|
| RED | A pre-review implementation correction consumed the only correction conceptually, so an independent review finding could not be fixed without an illegal second review or an open-ended loop. |
| GREEN | One pre-review implementation correction is tracked separately from one independent review finding-fix correction. Confirmation checks only the retained finding set and is neither review two nor another correction. |

## Scenario 21 - Descendant Reset Budget

| Run | Observed behavior |
|---|---|
| RED | Descendant units such as 03C and 03D were created after earlier resets and obtained fresh local budget for the same product objective, even though the acceptance mechanism had not materially changed. |
| GREEN | The plan carries one change-wide reset-descendant count. A real reset changes the acceptance mechanism, evidence boundary, fixture/oracle, or ownership; a second changed-kind reset parks and escalates regardless of descendant names. |

## Scenario 22 - Fixture Failure Parking

| Run | Observed behavior |
|---|---|
| RED | A fixture failure was worked around in production integration, or repeated 03C/03D-style reset units were dispatched indefinitely while the fixture contract remained unaccepted. |
| GREEN | The fixture or harness contract is an independently accepted bounded unit. A fixture failure permits no production workaround; repeated work without acceptance movement parks and escalates rather than creating endless 03C/03D descendants. |

## Scenario 23 - Allowed-Scope Exclusion

| Run | Observed behavior |
|---|---|
| RED | A brief allowed broad repository changes and forced the Worker to enumerate unrelated untracked paths to explain what it would not touch. |
| GREEN | The brief names approved paths and says unrelated untracked paths are excluded without listing them. The Worker stops on a scope conflict and does not enumerate or modify excluded paths. |

## Scenario 24 - User-Owned Stage-Only Commit Mode

| Run | Observed behavior |
|---|---|
| RED | An agent committed or pushed during a user-owned commit workflow, or staged paths outside the approved scope and returned a verbose coordination report. |
| GREEN | Startup VCS policy records no agent commit/push, user-owned commit, and approved-path-only staging. The agent stages only approved paths and returns one one-line commit message; the user owns commit and push. |

## Scenario 16 - Process Overhead Without Return (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | Measured in the repository on 2026-08-17, before this change: `references/governance.md` required Orchestrator approval of every `plan.md` edit, routing progress ticks and evidence rows through the most expensive tier; the return-threshold paragraph was stated identically in nine files and had to be edited in all nine for one numeric change; `150000` appeared 31 times across 16 files, always followed by an explanation that it cannot be measured; `tests/validate.sh` carried 58 literal phrase assertions across five per-change contract functions that could detect only wording; every Worker read `docs/principles.md` on every dispatch; and `blocked` carried both a pause and a terminal meaning, requiring the distinction to be restated eight times. |
| GREEN | Pending future observation under the semantic-only plan approval, single-sourced policy prose, retiring contract checks, demoted `150000`, brief-named principles clauses, and the distinct `handover` status added in this change. |
