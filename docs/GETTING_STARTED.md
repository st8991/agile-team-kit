# Getting started

This guide takes you from an empty or existing app repo to the team's first
supervised sprint. Plan on about an hour for setup and a week of watching before
you leave it to run on a schedule.

[`team/SETUP.md`](../team/SETUP.md) is the short reference that travels with the
kit into your repo. This page is the longer walk-through for first-time adopters.

## 1. Is this kit for you?

It fits when:
- You have a product idea or an app you want to grow ticket by ticket, and you
  are happy to act as Product Owner: write the vision, answer questions, merge.
- The repo lives on GitHub, and you can protect `main`.
- You have a Claude plan with enough usage for several agent sessions a day.
  Each ticket spawns a developer plus at least a reviewer and QA.

It doesn't fit when you want one-off edits (use Claude Code directly), or when no
human will review the daily `develop → main` PR. The kit's safety comes from
you holding `main`.

## 2. Prerequisites

| Need | Why |
|---|---|
| [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) | Runs the scrum master and spawns the agents |
| `git` and a GitHub repo | Branches, worktrees, PRs |
| `gh` CLI, signed in (`gh auth status`) | The integrator opens the `develop → main` PR |
| node 22+, npm, openssl | The safety hook installs a pinned, checksum-verified copy of cc-safety-net once per machine. Without them, shell commands are blocked |
| Your stack's toolchain | Whatever builds, lints and tests your app |

## 3. Install

From the root of your app's repo:

```bash
git clone --depth 1 https://github.com/st8991/agile-team-kit /tmp/agile-team-kit
cp -r /tmp/agile-team-kit/{.claude,.cc-safety-net,team} .
cp /tmp/agile-team-kit/THIRD_PARTY_NOTICES.md ./AGILE_TEAM_KIT_NOTICES.md
# CLAUDE.md: copy it if you have none, otherwise merge by hand (see below)
[ -f CLAUDE.md ] || cp /tmp/agile-team-kit/CLAUDE.md .
```

Don't copy the kit's `README.md`, `LICENSE`, `CONTRIBUTING.md`, `docs/` or
`.github/`; those describe the kit, not your app. Do keep every `LICENSE`,
`LICENSE.txt` and `NOTICE` inside `.claude/skills/`, and the notices file. That
is what the skills' licenses ask of you.

**Already have a `CLAUDE.md` or `.claude/settings.json`?** Merge rather than
overwrite:
- `CLAUDE.md`: keep your content, then add the kit's "Code quality standard",
  "Team skills" and "How work happens here" sections, including the
  `@team/TEAM.md` import line.
- `.claude/settings.json`: add the kit's `allow` and `deny` entries and its
  `PreToolUse` hook to yours. Keep every `deny` entry.
- `.claude/agents/` or `.claude/skills/` with the same names as the kit's: rename
  yours, or the kit's versions will replace them.

Commit and push to `main`.

## 4. Tell the team about your product

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
you make every change to it.

Optional: for the devops-engineer's CI checks, allow
`"Bash(gh run list:*)"`, `"Bash(gh run view:*)"` and `"Bash(gh pr checks:*)"`.

Never remove the `deny` entries. They are what stop an agent from pushing to
`main`, force-pushing, deleting branches or merging PRs.

## 6. Protect `main`

GitHub → Settings → Branches → add a rule (or ruleset) for `main` that requires a
pull request before merging. This is your backstop if an agent ever gets past
the settings and the hook.

## 7. First run, supervised

Open Claude Code at the repo root and type:

```
Run the daily sprint
```

On the first run the scrum master creates `develop` and `team-state`, the
product manager turns your roadmap into stories, the tech lead points them and
writes `team/CONVENTIONS.md`, and the project manager plans sprint 1. Sprint 1
is usually the foundation: build, lint and test commands, and CI.

Watch the first few runs. Things to tune:
- **Too slow or too much usage:** lower the default lanes to 1 in
  `.claude/agents/project-manager.md`, and switch developer, reviewer and QA to
  `model: haiku` in their frontmatter.
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

Once a few supervised runs look right, schedule the daily run with the text in
[`team/DAILY_PROMPT.md`](../team/DAILY_PROMPT.md), replacing `<OWNER>/<REPO>`.
The easiest way is to ask Claude Code to create a daily scheduled task for your
repo with that prompt. Any scheduler that can start a Claude Code session in a
fresh clone of the repo works too.

Pick a time when you won't be using Claude yourself, so the run doesn't compete
with you for usage.

## 10. Keeping the kit up to date

The kit changes as retros find friction. To update a project:
1. Diff the new kit against your copy, starting with `team/TEAM.md`,
   `.claude/agents/` and `.claude/skills/`.
2. Take process and agent changes as a normal PR to your `main`.
3. Don't overwrite your `team/` state files (BACKLOG, SPRINT, INBOX, STANDUPS,
   FINDINGS, DECISIONS, CONVENTIONS, reports, retros).

Found something that should change in the kit itself? Open an issue here; see
[CONTRIBUTING.md](../CONTRIBUTING.md).

## Removing the kit

Delete `.claude/agents/`, `.claude/skills/` (or only the kit's skills),
`.claude/hooks/cc-safety-net.sh`, `.cc-safety-net/`, the hook and kit entries in
`.claude/settings.json`, the kit sections of `CLAUDE.md`, and `team/`. Delete the
daily scheduled task. Your `develop` branch and history stay as they are.
