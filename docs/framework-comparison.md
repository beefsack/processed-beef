# Agent Process Framework Comparison

Retained research evidence for the Processed Beef design. The content below is
the reviewed framework comparison produced during the lean-agent-process
change and is preserved here so design traceability survives outside the change
archive.

## Scope And Method

This comparison is based on source inspection of shallow clones captured on
2026-08-01, supplemented by the Plannotator same-case artifact corpus. Marketing
claims were not treated as implementation facts when source was available.

The frameworks below were studied as research evidence only. They are not
dependencies of this repository, are not required to run the Processed Beef
skills, and are not bundled or distributed with it. The Design Traceability
section records the retained choices and their precedents.

| Project | Repository | Inspected commit |
|---|---|---|
| Superpowers | `obra/superpowers` | `44c9b2d6e889982ac18c27d05a19fefe335194e1` |
| GSD Pi, successor to GSD 2 | `open-gsd/gsd-pi` | `331cee83a1142683d722481ab8ac44c4ae049d13` |
| GSD Core | `open-gsd/gsd-core` | `0bb7525a625e6bc047452646b86e18cb0662e859` |
| OpenSpec | `Fission-AI/OpenSpec` | `45cca5db6137ed209117cc70510eb3e057fb981b` |
| oh-my-claudecode | `Yeachan-Heo/oh-my-claudecode` | `41a4c0f77144c5beb5f5f000a89cff379c680606` |
| GitHub Spec Kit | `github/spec-kit` | `d1e86f638277a99b82715c22c90558cd58d3cffd` |
| BMAD Method | `bmad-code-org/BMAD-METHOD` | `6c36990123ee46012e5adb877d84adef80d8655b` |
| gstack | `garrytan/gstack` | `a3259400a366593e0c909dd9ac3e59752efd2488` |
| Blueprint OS | `gj1342/blueprint-os` | `c83ff17c868f730a6c1da2d24bba15a46ca1f0f0` |
| Plannotator comparison corpus | `plannotator/spec-planning-frameworks` | `7bfffe891436c02e0b9ecccc65ceb0b64c2a0701` |

The Plannotator corpus also provides source-faithful examples for Matt Pocock's
skills and Kiro Specs. The Kiro output is explicitly manual because vendor
authentication prevented a tool run.

Evaluation dimensions were:

- process and phase gates;
- durable and transient documentation;
- artifact duplication and downstream consumers;
- context management and crash recovery;
- model and subagent topology;
- testing, review, and verification;
- task-size adaptation;
- runtime and tool coupling;
- measured artifact volume where comparable;
- mechanisms worth retaining in a lean skill-only process.

## Executive Comparison

| Framework | Primary optimization | Process shape | Main documentation | Main cost |
|---|---|---|---|---|
| Superpowers | Agent discipline | Auto-triggered skill chain with hard prose gates | Design, plan, task briefs/reports, review diffs, progress ledger | Mandatory design/planning/TDD/review passes |
| GSD Pi | Autonomous runtime control | Coded phase state machine with fresh sessions | Database plus projected roadmap, plans, context, summaries, validation, journals | Large runtime and state surface |
| GSD Core | Portable long-project delivery | Discuss, Plan, Execute, Verify, Ship | Project, requirements, roadmap, state, phase context, plans, summaries, verification, archives | Repeated checks and broad artifact ledger |
| OpenSpec | Brownfield change control | Propose, Apply, Archive over an artifact DAG | Proposal, delta specs, optional design, tasks, canonical specs | Four-artifact convention and CLI/schema coupling |
| OMC | Multi-agent execution | Code-enforced team plan/PRD/execute/verify/fix pipeline | Machine state, PRDs, handoffs, plans, replay and memory | Hooks, compiled runtime, modes, and potentially expensive loops |
| Spec Kit | Formal spec-driven governance | Constitution, Specify, Clarify, Plan, Tasks, Analyze, Implement | Constitution, spec, plan, research, model, contracts, quickstart, tasks, checklists | Highest document volume and repetition |
| BMAD | Scale-adaptive lifecycle | Quick or full role-driven paths | Context, PRD/spec, architecture, stories, memlog, compiled context | Large skill/script/persona surface |
| gstack | Specialist consultation and release discipline | Think, Plan, Build, Review, Test, Ship, Reflect | Plans, specs, test plans, decisions, checkpoints, reviews, learnings | Large skill payloads and sequential model passes |
| Blueprint OS | Portable project context | Manually selected brainstorm/spec/deploy/gate skills | Standards, references, designs, shaped specs, optional gate reports | Manual routing and brainstorm/spec overlap |
| Matt Pocock skills | Tracker-oriented execution | Spec then dependency-aware tickets | One spec and thin tickets | External tracker dependency and limited lifecycle verification |
| Kiro Specs | Requirements traceability | Requirements, Design, Tasks | Three linked documents with EARS-style criteria | Vendor coupling and fixed document chain |

