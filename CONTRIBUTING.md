# Contributing

## Validation

Run the validation gate from anywhere in the repository:

```
sh tests/validate.sh
```

The same gate runs in CI (`.github/workflows/validate.yml`) on every push and pull request. A failing gate blocks the release.

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
