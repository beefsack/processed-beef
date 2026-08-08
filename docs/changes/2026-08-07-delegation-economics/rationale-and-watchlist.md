# Delegation Economics Rationale and Observation Watchlist

## Purpose and Status

This is the durable evidence and follow-up record for the delegation economics
change. It records historical observations, the reasoning behind the change,
and desired outcomes to validate in future sessions. It is non-normative
supporting evidence, not the process contract itself: the installed skills and
their references remain the normative source for delegation rules.

## Historical Baseline

The brdgme session that prompted this change ran 2026-08-06/07 under the
Lead-owned lifecycle from 2026-08-05. It was measured from one opencode session
store, across 13 sessions:

- Roles: 1 Orchestrator (claude-opus-5), 8 Leads (claude-sonnet-5 high), and 4
  Workers (deepseek-v4-flash).
- Cost: Orchestrator $12.48 (43%), Leads $16.45 (57%), Workers $0.03 (0.1%).
  Total $28.96.
- Tokens: 55.2M cache-read tokens and 444k output tokens.
- Time: 14.3 wall hours, about 4.7 active hours, with a 9.6-hour overnight gap.
- Worker:Lead session ratio of 0.5. The 2026-08-05 lifecycle change's
  directional target implies about 2.8 (50 Workers / 18 Leads). The prior
  baseline before that change was 1.5 (93/62).
- Four of the eight Leads dispatched zero Workers.
- Tool calls: Leads self-executed 503; Workers made 139 total.
- The most expensive session was a Lead doing 127 tool calls (121 bash) of
  mechanical git hunk-splitting and staging: $5.52 and 19.7M cache-read tokens.
  It was the most delegable work in the session, run on the
  second-most-expensive model.
- One Lead wrote 261 lines of production code across two files with no
  independent review.
- Workers made 37 direct edit calls across three sessions (5, 8, 24); they
  already edit files directly, and no patch-passing occurred.
- One observed duplication: a Lead did 22 reads of a tracker corpus, then its
  Worker did 18 reads and 16 greps of the same corpus.
- The Orchestrator made 72 tool calls, 39 of them bash, including four
  successive expensive CI-log extractions hunting one failure line.

This is aggregate evidence from one session of commit-and-cleanup work, not a
benchmark promise. Its scope is not comparable to the 2026-08-05 baseline,
which covered a different, larger session.

What worked and must not be weakened: zero commit-only Workers, zero Worker
task calls, zero `host-unknown` results, zero correction rounds, and one Lead
that correctly returned `decision-needed` when handed a factually wrong brief,
which prevented a wrong change to accepted business logic.

## Attribution

Do not assign all cost or failures to one cause. Preserve these separate,
non-exclusive contributors when interpreting future results:

- Three scheduling.md clauses that, as they read before this change, told Leads
  to read directly by default and are named as contributing causes:
  - references/scheduling.md, Standard Dispatch Sequence item 2 (formerly):
    "Lead uses serial Workers for focused investigation only when direct reads
    are insufficient."
  - references/scheduling.md, Recovery section (formerly): "Workers are never
    dispatched only to stage or commit..."
  - references/scheduling.md, Lead Inspection section (formerly): "the Lead
    deeply reads the active change's relevant specification and plan, governing
    clauses, implementation evidence..."
- Lead choices, including defaulting to direct execution of delegable work.
- Orchestrator raw extraction during its own root-session work.
- Model assignment choices and user-session constraints in effect at the time.
- Host and tool behavior in effect at the time.

The following were not caused by the skills and must not be conflated with a
skill defect: model assignment choices, user-session constraints in effect at
the time, and host or tool behavior (for example, how a given host truncates or
rejects oversized reads).

## Decision Rationale

The dominant observed problem was Leads defaulting to direct execution of
delegable work. The prior wording only triggered delegation when direct reads
were "insufficient", leaving that test undefined; it never asked whether the
Lead could already state the work. The new specifiability test replaces that
ambiguity: a unit is delegated unless the Lead can already state, in the brief
itself, what changes and what the result must be.

The corpus-ownership and forfeit rule fixes the observed duplication directly.
Once material is loaded, dispatching a Worker to reload it recovers nothing:
the load cost is already paid. The Lead therefore finishes the unit itself and
records the forfeit. This is the direct fix for the observed 22-then-18-reads
and 16-greps duplication of one corpus.

Late Size Discovery is a reactive delegation trigger, distinct from a forfeit.
Reactive delegation is permitted only when the triggering event, a size
rejection, truncation, or pagination, leaves the cost unpaid, meaning the
content is still outside the role's context. Delegating after the Lead already
paid to load the material is a forfeit, not a legitimate reactive trigger. The
four successive CI-log extractions are the motivating case: each repeated
narrowing or resampling paid again for the same discovery instead of
dispatching once.

