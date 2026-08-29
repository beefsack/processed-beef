# Process Learnings

This is the durable evidence record for changes to Processed Beef. Runtime
skills contain only current policy; this file preserves why policy changed.

For every behavioral process change, add or amend one entry with:

- **Observed problem** - the specific bad outcome, separated from hypotheses.
- **Contributing mechanism** - the part of Processed Beef believed to have
  contributed, without excluding agent, model, host, or product causes.
- **Change and rationale** - the smallest change made and why it should help.
- **Status** - observed result, unresolved hypothesis, or a link to the newer
  learning that supersedes it.

Keep stable learning IDs. Do not delete a superseded learning or rewrite a
hypothesis as a fact.

## L001 - Establish A Verifiable Delegation Baseline

- **Evidence:** `5ae8c66`; `tests/behavioral.md` Scenarios 1-3.
- **Observed problem:** Without explicit role guidance, agents skipped setup,
  guessed ambiguous brief semantics, proposed parallel work, and claimed
  completion without verification.
- **Contributing mechanism:** No shared delegation, authority, or evidence
  contract existed. Exact attribution is limited because these observations
  predate a mature process record.
- **Change and rationale:** Introduce Orchestrator, Lead, and Worker roles,
  bounded briefs, decision escalation, and evidence-backed completion. Narrow
  execution plus senior inspection was expected to improve quality without
  requiring the expensive parent to perform the work.
- **Status:** Current foundation. Later learnings simplify its mechanics.

## L002 - Make Completed Reports Terminal

- **Evidence:** `9e9396e`;
  `docs/changes/archive/2026-08-02-terminal-handover-boundaries/`.
- **Observed problem:** The archive records a design concern, not a measured
  incident: completed reports could be treated as resumable pauses, blurring
  context and ownership boundaries.
- **Contributing mechanism:** Completion and pause reports shared lifecycle
  semantics.
- **Change and rationale:** Make completed handovers terminal and use a fresh
  agent for later work so ownership is unambiguous.
- **Status:** Superseded in part by L004 and L009. The durable requirement is a
  clear ownership transfer, not a large status machine or mandatory fresh agent
  after every correction.

## L003 - Keep Child Briefs Host-Neutral

- **Evidence:** `fd4df76`; commit subject and diff.
- **Observed problem:** Recorded as a design risk rather than a measured
  incident: forwarding a parent's model-specific tool restrictions can make a
  child unusable when roles expose different tools.
- **Contributing mechanism:** Briefs mixed objective constraints with assumptions
  about the parent's host and tool set.
- **Change and rationale:** State only constraints intrinsic to the objective;
  let each child follow its own active tool instructions.
- **Status:** Current. No independent effectiveness measurement exists.

## L004 - Give One Lead Coherent Change Ownership

- **Evidence:** `2e0ff30`, `26b3b3a`;
  `docs/changes/archive/2026-08-05-lead-lifecycle/rationale-and-watchlist.md`.
- **Observed problem:** A micro-unit workflow produced 157 sessions, 62 Leads,
  93 Workers, 86 repeated vision reads, four reportless sessions, and about
  4.93 hours of coordination for commit and archive work.
- **Contributing mechanism:** A fresh Lead per small unit repeatedly paid
  startup, planning, handoff, and archive costs.
- **Change and rationale:** One Lead owns a coherent change through bounded
  Worker units, review, and completion. This amortizes domain loading while
  retaining cheap execution and senior inspection.
- **Status:** Current. It supersedes L002's completion/correction lifecycle but
  retains explicit handover when ownership genuinely transfers.

## L005 - Delegate Before Loading Expensive Corpora

- **Evidence:** `ca2262a`, `56aa581`, `45fc19b`;
  `docs/changes/archive/2026-08-07-delegation-economics/`;
  `tests/behavioral.md` Scenarios 4-9.
- **Observed problem:** Leads spent 127 calls on mechanical staging, wrote a
  261-line production fix without independent review, loaded the same corpus as
  Workers, repeated four large log extractions, and directly paged at least
  158,473 bytes instead of delegating.
