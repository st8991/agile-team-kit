# Team skills registry

Every skill in `.claude/skills/`: where it came from, the commit it is pinned to,
its license, the roles that use it, and what we changed. The weekly skill-research
routine (`team/SKILL_RESEARCH_PROMPT.md`) keeps this file current. Skills change
only through an owner-merged PR.

**Adoption rules**
1. **Vendor, don't subscribe.** Copy the skill folder at a pinned commit, keeping
   its LICENSE/NOTICE. No auto-updating plugins or marketplaces. The kit is
   public: only redistributable licenses, and every vendored skill is listed in
   `THIRD_PARTY_NOTICES.md`, with a NOTICE of our changes where the license asks.
2. **Adapt rather than fight.** Where a skill clashes with CLAUDE.md or TEAM.md, add
   an "In this repo" note under its frontmatter (marked `adapted` below) and record
   it here. For sources with no license, write our own version instead of copying
   (marked `own rewrite`).
3. **One skill per topic per role.** No agent gets two TDD skills or two debugging
   skills.
4. **Assign deliberately.** Preload small skills an agent needs on every task.
   Make large or occasional ones on-demand, through the Skill tool and the agent's
   `## Skills` section.
5. **Security review.** security-engineer reviews every added or re-pinned skill
   (prompt injection, permission or git-rule bypass, network calls, scripts).

## Sources

