# agile-team-kit

A drop-in kit that turns your GitHub repo into one built by an **autonomous agile
team of Claude Code agents**, once a day, under rules you control.

You are the Product Owner. You write the vision, talk to the team through an inbox
file, read one short report a day, and merge one pull request. The team does the
rest: grooming, story points, sprint planning, design review, building, code
review, QA, merging to `develop`, and retrospectives. Nothing reaches `main`
without you.

> **Status:** early. It has run on one real project so far, and the process changes as
> retros find friction. Expect the files to move between versions.

## Why use it

- **Controlled, not hands-off.** `main` is yours. Agents work on `develop` and
  ticket branches, and every ticket goes through code review, the flagged
  specialist reviews and QA before the integrator merges it.
- **Guardrails in config, not just prompts.** `.claude/settings.json` denies
  force-pushes, pushes to `main`, branch deletion, PR merges and `.env` reads.
  A pinned [cc-safety-net](https://github.com/kenryu42/cc-safety-net) hook
  blocks destructive shell commands before they run.
- **Safe against usage cut-offs.** Team state is checkpointed to a `team-state`
  branch after every ticket, so a run that stops mid-way loses one ticket at most.
- **Real agile, sized for agents.** Five-run sprints, Fibonacci points,
  Definition of Ready and Done, refinement on day 3, a sprint review and a
  whole-team retro on day 5, and a weekly product sync with you.
- **Pay only for what a ticket needs.** Security, UX, data and DevOps
  specialists run only on tickets the tech lead flags.

## Quick start

You need [Claude Code](https://docs.claude.com/en/docs/claude-code/overview), a
GitHub repo for your app, `git`, the `gh` CLI signed in, and node 22+, `npm` and
`openssl` (for the safety hook).

```bash
# from the root of your app's repo
git clone --depth 1 https://github.com/st8991/agile-team-kit /tmp/agile-team-kit
cp -r /tmp/agile-team-kit/{.claude,.cc-safety-net,team,CLAUDE.md} .
cp /tmp/agile-team-kit/THIRD_PARTY_NOTICES.md ./AGILE_TEAM_KIT_NOTICES.md
```

Then fill in `CLAUDE.md` and `team/PRODUCT.md`, add a first request to
`team/INBOX.md`, protect `main`, and run `Run the daily sprint` in Claude Code.

**Read [docs/GETTING_STARTED.md](docs/GETTING_STARTED.md)** before your first
run. It covers merging with an existing `CLAUDE.md`, fitting the allow list to
your stack, supervising the first week, scheduling the daily run and what it
costs.

## The team (`.claude/agents/`)

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

## How a day works

```
recover → standup → owner input (grooming) → plan → build loop → wrap
                                                    │
               design note → developer → code review → specialists (if flagged)
                                       → QA → integrator merges to develop
```

The full process, roles and git rules are in [`team/TEAM.md`](team/TEAM.md).
Your daily ten minutes: read the newest file in `team/reports/`, answer in
`team/INBOX.md`, and merge the `develop → main` PR when you're happy.

## Skills (`.claude/skills/`)

Each agent preloads a few skills and can load others on demand. Most are copied
at a pinned commit from community repos (Addy Osmani, Matt Pocock, obra/superpowers,
Anthropic, Trail of Bits, GitHub and others), plus two of our own.
[`team/SKILLS.md`](team/SKILLS.md) lists each skill's source, pin, license, roles
and our changes. A weekly research routine
([`team/SKILL_RESEARCH_PROMPT.md`](team/SKILL_RESEARCH_PROMPT.md)) proposes
changes to the kit as a PR; nothing changes until a maintainer merges it.

## What's in the repo

| Path | What it is | Copy into your project? |
|---|---|---|
| `CLAUDE.md` | Product rules and the code-quality standard; imports `team/TEAM.md` | Yes (merge if you have one) |
| `.claude/` | Agents, skills, settings, safety hook | Yes |
| `.cc-safety-net/` | The hook's policy and the team's extra rules | Yes |
| `team/` | The team's process and shared memory (templates) | Yes |
| `THIRD_PARTY_NOTICES.md` | Licenses of the vendored skills | Yes, under any name |
| `docs/` | Getting-started guide and the kit's own skill research | No |
| `README.md`, `CONTRIBUTING.md`, `LICENSE`, `.github/` | About the kit itself | No |

## License

The kit is under the [MIT License](LICENSE). The vendored skills in
`.claude/skills/` keep their own licenses (MIT, Apache-2.0 and, for two Trail of
Bits skills, CC BY-SA 4.0); see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
Keep each skill's `LICENSE` and `NOTICE` files when you copy it.

This project is not affiliated with or endorsed by Anthropic. Claude and Claude
Code are trademarks of Anthropic.

## Contributing

Bug reports, process ideas, skill feedback and pull requests are welcome. See
[CONTRIBUTING.md](CONTRIBUTING.md).