## Same-Brief Artifact Volume

The Plannotator corpus applied each framework to the same reliable webhook
delivery brief.

| Framework | Files | Lines | Bytes | Result |
|---|---|---:|---:|---:|---|
| BMAD Express | 2 | 125 | 13,879 | Express spec completed |
| Kiro manual | 4 | 229 | 11,080 | Source-faithful manual example |
| Matt Pocock | 12 | 343 | 40,608 | Spec and 11 tickets completed |
| Superpowers | 1 | 487 | 25,694 | Design completed; planning stalled twice |
| GSD | 6 | 540 | 28,778 | Project ledger completed; phase planning stalled |
| Spec Kit | 12 | 1,639 | 112,677 | Full planning flow completed |

Measured duplication included:

- GSD repeated the deliberately unresolved choice list across five artifacts.
- Spec Kit repeated major technical choices across seven artifacts.
- BMAD intentionally represented the same compact contract in an append-only
  memlog and a derived specification.
- Superpowers used one self-contained design in this run, but never reached its
  separate implementation plan.
- Matt Pocock's tickets avoided restating the full specification by referring
  back to it.
- Kiro provided the most compact requirement-to-task traceability.

The corpus does not prove general runtime performance, but it provides direct
evidence of the documentation and review surface produced by one realistic,
controlled brief.

## Superpowers

### Process

The normal chain is `using-superpowers`, brainstorming, worktree setup,
writing-plans, subagent-driven development or executing-plans, review, and
branch completion. Brainstorming blocks implementation until the user approves a
design. Writing-plans performs another decomposition pass. Subagent delivery
uses per-task review and a final whole-branch review.

### Artifacts

| Artifact | Consumer | Lifetime | Value |
|---|---|---|---|
| Dated design | Planner and reviewers | Project | High |
| Dated implementation plan | Executors | Project | High |
| Task brief and report | Worker and reviewer | Task | High during execution |
| Review diff package | Reviewer | Review | High during execution |
| Progress ledger | Resuming controller | Active run | High during execution |
| Separate reviewer prompt templates | Reviewer | Framework | Low when inline review duplicates them |

### Assessment

The strongest ideas are explicit intent approval, disciplined debugging, fresh
task contexts, evidence before completion, and bounded correction. The main cost
is that these controls are universal rather than proportional. Brainstorming and
planning often revisit the same decisions, and routine work receives both task
and final review.

The documents are ordinary Markdown. The coupling comes from the
`docs/superpowers/` namespace, mandatory skill transitions, and conventions that
are not visible from an individual artifact, not from a proprietary file format.

## GSD Pi And GSD Core

### GSD Pi

GSD Pi is the active successor to GSD 2 and is a standalone application rather
than a prompt framework. Its runtime can manage fresh sessions, task graphs,
budgets, model routing, worktrees, recovery, and state transitions directly.
Its database is authoritative; Markdown files are projections for agents and
humans.

High-value portable artifacts include state, roadmap, context, plan, summaries,
acceptance assessment, decisions, knowledge, and a resume handoff. The database,
transition engine, context masker, daemon, dashboard, memory engine, and parallel
orchestrators are runtime machinery rather than reusable skill design.

### GSD Core

GSD Core implements a portable Discuss, Plan, Execute, Verify, Ship loop. It uses
fresh-context agents, wave planning, explicit plan checks, verification gates,
and `.planning/` state that survives sessions.

| Artifact | Value | Main issue |
|---|---|---|
| Project, requirements, roadmap | High for milestones | Too broad for normal incremental work |
| State | High for resume | Unnecessary for short work |
| Phase context | High | Overlaps discussion logs and specifications |
| Plans and summaries | High | Summary layers can repeat completed work |
| Verification record | High | Can duplicate tests, summaries, and user acceptance |
| Discussion log | Low | Mostly process history |
| Handoff | High when transferring | Should remain conditional and transient |
| Learnings and decision index | Medium | Valuable only when kept concise and active |

