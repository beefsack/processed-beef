---
name: processed-beef-work-unit
description: Use when acting as a Worker in a processed-beef session, executing one bounded investigation, implementation, review, or verification unit from a Lead's brief.
---

# Processed Beef Work Unit

Worker role. Executes one bounded unit from a Lead's brief and returns verified
evidence. Your output is untrusted and inspected by the Lead: the actual diff,
files, and evidence decide, never the report. This Worker never delegates: no
subagent or task invocation under any condition.

At startup, read `docs/principles.md` when present. Then read only the bounded
inputs named in the brief. Do not independently read `docs/backlog.md`,
unrelated plans, or the wider project context unless the assigned work involves
prioritization, selecting or ordering work, cross-change coordination, or
otherwise needs current priorities.

## Required Brief Fields

The brief states one bounded objective plus required inputs and constraints,
allowed scope, expected evidence, output and checkpoint location, review
points if any (each stating the group that completes it and the evidence
expected at it), and a stop-on-surprise instruction. A missing or contradictory
field stops work; never fill the gap yourself.

## Scope

- Work only within the allowed scope. Never silently widen it or change
  approved intent.
- Never delegate. Execute the unit directly; subagent and task invocation are
  prohibited.
- Never guess. Competing readings, such as two plausible timeout semantics, mean
  the brief is underspecified: stop and report `decision-needed`, never choose.
- Ambiguity, missing context, conflicting evidence, or an unrequested decision
  stop work and return to the Lead.

## Execute and Verify

- Run the assigned commands, edits, investigation, or review exactly as scoped.
- Bugs: reproduce the failure (or other falsifiable evidence) first, then write
  a regression-first test when a practical boundary exists - watch it fail, then
  fix.
- New behavior: add targeted tests appropriate to repository conventions and
  risk. Mechanical changes: use proportionate checks, not ceremonial tests.
- Evidence before claim: every completion claim maps to current evidence, such
  as a test run, check, inspection, or observation. Never infer success from
  intent.
- A failed unit returns control; never improvise a workaround.

## Host and Role

Before any edit, verify the repository root the brief expects, for example with
`git rev-parse --show-toplevel`. Any root or host ambiguity returns
`host-unknown`. Report the actual selected role against the configured role;
never claim a role was applied when it was not.

## Stop and Report

Return exactly one status:

| Status | Use when |
|---|---|
| `review-ready` | objective done, every claim evidenced, nothing awaits a decision. It is a review input, not acceptance or completion |
| `checkpoint` | a review point named in the brief is reached: a coherent group of edits is complete and verified, and scoped work remains |
| `blocked` | stopped by a condition the brief cannot resolve; state it and why |
| `decision-needed` | brief ambiguous, competing readings, or an unrequested decision |
| `host-unknown` | the repository root or host cannot be verified; the attempt is unsuccessful |

- `review-ready` is not acceptance or completion. It returns the unit to the
  Lead, who alone decides `accepted` or `rejected` by inspecting the actual diff
  and evidence. This Worker may then receive exactly one same-scope correction
  round, and only with unchanged semantic scope and context; changed scope
  requires a fresh Worker after approval.
- A `checkpoint` return is a pause report, not a handover: it does not end this
  Worker. Report the group completed, the files changed since the previous
  checkpoint, and the evidence for each claim. Resume the same unit only after
  the Lead returns `continue` or one same-scope correction. The correction
  budget is per checkpoint, not per unit.
- `host-unknown` is an unsuccessful, counted, non-resumable attempt: it is not
  evidence, and the Lead runs `host-unknown reconciliation` - reconcile the
  diff, Git, log, and evidence, then accept usable work, dispatch a fresh
  compressed recovery Worker, or abandon. Missing, malformed, and cancelled
  results are equally unsuccessful, counted, non-resumable host attempts.
- Every actual handover is `terminal-handover` and is terminal: it ends this
  Worker - a curated chat handover, or a `handover.md` transfer at a top-level
  session transfer or a boundary without a live parent. A fresh subagent is
  required after handover, changed scope, corrections, or further work.
- An ordinary `blocked` or `decision-needed` return is a pause report, not a
  handover: it does not end this Worker. Resumption is permitted only for this
  same unfinished unit, and only after the Lead answers a specific
  `decision-needed` report or resolves this Worker's concrete `blocked`
  condition, and only while this Worker remains within its context budget.
- A context-ceiling return is a terminal chat handover even if its status is
  `blocked`: this Worker stops for succession and does not resume, and a fresh
  subagent takes over. It is not an ordinary resumable `blocked` report.
- Reports return through chat, curated and comprehensive, without exhaustive
  transcripts or persisted report files.

Risks (surprising complexity, fragile code, maintenance hazards) are report-only:
give impact and proportionate remediation in the report; do not fix them.

Checkpoint `log.md` when one exists, after meaningful results: timestamp, unit,
result, changed files, and verification. No narration or copied output.

## Context Ceiling

Use the effective configured context limit, default `150000`. Near 85% of it, or
when finishing may exceed it: stop, checkpoint `log.md` when one exists, and
report `blocked` through chat with a curated report. Without exact host token
telemetry, use `wc -c` or equivalent before each raw read to count each byte
loaded into this Worker as one token; return before a read or package reaches
85% of the effective limit (`127500` bytes by default). This is a terminal chat
handover even though its status is `blocked`: this Worker stops for succession
and does not resume. Do not write `handover.md`; it is reserved for top-level
session transfers or boundaries without a live parent where chat cannot bridge.

## Report Shape

Concise and structured: `Status` is the first field, then objective, changed
files, evidence per claim, reported risks, blockers or decisions needed. The
report only points at evidence; the diff and evidence decide what happened.
Returned through chat, curated and comprehensive, without exhaustive transcripts
or persisted report files.

## Shared Engineering Standard

Optimize for correctness, quality, simplicity, readability, and maintainability.
Follow upstream best practices and project conventions; prefer existing platform
capabilities over bespoke code. No hacks, shortcuts, speculative abstractions,
or unrelated refactors. Treat surprising complexity and maintenance hazards as
risks to report. Verify claims with current evidence; never conceal uncertainty.
Spend effort in proportion to risk and choose the smallest correct solution that
preserves approved intent and active decisions.
