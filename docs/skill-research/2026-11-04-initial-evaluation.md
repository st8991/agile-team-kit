# Skill research: initial evaluation (2026-11-04)

Ten community skill repos, checked against how this kit works: an autonomous team
of Claude agents that runs once a day with no human in the loop, spawns agents one
level deep, and has push rights to `develop`. That context matters more than star
counts. A skill that is great for one developer pairing with Claude can break an
unattended run (it waits for a human, spawns its own subagents, or auto-updates
itself from someone else's repo).

All ten repos were found and shallow-cloned at the commits below. Stars and dates
are from the GitHub API on 2026-11-04.

## Name corrections

| You wrote | Actual repo |
|---|---|
| DietrichGebret/ponytail | [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) |
| leanxlnx/taste-skill | [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) |
| addy/agent-skills | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) |
| anthopics/skills | [anthropics/skills](https://github.com/anthropics/skills) |
| mulitca-ai/andrej-karpathy-skills | [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) (README still points to its old home, forrestchang/andrej-karpathy-skills) |

The other five names were right: JuliusBrussee/caveman, Graphify-Labs/graphify,
nextlevelbuilder/ui-ux-pro-max-skill, mattpocock/skills, obra/superpowers.

## Verdicts at a glance

| Repo | What it is | Stars | Last push | License | Verdict |
|---|---|---:|---|---|---|
| obra/superpowers @22f0b46 | Full dev methodology: brainstorm → plan → subagent build → review | 312k | 2026-11-03 | MIT | **Adapt**: cherry-pick 4 skills, not the plugin |
| mattpocock/skills @4ae2317 | Small composable engineering skills (grilling, TDD, domain model, tickets) | 312k | 2026-10-31 | MIT | **Include** a curated subset |
| addyosmani/agent-skills @301b02b | 25 lifecycle skills: spec, plan, TDD, review, security, CI, ship | 113k | 2026-11-01 | MIT | **Include** a curated subset |
| anthropics/skills @ca45fc4 | Official examples: skill-creator, webapp-testing, mcp-builder, docs | 187k | 2026-10-28 | Mixed (see below) | **Include** 3 skills |
| DietrichGebert/ponytail @96608e0 | "Lazy senior dev": smallest complete change, anti-over-engineering | 184k | 2026-10-29 | MIT | **Adapt**: SKILL.md only, no hooks |
| nextlevelbuilder/ui-ux-pro-max-skill @dd9a1b4 | Design-system generator backed by a searchable style/palette/type database | 145k | 2026-11-04 | MIT | **Include** for UX, when there is a UI |
| Leonxlnx/taste-skill @12af471 | Art direction + real-browser look-and-fix loop for web pages | 110k | 2026-10-25 | MIT | **Adapt**: only for public-facing pages |
| JuliusBrussee/caveman @2e068f7 | Terse output voice, plus a CLI/proxy that compresses tool output and routes models | 117k | 2026-11-01 | Apache-2.0 | **Skip the CLI**; trial 2 tiny skills |
| Graphify-Labs/graphify @59b5ab1 | Turns a codebase into a queryable knowledge graph (tree-sitter, local) | 142k | 2026-11-03 | Apache-2.0 | **Skip for now**; revisit when a project codebase is large |
| multica-ai/andrej-karpathy-skills @2c60614 | One CLAUDE.md with 4 principles (think first, simplicity, surgical changes, verifiable goals) | 229k | 2026-04-20 | None declared | **Adapt**: restate the principles in our own CLAUDE.md, don't copy |

## Repo by repo

### obra/superpowers — Adapt
The most complete methodology of the ten, very actively maintained, and listed in
Anthropic's official plugin marketplace. But installed as a plugin it would fight
this kit: `using-superpowers` demands a skill call before *any* response,
`brainstorming` stops to question a human (nobody is there on a daily run),
`subagent-driven-development` has an agent spawn its own subagents (our rule is
one level deep, spawned by the scrum master), and the optional visual companion
loads a logo from the vendor's site as usage telemetry. The individual skills are
excellent, so take them one by one:

- `verification-before-completion`: evidence before claiming done. Developer, QA, integrator.
- `systematic-debugging`: root cause before fixes. Developer.
- `receiving-code-review`: respond to review comments without thrashing. Developer.
- `writing-skills`: how to write and test a skill. Whoever maintains the team's skills (tech-lead).

### mattpocock/skills — Include (subset)
Small, opinionated, designed to be forked, and the maintainer holds a strict bar
(see its SCOPE.md). Several skills are marked `disable-model-invocation`, so they
only run when called by name, which is the right default for us.

- `grill-me` / `grill-with-docs`: the agent interviews the owner one question at a time. Use **only in live product-sync sessions** (product-manager with the owner). Never on the unattended daily run.
- `domain-modeling`: glossary + ADR discipline. Tech-lead (fits `team/DECISIONS.md`).
- `to-tickets` / `to-spec`: break a plan into tracer-bullet tickets with blocking edges. Product-manager, after adapting the "tracker" to `team/BACKLOG.md`.
- `diagnosing-bugs`: hard-bug loop. Developer and QA (pick this *or* superpowers' `systematic-debugging` per role, not both).
- `improve-codebase-architecture`: periodic architecture review. Tech-lead at backlog refinement (day 3).
- `retro`: session retro. Project-manager, adapted to the whole-team day-5 retro.
- Skip `misc/` (frozen and unmaintained by the author) and `in-progress/`.

### addyosmani/agent-skills — Include (subset)
Production-grade, well-documented, and it maps almost one-to-one onto our roles.
Its slash commands (`/spec`, `/build auto`, `/ship`) duplicate what TEAM.md already
orchestrates and `/ship` assumes a different git model, so take skills, not commands.

- `test-driven-development`: developer (our single TDD skill; it matches CLAUDE.md's test rules).
- `code-review-and-quality`: code-reviewer.
- `security-and-hardening`: security-engineer.
- `planning-and-task-breakdown`: project-manager and tech-lead.
- `spec-driven-development`: product-manager.
- `documentation-and-adrs`, `api-and-interface-design`: tech-lead.
- `browser-testing-with-devtools`: qa-engineer, on UI tickets.
- `ci-cd-and-automation`: integrator.
- `observability-and-instrumentation`, `performance-optimization`: on demand, via tech-lead flags.
- `doubt-driven-development` is interesting but spawns fresh-context reviewers; skip until we want a second opinion lane.
- Note: some skills reference the repo-level `references/` folder; copy the checklists they need when vendoring.

### anthropics/skills — Include (3 skills)
Official and well-maintained, but licensing is per skill: most are Apache-2.0, while
`docx`, `pdf`, `pptx` and `xlsx` are proprietary ("governed by your agreement with
Anthropic") and Claude Code already ships equivalents. Take:

- `skill-creator`: authoring and evaluating our own skills. Tech-lead (and the owner).
- `webapp-testing`: Playwright-driven checks of a running web app. QA-engineer.
- `mcp-builder`: only if a product needs an MCP server. Developer, flagged by tech-lead.

### DietrichGebert/ponytail — Adapt
The core idea (take the smallest change that fully solves the ticket; never cut
validation, security or tests) is a strong counter to agent over-engineering, and
the repo publishes benchmarks. Two cautions. The plugin installs hooks that
auto-activate every session and inject into subagents, which we don't want on top
of our own agent prompts. And it says "comment only the why", which conflicts with
our CLAUDE.md rule that every exported function gets a doc comment. Vendor only
`skills/ponytail/SKILL.md` (at `lite` level) for the developer and
`ponytail-review` for the code-reviewer, and state in CLAUDE.md that the team's
code-quality standard wins on conflict. Overlaps heavily with the Karpathy
principles; we only need one source of this idea.

### nextlevelbuilder/ui-ux-pro-max-skill — Include for UX
A design-system generator: given a product type it searches a local database
(product categories, styles, palettes, type pairings, layout patterns) and writes
tokens plus a pre-delivery checklist (contrast, focus states, reduced motion,
breakpoints). That is exactly what `team/UX.md` is meant to hold, and the checklist
lines up with the UX/accessibility gate. Needs Python for its search script. Owner
role: **ux-designer**; developers on `Specialists: ux` tickets read the resulting
UX.md rather than loading the skill.

### Leonxlnx/taste-skill — Adapt
Very good at making public-facing pages look designed rather than generic, with a
screenshot-and-fix loop in a real browser. Needs Node 22+, Chrome, and network
access to find images, which a scheduled cloud run may not have. It overlaps with
ui-ux-pro-max; use it only when a project has a marketing site or landing page.
Roles: ux-designer (direction and review) and developer on those tickets.

### JuliusBrussee/caveman — Skip the CLI, trial two skills
Real token savings, with outside replication (JetBrains, Elastic, an Adobe paper).
But the 4.0 installer rewires every agent on the machine, puts a proxy in the
model traffic path, sends usage telemetry by default, and its "Auto" model routing
needs a vendor account. That is too much trust for an autonomous agent with push
rights. Also, our only human-facing output is the owner's daily report, which must
stay readable. Worth a trial:

- `verify-and-stop` (16 lines): prove acceptance criteria without expanding scope. QA-engineer.
- `investigate-first` (16 lines): evidence-ranked hypotheses before editing. Developer.
- Optionally ask agents to return results to the scrum master in a terse format to save context. Never the reporter.

### Graphify-Labs/graphify — Skip for now
A capable local code-graph tool (tree-sitter, no LLM for code; docs and images do
go to a model). It pays off on large or unfamiliar codebases, which a new project
under this kit is not. It also has 1,600+ open issues and pushes a paid cloud
tier. Revisit when a product repo passes roughly 50k lines; then it would serve the
tech-lead (design review, module map) and developers (finding callers). Never
commit `graphify-out/`.

### multica-ai/andrej-karpathy-skills — Adapt (restate)
Four good principles in one file, the most-starred repo here, but tiny, untouched
since April, and with **no license declared**, so we should not copy its text.
Our CLAUDE.md already covers "surgical changes" and verifiable goals. Add two short
lines in our own words: state assumptions and stop to ask (via
`BLOCKED: story unclear`) rather than guess; and prefer the simplest solution that
meets the acceptance criteria. That applies to every role through CLAUDE.md, so no
skill is needed.

## Who gets which skill

The kit already defines its roles in `.claude/agents/`, so these map onto them.
"Pick one per topic" is deliberate: two TDD skills or two debugging skills in one
agent's context just argue with each other.

| Role | Skills |
|---|---|
| Scrum master (main session) | None. Keep its context for orchestration. |
| product-manager | addy `spec-driven-development`; matt `to-tickets`, `to-spec` (adapted to BACKLOG.md); matt `grill-with-docs` in live product sync only |
| project-manager | addy `planning-and-task-breakdown`; matt `retro` (adapted) |
| tech-lead | matt `domain-modeling`, `improve-codebase-architecture`; addy `documentation-and-adrs`, `api-and-interface-design`; anthropic `skill-creator`; superpowers `writing-skills` |
| developer | addy `test-driven-development`; superpowers `systematic-debugging`, `verification-before-completion`, `receiving-code-review`; ponytail (lite); caveman `investigate-first` (trial) |
| code-reviewer | addy `code-review-and-quality`; `ponytail-review` |
| qa-engineer | anthropic `webapp-testing`; addy `browser-testing-with-devtools`; matt `diagnosing-bugs`; caveman `verify-and-stop` (trial) |
| integrator | superpowers `verification-before-completion`; addy `ci-cd-and-automation` |
| security-engineer | addy `security-and-hardening`; also reviews every new or updated vendored skill (skills are dependencies) |
| ux-designer | ui-ux-pro-max; taste-skill when there is a public web page |
| data-scientist | None from this batch. A gap for the next research run. |
| reporter | None. |

## How to add them (proposal, not done yet)

1. **Vendor, don't subscribe.** Copy each chosen skill folder into
   `.claude/skills/<source>-<name>/` at the pinned commit above, keeping its
   LICENSE/NOTICE. Do not enable auto-updating plugins or marketplaces: a skill is
   a prompt with the run's push rights, and an upstream change would reach the
   unattended team with no review.
2. **Assign per agent.** List each agent's skills in its `.claude/agents/*.md`
   frontmatter (`skills:`) so a role only loads what it needs. Check the field
   name against the current Claude Code subagent docs when implementing.
3. **Keep a registry.** Add `team/SKILLS.md`: skill, source repo, pinned sha,
   license, roles, verdict, date reviewed. The security-engineer reviews any
   diff when a pin moves.
4. **CLAUDE.md wins.** One line in CLAUDE.md: when a skill conflicts with the code
   quality standard or TEAM.md, the repo's rules win.
5. **Trial, then keep.** Run one sprint with the new skills, and have the day-5
   retro note what helped, using the existing retro flow.

## Scheduled deep research (proposal)

A monthly routine (first Monday, before the product sync) on this repo that:

1. Re-checks every repo in `team/SKILLS.md`: new commits since the pin, license
   changes, archived or abandoned repos, notable breaking changes.
2. Searches for new candidates: GitHub repos with topics like `claude-skills`,
   `agent-skills`, `claude-code-plugin` (stars and recent pushes as a first
   filter), additions to `anthropics/claude-plugins-official`, and the skills.sh
   leaderboard. It looks hardest at gaps, such as data-science and
   retro/estimation skills, which nothing in this batch covers.
3. Scores each candidate the same way as this report (fit with an unattended,
   one-level-deep team; maintenance; license; safety; role).
4. Writes `docs/skill-research/YYYY-MM-DD.md` on a branch and opens a PR for the owner,
   plus one INBOX line so the product-manager surfaces it at the sync.
5. Never installs or bumps a skill on its own. Adoption happens only after the owner
   approves, through the vendoring steps above.

Nothing is scheduled yet; it needs the owner's go-ahead.