GSD Core's best transferable ideas are path-only handoffs, fresh contexts,
explicit context budgets, adaptive quick/full routes, and skeptical verification.
Its repeated requirement coverage checks, plan audits, discussion artifacts, and
verification layers are too costly as defaults.

## OpenSpec

OpenSpec organizes work under `openspec/changes/<name>/` and archives to
`openspec/changes/archive/YYYY-MM-DD-<name>/`. Its artifact graph declares
dependencies, and deterministic validation checks requirement and scenario
structure. Archival merges delta requirements into canonical capability specs.

| Artifact | Purpose | Value |
|---|---|---|
| Proposal | Why and impact | Medium when a spec already states intent |
| Delta spec | Behavioral change | High in OpenSpec's living-spec model |
| Optional design | Technical approach | High when complexity requires it |
| Tasks | Execution checklist | High |
| Canonical capability spec | Current behavior | High if actively maintained |
| Dated archive | Audit history | High |

OpenSpec is substantially leaner than Spec Kit and particularly well suited to
brownfield changes. Its strongest ideas are ordinary change directories,
optional artifacts, explicit archival, deterministic validation, and editing in
place rather than rigid phase gates.

This design does not adopt canonical capability specs because maintaining a
second representation of current behavior introduces drift and ongoing cost.
The code, project documentation, principles, active decisions, and archived
change contracts provide sufficient sources of truth for the intended process.

## OMC

OMC's canonical Team pipeline is `team-plan`, `team-prd`, `team-exec`,
`team-verify`, and a bounded `team-fix` loop. Transition guards, task claims,
leases, mode state, and persistence are implemented in TypeScript and hooks.
It provides real task-level concurrency and model routing.

Durable or recovery artifacts include session mode state, PRDs, progress,
plans, handoffs, team task state, notepad memory, project memory, replay logs,
session summaries, research results, and deep-interview specifications.

OMC is strongest as an execution engine. Bounded retries, fresh skeptical
verification, explicit role/model routing, and concise handoffs transfer well.
The hook engine, magic keyword routing, concurrent teams, many modes, and broad
state surface conflict with a portable, serial, skill-only process.

## GitHub Spec Kit

Spec Kit provides the most formal sequence: constitution, specification,
clarification, technical plan, tasks, cross-artifact analysis, implementation,
and convergence. Human review gates can pause between major stages.

| Artifact | Purpose | Value |
|---|---|---|
| Constitution | Project governance | High |
| Functional specification | What and why | High |
| Technical plan | How | High |
| Research | Resolve technical unknowns | Conditional |
| Data model and contracts | Detailed design | Conditional |
| Quickstart | Integration validation | Conditional |
| Tasks | Execution | High |
| Checklists | Spec quality | Medium, often duplicative |

Spec Kit's constitution directly informs the proposed user-owned principles and
decisions. Its separation of user intent from agent planning and its
requirement-to-task traceability are valuable.

Its default artifact chain is the heaviest studied. Quality consistency depends
substantially on additional LLM passes rather than deterministic artifact
validation, and the feature-folder persistence model can repeat decisions across
many files. The lean process therefore keeps the separation but not the full
chain.

## BMAD Method

BMAD has the strongest explicit scale adaptation. A single build entry point can
route low-blast-radius work to a one-shot path and larger work to planning,
implementation, and review. Review findings are classified as patch, defer, or
reject so low-value findings do not derail scope.

BMAD also demonstrates selective context loading: indexes first, just-in-time
references, subagent-produced digests, and compiled feature context. Its compact
spec kernel and companion-file model avoid forcing every detail into one file.

The costs are 50 skills, scripts, configuration resolution, personas, memlogs,
rendered derivatives, compatibility shims, and extensive role handoffs. The lean
process retains blast-radius routing, selective loading, and finding triage while
discarding the runtime and persona simulation.

## gstack

gstack's lifecycle is Think, Plan, Build, Review, Test, Ship, Reflect. Its
specialist skills cover product review, engineering review, design, QA,
security, release, documentation, and retrospectives. It uses cross-model review
and preserves plans, test plans, decisions, checkpoints, reviews, learnings, and
telemetry.

