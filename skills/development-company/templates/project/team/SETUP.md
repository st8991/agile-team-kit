# Setting up the autonomous agile team

## What's where
The **development-company plugin** carries the team itself: 13 agents, 42 skills (each with
its license), the `/development-company` command and the safety hook. Plugin updates bring
new versions; the team never edits them.

This repo carries what is yours and changes over time:
```
CLAUDE.md                 Product rules + code quality standard; imports team/TEAM.md
.claude/settings.json     Enables the plugin; guardrails for what agents may run
.cc-safety-net/           The safety hook's policy and the team's extra rules
team/                     The team's shared memory — lives in git
  TEAM.md                 Scrum master / orchestrator: the daily loop and rules
  PRODUCT.md              ← YOU write the vision here
  INBOX.md                ← YOU talk to the team here
  BACKLOG.md  SPRINT.md  DECISIONS.md  CONVENTIONS.md  STANDUPS.md  FINDINGS.md
  STRATEGY.md  SECURITY.md  UX.md  DATA.md  DEVOPS.md   role notes
  reports/                ← YOU read one report a day here
  product-sync/           ← YOU answer the Monday product sync here
  reviews/  retros/  sprints/  ux/  data/  security/
  DAILY_PROMPT.md         the text of the daily scheduled task
```

## One-time setup
1. Install the plugin and run `/development-company setup` from the repo root. It copies
   these files without overwriting yours, asks about the product, and commits on
   a branch when you say so.
2. On GitHub, protect `main` (Settings → Branches → add rule for `main`:
   require a pull request before merging). This is your backstop: even if an
   agent misbehaves, it can't land code on main without you.
3. Run `/development-company` once and watch, then `/development-company schedule` for the daily run.
4. Optional, for the devops-engineer's CI checks: add these read-only rules to
   the `allow` list in `.claude/settings.json` (agents can't edit that file):
   `"Bash(gh run list:*)"`, `"Bash(gh run view:*)"`, `"Bash(gh pr checks:*)"`.
   Without them the team triages CI from local builds only.

## Your daily routine (about 10 minutes)
1. Open the newest file in `team/reports/`. Read "Needs you" first.
2. Answer questions and approve or reject proposals in `team/INBOX.md`.
3. Review the open pull request `develop → main`. Merge it when you're happy.

## First week: supervise
Run it manually a few times before trusting the schedule: in Claude Code from
the repo root, type `/development-company` and watch. Things to tune:
- Too slow / too much usage → in `team/CONVENTIONS.md` "Team settings", set max
  lanes to 1 and add model overrides such as `developer=haiku, qa=haiku`.
- Stories too vague → write more in PRODUCT.md; tighten the story template.
- Agents keep colliding → the tech lead's module map is too coarse; ask for a finer one.
- A command keeps getting blocked → add it to `allow` in `.claude/settings.json`
  (e.g. your project's build tool). Never remove the `deny` entries.
- A command is blocked "by CC Safety Net" → the safety hook judged it destructive.
  Find a safer form (for example `git reset --keep` instead of `--hard`). If it is
  really needed, turn that one rule off in `.cc-safety-net/policy.json` yourself;
  agents can't edit that folder.
- "CC Safety Net could not be installed" → the machine needs node, openssl and npm
  registry access once. Until then shell commands are blocked; file tools still work.

## How the pieces fit
- Chain of command is one level deep: the scrum master spawns every specialist
  directly. Nested spawning exists but is still unreliable, so the kit doesn't
  depend on it.
- Parallel developers each get their own git worktree and branch, so they can't
  overwrite each other.
- All state is committed to the `team-state` branch after every ticket, so a run
  that hits the usage limit mid-way loses at most the ticket it was on.
