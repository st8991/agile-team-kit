# Team skills registry

Every skill in `.claude/skills/`: where it came from, the commit it is pinned to,
its license, the roles that use it, and what we changed. The weekly skill-research
routine (`team/SKILL_RESEARCH_PROMPT.md`) keeps this file current. Skills change
only through an owner-merged PR.

**Adoption rules**
1. **Vendor, don't subscribe.** Copy the skill folder at a pinned commit, keeping
   its LICENSE/NOTICE. No auto-updating plugins or marketplaces.
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
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | dd9a1b4 | MIT |
| [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | 12af471 | MIT |
| [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | 2c60614 | none declared, so ideas only |
| [agamm/claude-code-owasp](https://github.com/agamm/claude-code-owasp) | 1ae29cb | MIT |
| [trailofbits/skills](https://github.com/trailofbits/skills) | 470419e | CC-BY-SA-4.0 (adaptations stay CC-BY-SA; LICENSE kept per skill) |
| [anthropics/defending-code-reference-harness](https://github.com/anthropics/defending-code-reference-harness) | d3bea6b | Apache-2.0, ideas only (repo unmaintained) |

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
| ci-cd-and-automation | addyosmani | integrator D | vendored | 2026-11-04 |
| to-tickets | mattpocock | product-manager P | adapted: tracker is BACKLOG.md | 2026-11-04 |
| to-spec | mattpocock | product-manager D | adapted: tracker is BACKLOG.md | 2026-11-04 |
| grill-with-docs | mattpocock | product-manager D (live sync only) | adapted: live sessions only | 2026-11-04 |
| grilling | mattpocock | needed by grill-with-docs | adapted: live sessions only | 2026-11-04 |
| domain-modeling | mattpocock | tech-lead P | adapted: ADRs and glossary in DECISIONS.md | 2026-11-04 |
| improve-codebase-architecture | mattpocock | tech-lead D | vendored | 2026-11-04 |
| retro | mattpocock | project-manager D | adapted: whole-team day-5 retro | 2026-11-04 |
| diagnosing-bugs | mattpocock | qa-engineer D | vendored | 2026-11-04 |
| skill-creator | anthropics | weekly skill-research run | adapted note | 2026-11-04 |
| webapp-testing | anthropics | qa-engineer D | vendored | 2026-11-04 |
| mcp-builder | anthropics | developer D | vendored | 2026-11-04 |
| verification-before-completion | superpowers | developer P, qa-engineer P, integrator P | vendored | 2026-11-04 |
| systematic-debugging | superpowers | developer D | vendored | 2026-11-04 |
| receiving-code-review | superpowers | developer P | vendored | 2026-11-04 |
| writing-skills | superpowers | weekly skill-research run | adapted note | 2026-11-04 |
| ponytail | ponytail | developer P, tech-lead D | adapted: lite level, CLAUDE.md comment rules win | 2026-11-04 |
| ponytail-review | ponytail | code-reviewer P | adapted: reviewer's verdict format | 2026-11-04 |
| verify-and-stop | caveman | qa-engineer P | vendored (trial) | 2026-11-04 |
| investigate-first | caveman | developer D | vendored (trial) | 2026-11-04 |
| ui-ux-pro-max | ui-ux-pro-max | ux-designer D | adapted: repo-root paths, output to UX.md | 2026-11-04 |
| design-taste-frontend | taste-skill | ux-designer D, developer D | adapted: public pages only | 2026-11-04 |
| owasp-security | claude-code-owasp | security-engineer P | adapted: output in the verdict block | 2026-11-04 |
| agentic-actions-auditor | trailofbits | security-engineer D | adapted: local checkout only (`gh api` denied) | 2026-11-04 |
| property-based-testing | trailofbits | developer D, data-scientist D | adapted: library choice is tech-lead's, seeded generators | 2026-11-04 |
| threat-modeling | own, inspired by defending-code-reference-harness | security-engineer D | own rewrite: sequential, writes team/SECURITY.md | 2026-11-04 |

## Watching, not adopted

| Repo | Why not yet | Revisit when |
|---|---|---|
| JuliusBrussee/caveman (CLI, proxy, Auto) | Rewires agents, sends telemetry by default, needs a vendor account | Telemetry becomes opt-in and runs without an account |
| Graphify-Labs/graphify | Code graph pays off only on large codebases; 1.6k open issues | A product repo passes ~50k lines |
| obra/superpowers (whole plugin) | Waits on a human, nests subagents, logo telemetry | Never as a whole; keep cherry-picking |
| anthropics/skills docx/pdf/pptx/xlsx | Proprietary license; Claude Code has equivalents | A report needs a file format |
| kenryu42/cc-safety-net | Not a skill: a PreToolUse hook that parses commands and blocks force-push, branch deletion, `rm -rf` and `.env` reads. Adding it changes `.claude/settings.json`, so it is the owner's call | Owner approves the hook (see docs/skill-research/2026-11-04-security-skills.md) |
| cloudflare/security-audit-skill | Best full-audit method seen, but full mode fans out subagents and writes to `~/security-audit-skill/`; guidance mode overlaps owasp-security | The team adds a periodic full-audit lane the scrum master orchestrates |
| AgriciDaniel/pya | Strong read-only audit, but the orchestrator spawns 9 agents; overlaps owasp-security | Same as cloudflare; its `references/agentic-security.md` could feed our skill-review checklist |
| trailofbits/skills (rest) | `supply-chain-risk-auditor` calls OSV, deps.dev, npm, PyPI and GitHub; `insecure-defaults`, `differential-review`, `sharp-edges`, `fp-check` overlap owasp-security or need subagents | A day-3 audit needs more than `npm audit`/`pip-audit`, or owasp-security misses a class in practice |
| codexstar69/bug-hunter | Node 22 runtime with ~35 scripts, Context7 network lookups, writes `.bug-hunter/`; Hunter/Skeptic/Referee duplicates our review chain | Never as a whole |
| GoPlusSecurity/agentguard | Global npm install, hooks on every tool call, optional cloud sync, Web3 focus, 1,400-line skill | cc-safety-net is declined and we still want a runtime guard |
| ghostsecurity/skills | Installs scanner binaries with `curl … \| bash` from `main`, writes to `~/.ghost/`, Task-only orchestrators, MITM proxy, vendor platform (exo) | Binaries are pinned by version and checksum |
| tanviet12/vbsec | Prompts mostly in Vietnamese, overlaps owasp-security; optional auto-fix rewrites source and `--sca` goes online | Never; owasp-security covers it |

## Learning log

One row per weekly run, newest first. The next run reads this to learn which
kinds of changes the owner accepts, edits or rejects.

| Week | PR | Added / changed / removed | Outcome (merged, edited, rejected) | Lesson |
|---|---|---|---|---|
| 2026-11-04 | security round | Owner-requested review of 10 security repos: 3 skills vendored (owasp-security, agentic-actions-auditor, property-based-testing) + own threat-modeling; security-engineer preload switched to owasp-security | pending | Security tools need a behaviour check beyond the license: 4 of 10 install hooks, binaries or network calls |
| 2026-11-04 | #1, #2 | Initial evaluation; 30 skills vendored + team-coding-principles | merged unedited | Owner wants the research applied to the kit, not just reported: include, cherry-pick bundles, rewrite unlicensed ideas |

Feedback from projects that use the kit arrives as GitHub issues labelled
`skill-feedback`. Requests for specific repos to look at come as `skill-request`.

## Gaps to research
- data-scientist: golden-data and model-evaluation skills (property-based-testing now covers part of numerical validation).
- project-manager: estimation and capacity-planning skills.
- reporter: concise status-report writing.
