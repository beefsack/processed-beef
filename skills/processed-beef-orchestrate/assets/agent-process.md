# Agent Process

Effective role configuration resolves in order: explicit user instruction, this
file, host agent definitions at project and user scope, inherited defaults.
Which host scope wins is decided by the host adapter, so precedence is
host-resolved and must be verified against the installed host. Agents report the
resolved Orchestrator, Lead, and Worker agent names, model preferences, and
context limits, and report any host mismatch rather than claiming the values
were applied. Each role reports its actual selected role against its configured
role; a mismatch is reported, never concealed.

## Roles

| Role | Agent | Model | Context limit |
|---|---|---|---|
| Orchestrator | `<agent>` | `<model>` | 150000 |
| Lead | `<agent>` | `<model>` | 150000 |
| Worker | `<agent>` | `<model>` | 150000 |

## Startup Context

The Orchestrator and Lead read `docs/principles.md` when present. The
Orchestrator also reads `docs/backlog.md` and `docs/decisions.md` when present
to maintain current priorities, active governance, and cross-change
dependencies. A Worker reads only its brief's bounded inputs: the brief states
the applicable principles clauses. Leads and Workers read `docs/backlog.md`,
and a Worker reads `docs/principles.md`, only when assigned work involves
prioritization, ordering work, cross-change coordination, or a governance
question the brief did not resolve.

## Concurrency

Concurrency is fixed at 1: exactly one subagent is active at a time across the
whole hierarchy, in every mode, including autonomous mode. It is never
increased to parallelize independent work.

## Context Limits

The `150000` in the table above is a host configuration value, not a quantity
any role can observe about itself. The return thresholds that govern behavior
are stated once in `references/scheduling.md` under Context Limits; do not
restate them here.

Record only this project's overrides:

- Project return thresholds, if they differ from the skill defaults: `<none>`
- Earlier handover warning for this project, if any: `<none>`
- Host token telemetry available: `<yes | no>`