Named review points (checkpoints) let a Lead delegate large, discoverable,
higher-risk units, such as the 127-tool-call mechanical staging session or the
261-line unreviewed production fix, without giving up incremental review. The
correction budget is per checkpoint, not per unit, so review stays cheap and
frequent without recreating whole-unit fragmentation.

Alternatives considered and rejected:

- A tool-call or file-count threshold for triggering delegation: rejected
  because count and cost are decorrelated; one 95KB read exceeded the cost of
  121 small git commands in the observed session.
- Mid-unit reactive dispatch after the Lead has already loaded the unit's
  material: rejected because it recovers nothing (the cost is already paid),
  hence the forfeit rule instead.
- Granting Workers patch-only output instead of direct edit access: rejected
  because Workers already edit files directly (37 direct edit calls observed)
  and patch-passing was previously found inefficient.
- Replacing checkpoints with smaller units, one Worker per smaller slice:
  rejected because it recreates the fragmentation that the 2026-08-05
  lead-lifecycle change removed, a fresh Lead or Worker per micro-unit.

## Desired Outcomes for a Future Session

The following are measurable targets for a future comparable session, not
promises:

| Measure | Target | Observed from |
|---|---|---|
| Worker:Lead session ratio | At or above 2.0 | Session-store session count by role |
| Orchestrator share of total session cost | Materially below the measured 43% | Session-store per-session cost attribution |
| Orchestrator cost per dispatch | Track alongside cost share, not as a replacement: cost share alone conflates dispatch-driven cost with raw-extraction cost | Orchestrator total session cost divided by dispatch (`task`) tool-call count, from the session store |
| Recorded dispatch forfeits | Zero (a Lead loading a unit's material and then dispatching a Worker for that same unit's remaining work, rather than finishing it itself) | Lead reports and log entries recording forfeits |
| Same-material duplication events | Zero, excluding a unit's `spec.md` and `plan.md`, which the owning Lead is required to hold fully to scope, decide, and accept the unit (Lead and Worker, or two Workers, independently loading the same corpus in one unit, is still zero) | Comparing read and grep targets across roles within a unit in the session record, excluding each unit's `spec.md` and `plan.md` |
| Unreviewed Lead-written production changes | Zero (every Lead-authored production diff has an independent review or an explicit recorded reason review was not possible) | Lead reports and commit history |
| Quality signals | Preserved: zero commit-only Workers, zero Worker task calls, zero `host-unknown`, and `decision-needed` still correctly returned on contradictory briefs | Session record status counts |

Orchestrator cost share is driven by dispatch count and accumulated
conversation length, not raw-extraction volume: one observed session reached
49.3% Orchestrator cost share from dispatch and conversation overhead alone,
with a single file read and zero raw extraction. Track Orchestrator cost per
dispatch alongside cost share, and treat a rising share at a falling or flat
per-dispatch cost as compatible with healthy delegation, not a regression.

These targets depend on the current model assignment (Workers on a
near-zero-cost model, Leads and Orchestrator on premium models) and must be
revisited if that assignment changes.

## Per-Session Capture

For each material session, keep a concise aggregate record with:

- Role counts by actual host, and the Worker:Lead session ratio.
- Per-role cost and cache-read token totals from the session store.
- For every unit, whether its owner was chosen before its material was loaded,
  and any recorded dispatch forfeit.
- Same-material duplication events: matching read and grep targets across roles
  within one unit.
- Tool-call counts per role, and the most expensive unit with its trigger.
- Late Size Discovery usage, with each trigger classified as leaving the cost
  paid or unpaid.
- Checkpoint usage: named review points, per-checkpoint correction rounds, and
  any review that reloaded the unit's whole material.
- Lead-authored production diffs and whether each had independent review or a
  recorded reason it was not possible.
- Orchestrator raw-extraction attempts in the root session.

Raw session records are useful aggregate evidence. Reports must summarize them
rather than copying huge transcripts, and must never include secrets.

## Success Signals and Warning Thresholds

| Area | Success signal | Warning threshold |
|---|---|---|
| Delegation decision | Every unit's owner is chosen before its material is loaded | Any recorded dispatch forfeit, or any dispatch after the Lead loaded the unit's material |
| Tier economics | Work sits in the cheapest tier that can do it correctly | A Lead unit consuming heavy context on self-executed change work, with no dispatch and no recorded forfeit |
| Duplication | Each body of material is loaded by exactly one role per unit, excluding a unit's `spec.md` and `plan.md`, which the owning Lead is required to hold | Lead and Worker both loading the same material in one unit, other than `spec.md` and `plan.md` |
| Late size discovery | Size-rejected material is delegated on first rejection | Any repeated narrowing, paging, or resampling of size-rejected material by the rejecting role |
| Checkpoint review | Review points are named before dispatch and reviewed incrementally | Any checkpoint review that reloads the unit's whole material, or a correction budget applied per unit instead of per checkpoint |
| Orchestrator discipline | Zero raw extraction in the root session | Any raw log, diff, test-output, or file-survey extraction by the Orchestrator |

