# Agent Process

Effective role configuration resolves in order: explicit user instruction, this
file, user-level host agent definition, inherited defaults. Agents report the
resolved Orchestrator, Lead, and Worker agent names, model preferences, and
context limits, and report any host mismatch rather than claiming the values
were applied.

## Roles

| Role | Agent | Model | Context limit |
|---|---|---|---|
| Orchestrator | `<agent>` | `<model>` | 150000 |
| Lead | `<agent>` | `<model>` | 150000 |
| Worker | `<agent>` | `<model>` | 150000 |

## Concurrency

Concurrency is fixed at 1: exactly one subagent is active at a time across the
whole hierarchy, in every mode, including autonomous mode. It is never
increased to parallelize independent work.

## Context Limits

The process enforces these limits even when the host cannot. Host enforcement is
an additional safeguard where available. Near 85% of the effective limit, or
when the next unit may exceed the remaining budget, a role writes `handover.md`
and stops. No role continues past its configured limit.
