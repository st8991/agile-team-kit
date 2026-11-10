# Getting started

This guide takes you from an empty or existing app repo to the team's first
supervised sprint. Plan on about an hour for setup and a week of watching before
you leave it to run on a schedule.

`team/SETUP.md`, which setup copies into your repo, is the short reference. This
page is the longer walk-through for first-time adopters.

## 1. Is this for you?

It fits when:
- You have a product idea or an app you want to grow ticket by ticket, and you
  are happy to act as Product Owner: write the vision, answer questions, merge.
- The repo lives on GitHub, and you can protect `main`.
- You have a Claude plan with enough usage for several agent sessions a day.
  Each ticket spawns a developer plus at least a reviewer and QA.

It doesn't fit when you want one-off edits (use Claude Code directly), or when no
human will review the daily `develop → main` PR. Its safety comes from you
holding `main`.

## 2. Prerequisites

| Need | Why |
|---|---|
| [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) | Runs the scrum master and spawns the agents |
| `git` and a GitHub repo | Branches, worktrees, PRs |
| `gh` CLI, signed in (`gh auth status`) | The integrator opens the `develop → main` PR |
| node 22+, npm, openssl | The safety hook installs a pinned, checksum-verified copy of cc-safety-net once per machine. Without them, shell commands are blocked |
| Your stack's toolchain | Whatever builds, lints and tests your app |

## 3. Install and set up

Install the plugin one of two ways:

- **On your Claude account** (recommended if you use the desktop app or cloud
  sessions): in claude.ai or the desktop app, go to **Customize → Plugins → Add →
  Add marketplace**, enter `st8991/agile-team-kit`, and add **Development
  Company**. It syncs to Claude Code the next time you start a session.
- **In Claude Code only**:
  ```
  /plugin marketplace add st8991/agile-team-kit
  /plugin install development-company@development-company
  ```
  When it asks for a scope, **project** is the tidy choice: the team's 42 skills
  then only load in this repo. User scope works too.

The safety hook stays inactive in repos that weren't set up. Then, in Claude Code
at the root of your app's repo:

```
/development-company setup
```

Setup copies `CLAUDE.md`, `.claude/settings.json`, `.cc-safety-net/` and `team/`
into your repo. It never overwrites:
- **`CLAUDE.md` exists:** your content stays, and the team's "Code quality
  standard", "Team skills" and "How work happens here" sections (with the
  `@team/TEAM.md` import) are added.
- **`.claude/settings.json` exists:** the `allow` and `deny` lists are merged,
  the plugin is enabled, and your other keys stay.
- **Any other file exists:** it's skipped and listed.

The project's `.claude/settings.json` declares this marketplace and enables the
plugin, so collaborators who open the repo in Claude Code are offered it (they
trust the marketplace and install it once). Cloud sessions ignore plugins that a
repo enables; there the plugin comes from your Claude account.

The vendored skills stay inside the plugin, so you don't copy any license or
notice files into your repo.

## 4. Tell the team about your product

Setup asks you these questions and writes the answers in; this is where they
end up if you'd rather edit by hand.

1. **`CLAUDE.md`**: replace `<Project name>`, then fill in "Decisions already
   made" (stack, hosting, anything the team must not change without asking) and
   "Roadmap" (epics in priority order). Short is fine.
2. **`team/PRODUCT.md`**: what the product is, who uses it, what "good" looks
   like next month, must and must-not rules, and your time zone (the Monday
   product sync uses it).
3. **`team/INBOX.md`**: replace the `YYYY-MM-DD` on the kickoff line with
   today's date, and add any first requests.

You don't need to fill in `team/CONVENTIONS.md`. The tech lead writes it on the
first run from what your repo actually uses.

## 5. Fit the guardrails to your stack

`.claude/settings.json` allows git, `gh pr`, and common npm, pnpm, pytest and uv
commands. Add your own build, test and lint commands to `allow`, for example
`"Bash(cargo test:*)"` or `"Bash(go test:*)"`. Agents can't edit this file, so
you make every change to it. Setup offers to add the commands it finds.

Optional: for the devops-engineer's CI checks, allow
`"Bash(gh run list:*)"`, `"Bash(gh run view:*)"` and `"Bash(gh pr checks:*)"`.

Never remove the `deny` entries. They are what stop an agent from pushing to
`main`, force-pushing, deleting branches or merging PRs.

## 6. Protect `main`

GitHub → Settings → Branches → add a rule (or ruleset) for `main` that requires a
pull request before merging. This is your backstop if an agent ever gets past
the settings and the hook.

## 7. First run, supervised

Merge the setup PR, open Claude Code at the repo root, and type:

```
/development-company
```

On the first run the scrum master creates `develop` and `team-state`, the
product manager turns your roadmap into stories, the tech lead points them and
writes `team/CONVENTIONS.md`, and the project manager plans sprint 1. Sprint 1
is usually the foundation: build, lint and test commands, and CI.

Watch the first few runs. Things to tune:
- **Too slow or too much usage:** in `team/CONVENTIONS.md` under "Team
  settings", set max lanes to 1 and add model overrides such as
  `developer=haiku, code-reviewer=haiku, qa-engineer=haiku`.
- **Stories too vague:** write more in `team/PRODUCT.md`.
- **A command keeps getting blocked:** add it to `allow` in `.claude/settings.json`.
- **"Blocked by CC Safety Net":** the hook judged the command destructive. Look
  for a safer form first. If it is really needed, turn off that one rule in
  `.cc-safety-net/policy.json`.

## 8. Your daily routine (about 10 minutes)

1. Open the newest file in `team/reports/` and read "Needs you" first.
2. Answer questions and approve or reject proposals in `team/INBOX.md`. You can
   edit it straight on GitHub.
3. Review the `develop → main` PR and merge it when you're happy.

On Mondays, also answer the product sync in `team/product-sync/`. To change
direction at any time, write it in the inbox.

## 9. Put it on a schedule

Once a few supervised runs look right, run `/development-company schedule`. It fills in
[`team/DAILY_PROMPT.md`](../skills/development-company/templates/project/team/DAILY_PROMPT.md)
for your repo and, where Claude Code can create scheduled tasks, offers to make
one. Any scheduler that can start a Claude Code session in a fresh clone of the
repo works too, as long as that environment can install the plugin.

Pick a time when you won't be using Claude yourself, so the run doesn't compete
with you for usage.

## 10. Updating

Agents, skills and the hook update with the plugin (`/plugin` → update). The
plugin's version is pinned, so nothing changes until a new release and your
update.

Your `team/` files don't change on update: they are the team's memory, and the
retro edits the process on purpose. Run `/development-company templates` to see what the
newer templates changed and pick what to take, as a PR to your `main`.

Found something that should change in the plugin itself? Open an issue here; see
[CONTRIBUTING.md](../CONTRIBUTING.md).

## Removing it

Uninstall the plugin (`/plugin`), then delete `.cc-safety-net/`, the
`development-company` entries and any permissions you don't want in
`.claude/settings.json`, the team sections of `CLAUDE.md`, and `team/`. Delete
the daily scheduled task. Your `develop` branch and history stay as they are.