"Heavy" is deliberately unquantified: the meaningful comparison is a Lead
unit's context volume against comparable Worker units in the same session, and
it becomes usable only once several sessions are recorded.

## Revisit or Rollback Triggers

Do not automatically revert on a single metric miss. Propose a governed
revision or rollback when any of the following is established:

- Repeated dispatch forfeits show the specifiability test is not changing Lead
  behavior in a comparable session.
- Same-material duplication recurs after the corpus-ownership rule is in force.
- Unreviewed Lead-written production changes recur without recorded reasons.
- The efficiency targets (Worker:Lead ratio and Orchestrator cost share) miss
  across several comparable sessions without an offsetting quality benefit.
- Late Size Discovery is used as a path around the forfeit rule.

Any such decision should use the captured aggregate evidence, identify the
contributing attribution categories above, and preserve historical records
unchanged.

## Falsification

Scenario 7 ("Duplicated Corpus Loading") was recorded GREEN: Pending future observation. On 2026-08-07 the predicted case was tested by a fresh Lead session auditing two large tracker files (186,611 and 162,677 bytes) under the delegation-economics guidance from ca2262a. The observation falsified the prediction for the Lead-direct-read variant: the Lead made 0 child-session dispatches (task tool calls: 0; bash 25, read 11, skill 1) and read at least 158,473 bytes directly across 11 self-paginated offset/limit reads, exceeding the skill's own 127,500-byte ceiling (already breached on this low, lower-bound estimate; the on-disk total across both files is 349,288 bytes). This is recorded as a new failure mode (Scenario 8), distinct from Scenario 7's original duplicated-loading pattern: rather than the Worker re-loading what the Lead already loaded, the Lead never delegated at all.

## Follow-up Rationale (Including the Mechanism Finding)

The dominant cost is not the raw bytes read but the compounding cache-read cost of carrying that content through every subsequent tool turn: the session drove cache_read to 2,069,716 tokens (cache_write 117,951) across roughly 36 tool turns, each of which re-sends the accumulated context, against a same-session Orchestrator baseline of 230,314 cache_read tokens for comparable oversight work with a single narrow read. The burn is therefore superlinear in what is read early, not linear - an early bulk load inflates every later turn's cost, not just its own. The seven edits close the specific gaps that let this happen:

1. Context Discipline (SKILL.md) now names the Lead, not just the Orchestrator, as excluded from holding raw content, closing the gap that only bound the Orchestrator.
2. The raw-extraction prohibition (SKILL.md) now covers the Lead's own reads, not only Orchestrator commands.
3. Late Size Discovery (scheduling.md) now treats a Lead's own size/line-count check as equivalent to a host-triggered rejection, closing the gap that let self-chosen pagination dodge the reactive trigger.
4. The specifiability test (scheduling.md) now explicitly binds read-only/investigation units, closing the gap that framed specifiability only around change units.
5. Corpus Ownership (scheduling.md) now requires a Lead-held brief to carry forward already-established facts/IDs, addressing the counter-pressure that briefs must carry comprehensive context while still requiring delegation.
6. Report Shape (work-unit/SKILL.md) now requires read-only/investigation Worker reports to itemize every requested fact rather than summarize, addressing the counter-pressure that read-only units have no diff safety net, so the report is the only evidence.
7. The cost-asymmetry note (scheduling.md) records that a Lead's byte typically costs more than a Worker's under mixed model tiers (the failing session ran the Lead on a costlier model tier than the Worker), giving an explicit reason to delegate beyond raw context volume.

## Monitoring Criteria for the Next Test Session

Query `~/.local/share/opencode/opencode.db` for the next Lead session handling a large corpus (read-only audit, investigation, or similar) and check:

- Lead `task` tool-call count is > 0 whenever the unit involves a corpus that cannot be fully specified without loading it (specifiability test, edit 4).
- Lead direct-read bytes (summed across all `read` tool calls attributed to the Lead role) stay under the 127,500-byte ceiling; a Lead that self-checks a file's size and finds it large must delegate the load rather than proceed with self-paced pagination (edit 3).
- Lead session `cache_read` tokens are compared against this session's 2,069,716-token baseline; a materially lower figure for comparable corpus size is the expected signal that delegation is compounding less cost per turn.
- Regression is specifically: any Lead session with `task` tool-call count == 0 while its `read` tool calls sum past 127,500 bytes on files the Lead could not have fully specified in advance. That exact pattern is what this follow-up targets, and its recurrence means the edits did not close the gap.

