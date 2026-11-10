# <Project name>

<!-- One paragraph: what this product is and who it's for. The full vision lives in
team/PRODUCT.md. -->

## Decisions already made
<!-- Stack, hosting, data stores, auth, anything the team must not change without
asking you. Example:
- **Stack:** Next.js + TypeScript in `apps/web`; Python FastAPI in `services/api`.
- **Single user, no auth in v1.**
- Any production deploy needs owner approval. -->

## Roadmap
<!-- Numbered epics, in order. The product manager turns these into stories.
1. **Foundation:** build, lint and test from the repo root; CI on pull requests.
2. ...
-->

## Conventions
<!-- Language rules the team must follow, e.g. "TypeScript strict mode; no `any`",
"Never call live external APIs in tests; use recorded fixtures". -->

## Code quality standard (every ticket, every reviewer)

**Unit tests**
- Test behaviour, not implementation: each test names the rule it proves,
  e.g. `returns null when the input is empty`, not `test3`.
- Arrange / act / assert, one behaviour per test. Cover the happy path, the edges
  (zero, negative, missing, boundary values) and every error path.
- Every bug fix starts with a failing test that reproduces it.
- Calculations get hand-checked expected values or parity with a reference
  implementation; never assert a number just because the code produced it.
- Tests are deterministic: no network, no wall clock, no random without a seed.

**Comments a person can read**
- Comments explain *why*, not *what*: the reason for a choice, a formula's source,
  a business rule, a unit, a gotcha. If the code needs a comment to explain what it
  does, rename or split it first.
- Every exported function, class and API endpoint has a doc comment: what it does,
  parameters with units, return value, and errors.
- No commented-out code, no stale comments, no TODO without a story ID (`TODO(S-031)`).

**Clean code**
- Names say what a thing is in the domain's words, with units in the name or the
  type when ambiguous. No abbreviations a reader must decode.
- Small functions that do one thing; aim for under ~40 lines and shallow nesting
  (early returns over nested ifs).
- No magic numbers: named constants with units and a comment on where they come from.
- Don't repeat logic: one source of truth per rule.
- Pure functions for logic; I/O at the edges. Validate inputs at boundaries and fail
  with a clear message rather than returning a silently wrong result.
- Leave code you touch a little cleaner, but never refactor outside the ticket's scope;
  log it in team/FINDINGS.md instead.

## Team skills

The team's agents and skills ship with the **development-company** Claude Code plugin
(enabled for this repo in `.claude/settings.json`). Most skills are copied from
community repos at a fixed commit; the plugin's `SKILLS.md` lists each skill's
source, license, the roles that use it, and the changes made. Each agent preloads
its own skills (the `skills:` list in its frontmatter) and can load the on-demand
ones named in its prompt.
- Where a skill conflicts with this file or with team/TEAM.md, **this repo's rules
  win**.
- Interactive skills (`grill-with-docs`, `grilling`) are only for live sessions
  with the owner, never the unattended daily run.
- The team never adds, edits or updates skills or agents. New versions arrive as
  plugin updates the owner chooses to install.

## How work happens here

This repo is built by an autonomous agile team that runs every morning. The process,
roles and git rules are in the file imported below. Follow them.

@team/TEAM.md
