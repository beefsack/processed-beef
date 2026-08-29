# Behavioral Record

Historical pressure record for the processed-beef skill set. It preserves the
incidents behind current and superseded rules; it is not a normative runtime
specification or a guarantee. RED is an observed failure. GREEN is an observed
or explicitly pending result under the guidance named at that time. Durable
causality and supersession are indexed in `docs/learnings.md`.

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
| GREEN | The plan names `bash scripts/dogfood-install.test.sh` as the canonical gate with a zero-failure baseline. The Lead reruns and reconciles that gate locally; the command mismatch is not a user decision. |

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

## Scenario 25 - COSMIC Fixture and Integration Dependency Cycle (processed-beef-orchestrate)

| Run | Observed behavior |
|---|---|
| RED | A COSMIC integration packet depended on a fixture that depended back on the integration, or proceeded with a replacement fixture before the fixture contract was accepted, treating the cycle as implementation work. |
| GREEN | Pre-source dependency validation returns `dispatch-invalid` for the cycle and for integration without an accepted fixture or harness dependency. One packet repair is allowed; changing the graph requires an approved semantic plan change. No production workaround, semantic attempt, correction, review, or no-progress increment occurs. |

## Scenario 26 - Correction-Omitted Test Import (processed-beef-orchestrate / processed-beef-work-unit)

| Run | Observed behavior |
|---|---|
| RED | A finding-fix correction omitted a test import, causing a formerly passing canonical gate to fail, and a follow-up patch was treated as an ordinary correction without proving causality or freshness. |
| GREEN | Exactly one repair is admitted only after predecessor-valid passing evidence, reproducible failure, localized correction provenance, unchanged finding set, fresh before/after scoped snapshots and output correspondence, and an original-target recheck. The import-only test repair records `canonical_gate_restored`, preserves counters, and does not reset no-progress; stale evidence, a second claim, a failed restoration, or any semantic edit parks and escalates. |

## Scenario 27 - Untracked Generated Candidate Preservation (processed-beef-orchestrate / processed-beef-work-unit)

| Run | Observed behavior |
|---|---|
| RED | A generated untracked candidate was overwritten or omitted from the source inventory, then output from a different worktree state was presented as current acceptance evidence. |
| GREEN | The scoped inventory preserves the generated candidate and classifies approved, modified, deleted, and untracked inputs without mutating excluded state. The source snapshot records relevant untracked inputs, separate read and mutate authorization is retained, and output correspondence plus post-latest-change freshness is required before acceptance. |

## Scenario 28 - Pointer Unsupported Ordered-Write Oracle (processed-beef-orchestrate / processed-beef-work-unit)

| Run | Observed behavior |
|---|---|
| RED | A pointer-resize ordered-write failure was labeled a harness defect so a repair could change the oracle or expected ordering, widening semantic scope while preserving a passing test. |
| GREEN | Oracle, ownership, route, snapshot, rollback, fixture-contract, and production-invariant changes are disqualified from the bounded verification-repair protocol and remain ordinary semantic work. An oracle change cannot erase correction, finding-fix, or changed-kind-reset counters, and mere relabeling cannot reset no-progress. Acceptance or progress credit requires fresh verified evidence. Separately, one genuine changed-kind reset is allowed once across the change and its descendants when it changes the acceptance mechanism, evidence boundary, fixture/oracle, or ownership; a second changed-kind reset parks and escalates. A changed-kind reset is not a patch, Worker replacement, review pass, or relabeled brief. |

## Scenario 29 - Pointer Payload-Free Signal Typing (processed-beef-orchestrate / processed-beef-work-unit)

| Run | Observed behavior |
|---|---|
| RED | A payload-free pointer signal exposed a production typing or public-contract change as a verification repair, bypassing the semantic-attempt and review budgets. |
| GREEN | A test, fixture, harness, gate, typing, or evidence-plumbing-only correction may use the bounded protocol with fresh snapshots and output correspondence. A production signal type, ownership, public route, or contract change remains semantic work, increments only its semantic-attempt class, and receives no repair credit or no-progress reset. |

## Scenario 30 - Pre-Effect Live Failures Consume Attempt Budget

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-29 in a plasma-auto-tiler tray session: one live runner stopped before mutation on a harness ownership-query defect and a second stopped before any target scenario because `cargo` was outside `devenv`. Zero product scenarios ran, but both were counted as semantic attempts and the live unit parked. |
| GREEN | A live semantic attempt begins at the first intended host mutation or target scenario. Preflight, tool, environment, dependency, working-directory, output-containment, and evidence-path failures before that boundary are mechanically reconciled, preserve their evidence, and consume no semantic-attempt or no-progress budget. Any source fix still follows the ordinary semantic lifecycle, and repeated pre-effect failures require Lead reassessment rather than unlimited reruns. |

