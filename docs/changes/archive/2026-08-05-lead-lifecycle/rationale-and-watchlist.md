# Lead Lifecycle Rationale and Observation Watchlist

## Purpose and Status

This is the durable evidence and follow-up record for the Lead-owned lifecycle
change. It records historical observations, the reasoning behind the change,
and hypotheses to validate in future sessions. It is not a second statement of
the process contract: the installed skills and their references remain the
normative source for lifecycle rules.

## Historical Baseline

The brdgme session that prompted this change ran for 14.27 wall hours across
157 sessions:

- Root session: 1.
- Leads: 62.
- Workers: 93.
- Other: 1 mistaken `general` session.
- Tokens: 10.48M input, 0.89M output, and 2.19M reasoning.
- Worker dispatches included 33 commit Workers and 10 survey or splitting
  Workers.
- Roles read VISION 86 times.
- Four reportless sessions ended `host-unknown`.
- The commit and archive phase alone took about 4.93 wall hours.

No Worker attempted a task or subagent call. Every nested call came from a
Lead, so Worker task permission was not the observed bottleneck. One
brief-and-plan contradiction instead consumed extensive context; it should have
returned `decision-needed` before implementation.

The session is useful aggregate evidence, not a benchmark promise. Counts and
timing include repository startup rules and the user and session constraints in
effect at the time.

## Attribution

The baseline does not assign all cost or failures to one cause. Preserve these
separate contributors when interpreting future results:

- Skill contradiction or ambiguity, including the brief-and-plan conflict.
- Orchestrator routing of micro-units to fresh Leads.
- Lead choices, including delegation and commit/archive handling.
- Worker or model violations.
- `host-unknown` failures.
- Repository startup rules, including repeated VISION reads.
- User and session constraints.

## Decision Rationale

The dominant observed problem was lifecycle fragmentation, especially creating
a fresh Lead for each micro-unit. The change therefore gives one Lead ownership
of a major unit while retaining serial execution and independent review of
production diffs.

The intended operating model follows from that evidence:

- The Lead directly scopes work, maintains recovery and artifact evidence,
  verifies and reconciles results, groups coherent commits, and completes
  archive administration.
- Semantic plan units remain stable while dispatches and recovery are ephemeral
  execution attempts. This distinguishes changed intent from mechanical retry.
- A `review-ready` result plus one unchanged-scope same-Worker correction is
  more efficient than a premature terminal completion. Accepted completion and
  actual handover remain terminal boundaries.
- `host-unknown` is not completion evidence. Reconciliation precedes retry or
  dependent work.
- Workers remain task-denied and never delegate. Actual selected host role is
  reported separately from the configured role preference.
- Commit boundaries are independent of Worker and plan slices. Artifact updates
  are batched at meaningful checkpoints rather than written for every attempt.
- Independent review remains mandatory for high-risk migration, authorization,
  public-contract, and hydration work. Lower dispatch volume must not weaken
  defect detection.

Alternatives considered and rejected:

- Granting Workers task permission: the baseline found no Worker task calls.
- Making Lead production edits the default: this would remove the independent
  production-diff review boundary.
- Removing serial execution: it does not address fragmented ownership and
  introduces separate isolation and recovery problems.
- Weakening independent review: reduced dispatches must not trade away scrutiny
  for high-risk changes.
- Blindly retrying `host-unknown`: the repository may already contain usable or
  conflicting work.
- Preserving one Worker per plan unit: it recreates the unnecessary terminal
  boundary that caused fragmentation.

## Post-Change Hypotheses

The following are directional estimates for comparable work, not promises:

| Measure | Baseline | Directional observation target |
|---|---:|---:|
| Total sessions | 157 | About 70 |
| Lead sessions | 62 | About 18 |
| Worker sessions | 93 | About 50 |
| Input tokens | 10.48M | 45-55% lower |
| Wall time | 14.27 hours | 40-55% lower |

The causal hypothesis is that a continuous Lead avoids repeated startup,
handoff, planning, and commit/archive work while Worker slices remain narrow.
Compare only sessions with recorded scope and material constraints; do not claim
causation from counts alone.

## Per-Session Capture

