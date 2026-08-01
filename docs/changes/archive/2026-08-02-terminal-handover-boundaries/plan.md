# Plan: Terminal Handover Boundaries

Ownership and approval:
- Owner: Lead
- Status: Result approved 2026-08-02 by user and Orchestrator

## Technical Approach

Encode terminal-report and chat-handover policy first in the Worker and
Orchestrator process sources and templates. Then align public documentation and
integration guidance, adding only reliable static validation that guards the
policy. Inspect each Worker result directly and run the required repository
validation before requesting completion approval.

## Work Units

| ID | Objective | Depends on | File or subsystem scope | Verification |
|---|---|---|---|---|
| unit-02 | Encode terminal report, resumption, and handover policy in process skills and templates. | - | `skills/processed-beef-work-unit/SKILL.md`, `skills/processed-beef-orchestrate/SKILL.md`, `skills/processed-beef-orchestrate/references/scheduling.md`, `skills/processed-beef-orchestrate/references/artifacts.md`, `skills/processed-beef-orchestrate/assets/agent-process.md`, `skills/processed-beef-orchestrate/assets/handover.md` | Direct file inspection and targeted consistency review. |
| unit-03 | Align public documentation and integration guidance; add reliable static invariants only if proportionate. | unit-02 | `README.md`, `docs/architecture.md`, integration guides with handover instructions, and optionally `tests/validate.sh` | `git diff --check`; `sh tests/validate.sh`; direct file inspection. |

Only the Lead mutates plans and state.

## Progress

- [x] unit-02 Encode terminal, pause-report, resumption, and handover policy in skills and templates, including fresh corrections for the terminal-versus-pause distinction.
- [x] unit-03 Align README, architecture, and five integration guides; no brittle static validation added.

## Pending User Decisions

- None.

## Acceptance-Criterion Evidence

| Acceptance criterion | Evidence |
|---|---|
| Rules are explicit and consistent. | Direct inspection of Worker and Orchestrator skills, scheduling and artifact references, templates, README, architecture, and all five integration guides. |
| Every handover is terminal and resumption is narrowly limited. | `complete` and actual handovers are terminal; ordinary `blocked` and `decision-needed` returns are pause reports; only the same unfinished Worker unit resumes after the specified answer or resolution within budget. A context-ceiling `blocked` return is explicitly a terminal chat handover. |
| `handover.md` is limited to parentless boundaries and role handovers use chat. | Skills, artifact reference, handover template, README, architecture, and integrations restrict `handover.md` to top-level or no-live-parent boundaries; live-parent reports and handovers use curated chat. |
| Reports are curated without persisted exhaustive reports. | Worker and Orchestrator guidance, README, and architecture require curated comprehensive chat reports and reject persisted exhaustive reports or transcripts. |
| Governance, serial delegation, context limits, and completion remain unchanged. | Direct diff inspection confirms approval gates, exact-one-subagent delegation, `150000` limit, and completion transaction behavior are retained. |
| Validation and diff checks pass, except confirmed pre-existing environment failures. | `git diff --check` passes. Working-tree `sh tests/validate.sh` fails only on ignored `.opencode/node_modules` non-ASCII READMEs; clean detached `HEAD` and the full changed tree without that ignored environment content pass. |

## Residual Risks

- The working-tree validator remains blocked by ignored `.opencode/node_modules`
  READMEs. `.opencode/.gitignore` confirms this is pre-existing and outside the
  change.
- Policy remains prose-driven. No static `tests/validate.sh` invariant was added
  because Markdown phrase matching would be brittle.

## Final Outcome

- Implementation and evidence were accepted by the user on 2026-08-02. The
  completion transaction, archival, commit, and push were authorized.