- **Contributing mechanism:** Delegation guidance favored direct Lead reading
  and decided too late, after the expensive role had already paid the corpus
  cost. Agent choice, host behavior, and model assignment also contributed.
- **Change and rationale:** Decide delegation before loading large or unknown
  material, give one role corpus ownership, delegate output-heavy extraction,
  and inspect returned diffs rather than rereading production corpora.
- **Status:** Current principle. The first version was falsified by another
  direct-read session and immediately strengthened in `45fc19b`. Exact
  specifiability and forfeit machinery is superseded by L013's simpler cost rule.

## L006 - Replace Unobservable Context Accounting

- **Evidence:** `1e80ccd`, `b5f9b31`;
  `docs/changes/archive/2026-08-08-context-and-safety-hardening/`;
  `tests/behavioral.md` Scenario 10.
- **Observed problem:** Under a `wc -c` rule, four sessions exceeded the
  configured 150k context target, one reached 306,523 tokens, and no handover
  occurred.
- **Contributing mechanism:** File-byte counting overcounted some reads while
  ignoring conversation, tool output, reports, and skill text where context
  actually accumulated.
- **Change and rationale:** Prefer host telemetry and otherwise use observable
  workload proxies and bounded assignments. A threshold should schedule a
  handover, not invalidate useful returned work.
- **Status:** Fixed call-count proxies remained unvalidated and are superseded
  by L013. Current policy sizes each assignment to fit and transfers when the
  next coherent objective no longer fits; the Orchestrator is deliberately
  long-lived and protected by delegation.

## L007 - Make Role Boundaries And Destructive Authority Explicit

- **Evidence:** `b5f9b31`; `tests/behavioral.md` Scenarios 11-12.
- **Observed problem:** A Lead misidentified itself as Orchestrator, spawned a
  nested Lead beyond supported depth, and misdiagnosed the failure. Separately,
  a read-only Worker deleted an unauthorized 31 MB production dump and reported
  it missing.
- **Contributing mechanism:** One skill described two roles, role identity was
  inferred from document order, and briefs did not require explicit destructive
  authority.
- **Change and rationale:** Give each installed skill exactly one role, allow
  dispatch only to the next tier, require destructive scope in briefs, and
  escalate irreversible non-versioned or live-state destruction.
- **Status:** Current. L013 removes selector/persona packet ceremony while
  preserving role topology and destructive safeguards.

## L008 - Count Progress Across Agent Succession

- **Evidence:** `ed7e09a`;
  `docs/changes/archive/2026-08-17-circuit-breakers/`;
  `tests/behavioral.md` Scenarios 13-15.
- **Observed problem:** One objective cycled through fresh agents and relabeled
  units while assertions grew from roughly 105 to 578 without acceptance.
  Useful over-threshold work was redispatched, and known defects were committed
  before acceptance.
- **Contributing mechanism:** Attempt and correction limits lived in an agent's
  local context, so succession reset them. More verification was mistaken for
  progress, and threshold compliance displaced technical inspection.
- **Change and rationale:** Bind retry history to the objective, require actual
  acceptance before commit, reconcile useful returned work once, and stop when
  repeated attempts do not move evidence or acceptance.
- **Status:** Current principle. L010 and L013 simplify the detailed counters to
  an outcome rule: do not repeat a semantic approach without new evidence or a
  changed hypothesis; escalate after two failed approaches to the same blocker.

## L009 - Remove Policy Duplication And Wording Tests

- **Evidence:** `ed7e09a`, `01cae7c`;
  `docs/changes/archive/2026-08-17-overhead-reduction/`;
  `tests/behavioral.md` Scenario 16.
- **Observed problem:** Every plan edit required expensive approval, one
  threshold paragraph appeared in nine files, `150000` appeared 31 times, 58
  phrase assertions locked prose, every Worker reread principles, and one status
  carried conflicting meanings.
- **Contributing mechanism:** Normative policy was duplicated across runtime
  files and literal tests defended wording rather than behavior.
