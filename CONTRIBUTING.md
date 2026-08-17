# Contributing

## Validation

Run the validation gate from anywhere in the repository:

```
sh tests/validate.sh
```

The same gate runs in CI (`.github/workflows/validate.yml`) on every push and pull request. A failing gate blocks the release.

### Contract checks retire

A change may add a `check_<change>_contract` function of literal phrase
assertions. Those checks guard the change for the current release cycle only.
Once its behavior is recorded in `tests/behavioral.md`, delete the function.
Phrase checks can detect wording, never behavior, and letting them accumulate
locks the prose in place: the skill set then cannot be simplified without
breaking tests that were defending old sentences rather than real controls. The
structural checks - frontmatter, size, ASCII, links, harness tokens, canonical
paths, single-sourcing - are permanent.

### Policy prose is single-sourced

A rule is stated in full in exactly one place: the role skill or reference that
a working agent actually loads. README, `docs/architecture.md`, the
`agent-process.md` template, and `docs/integrations/*` describe and link.
Return thresholds are guarded this way by the validator.

## Behavioral Skill TDD

Skill behavior is developed RED/GREEN. Each scenario in `tests/behavioral.md` is observed twice under pressure:

- **RED** - the scenario runs with the skill guidance absent; the observed behavior is the failure the skill targets.
- **GREEN** - the scenario runs with the skill guidance present; the observed behavior changes to the intended discipline.

Do not invent speculative behavioral fixtures. When real use exposes a concrete
failure, capture that pressure scenario, observe the RED behavior without new
guidance, then change the skill and record the GREEN result.

## Size and Portability Constraints

- Each `SKILL.md` stays under 500 lines and approximately 5000 tokens. The
  dependency-free validator conservatively uses 20000 bytes as the token-budget
  proxy.
- Frontmatter is portable: exactly `name` and `description`, and `name` must match the skill directory name.
- Skills contain no runtime or host-specific content. Host paths and per-host configuration belong in `docs/integrations/`.
- All skill files are ASCII only.
- Relative links from a `SKILL.md` must resolve inside its own skill directory; load supporting material as references rather than inlining it.

## Naming

The project is pre-release and the role agent names are configuration interfaces. Do not add compatibility aliases before the rename or release.
