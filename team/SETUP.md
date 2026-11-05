# Setting up the autonomous agile team

## What's in the kit
```
CLAUDE.md                 Product rules + code quality standard; imports team/TEAM.md
.claude/settings.json     Guardrails: what commands agents may and may not run
.claude/hooks/            cc-safety-net.sh: blocks destructive git, rm -rf and secret reads before they run
.cc-safety-net/           The hook's policy and the team's extra rules (no push to main, no PR merge)
.claude/agents/           The team (11 specialists)
team/                     The team's shared memory — lives in git
  TEAM.md                 Scrum master / orchestrator: the daily loop and rules
  PRODUCT.md              ← YOU write the vision here
  INBOX.md                ← YOU talk to the team here
  BACKLOG.md  SPRINT.md  DECISIONS.md  CONVENTIONS.md  STANDUPS.md  FINDINGS.md
  SECURITY.md  UX.md  DATA.md          specialists' notes
  reports/                ← YOU read one report a day here
  product-sync/           ← YOU answer the Monday product sync here
  reviews/  retros/  sprints/  ux/  data/  security/
  DAILY_PROMPT.md         the text of the daily scheduled task
  SKILLS.md               registry of team skills (source, pin, license, roles)
  SKILL_RESEARCH_PROMPT.md  the text of the weekly skill-research task
```
If the repo already has a CLAUDE.md, merge this one in rather than overwriting.

## One-time setup
1. Copy the kit into the root of your repo, commit, and push to `main`.
2. Fill in the placeholders in `CLAUDE.md` (decisions, roadmap) and `team/PRODUCT.md`
   (vision, time zone). Add a few starting requests to `team/INBOX.md`.
3. On GitHub, protect `main` (Settings → Branches → add rule for `main`:
   require a pull request before merging). This is your backstop: even if an
   agent misbehaves, it can't land code on main without you.
4. Create the daily scheduled task (Claude can do this for you), pointing at
   the repo and using the text in `team/DAILY_PROMPT.md`.

## Your daily routine (about 10 minutes)
1. Open the newest file in `team/reports/`. Read "Needs you" first.
2. Answer questions and approve or reject proposals in `team/INBOX.md`.
3. Review the open pull request `develop → main`. Merge it when you're happy.

## First week: supervise
Run it manually a few times before trusting the schedule: in Claude Code from
the repo root, type `Run the daily sprint` and watch. Things to tune:
- Too slow / too much usage → in project-manager.md lower the default lanes to 1
  and switch developer/reviewer/qa to `model: haiku`.
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
