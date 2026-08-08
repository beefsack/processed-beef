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

Every role reads `docs/principles.md` when present. The Orchestrator also reads
`docs/backlog.md` and `docs/decisions.md` when present to maintain current
priorities, active governance, and cross-change dependencies. Leads and Workers
read `docs/backlog.md` only when assigned work involves prioritization,
selecting or ordering work, cross-change coordination, or otherwise needs
current priorities. Workers read only their brief's bounded inputs beyond the
universal files.

## Concurrency

Concurrency is fixed at 1: exactly one subagent is active at a time across the
whole hierarchy, in every mode, including autonomous mode. It is never
increased to parallelize independent work.

## Context Limits

`150000` is a documented budget, not a quantity any role can measure about
itself. Prefer exact host token telemetry wherever a host exposes it; host
enforcement is an additional safeguard where available. Otherwise, return on a
countable proxy from the role's own history: completed work units, dispatches
made, and its own tool calls. These are provisional thresholds, due for
revalidation over the next 2-3 sessions: a Worker returns after about 30 of its
own tool calls; a Lead returns after 3 completed work units or about 50 of its
own tool calls, whichever comes first; the Orchestrator hands over after about
20 dispatches.

Reaching a threshold is the normal end of a bounded stint, not an emergency: a
role with a live parent returns a terminal curated report through chat; the
chat return is a terminal handover even when reported as `blocked`, and the
outgoing role does not resume. A top-level session or a boundary without a
live parent writes a terminal `handover.md`. No role continues past its
threshold. Reassess after cancellations, retries, and failed units, and use a
compressed replacement brief.
