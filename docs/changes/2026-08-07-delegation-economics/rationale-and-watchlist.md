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
| Recorded dispatch forfeits | Zero (a Lead loading a unit's material and then dispatching a Worker for that same unit's remaining work, rather than finishing it itself) | Lead reports and log entries recording forfeits |
| Same-material duplication events | Zero (Lead and Worker, or two Workers, independently loading the same corpus in one unit) | Comparing read and grep targets across roles within a unit in the session record |
| Unreviewed Lead-written production changes | Zero (every Lead-authored production diff has an independent review or an explicit recorded reason review was not possible) | Lead reports and commit history |
| Quality signals | Preserved: zero commit-only Workers, zero Worker task calls, zero `host-unknown`, and `decision-needed` still correctly returned on contradictory briefs | Session record status counts |

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
| Duplication | Each body of material is loaded by exactly one role per unit | Lead and Worker both loading the same material in one unit |
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