Its best ideas are search-before-build, confidence-calibrated findings,
specialist gates only when useful, browser-backed evidence, and user sovereignty
over cross-model recommendations.

The implementation has many large generated skill documents and can run several
sequential model passes over one plan. State is distributed across numerous
global paths and services. These costs make its complete lifecycle unsuitable,
while selected specialist methods remain valuable.

## Blueprint OS

Blueprint OS is the closest storage precedent for a tool-neutral process. It
uses plain Markdown and separates:

- standards derived from the codebase;
- references supplied as design inputs;
- brainstorm designs;
- shaped implementation specs;
- optional QA, security, and review reports.

It also recommends index-first selective loading and keeping skills under 500
lines with only one level of supporting references.

The main weaknesses are manual routing, a brainstorming-to-spec pass that can
repeat content, and optional gates that can be skipped without a controller.
This design adopts plain Markdown, selective loading, and small skills but folds
design and intent into one specification and puts routing under the Orchestrator.

## Matt Pocock Skills And Kiro Specs

Matt Pocock's same-case output used one durable specification and 11 thin,
dependency-aware tickets. This is an efficient pattern because work units link to
one source rather than restating it. A repository plan can provide the same
benefit without making an external tracker mandatory.

Kiro's source-faithful example used requirements, design, and tasks. Its
EARS-style acceptance language and explicit requirement-to-task links provide
good traceability at low volume. The fixed document chain and vendor workflow
are unnecessary; the traceability pattern belongs in the specification and
plan.

## Documentation Value

### Always High Value

- concise project principles;
- concise active decisions;
- clear user intent and material decision boundaries;
- acceptance criteria linked to current evidence;

### Conditionally High Value

- one-line backlog for multiple changes;
- one concise change note when recovery or multiple units justify it;
- a deliberate handover when context or ownership transfers;
- cited research for consequential decisions;
- migration, rollback, security, or public-contract evidence;
- independent review findings for high-risk or suspicious work.

### Usually Low Value

- separate proposal when the specification already contains why and impact;
- separate design and tasks when one plan remains readable;
- discussion transcripts;
- raw research dumps;
- rendered copies of append-only logs;
- repeated requirement and plan audits by several agents;
- permanent per-task reports after the change is complete;
- checklists that restate acceptance criteria;
- final verification documents that restate test evidence already in the plan.

## Process Lessons

1. Start small and upgrade on discovered blast radius, uncertainty, or risk.
2. Keep intent user-owned and execution planning agent-owned.
3. Preserve project-wide governance outside archived changes.
4. Use one durable source for each kind of truth.
5. Pass paths and narrow context rather than copying whole documents into briefs.
6. Keep execution units independently verifiable and within one Worker context.
7. Treat cheap Worker output as untrusted until a capable Lead inspects it.
8. Bound review and correction loops and escalate when evidence does not converge.
9. Prefer crash-recovery checkpoints over narrative process logs.
10. Use specialist skills as targeted methods, not as overlapping lifecycle
    controllers.
11. Keep serial execution when quota preservation is more valuable than elapsed
    speed.
12. Archive the durable contract and evidence, not operational debris.

## Design Traceability

The Processed Beef design retains the following elements. Precedents are the
frameworks above, as reviewed; none of them are dependencies of this repository.

| Adopted design element | Primary precedents |
|---|---|
| User-owned principles and decisions | Spec Kit constitution, OpenSpec project context |
| Conditional single change note | OpenSpec, Matt Pocock skills |
| Concise handoff when ownership transfers | GSD Core, GSD Pi, OMC |
| Adaptive process depth | BMAD quick/full routing, GSD quick mode, OpenSpec optional design |
| Fresh, narrow Worker context | Superpowers, GSD Core, GSD Pi |
| Bounded skeptical review | OMC, Superpowers, gstack |
| Patch/defer/reject review triage | BMAD |
| Criterion-to-evidence traceability | Kiro, Spec Kit, GSD verification |
| Small tool-neutral skills | Blueprint OS, Superpowers skill format |
| Exactly serial subagents | Existing local Orchestrate process; deliberately differs from GSD, OMC, and gstack |
| Bounded role context and deliberate handover | GSD Core, GSD Pi |

The table above is this repository's retained framework traceability. Current
incident-derived design rationale lives in `learnings.md`.
