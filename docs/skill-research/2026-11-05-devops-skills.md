# Skill research: DevOps and CI/CD skills (2026-11-05)

Sam asked for DevOps and CI/CD skills and a new team member, a CI/CD DevOps
engineer. This round checked 16 repos the same way as the
[initial evaluation](2026-11-04-initial-evaluation.md) and the
[security round](2026-11-04-security-skills.md): what each one does, whether it
fits an unattended team that spawns agents one level deep and keeps `main`
owner-only, its license, and which roles would use it. Each candidate also got
the **behaviour check** from the security round: hooks, install scripts,
network calls, files written outside the repo, subagent fan-out, and
interactive prompts that would stall an unattended run.

Candidates came from GitHub repository search ("devops skills claude",
"github actions skill", "terraform skill", "ci-cd agent skills", "kubernetes
claude skills", "docker claude skill") plus the bundles already pinned in
`team/SKILLS.md`. All 16 were shallow-cloned at the commits below. Stars, license
and last push come from the GitHub search API on 2026-11-05.

## Verdicts at a glance

| Repo @ commit | What it is | Stars | Last push | License | Verdict |
|---|---|---:|---|---|---|
| github/awesome-copilot @9654314 | GitHub's community collection: 472 skills, several small, careful CI ones | 40.8k | 2026-11-05 | MIT | **Cherry-pick 4**: github-actions-hardening, diagnose-ci-gate, github-actions-efficiency, multi-stage-dockerfile |
| addyosmani/agent-skills @301b02b (already pinned) | Production engineering skills | 113k | 2026-11-01 | MIT | **Add 1**: shipping-and-launch. Move ci-cd-and-automation to the new role |
| wshobson/agents @7e2fb55 | Plugin marketplace: cicd-automation, kubernetes-operations, incident-response, observability | 42.2k | 2026-11-02 | MIT | **Watch**: Actions templates pin by tag; k8s/incident skills need a deployed service |
| akin-ozer/cc-devops-skills @276af75 | 31 generator/validator pairs (Actions, GitLab, Jenkins, Dockerfile, Helm, Terraform…) | 332 | 2026-07-26 | Apache-2.0 | **Skip**: validators install act and actionlint with `curl … \| bash` from `master` |
| nitinjain999/platform-skills @001b232 | Platform handbook: github-actions, zizmor, renovate, supply-chain, k8s, GitOps | 71 | 2026-11-03 | Apache-2.0 | **Watch**: every command opens with an interactive wizard |
| selvarajmurugesan90/ops-engineering-skills @59bee31 | 297 DevOps/DevSecOps/platform skills | 43 | 2026-07-28 | Apache-2.0 | **Skip**: pipeline triage recommends quarantining flaky tests (TEAM.md forbids it); very broad, low adoption |
| antonbabenko/terraform-skill @9c1e92d | Terraform/OpenTofu testing, modules, CI patterns | 2.4k | 2026-10-24 | Apache-2.0 (GitHub shows NOASSERTION because of an extra header) | **Watch**: first pick when an ADR adds IaC |
| LukasNiessen/terrashark @21f2c18 | Terraform anti-hallucination skill | 716 | 2026-11-02 | MIT | **Watch**: same trigger |
| hashicorp/agent-skills @5e30fa5 | Official Terraform skills, mostly provider development | 913 | 2026-11-04 | MPL-2.0 | **Watch**: same trigger; style-guide and terraform-test are the useful ones |
| ahmedasmar/devops-claude-skills @1489c33 | CI/CD, GitOps, Terraform, k8s, monitoring, AWS cost | 206 | 2026-04-11 | none declared | **Skip**: no license; covered by the picks |
| harness/harness-skills @e01dc72 | Skills for the Harness platform | 130 | 2026-10-28 | Apache-2.0 | **Skip**: vendor platform |
| microsoft/skills @ddb78d1 | Azure SDK and deploy skills | 3.2k | 2026-11-04 | MIT | **Skip**: Azure-only |
| mattpocock/skills @4ae2317 (already pinned) | setup-pre-commit, git-guardrails-claude-code | 314k | 2026-11-04 | MIT | **Watch** setup-pre-commit (Node-only, installs packages); git-guardrails is superseded by cc-safety-net |
| obra/superpowers @22f0b46 (already pinned) | using-git-worktrees, finishing-a-development-branch | 313k | 2026-11-03 | MIT | **Skip**: worktrees come from Agent `isolation`; finishing waits on a human |
| trailofbits/skills @470419e (already pinned) | devcontainer-setup, supply-chain-risk-auditor | 8.0k | 2026-11-04 | CC-BY-SA-4.0 | **No change**: supply-chain auditor still goes online (see security round) |
| netresearch/github-project-skill @68e37d7 | Repo setup: branch protection, templates, CI | 10 | 2026-11-04 | NOASSERTION | **Skip**: changes repo settings, which the team must never do |

## Behaviour check summary (adopted skills)

| Skill | Hooks | Network | Writes outside repo | Subagents | Interactive | Notes |
|---|---|---|---|---|---|---|
| github-actions-hardening | none | none | none | none | no | 160 lines + 5 references; reasons about trigger privilege, `${{ }}` injection, SHA pins, token scope, OIDC |
| diagnose-ci-gate | none | `gh pr checks`, `gh run list/view` (read-only) | throwaway worktree from `mktemp -d` | none | no | Hard rules match TEAM.md: never skip or weaken a test, never re-run without evidence. Ships a validation transcript |
| github-actions-efficiency | none | `gh run list/view` | none | none | no | Guardrail: never drop required validation |
| multi-stage-dockerfile | none | none | none | none | no | 46 lines of guidance |
| shipping-and-launch | none | none | none | none | no | Same pin as the rest of addyosmani; 4 shared references copied in |

The two `gh run` commands are not in `.claude/settings.json`'s allow list, and agents
can't edit that file. The PR lists the three read-only rules for the owner to add;
without them the team triages CI from local builds only.

## Overlap with skills we already have

| Need | Already have | Decision |
|---|---|---|
| Pipeline design and quality gates | `ci-cd-and-automation` (integrator, on demand) | Keep; **move** to devops-engineer (preloaded). The integrator's job is merging, not building CI |
| Workflow security | `agentic-actions-auditor` (security-engineer, on demand) covers AI-agent actions only | Add `github-actions-hardening` for general workflow security, shared by devops-engineer (writes) and security-engineer (reviews) |
| CI failure triage | `systematic-debugging`, `diagnosing-bugs` (code bugs) | Add `diagnose-ci-gate`: its bug / flaky / environment / pipeline classes let the scrum master route a broken develop to the right role. Shared with the integrator |
| Release readiness | none | Add `shipping-and-launch`, with production always owner-approved |

## The new role: devops-engineer

Before this PR, nobody owned CI: the developer is told "never change CI config",
and the integrator only loaded `ci-cd-and-automation` when something broke. The
devops-engineer fills that gap without adding cost to ordinary tickets.

| Job | When | Output |
|---|---|---|
| Build CI/DevOps tickets | Design note says `Builder: devops-engineer` (CI workflows, Dockerfiles, build/release tooling, deploy config) | Branch `chore/T-0xx-…`; same gates as any ticket, always security-flagged, never self-reviewed |
| Design input + pipeline gate | Design note flags `Specialists: devops` (build scripts, new runtime or service, env vars, deploy steps) | `DEVOPS DESIGN` block, then `DEVOPS APPROVE / REQUEST_CHANGES / ESCALATE` |
| Red CI triage | Step 0 finds develop's last run red, or the integrator reports `BROKE_DEVELOP` flaky / environment / pipeline | `diagnose-ci-gate` report and a fix ticket |
| CI health review | Day 3, next to the security-engineer's dependency audit | Row in the CI health log in `team/DEVOPS.md`, Findings |

It never deploys to production, never touches `main`, branch protection,
secrets or environments, and never weakens a check. Production steps and new
secrets are always "Needs you".

**Skills:** preloaded `ci-cd-and-automation`, `github-actions-hardening`,
`verification-before-completion`; on demand `diagnose-ci-gate`,
`github-actions-efficiency`, `multi-stage-dockerfile`, `shipping-and-launch`.

## Changes in the kit (this PR)

- New `.claude/agents/devops-engineer.md` and `team/DEVOPS.md`.
- Five skills vendored with "In this repo" notes; registry, watch list and
  learning log updated in `team/SKILLS.md`.
- Integrator: `ci-cd-and-automation` replaced by `diagnose-ci-gate` (diagnosis
  only); `BROKE_DEVELOP` now carries a failure class.
- Security-engineer: `github-actions-hardening` on demand; `agentic-actions-auditor`
  narrowed to AI-agent actions.
- Tech lead: `devops` specialist trigger and a `Builder:` line in the design note.
- TEAM.md: role and layer tables, the builder rule, a CI check in step 0,
  BROKE_DEVELOP routing, day-3 CI health review, estimation and retro lists.
- README, SETUP and the project-manager's model line mention the new role.

## Needs you

1. **Allow `gh run`** (optional): add `"Bash(gh run list:*)"`, `"Bash(gh run view:*)"`
   and `"Bash(gh pr checks:*)"` to the allow list in `.claude/settings.json`. Agents
   are blocked from editing that file, so this PR doesn't.
2. **Workflow linters:** when a product repo gets CI, the tech lead can add
   actionlint and zizmor at pinned versions to the conventions' Environment list.
   The devops-engineer then runs them on every workflow change.
