# agile-team-kit

A drop-in kit that turns a GitHub repo into one worked on by an **autonomous agile
team of Claude agents**, once a day. You are the Product Owner: you write the vision,
talk to the team through an inbox file, read one short report a day, and merge one
pull request. The team does the rest — grooming, story points, sprint planning,
design review, building, code review, QA, merging to `develop`, retros.

## The team (`.claude/agents/`)

| Agent | Job |
|---|---|
| Scrum master *(the main session)* | Runs the daily loop in `team/TEAM.md`; delegates everything |
| product-manager | Stories, acceptance criteria, backlog priority, weekly product sync |
| project-manager | Sprint planning, daily plan, scaling lanes up/down, retro data |
| tech-lead | Architecture, ADRs, conventions, design notes, story points |
| developer | One ticket on one branch, in its own worktree |
| code-reviewer | Diff quality and security (read-only) |
| qa-engineer | Does it work, regressions (read-only) |
| integrator | The only agent that merges; keeps `develop` green; opens `develop → main` PR |
| reporter | The owner's one-page daily report |
| security-engineer | Threat review + security gate on flagged tickets; dependency audits |
| ux-designer | UX criteria, UI specs + UX/accessibility gate on flagged tickets |
| data-scientist | Formula/model specs + numerical-correctness gate on flagged tickets |

Specialists only run on tickets the tech lead flags, so they cost nothing otherwise.

## How it works

- **Git model:** `main` is yours; nobody on the team pushes to it. The team works on
  `develop` and per-ticket branches, and keeps its state on a `team-state` branch.
- **Safe against cut-offs:** state is checkpointed to GitHub after every ticket, so a
  run that hits the usage limit loses at most the ticket it was on.
- **Guardrails:** `.claude/settings.json` denies force-pushes, pushes to `main`,
  branch deletion, PR merging and reading `.env` files.
- **Sprints:** 5 daily runs, Fibonacci story points, Definition of Ready/Done,
  backlog refinement on day 3, sprint review and a whole-team retro on day 5,
  and a product sync with you every Monday.

## Install

1. Copy everything here except this README into the root of your project repo.
   If it already has a `CLAUDE.md`, merge rather than overwrite.
2. Fill in the placeholders in `CLAUDE.md` and `team/PRODUCT.md`, and add starting
   requests to `team/INBOX.md`.
3. Protect `main` on GitHub (require a pull request before merging).
4. Create a daily scheduled task using the text in `team/DAILY_PROMPT.md`
   (Claude can set this up for you).

Full instructions, your daily 10-minute routine and tuning tips: [`team/SETUP.md`](team/SETUP.md).

## In use

First deployed on `finance-toolkit` (Oct 2026). This version folds in the process
changes from its first sprints: story points, estimation rounds, the specialist
agents, stretch work, retro action tracking and the weekly product sync.