| Source | Pinned commit | License |
|---|---|---|
| [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | 301b02b | MIT |
| [mattpocock/skills](https://github.com/mattpocock/skills) | 4ae2317 | MIT |
| [anthropics/skills](https://github.com/anthropics/skills) | ca45fc4 | Apache-2.0 (per skill LICENSE.txt) |
| [obra/superpowers](https://github.com/obra/superpowers) | 22f0b46 | MIT |
| [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) | 96608e0 | MIT |
| [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) | 2e068f7 | Apache-2.0 (NOTICE kept) |
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | 4f2dbb6 (was dd9a1b4 until 2026-11-08) | MIT |
| [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | 12af471 (held: v2.5 adds a Stop hook, see Watching) | MIT |
| [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | 2c60614 | none declared, so ideas only |
| [agamm/claude-code-owasp](https://github.com/agamm/claude-code-owasp) | 1ae29cb | MIT |
| [trailofbits/skills](https://github.com/trailofbits/skills) | 470419e | CC-BY-SA-4.0 (adaptations stay CC-BY-SA; LICENSE kept per skill) |
| [anthropics/defending-code-reference-harness](https://github.com/anthropics/defending-code-reference-harness) | d3bea6b | Apache-2.0, ideas only (repo unmaintained) |
| [github/awesome-copilot](https://github.com/github/awesome-copilot) | 9654314 | MIT (repo LICENSE copied into each skill) |
| [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) | 1ecea19 | MIT |

## Skills

| Skill | Source | Roles (P = preloaded, D = on demand) | Changes | Reviewed |
|---|---|---|---|---|
| team-coding-principles | own, inspired by karpathy | developer P, code-reviewer P, tech-lead P, product-manager P | own rewrite | 2026-11-04 |
| spec-driven-development | addyosmani | product-manager P | vendored | 2026-11-04 |
| planning-and-task-breakdown | addyosmani | project-manager P | shared reference copied in | 2026-11-04 |
| test-driven-development | addyosmani | developer P | shared reference copied in | 2026-11-04 |
| code-review-and-quality | addyosmani | code-reviewer P | shared references copied in | 2026-11-04 |
| security-and-hardening | addyosmani | security-engineer D (was P until 2026-11-04) | shared reference copied in | 2026-11-04 |
| documentation-and-adrs | addyosmani | tech-lead P | vendored | 2026-11-04 |
| api-and-interface-design | addyosmani | tech-lead D | vendored | 2026-11-04 |
| browser-testing-with-devtools | addyosmani | qa-engineer D | vendored | 2026-11-04 |
| ci-cd-and-automation | addyosmani | devops-engineer P (was integrator D until 2026-11-05) | vendored | 2026-11-04 |
| to-tickets | mattpocock | product-manager P | adapted: tracker is BACKLOG.md | 2026-11-04 |
| to-spec | mattpocock | product-manager D | adapted: tracker is BACKLOG.md | 2026-11-04 |
| grill-with-docs | mattpocock | product-manager D (live sync only) | adapted: live sessions only | 2026-11-04 |
| grilling | mattpocock | needed by grill-with-docs | adapted: live sessions only | 2026-11-04 |
| domain-modeling | mattpocock | tech-lead P | adapted: ADRs and glossary in DECISIONS.md | 2026-11-04 |
| improve-codebase-architecture | mattpocock | tech-lead D | vendored | 2026-11-04 |
| retro | mattpocock | project-manager D | adapted: whole-team day-5 retro | 2026-11-04 |
| chief-of-staff | mattpocock (`skills/in-progress/`, beta) | ceo, read by path at the start of every task (user-invoked skill) | adapted: subagent work becomes directives the Scrum Master carries out, wiki is `team/` with STRATEGY.md as index, no mid-run questions, retro and spec work routed to the team | 2026-11-05 |
| diagnosing-bugs | mattpocock | qa-engineer D | vendored | 2026-11-04 |
| skill-creator | anthropics | weekly skill-research run | adapted note | 2026-11-04 |
| webapp-testing | anthropics | qa-engineer D | vendored | 2026-11-04 |
| mcp-builder | anthropics | developer D | vendored | 2026-11-04 |
| verification-before-completion | superpowers | developer P, qa-engineer P, integrator P, devops-engineer P | vendored | 2026-11-04 |
| systematic-debugging | superpowers | developer D | vendored | 2026-11-04 |
| receiving-code-review | superpowers | developer P | vendored | 2026-11-04 |
| writing-skills | superpowers | weekly skill-research run | adapted note; copy of Anthropic's best-practices page removed and linked instead (not covered by MIT) | 2026-11-05 |
| ponytail | ponytail | developer P, tech-lead D | adapted: lite level, CLAUDE.md comment rules win | 2026-11-04 |
| ponytail-review | ponytail | code-reviewer P | adapted: reviewer's verdict format | 2026-11-04 |
| verify-and-stop | caveman | qa-engineer P | vendored (trial) | 2026-11-04 |
| investigate-first | caveman | developer D | vendored (trial) | 2026-11-04 |
| ui-ux-pro-max | ui-ux-pro-max | ux-designer D | adapted: repo-root paths (upstream's `${CLAUDE_PLUGIN_ROOT}` prefix removed again on every re-pin), output to UX.md | 2026-11-08 (re-pinned to 4f2dbb6) |
| design-taste-frontend | taste-skill | ux-designer D, developer D | adapted: public pages only | 2026-11-04 |
| owasp-security | claude-code-owasp | security-engineer P | adapted: output in the verdict block | 2026-11-04 |
| agentic-actions-auditor | trailofbits | security-engineer D | adapted: local checkout only (`gh api` denied) | 2026-11-04 |
| property-based-testing | trailofbits | developer D, data-scientist D | adapted: library choice is tech-lead's, seeded generators | 2026-11-04 |
| threat-modeling | own, inspired by defending-code-reference-harness | security-engineer D | own rewrite: sequential, writes team/SECURITY.md | 2026-11-04 |
| github-actions-hardening | awesome-copilot | devops-engineer P, security-engineer D | adapted: SHA pins required, findings in the role's own verdict, AI actions still go to agentic-actions-auditor | 2026-11-05 |
| diagnose-ci-gate | awesome-copilot | devops-engineer D, integrator D | adapted: base branch is develop, no test quarantine (hard rule), scratchpad worktree, works without `gh run` | 2026-11-05 |
| github-actions-efficiency | awesome-copilot | devops-engineer D | adapted: required checks never dropped, output to team/DEVOPS.md and Findings | 2026-11-05 |
| multi-stage-dockerfile | awesome-copilot | devops-engineer D | adapted: digest-pinned base images, container runtime needs an ADR | 2026-11-05 |
| i-have-adhd | i-have-adhd | reporter, read by path at the start of every task (user-invoked skill) | adapted: reader is the owner skimming the daily report, persistence section off, reporter template and 300-word limit win; plugin hooks, evals and `agents/` files not copied | 2026-11-08 |
| shipping-and-launch | addyosmani | devops-engineer D | adapted: production is always owner-approved, TEAM.md DoD wins; shared references copied in | 2026-11-05 |

## Guards (hooks, not skills)

| Tool | Pinned | License | What it does | Reviewed |
|---|---|---|---|---|
| [kenryu42/cc-safety-net](https://github.com/kenryu42/cc-safety-net) | 2.7.3, npm tarball sha512 checked by `.claude/hooks/cc-safety-net.sh` | MIT | PreToolUse hook on every tool: blocks force-push, branch and tag deletion, `git reset --hard`, `git clean`, `rm -rf` on dangerous paths, `curl \| bash`, and `.env`/SSH/credential reads. Strict level. `.cc-safety-net/rules/team-rules` adds no push to main, no `gh pr merge`, no `gh repo delete`. One built-in rule is off: `git.merge-abort`, which the integrator needs | 2026-11-05 |

Upgrades follow the same rule as skills: change the version and checksum in the hook script in an owner-merged PR, after the security-engineer reads the release diff.

## Watching, not adopted

| Repo | Why not yet | Revisit when |
|---|---|---|
| Leonxlnx/taste-skill 2.5 (re-pin of design-taste-frontend) | v2.5.1 adds a frontmatter `Stop` hook that runs `node scripts/gate.mjs` on every stop and searches `$HOME` and plugin roots for it, plus ~1,600 changed files of Node 22 + Chrome tooling; fails our no-hooks rule | The hook becomes opt-in, or we vendor SKILL.md and references without the hook and scripts after a security-engineer review |
| blader/humanizer | Good prose pass for owner-facing writing (MIT, 66k stars), but it is built on Wikipedia's "Signs of AI writing" (CC BY-SA) and the run could not reach Wikipedia to check no text was copied | A provenance check finds no copied passages: then product-manager D for product-sync and sprint-review files |
| K-Dense-AI/scientific-agent-skills (uncertainty-and-units, statistical-analysis, statistical-power) | Careful MIT skills, local scripts only, but physics/lab focused with pinned scientific Python stacks; our data-scientist needs golden-data and metric checks for software products | A product computes physical quantities or runs experiments with significance tests |
| JuliusBrussee/caveman (CLI, proxy, Auto) | Rewires agents, sends telemetry by default, needs a vendor account | Telemetry becomes opt-in and runs without an account |
| Graphify-Labs/graphify | Code graph pays off only on large codebases; 1.6k open issues | A product repo passes ~50k lines |
| obra/superpowers (whole plugin) | Waits on a human, nests subagents, logo telemetry | Never as a whole; keep cherry-picking |
| anthropics/skills docx/pdf/pptx/xlsx | Proprietary license; Claude Code has equivalents | A report needs a file format |
| cloudflare/security-audit-skill | Best full-audit method seen, but full mode fans out subagents and writes to `~/security-audit-skill/`; guidance mode overlaps owasp-security | The team adds a periodic full-audit lane the scrum master orchestrates |
| AgriciDaniel/pya | Strong read-only audit, but the orchestrator spawns 9 agents; overlaps owasp-security | Same as cloudflare; its `references/agentic-security.md` could feed our skill-review checklist |
| trailofbits/skills (rest) | `supply-chain-risk-auditor` calls OSV, deps.dev, npm, PyPI and GitHub; `insecure-defaults`, `differential-review`, `sharp-edges`, `fp-check` overlap owasp-security or need subagents | A day-3 audit needs more than `npm audit`/`pip-audit`, or owasp-security misses a class in practice |
| codexstar69/bug-hunter | Node 22 runtime with ~35 scripts, Context7 network lookups, writes `.bug-hunter/`; Hunter/Skeptic/Referee duplicates our review chain | Never as a whole |
| GoPlusSecurity/agentguard | Global npm install, hooks on every tool call, optional cloud sync, Web3 focus, 1,400-line skill | cc-safety-net stops being maintained |
| ghostsecurity/skills | Installs scanner binaries with `curl … \| bash` from `main`, writes to `~/.ghost/`, Task-only orchestrators, MITM proxy, vendor platform (exo) | Binaries are pinned by version and checksum |
| akin-ozer/cc-devops-skills | 31 generator/validator pairs (Actions, Dockerfile, Helm, Terraform…), but the validators' `install_tools.sh` runs `curl … \| bash` from `master` for act and actionlint | Validators install pinned binaries by checksum |
| wshobson/agents (cicd-automation, kubernetes-operations, incident-response) | Clear MIT patterns, but the Actions templates pin by tag (`@v4`), which github-actions-hardening flags; deploy/k8s/incident skills need a deployed service | The product deploys to Kubernetes or runs on-call |
| nitinjain999/platform-skills | Good zizmor/actionlint/renovate coverage (Apache-2.0), but every command opens with an interactive wizard, and it's 71 stars | Non-interactive modes become the default |
| selvarajmurugesan90/ops-engineering-skills | 297 broad DevOps skills (Apache-2.0); pipeline triage recommends quarantining flaky tests, which TEAM.md forbids; 43 stars | Never as a whole |
| antonbabenko/terraform-skill, LukasNiessen/terrashark, hashicorp/agent-skills | Strongest Terraform options (Apache-2.0 / MIT / MPL-2.0); the kit has no IaC yet | A tech-lead ADR adds Terraform or OpenTofu: start with antonbabenko |
| github/awesome-copilot dependabot, secret-scanning | Accurate, but 450+ lines and tied to GitHub Advanced Security and Copilot plugins | The owner enables Dependabot or GHAS on a product repo |
| mattpocock setup-pre-commit | Husky + Prettier only (Node), installs packages | A tech-lead ADR picks a Node stack and wants commit hooks |
| addyosmani git-workflow-and-versioning, observability-and-instrumentation | Trunk-based advice conflicts with the develop/main model; observability needs a running service | Observability: the product has a deployed service |
| ahmedasmar/devops-claude-skills, harness/harness-skills, microsoft/skills | No license (ahmedasmar); vendor platforms (Harness, Azure) | Never, unless the product adopts that platform |
| tanviet12/vbsec | Prompts mostly in Vietnamese, overlaps owasp-security; optional auto-fix rewrites source and `--sca` goes online | Never; owasp-security covers it |

## Learning log

One row per weekly run, newest first. The next run reads this to learn which
kinds of changes the owner accepts, edits or rejects.

| Week | PR | Added / changed / removed | Outcome (merged, edited, rejected) | Lesson |
|---|---|---|---|---|
| 2026-11-08 | first weekly run | Added i-have-adhd for the reporter (read by path); re-pinned ui-ux-pro-max to 4f2dbb6; held design-taste-frontend at 12af471 because v2.5 ships a Stop hook; humanizer deferred on provenance | pending | Re-pins can bring hooks in frontmatter: diff the frontmatter, not just the body. Upstream also rewrote our repo-root paths, so re-apply path fixes after every copy |
| 2026-11-05 | public-release prep (#8) | Owner-requested license audit before going public: NOTICE files added for the CC BY-SA, modified Apache and holder-less MIT skills; writing-skills' copy of an Anthropic docs page removed; THIRD_PARTY_NOTICES.md added | merged unedited | Check that every copied file is the source's to license, not just that the repo has a LICENSE: bundles sometimes include third-party docs |
| 2026-11-05 | devops round (#7) | Owner-requested: 16 DevOps/CI repos reviewed; new devops-engineer agent (builds CI tickets, pipeline gate, red-CI triage, day-3 CI health); 4 awesome-copilot skills + addyosmani shipping-and-launch vendored; ci-cd-and-automation moved from integrator to devops-engineer; integrator and security-engineer share diagnose-ci-gate and github-actions-hardening on demand | merged unedited | DevOps skill repos are mostly broad bundles with installers or wizards; small, single-purpose, non-interactive skills from a well-run source fit an unattended team best |
| 2026-11-05 | chief-of-staff + ceo (#6) | Owner-requested: new ceo agent (strategy, environment improvements, tie-breaks) with mattpocock's beta chief-of-staff at the existing 4ae2317 pin; `agents/openai.yaml` dropped. First draft gave it to the Scrum Master; owner redirected it to a new CEO role | merged unedited | An orchestration skill can go to a subagent if its delegation becomes directives the main session carries out |
| 2026-11-05 | cc-safety-net hook (#5) | Owner chose to adopt cc-safety-net as a pinned hook | merged unedited | Hooks are pinned by checksum in a wrapper, not run with `npx @latest` |
| 2026-11-04 | security round (#4) | Owner-requested review of 10 security repos: 3 skills vendored (owasp-security, agentic-actions-auditor, property-based-testing) + own threat-modeling; security-engineer preload switched to owasp-security | merged unedited | Security tools need a behaviour check beyond the license: 4 of 10 install hooks, binaries or network calls |
| 2026-11-04 | #1, #2 | Initial evaluation; 30 skills vendored + team-coding-principles | merged unedited | Owner wants the research applied to the kit, not just reported: include, cherry-pick bundles, rewrite unlicensed ideas |

Feedback from projects that use the kit arrives as GitHub issues labelled
`skill-feedback`. Requests for specific repos to look at come as `skill-request`.

## Gaps to research
- data-scientist: golden-data and model-evaluation skills (property-based-testing now covers part of numerical validation).
- project-manager: estimation and capacity-planning skills (2026-11-08: only repos under 10 stars found, none maintained).
- reporter: covered by i-have-adhd (2026-11-08); revisit humanizer for prose once its provenance is checked.
- devops-engineer: a non-interactive workflow linter skill (actionlint + zizmor at pinned versions) once a validator installs by checksum.
