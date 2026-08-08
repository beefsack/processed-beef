# Plan: Context and Safety Hardening

Ownership and approval:
- Owner: Lead
- Status: Approved 2026-08-08 by user and Orchestrator

## Technical Approach

Replace the `wc -c` byte-counting context rule with countable-proxy return
thresholds across the 11 files that carry it, add a role-assertion
requirement and destructive-action authorization/escalation clauses to the
canonical role skills and references, and correct two watchlist measures in
the 2026-08-07 change's non-normative rationale document. Each content edit
is dispatched to a Worker with exact before/after text, since the precise
wording and locations are already established by Lead investigation before
this plan was written (specifiable, not delegated as open-ended
investigation). `tests/validate.sh` is updated after the content edits so its
new literal-phrase contract matches the final wording. `spec.md` and `plan.md`
are Lead-owned and not delegated.

## Work Units

| ID | Objective | Depends on | File or subsystem scope | Verification |
|---|---|---|---|---|
| unit-01 | Replace the context-limit mechanism (Schedule Serially bullet), add role-assertion and dispatch-tier sentence (Roles section), add destructive-action authorization to the brief-contents sentence (Delegate to Workers section). | - | `skills/processed-beef-orchestrate/SKILL.md` | Direct consistency inspection |
| unit-02 | Replace the Context Limits section with the countable-proxy mechanism; add a destructive-action-authorization bullet to Worker Brief; add a new Destructive Actions subsection. | - | `skills/processed-beef-orchestrate/references/scheduling.md` | Direct consistency inspection |
| unit-03 | Add an irreversible-destruction-outside-version-control escalation paragraph to the Escalation section. | - | `skills/processed-beef-orchestrate/references/governance.md` | Direct consistency inspection |
| unit-04 | Replace the Context Limits section with the countable-proxy mechanism. | - | `skills/processed-beef-orchestrate/assets/agent-process.md` | Direct consistency inspection |
| unit-05 | Add Worker role-assertion sentence to the preamble; add destructive-action authorization to Required Brief Fields; add a destructive-action bullet to Scope; replace the Context Ceiling section with the Worker-specific countable-proxy mechanism. | - | `skills/processed-beef-work-unit/SKILL.md` | Direct consistency inspection |
| unit-06 | Replace the `wc -c` paragraph with the countable-proxy mechanism in all 7 files (README bullet, architecture.md third bullet, and the identical second paragraph in all five integration docs). | - | `README.md`, `docs/architecture.md`, `docs/integrations/{antigravity,claude-code,codex,opencode,vscode}.md` | Direct consistency inspection |
| unit-07 | Replace the obsolete `wc -c`/`one token`/`127500` contract in `check_process_conventions` with a countable-proxy phrase contract; add a new `check_context_and_safety_hardening_contract` guarding the role-assertion and destructive-action phrases; wire it into the run list. | unit-01 through unit-06 | `tests/validate.sh` | `sh tests/validate.sh` |
| unit-08 | Exclude `spec.md`/`plan.md` from the same-material duplication target (both tables); add an Orchestrator cost-per-dispatch supplementary metric and explanatory note; add a `Session Capture: 2026-08-08` section with the measured data, the hit/missed/failed comparison against targets, the comparability caveat, and the PII-rejection note. | - | `docs/changes/2026-08-07-delegation-economics/rationale-and-watchlist.md` | Direct inspection against the approved content |
| unit-09 | Add three RED behavioral scenarios (context ceiling never triggering, nested-Lead role confusion, unauthorised destructive action); add the `CHANGELOG.md` Unreleased entry. | unit-01 through unit-07 | `tests/behavioral.md`, `CHANGELOG.md` | Direct inspection against the existing file's format; `sh tests/validate.sh` |
| unit-10 | Independent review of the complete diff (unit-01 through unit-09) for internal consistency, no contradicting clauses, and confirmation that no escalation, delegation, `decision-needed`, corpus-ownership, or specifiability clause was weakened. | unit-01 through unit-09 | complete diff and evidence | Concrete findings only; `sh tests/validate.sh` |
| unit-11 | Fix a contradiction found by unit-10: several untouched sentences still asserted a role can observe "85% of the effective limit" about itself, contradicting the new countable-proxy mechanism's premise. Replace all live-instruction occurrences with "return threshold" language; also correct a British/American spelling inconsistency ("authorises"/"unauthorised" to "authorizes"/"unauthorized") introduced by unit-01, unit-02, unit-05, unit-09 to match the repo's established American-spelling convention. | unit-10 | `docs/architecture.md`, 5 `docs/integrations/*.md`, `skills/processed-beef-orchestrate/SKILL.md`, `skills/processed-beef-orchestrate/assets/state.md`, `skills/processed-beef-orchestrate/references/scheduling.md`, `skills/processed-beef-work-unit/SKILL.md`, `tests/behavioral.md` | Direct consistency inspection; `sh tests/validate.sh` |

