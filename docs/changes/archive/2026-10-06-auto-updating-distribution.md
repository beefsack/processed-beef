# Auto-Updating Distribution

- **Goal:** Release 1.0.0 with skill distribution that reliably updates.
  OpenCode caches a Git or `@latest` plugin spec once under
  `~/.cache/opencode/packages/<spec>` and never refreshes it, so the plugin
  install froze users on their first-installed commit.
- **Scope:** Replace the OpenCode plugin with an OpenCode `skills.urls` index
  served from `main`; add `skills/index.json` with content-derived versions and
  a validator freshness check; set version 1.0.0; README install instructions
  for OpenCode, `npx skills`, and `gh skill` across major hosts; align the
  OpenCode guide, CONTRIBUTING, decisions, and changelog. Non-goals: runtime
  skill wording, role-agent configuration, Claude Code plugin marketplace, npm
  publishing, tagging, commits, or pushes.
- **Acceptance:** OpenCode refreshes a skill whose content changed on its next
  start; `tests/validate.sh` fails when the index is stale or lists wrong files;
  `npx skills add . --list` still discovers three skills; no plugin files or
  references remain outside archived history.
- **Plan:** Single Lead-direct change; no delegated units.
- **Verification:** `sh tests/validate.sh`, stale-index negative check,
  `npx skills add . --list`, and `opencode debug skill` against a locally served
  index with an isolated cache, before and after a version change.
- **Outcome:** Plugin and its test removed; `skills/index.json` added with
  12-character versions hashed from Git blob ids of each skill's files;
  `tests/validate.sh --write-index` regenerates it. Version 1.0.0. README,
  OpenCode guide, CONTRIBUTING, decisions, and changelog updated.
- **Evidence:** Validation and `git diff --check` pass; validation fails after
  editing a skill or adding a skill file without regenerating the index.
  `npx skills add . --list` and `gh skill install . --from-local` list three
  skills. OpenCode 1.18.30 with an isolated cache and `text/plain` index served
  locally: first start cached all three; changed content with the same version
  was not refreshed; a bumped version refreshed it. Gotcha: with the index
  unreachable OpenCode loaded none of the skills, so offline starts lose them;
  documented. The `raw.githubusercontent.com` URL is unverified until pushed.
- **Next action:** User reviews the working tree, commits, pushes, and tags
  `v1.0.0` (`gh skill` installs the latest tag). No commit, push, or tag made.