## Role-Model Clarification Follow-up (2026-08-07)

A user-authored audit of the role models found ten gaps in the delegation-economics guidance as installed: the pre-start split option was missing from the Lead role definition and Recovery, host reconciliation was an unstated exception to the raw-extraction rule, the delegable categories were unnamed, the Lead and Orchestrator had no read whitelists, the Worker had no interaction boundary, the escalation ladder by decision blast radius was undefined, the cost-tier rationale was scattered, and there was no path for a Lead to consult the Orchestrator's technical expertise. These were closed in the ten items (A-J) recorded in `spec.md` and `plan.md`. Scenario 9 (direct `sh tests/validate.sh` runs by the Lead and Orchestrator despite the test-run delegation trigger) was observed RED on 2026-08-07 and is recorded in `tests/behavioral.md`.

Two scope decisions were deliberate and are not open questions:

- Duration language (hours-to-days / minutes-to-hours / minutes) was omitted: agents cannot measure elapsed time, and token boundaries already govern handovers.
- The Orchestrator was kept a technical-consultation-only role (item J), not a general technical authority that reads code, preserving the days-long low-overhead Orchestrator the architecture depends on.

Watchlist:

- Whether the pre-start split path (item A) is actually used, or Leads still grind through oversized units and only hit the reactive two-failed-attempt trigger.
- Whether the blast-radius escalation ladder (items G and H) is legible enough to change Worker and Lead behavior, or decisions still route to the wrong role.
- Whether Scenario 9's direct test-run execution recurs: the test-run delegation trigger is already in `scheduling.md`, so any future Lead or Orchestrator running `sh tests/validate.sh` directly is a regression.

## Session Capture: 2026-08-08

A brdgme production-incident session was measured against the desired
outcomes above:

- 33 sessions: 1 Orchestrator (claude-opus-5), 8 Leads (claude-sonnet-5, one
  nested), 24 Workers (deepseek-v4-flash). Max depth 2. Worker:Lead ratio 3.0.
- Cost $36.07: Orchestrator $17.78 (49.3%), Leads $18.01 (49.9%), Workers
  $0.28 (0.8%).
- Tool calls: Orchestrator 67 (29 bash, 1 read, 24 task); Leads 369 (187
  bash, 79 edit, 54 read); Workers 627 (421 bash, 104 read, 48 edit). Leads
  made more edit calls (79) than Workers (48).
- Tokens: Orchestrator 4,097,574 cache-read / 82,530 output; Leads 44,652,892
  cache-read / 372,873 output; Workers 28,287,616 cache-read / 150,977
  output.
- Span 20.71 wall hours, about 3.21 active hours. Most expensive session: the
  root Orchestrator, $17.78.
- Incidents: one nested-Lead role confusion (a Lead loaded this skill,
  misidentified itself as Orchestrator, and dispatched a nested Lead past
  supported subagent depth); one unasked deletion of a 31 MB production
  database dump by a Worker during read-only recon.

Measured against the targets above:

- Hit: Worker:Lead ratio 3.0 (target at or above 2.0). Zero `host-unknown`,
  zero commit-only Workers. About 9 `decision-needed` escalations, every one
  correct, catching real production defects.
- Missed: Orchestrator cost share 49.3% (target: materially below 43%).
  Same-material duplication: 9 overlaps across 4 Leads, of which only the
  overlaps outside `spec.md`/`plan.md`/`log.md` (a `deny.toml`, a `ci.yml`,
  and both tracker files in one unit) count as waste under the corrected
  target above; the rest were a Lead correctly holding its own unit's spec
  and plan. Orchestrator raw extraction: 29 bash calls.
- Failed completely: the context ceiling. Peak single-request context reached
  306,523 tokens (a Lead), more than double the `150000` limit; four sessions
  exceeded it (306,523 / 225,278 / 176,832 / 154,843); 190 assistant messages
  tree-wide reached or exceeded 150,000 tokens; zero handovers occurred all
  session. Root cause: the `wc -c` rule counted file bytes read only,
  overcounting reads by 3-4x while ignoring the conversation, tool outputs,
  subagent reports, and skill text where context actually accumulates - the
  Orchestrator did one file read yet reached 4,097,574 cache-read tokens.
  This is the direct motivation for replacing byte counting with the
  countable-proxy thresholds recorded in the installed skills and
  references.

Comparability caveat: the delegation-economics baseline above was a
commit-and-cleanup session; this session was a production data repair with a
live incident, so the two are not directly comparable on cost or duration.

PII handling in agent output was raised during this follow-up and explicitly
rejected by the user as out of scope: it is a project- or user-owned data
concern, not agent-structure guidance, and should not be reproposed here.