Semantic IDs remain stable. Execution slices use `unit-<n>/attempt-<n>` and do
not amend this plan unless semantic scope, acceptance, dependencies, or
governance changes.

## Progress

- [x] unit-01 Orchestrate SKILL.md
- [x] unit-02 Scheduling reference
- [x] unit-03 Governance reference
- [x] unit-04 Agent-process asset
- [x] unit-05 Work-unit SKILL.md
- [x] unit-06 Top-level docs and integration guides
- [x] unit-07 Validation contract
- [x] unit-08 Delegation-economics rationale and watchlist corrections
- [x] unit-09 Behavioral scenarios and changelog
- [x] unit-10 Independent review (found the 85%-language contradiction; fixed as unit-11)
- [x] unit-11 85%-language and spelling correction

## Pending User Decisions

- None.

## Acceptance-Criterion Evidence

| Acceptance criterion | Evidence |
|---|---|
| `wc -c` removed, countable-proxy mechanism added, provisional, host telemetry preferred | unit-01 through unit-06 |
| Provisional thresholds stated (Worker 30, Lead 3 units/50, Orchestrator 20) | unit-01 through unit-06 |
| Threshold return framed as normal, not an emergency | unit-01 through unit-06 |
| Role-assertion and dispatch-tier requirement | unit-01, unit-05 |
| Destructive-action authorization and escalation | unit-01, unit-02, unit-03, unit-05 |
| Watchlist duplication-target and cost-share corrections, session capture, PII note | unit-08 |
| Three RED behavioral scenarios, changelog entry | unit-09 |
| Validation contract extension, obsolete assertions removed | unit-07 |
| Internal consistency, no weakened clause | unit-10 (found one contradiction, fixed by unit-11); re-confirmed after unit-11 |
| Complete `sh tests/validate.sh` pass | Passes after unit-07, and again after every subsequent unit through unit-11 |

## Residual Risks

- The provisional thresholds (30/50/20) are derived from one session's
  measurements and are explicitly unverified until observed across 2-3 more
  comparable sessions; this is stated in the wording itself, not hidden.
- Countable-proxy thresholds are coarser than byte counting: a role could in
  principle make very few, very expensive tool calls (e.g. one huge read) and
  stay under its tool-call threshold while still accumulating large context.
  This is accepted as an explicit tradeoff for a mechanism agents can actually
  observe about themselves, per the spec's Intent.
- Editing `governance.md`'s Escalation section and `scheduling.md`'s brief
  contents touches clauses the dispatching brief's hard constraints flagged
  for extra caution. Both edits are purely additive (a new escalation trigger,
  a new required brief field) and were explicitly pre-approved in the
  dispatching brief; this is called out explicitly rather than silently
  decided, per that same brief's request to report anything needing the
  Orchestrator's ruling.
- unit-10's independent review found that units 1-6 replaced the `wc -c`
  mechanism in its own paragraphs but left several other, untouched sentences
  in the same files (`docs/architecture.md`, all five integration docs,
  `SKILL.md`, `assets/state.md`) still asserting the old "85% of the
  effective limit" self-observable trigger, contradicting the new mechanism.
  unit-11 corrected this; `grep -rn '85%' . --include=*.md` after unit-11
  confirms the only remaining matches are the archived
  `2026-08-05-lead-lifecycle` record and `tests/behavioral.md` Scenario 3
  (both accurate historical records, correctly left untouched).
- The net byte delta across `skills/` is +2842 bytes (SKILL.md +682,
  agent-process.md +88, state.md -4, governance.md +349, scheduling.md
  +1194, work-unit SKILL.md +533), not net-neutral or smaller as the spec
  aspired to. The increase is substantive new content (the role-assertion
  clause and the two destructive-action clauses are net-new obligations, not
  a rewording of existing text) rather than restructuring; no section was
  duplicated or padded. Reported per the dispatching brief's request for the
  byte delta.

## Rationale and Follow-Up Observation

See `docs/changes/2026-08-07-delegation-economics/rationale-and-watchlist.md`
for the measured baseline this change responds to, this session's capture,
and the corrected watchlist targets.

## Final Outcome

- Accepted. All eleven work units complete; `sh tests/validate.sh` passes.
  Independent review (unit-10) found one substantive contradiction (stale
  "85% of the effective limit" self-observation language left in several
  untouched sentences) and one cosmetic spelling inconsistency, both fixed by
  unit-11 and re-verified. No escalation, delegation, `decision-needed`,
  corpus-ownership, or specifiability clause was weakened; the `scheduling.md`
  and `governance.md` edits are strictly additive. Net byte delta across
  `skills/` is +2842 bytes, driven by substantive new content (role assertion,
  destructive-action authorization and escalation), not restructuring.