## Scenario 31 - Incidental Baseline And Record Drift Block Valid Work

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-28 and 2026-08-29 in a plasma-auto-tiler tray session: adding a passing test broke an exact pass-count baseline, and stale summary rows repeatedly invalidated dispatches despite a current detailed gate and unchanged behavior, scope, safety, and dependencies. The final plan still reported both zero and two live attempts in different sections. |
| GREEN | Expected baselines state semantic pass conditions and pin exact counts only when contractual. Added passing tests do not invalidate an unchanged no-failure or no-new-failure baseline. Record-only drift is Lead-reconciled and cannot block source work when the approved semantic plan and gate are unambiguous. |

## Scenario 32 - Selector And Persona Confused With Process Role

| Run | Observed behavior |
|---|---|
| RED | Observed 2026-08-28 in a plasma-auto-tiler tray session: a valid Lead/Orchestrator role packet was rejected because `agent_selector` and host persona used the same label, even though the two process-role fields matched and nested Worker capability was demonstrated. |
| GREEN | `process_role` and `parent_process_role` are the only blocking role fields. Selector, model, and persona observations are reported for host reconciliation but do not invalidate a dispatch when process roles and required capabilities match. |

## Scenario 33 - Cumulative Process Weight Exceeds Its Work

| Run | Observed behavior |
|---|---|
| RED | Measured 2026-08-29 at `bcc1553`: a normal Standard parent/Lead path could load 1,047 lines and 60,569 bytes of skill and references before project context, while each Worker loaded another 160 lines and 10,554 bytes. Nine templates added 16,880 bytes, ordinary work required three change artifacts, and approval, packet, status, and retry ledgers could turn mechanical repair into the dominant work. |
| GREEN | The 2026-08-29 runtime contains three role-local `SKILL.md` files with no runtime references or templates. `tests/validate.sh` enforces per-skill and aggregate payload ceilings; the user request authorizes ordinary work; one change note, independent review, and escalation are conditional on demonstrated value or risk. Behavioral effectiveness remains subject to future observation. |

## Scenario 34 - Disposable Agent Ownership Boundaries

| Run | Observed behavior |
|---|---|
| RED | Prior policy/documentation gap evidenced by the pre-change diff: guidance did not explicitly require disposable Lead/Worker contexts, a fresh Worker for each bounded unit with a terminal result, or terminal completed agents at ownership boundaries. |
| GREEN | Pending future observation under the new disposable-context guidance: one Lead remains through one coherent change for L004 economics, a fresh Lead starts at a real ownership boundary, and a fresh Worker starts for each bounded unit with a terminal result. Completed agents remain terminal; an unfinished continuation is used only when it clearly unblocks the same narrow objective and is demonstrably cheaper, safe, and still context-useful. |

## Scenario 35 - Lean Terminal Handover Across Succession

| Run | Observed behavior |
|---|---|
| RED | Prior policy/documentation gap evidenced by the pre-change diff: guidance did not explicitly define a lean terminal handover limited to successor facts, or require nonzero semantic failures and causal repair provenance to cross fresh-context succession into an active change note when one exists. |
| GREEN | Pending future observation under the new lean-handover guidance: every role final response is a terminal handover carrying only successor-relevant attempts/failures, discoveries, decisions, gotchas/risks, evidence, and an exact next action, using `none` when no action remains. Nonzero semantic failed approaches and use of the one causal repair also appear in the active change note when one exists, preserving L008 across succession. |

## Scenario 36 - User-Owned Canonical Guidance

| Run | Observed behavior |
|---|---|
| RED | Prior policy/documentation gap evidenced by the pre-change repository: canonical process guidance was named `VISION.md` and `docs/decisions.md`, without an explicit runtime distinction between strict user-owned principles, concise active decisions, and a separate product vision. |
| GREEN | Pending future observation under the `docs/principles.md`/`docs/decisions.md` guidance: startup reads the concise records with `AGENTS.md` when present; product `VISION.md` is goal input only; Leads pass only applicable constraints to Workers, and Workers do not reload global guidance. Principles remain user-owned while authorized active decisions may be maintained without append-only history. |