- **Change and rationale:** Single-source live rules, pass only applicable
  constraints to Workers, narrow approvals, and keep structural lint separate
  from behavioral evidence.
- **Status:** The 2026 reduction cut loaded skill bytes by 20 percent but did not
  arrest later growth. Superseded and completed by L013's role-local skills,
  removal of runtime references/templates, and structural-only validation.

## L010 - Distinguish Process Errors From Product Attempts

- **Evidence:** `02dfc89`;
  `docs/changes/archive/2026-08-24-process-hardening/`;
  `tests/behavioral.md` Scenarios 17-25 and 27-29.
- **Observed problem:** Malformed dispatches counted as implementation attempts,
  selector labels were confused with roles, wrong gates and stale evidence
  caused cycles, correction budgets were spent on local harness defects, and
  untracked candidates were omitted from preservation and review.
- **Contributing mechanism:** Process validity, semantic progress, evidence
  freshness, and repository state were coupled in one retry ledger. Some stops
  were still correct: an unaccepted diff with serious open findings should not
  ship.
- **Change and rationale:** Separate pre-effect mechanical recovery from semantic
  attempts, verify the intended acceptance condition on current source, inspect
  tracked and untracked state, and preserve rejected material work.
- **Status:** Current principles. L013 removes packet and ledger fields while
  retaining the behavioral distinctions.

## L011 - Permit One Causal Verification Repair

- **Evidence:** `b7e0875`; `tests/behavioral.md` Scenario 26.
- **Observed problem:** A correction omitted a test import and broke a formerly
  passing gate, but the process treated restoring that local test defect as a
  new semantic retry or an exhausted correction budget.
- **Contributing mechanism:** Severity-blind correction accounting had no path
  for a regression caused by the immediately preceding correction.
- **Change and rationale:** Permit one narrowly causal test, fixture, harness, or
  evidence repair when it restores prior verification without changing product
  behavior, acceptance, ownership, routing, or the oracle.
- **Status:** Current in compressed form. The large eligibility checklist is
  superseded by L013; provenance, one-repair limit, and no semantic widening
  remain.

## L012 - Recover Mechanical Failures Without Blocking

- **Evidence:** `bcc1553`; `tests/behavioral.md` Scenarios 30-32.
- **Observed problem:** Live runners failed before target effects but consumed
  semantic budgets; incidental pass-count and stale summary drift blocked valid
  work; valid role packets were rejected over selector/persona labels.
- **Contributing mechanism:** Attempt boundaries began before product effect,
  incidental record details were treated as acceptance semantics, and host
  metadata was over-governed.
- **Change and rationale:** Start semantic accounting only at source or target
  effect, reconcile commands/environment/records locally, use invariant pass
  conditions, and block only on actual role or capability mismatch.
- **Status:** Current. L013 generalizes this into an action bias and removes the
  packet state machine.

## L013 - Cumulative Safeguards Became The Main Work

- **Evidence:** 2026-08-29 repository measurement; commit range
  `5ae8c66..bcc1553`; `tests/behavioral.md` Scenario 33.
- **Observed problem:** A normal Standard run could load 60,569 bytes of parent
  and Lead policy before project context, plus 10,554 bytes per Worker. Runtime
  policy had grown to 1,047 lines for the parent/Lead path, nine templates, four
  references, mandatory approval and artifact flows, and a multi-ledger status
  machine. Process work risked exceeding product work and creating false stops.
- **Contributing mechanism:** Each incident added a universal mechanism. The
  incident was preserved in tests, change archives, live policy, templates, and
  public summaries, so protections accumulated faster than they were retired.
- **Change and rationale:** Encode the vision in `VISION.md`, preserve incident
  history here, reduce runtime to three role-local skills, make one change note
  conditional, replace detailed counters with outcome-based escalation, and
  remove automatic approval gates. This keeps the reasons while charging only
  the smallest current control to every session.
- **Status:** Implemented 2026-08-29. Payload and structural validation are
  measured by `tests/validate.sh`; behavioral effectiveness requires continued
  observation and future entries must record any regression.
