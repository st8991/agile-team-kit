# development-company

A Claude Code plugin that gives your GitHub repo an **autonomous agile team of
Claude agents**. Type `/development-company` and the team runs a sprint day: grooming, story
points, planning, design review, building, code review, QA, merging to `develop`,
and retrospectives. Run it by hand or once a day on a schedule.

You are the Product Owner. You write the vision, talk to the team through an inbox
file, read one short report a day, and merge one pull request. Nothing reaches
`main` without you.

> **Status:** early (0.x). It has run on one real project so far, and the process
> changes as retros find friction.

## Quick start

You need [Claude Code](https://code.claude.com/docs), a GitHub repo for your app,
`git`, the `gh` CLI signed in, and node 22+, `npm` and `openssl` (for the safety
hook).

**Install it once, on your Claude account** (claude.ai or the Claude desktop app):
**Customize → Plugins → Add → Add marketplace**, enter `st8991/agile-team-kit`,
then add the **Development Company** plugin. It then follows your account into the
desktop app and Claude Code.

**Or install it in Claude Code only**, from a terminal session:

```
/plugin marketplace add st8991/agile-team-kit
/plugin install development-company@development-company
```

Then open your app's repo in Claude Code (terminal, IDE or the desktop app's Code
tab) and type:

```
/development-company
```

The first `/development-company` sets the repo up: it copies the team's files in without
overwriting yours, asks you about the product, and commits on a branch when you
say so. After that, `/development-company` runs the daily sprint.

Then protect `main` on GitHub (require a pull request before merging). **Read
[docs/GETTING_STARTED.md](docs/GETTING_STARTED.md)** before your first run.

## Commands

| Command | What it does |
|---|---|
| `/development-company` | Sets the repo up the first time, then runs the daily sprint |
| `/development-company setup` | Copies the team files into this repo and fills in the product with you |
| `/development-company run` | Runs one sprint day as Scrum Master |
| `/development-company sync` | Live product sync with the product manager (no build work) |
| `/development-company status` | Board, blockers and "Needs you" items, without spawning agents |
| `/development-company schedule` | Sets up the daily scheduled run |
| `/development-company templates` | After a plugin update, shows what changed in the process templates |

If another command already uses the name, type `/development-company:development-company`.

## Where it runs

| Where | Works? |
|---|---|
| Claude Code: terminal, IDE, desktop app's Code tab | Yes, the supported way. The team needs a git repo, `gh` and a shell |
| Cowork | Agents and hooks load there; untested so far |
| claude.ai chat | No. Chat loads skills but not agents or hooks, and has no repo to work on. `/development-company` says so and stops; the individual skills (TDD, code review, OWASP and so on) still work on their own |


## Why use it

- **Controlled, not hands-off.** `main` is yours. Agents work on `develop` and
  ticket branches, and every ticket goes through code review, the flagged
  specialist reviews and QA before the integrator merges it.
- **Guardrails in config, not just prompts.** Setup writes a project
  `.claude/settings.json` that denies force-pushes, pushes to `main`, branch
  deletion, PR merges and `.env` reads. A pinned, checksum-verified
  [cc-safety-net](https://github.com/kenryu42/cc-safety-net) hook blocks
  destructive shell commands before they run.
- **Safe against usage cut-offs.** Team state is checkpointed to a `team-state`
  branch after every ticket, so a run that stops mid-way loses one ticket at most.
- **Real agile, sized for agents.** Five-run sprints, Fibonacci points,
  Definition of Ready and Done, refinement on day 3, a sprint review and a
  whole-team retro on day 5, and a weekly product sync with you.
- **Pay only for what a ticket needs.** Security, UX, data and DevOps
  specialists run only on tickets the tech lead flags.

## The team (`agents/`)

| Agent | Job |
|---|---|
| Scrum master *(the main session)* | Runs the daily loop in `team/TEAM.md`; delegates everything |
| ceo | North star, weekly bets, environment improvements, tie-breaks |
| product-manager | Stories, acceptance criteria, backlog priority, weekly product sync |
| project-manager | Sprint planning, daily plan, scaling lanes up or down, retro data |
| tech-lead | Architecture, ADRs, conventions, design notes, story points |
| developer | One ticket on one branch, in its own worktree |
| code-reviewer | Diff quality and security (read-only) |
| qa-engineer | Does it work, regressions (read-only) |
| integrator | The only agent that merges; keeps `develop` green; opens the `develop → main` PR |
| reporter | Your one-page daily report |
| security-engineer | Threat review and security gate on flagged tickets; dependency audits |
| ux-designer | UX criteria, UI specs, UX and accessibility gate on flagged tickets |
| data-scientist | Formula and model specs, numerical-correctness gate on flagged tickets |
| devops-engineer | Builds CI/CD, Dockerfile and deploy tickets; pipeline gate; triages red CI |

In a session they appear as `development-company:<role>`.

## How a day works

```
recover → standup → owner input (grooming) → plan → build loop → wrap
                                                    │
               design note → developer → code review → specialists (if flagged)
                                       → QA → integrator merges to develop
```

The full process, roles and git rules are in
[`team/TEAM.md`](skills/development-company/templates/project/team/TEAM.md), which setup
copies into your repo so you and the retro can tune it per project.

## What lives where

| In the plugin (updates with the plugin) | In your repo (yours, changes every run) |
|---|---|
| `agents/`: the 13 specialists | `team/`: process, backlog, sprint board, reports, retros |
| `skills/`: the `/development-company` command and 42 team skills | `CLAUDE.md`: product rules and the code-quality standard |
| `hooks/` + `scripts/`: the safety hook | `.claude/settings.json`: enables the plugin; permissions |
| `skills/development-company/templates/`: what setup copies | `.cc-safety-net/`: the hook's policy and team rules |

The safety hook only acts in repos that `/development-company setup` initialised (they have
`.cc-safety-net/` or `team/TEAM.md`); it does nothing in your other projects.

## Skills

Each agent preloads a few skills and can load others on demand. Most are copied
at a pinned commit from community repos (Addy Osmani, Matt Pocock,
obra/superpowers, Anthropic, Trail of Bits, GitHub and others), plus two of our
own. [`SKILLS.md`](SKILLS.md) lists each skill's source, pin, license, roles and
our changes. A weekly research routine
([`maintainers/SKILL_RESEARCH_PROMPT.md`](maintainers/SKILL_RESEARCH_PROMPT.md))
proposes changes as a PR; nothing changes until a maintainer merges it.

## License

The plugin's own files are under the [MIT License](LICENSE). The vendored skills
in `skills/` keep their own licenses (MIT, Apache-2.0 and, for two Trail of Bits
skills, CC BY-SA 4.0); see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

This project is not affiliated with or endorsed by Anthropic. Claude and Claude
Code are trademarks of Anthropic.

## Contributing

Bug reports, process ideas, skill feedback and pull requests are welcome. See
[CONTRIBUTING.md](CONTRIBUTING.md).