For each material session, keep a concise aggregate record with:

- Major unit, scope class, repository startup requirements, user constraints,
  and whether the session is comparable to the baseline.
- Total sessions, actual host roles, configured role preferences, reported role
  mismatches, Lead successions, Worker dispatches, input/output/reasoning
  tokens, and wall time.
- Lead continuity for each major unit, with every succession classified as
  context ceiling, external block, or another cause.
- Semantic plan amendments separately from mechanical attempts; record the
  attempt outcome and the checkpoint artifact that preserves recovery evidence.
- Worker outcome counts, including correction rounds, commit-only dispatches,
  task-call attempts, brief-plan mismatches, and `host-unknown` results.
- For every `host-unknown`, whether Git, diff, log, and evidence reconciliation
  happened before retry or dependent work.
- Commit groups, their accepted scope, and whether grouping remained coherent.
- High-risk trigger, independent-review coverage, findings, and defects found
  during review or after acceptance.

Raw session records are useful aggregate evidence. Reports must summarize them
rather than copying huge transcripts, and must never include secrets.

## Success Signals and Warning Thresholds

| Area | Success signal | Warning or revisit threshold |
|---|---|---|
| Lifecycle boundaries | Zero commit-only Workers, Worker task calls, unreported role mismatches, and brief-plan mismatches reaching implementation. | Any occurrence is an immediate process investigation. |
| Lead continuity | One Lead carries each major unit; succession occurs only for context ceiling or an external block. | Any ordinary-scheduling succession is recorded and reviewed; two in one comparable session trigger lifecycle review. |
| Corrections | Same-Worker `review-ready` correction is at most one, unchanged in scope, then a fresh Worker. | Any second correction, changed-scope correction, or unrecorded correction is an immediate investigation. |
| Host recovery | Every `host-unknown` is reconciled before retry or dependent work. | Any unreconciled retry or dependent dispatch is an immediate investigation. |
| Plan and artifacts | Semantic amendments are distinct from attempts; artifacts are batched at meaningful checkpoints while recovery evidence remains available. | Missing recovery evidence, or per-attempt artifact churn without a checkpoint need, triggers process review. |
| Commits | Accepted groups are coherent and are not forced to match Worker or plan slices. | A group spanning unrelated accepted scope, or repeated fragmentation into commit-only Workers, triggers review. |
| Review quality | All high-risk work has independent review; findings and post-acceptance defects remain visible as dispatches fall. | Any uncovered high-risk change or declining defect detection over three comparable sessions triggers review-quality reassessment. |
| Efficiency | Aggregate comparable work trends toward the directional targets. | After three comparable sessions, less than 25% input-token reduction or less than 20% wall-time reduction from baseline triggers a design revisit, not a claim that the targets failed. |
| Lead context | Lead context stays below the 85% succession boundary, or succession is recorded and terminally handed over. | Crossing the boundary without compliant succession is an immediate investigation. |
| Correction bias | Same-Worker correction evidence shows the Lead challenged the result rather than merely confirming it. | A correction-round defect that a fresh independent Worker would likely have exposed, or repeated unchallenged acceptance patterns, triggers a bias review. |
| Host configuration | Actual roles and permissions match reported configuration, or mismatches are explicitly surfaced. | Any unreported preference/actual-role drift or permission drift triggers host-integration review. |

## Revisit or Rollback Triggers

Do not automatically revert the lifecycle on a single metric miss. Propose a
governed revision or rollback when any of the following is established:

- A high-risk migration, authorization, hydration, or public-contract defect
  escaped because required independent review was skipped or ineffective.
- Lead continuity repeatedly exceeds the context budget without compliant
  succession, materially reducing recovery quality.
- Reconciliation failures after `host-unknown` cause lost, duplicated, or
  conflicting repository work.
- Three comparable sessions meet the efficiency warning threshold without an
  offsetting quality or recovery benefit.
- Same-Worker correction rounds show recurring anchoring or confirmation bias
  that fresh review materially improves.
- Host permission or role-reporting drift makes the documented process
  unenforceable or misleading.

Any such decision should use the captured aggregate evidence, identify the
contributing attribution categories above, and preserve historical records
unchanged.
