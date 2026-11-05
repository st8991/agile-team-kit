# Skill research: security skills (2026-11-04)

Ten security-focused skill repos the owner asked about, checked the same way as the
[initial evaluation](2026-11-04-initial-evaluation.md): what each one does, whether
it fits an unattended team that spawns agents one level deep and keeps `main`
owner-only, its license, and which roles would use it. Because these are security
tools, each one also got a **behaviour check**: hooks, install scripts, network
calls, files written outside the repo, subagent fan-out, and the tool permissions
it asks for.

All ten were shallow-cloned at the commits below. Stars, last push and open issues
come from the GitHub search API on 2026-11-04.

## Name corrections

| You wrote | Actual repo |
|---|---|
| agamm/claude-code-owsap | [agamm/claude-code-owasp](https://github.com/agamm/claude-code-owasp) |
| trailsofbits/skills | [trailofbits/skills](https://github.com/trailofbits/skills) |
| claudflare/security-audit-skill | [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) |
| agriciDaniel/pya | [AgriciDaniel/pya](https://github.com/AgriciDaniel/pya) (capital A; GitHub resolves either) |

The other six names were right.

## Verdicts at a glance

| Repo @ commit | What it is | Stars | Last push | License | Verdict |
|---|---|---:|---|---|---|
| agamm/claude-code-owasp @1ae29cb | One compact review skill: OWASP Top 10:2025, ASVS 5.0, LLM and Agentic Top 10 (2026), with a triage rubric and evals | 427 | 2026-11-03 | MIT | **Include** for security-engineer |
| trailofbits/skills @470419e | 49 plugins from a top security firm (audits, testing, CI, smart contracts) | 8.0k | 2026-11-04 | CC-BY-SA-4.0 | **Cherry-pick** 2 skills |
| anthropics/defending-code-reference-harness @d3bea6b | Reference pipeline for vuln discovery: threat-model, vuln-scan, triage, patch skills | 7.7k | 2026-08-06 | Apache-2.0 | **Own rewrite** of threat-model (repo is unmaintained) |
| kenryu42/cc-safety-net @0fb31bd | A PreToolUse hook that parses shell commands and blocks destructive git, `rm -rf` and secret reads | 1.9k | 2026-11-04 | MIT | **Needs you**: strong fit, but it's a hook, not a skill |
| cloudflare/security-audit-skill @c1c8a8c | Six-phase audit with coverage ledger, independent verifiers and JSON schema validators | 59k | 2026-09-14 | MIT | **Skip for now**: full mode needs subagents |
| AgriciDaniel/pya @416c17f | `/pya`: 9 read-only specialist agents + verifier, threat feed, 0–100 score | 271 | 2026-10-23 | MIT | **Skip for now**: same reason |
| codexstar69/bug-hunter @b412f98 | Hunter/Skeptic/Referee adversarial audit with a Node runtime and optional fixer | 549 | 2026-10-29 | MIT | **Skip** |
| GoPlusSecurity/agentguard @337b767 | Runtime guard: hooks on every tool call, skill scanner, Web3 checks, optional cloud | 489 | 2026-10-19 | MIT | **Skip** |
| ghostsecurity/skills @25fdf06 | Ghost AppSec plugin (secrets, deps, SAST, DAST proxy) + exo platform skill | 437 | 2026-09-28 | Apache-2.0 | **Skip**: risky installs |
| tanviet12/vbsec @1b86c27 | 21-rule scanner for "vibe-coded" apps, bilingual reports, optional auto-fix | 323 | 2026-09-28 | MIT | **Skip** |

## Behaviour check summary

| Repo | Hooks | Network | Writes outside repo | Subagents | Other |
|---|---|---|---|---|---|
| claude-code-owasp | none | none | none | none | Pure prompt + references; ships evals |
| trailofbits (2 picks) | none in picks (3 other plugins have hooks) | `agentic-actions-auditor` can call `gh api` for remote workflows | none | none in picks | CC-BY-SA share-alike |
| defending-code harness | none; `.claude/settings.json` sets a tracking header (`anthropic-cyber-runbook`) | `gh api` advisories | `.threat-model-state/` checkpoints | yes (research swarm) | `AskUserQuestion`; "not maintained" |
| cc-safety-net | **PreToolUse on every tool** | none at runtime (GUI only checks GitHub stars) | logs to `~/.cc-safety-net/logs` | none | Installed via `npx`; README tells you to always use `@latest` |
| cloudflare | none | none | `~/security-audit-skill/<repo>/run-N` | yes, by design | Strict sandbox rules before running target code |
| pya | none | only with `--online` (osv, trufflehog, zizmor) or KEV refresh from cisa.gov | none | 9 agents per run | `disallowed-tools: WebFetch, WebSearch`; very careful about untrusted repos |
| bug-hunter | none | Context7 doc lookups | `.bug-hunter/` | Hunter/Skeptic/Referee | Node 22, ~35 scripts, npm/`npx` install from `main` tarball |
| agentguard | **SessionStart + Pre/PostToolUse on Bash, Write, Edit, WebFetch** | optional cloud policy and audit sync | global npm package | none | UTM links in reports, 1,400-line skill |
| ghostsecurity | none | **`curl -sfL …/main/scripts/install.sh \| bash`** for scanner binaries; exo fetches templates from ghostsecurity.ai | `~/.ghost/` | orchestrators may only use Task | MITM HTTPS proxy for DAST |
| vbsec | none | `--sca` queries OSV.dev | `vbsec-reports/` | yes on large repos | `--auto-fix` rewrites source |

## What changed in the kit (this PR)

| Change | Role | Why |
|---|---|---|
| Add `owasp-security` (vendored, adapted) | security-engineer **preloaded** | Single-agent review workflow with a strict "is it reachable and exploitable?" rubric and a finding format. Current to the 2025/2026 OWASP lists, including LLM and Agentic risks, which matter for any product that calls a model |
| Move `security-and-hardening` from preloaded to on demand | security-engineer | One security-review skill per role (adoption rule 3). It stays for writing a design note's required controls |
| Add `threat-modeling` (own rewrite) | security-engineer on demand | The security-engineer owns the threat model in `team/SECURITY.md` but had no method for it. Anthropic's skill is excellent but swarms subagents and interviews an owner; ours keeps its "threats, not bugs" test and STRIDE gap-fill, runs sequentially, and writes to SECURITY.md |
| Add `agentic-actions-auditor` (vendored, adapted) | security-engineer on demand | This kit's whole premise is AI agents with push rights, often triggered from GitHub. The skill catalogues 9 ways attacker text reaches an agent in CI (env-var intermediaries, `pull_request_target` checkouts, wildcard allowlists…). Adapted to audit the local checkout, since `gh api` is denied in our settings |
| Add `property-based-testing` (vendored, adapted) | developer and data-scientist on demand | Not a security skill, but the best pick in the Trail of Bits bundle for us: it fills the data-scientist "numerical validation" gap and fits CLAUDE.md's rule that calculations get checked against a reference (the "oracle" property). Adapted so that adding a PBT library is the tech lead's decision and generators are seeded |
| `team/SKILLS.md` | — | Sources, skills table, watching list (7 new rows) and Learning log updated |

This is four new skills, one over the weekly routine's cap of three, because the owner
asked for this round directly. The CLAUDE.md rule that skills change only through
the weekly routine is honoured in spirit: nothing changes until the owner merges.

## Repo by repo

### agamm/claude-code-owasp — Include
One 206-line SKILL.md plus four on-demand references (checklist, 20+ languages,
config and supply chain, a 1,100-line OWASP report). It reads well, cites the
current lists rather than the 2021 ones most material still uses, and its "Before
Reporting a Finding" rubric (attacker-controlled? reachable? blast radius? can the
attacker do every step?) is exactly the noise filter an unattended reviewer needs.
It ships five evals, including one that checks it does *not* flag safe code. No
scripts, hooks or network. Small and active (427 stars), so we pin and re-check
weekly. **Role:** security-engineer (preloaded).

### trailofbits/skills — Cherry-pick 2
The most credible source in the list, very active (pushed today, 155 open issues).
License is **CC-BY-SA-4.0**: we can copy and adapt, but our adapted copies must
stay CC-BY-SA with attribution, so each vendored folder keeps its LICENSE and the
"In this repo" note says so. Three plugins (`gh-cli`, `modern-python`, `fp-check`)
install hooks; we take none of them.
- **`agentic-actions-auditor`** → security-engineer, on demand. See above.
- **`property-based-testing`** → developer and data-scientist, on demand. See above.
- Watching: `supply-chain-risk-auditor` (good, but its scripts call OSV, deps.dev,
  npm, PyPI, Scorecard and GitHub; revisit if the day-3 audit needs more than
  `npm audit` / `pip-audit`), `insecure-defaults`, `differential-review`,
  `sharp-edges`, `fp-check` (overlap owasp-security or need subagents),
  `mutation-testing` (needs mewt/muton installed).
- Skip: smart-contract, C/C++, binary, YARA and Burp plugins until a product needs them.

### anthropics/defending-code-reference-harness — Own rewrite (threat-model)
Apache-2.0 (the API shows NOASSERTION, but the LICENSE file is Apache 2.0). The
README says the repo **is not maintained**, so we shouldn't pin to it and expect
updates. Its skills are thoughtful but built for a person at the keyboard
(`AskUserQuestion`, interview mode) and for subagent swarms (`vuln-scan`,
`threat-model` bootstrap). The autonomous pipeline executes target code and
requires a gVisor sandbox. Its repo settings also set an
`ANTHROPIC_CUSTOM_HEADERS` tag; we copy nothing from `.claude/settings.json`.
We wrote our own `threat-modeling` skill crediting it. `triage` (1,000 lines) and
`patch` (630 lines) are too large and interactive for our gates.

### kenryu42/cc-safety-net — Needs you
Not a skill: a PreToolUse hook that parses each Bash command (through `bash -c`,
wrappers and reordered flags) and blocks `git push --force`, `git push --delete`,
`git branch -D`, `git reset --hard`, `rm -rf` on dangerous paths, `curl | bash`,
and reads of `.env`, SSH keys and cloud credentials. That is our "Hard rules for
every agent" enforced by code instead of by prompt. Our `.claude/settings.json`
deny list does some of this, but deny rules are prefix matches. For example, we
allow `Bash(git -C:*)`, and `git -C . push --force …` doesn't start with any
denied prefix (logged in Findings below; not tested live).

The catches: it runs on **every** tool call, it is installed with `npx` from npm
(the README says to always use `@latest`, which is the auto-update pattern we
avoid), and it logs to `~/.cc-safety-net/logs`. No telemetry found in the source.
If adopted, pin an exact version (`npx -y cc-safety-net@2.7.3`) in
`.claude/settings.json` and commit a `.cc-safety-net/` policy so cloud runs get
the same rules. Changing `.claude/settings.json` is the owner's call, so this PR
does not do it.

### cloudflare/security-audit-skill — Skip for now
The most rigorous audit method in the set: coverage ledger, independent
verifiers that try to disprove each candidate, a JSON schema plus zero-dependency
validators, and strict sandbox rules before any target code runs. But the full
audit is built on subagent fan-out and writes to `~/security-audit-skill/`, and
its guidance mode overlaps owasp-security. Revisit if we add a periodic full-audit
lane that the scrum master orchestrates (the scrum master can spawn; specialists
can't). Its `AI-AND-LLM.md` and `SUPPLY-CHAIN-AND-RELEASE.md` are good reading for
the security-engineer.

### AgriciDaniel/pya — Skip for now
Very well built for safety: read-only agents, `disallowed-tools: WebFetch,
WebSearch`, offline unless `--online`, and it treats the audited repo's
CLAUDE.md as a possible attacker. But one run spawns nine agents plus a
verifier, which breaks our one-level rule from inside the security-engineer, and
it covers the same ground as owasp-security. Same revisit condition as Cloudflare.
Its `references/agentic-security.md` (agent configs, hooks, MCP servers) is a
good candidate to fold into our skill-review checklist later.

### codexstar69/bug-hunter — Skip
Interesting adversarial design (a Skeptic tries to refute each Hunter claim; only
a Referee confirms) and honest benchmarks, but it is really an application: Node
22, ~35 scripts, state in `.bug-hunter/`, Context7 lookups over the network, and
install instructions that pull the `main` tarball with `npx`. Our pipeline already
has the adversarial shape (developer → code-reviewer → specialists → QA), and
owasp-security's triage rubric covers the "disprove before reporting" idea.

### GoPlusSecurity/agentguard — Skip
A runtime guard that hooks SessionStart and every Bash, Write, Edit and WebFetch
call, auto-scans installed skills, and can sync policy and redacted audit logs to
GoPlus cloud. Heavy, Web3-oriented, and its reports carry UTM marketing links. If
we want a runtime guard, cc-safety-net does the job with far less surface.

### ghostsecurity/skills — Skip
The riskiest install in the set: the skills install their scanner binaries by
piping `install.sh` from the `main` branch into bash (unpinned, unverified), write
to `~/.ghost/`, and include a MITM HTTPS proxy for live validation. The
orchestrators may only call the Task tool, so every step is a subagent. The `exo`
plugin drives a vendor workflow platform. Revisit only if the binaries become
pinned by version and checksum.

### tanviet12/vbsec — Skip
Decent rule set for common web bugs, but the prompts are mostly Vietnamese, it
overlaps owasp-security, `--auto-fix` rewrites source files, and `--sca` goes
online. owasp-security covers what we need.

## Role-by-role changes

| Role | Before | After |
|---|---|---|
| security-engineer | P: security-and-hardening | P: owasp-security; D: threat-modeling, agentic-actions-auditor, security-and-hardening (gains the `Skill` tool) |
| developer | — | D: property-based-testing |
| data-scientist | no skills | D: property-based-testing (gains the `Skill` tool and a `## Skills` section) |
| everyone else | — | no change |

## Security pass on what we vendored

Diffed each vendored folder for prompt injection, instructions to push, merge,
force-push, read `.env` or widen permissions, and for network calls, hooks and
scripts. Only SKILL.md files, reference docs and LICENSEs were copied. Trail of
Bits' `agents/openai.yaml` and `assets/` were left out. Nothing failed. The one
network-capable instruction (`gh api` in agentic-actions-auditor) is already denied
by our settings, and the adaptation note tells the agent not to work around that.

## Needs you

1. **cc-safety-net as a pinned hook?** It would mechanically enforce the team's
   hard rules (no force-push, no branch deletion, no `.env` reads). Recommended,
   pinned to an exact version, as a follow-up PR that changes `.claude/settings.json`.
2. **Full-audit lane later?** If you want a periodic deep audit (for example once
   per sprint at refinement), Cloudflare's skill run by the scrum master is the
   best candidate. Not needed yet.

## Findings
- `.claude/settings.json` allows `Bash(git -C:*)`, and the deny list matches on
  prefixes, so `git -C . push --force …` or `git -C . branch -D …` may get past
  the force-push and branch-deletion denies. Not tested live. Fixed either by
  cc-safety-net or by narrowing the `git -C` allow.

## Update 2026-11-05
The owner chose to adopt cc-safety-net. The follow-up PR runs it as a PreToolUse hook
through `.claude/hooks/cc-safety-net.sh`, which installs version 2.7.3 once per
machine after checking the npm tarball's sha512. It also removes the
`Bash(git -C:*)` allow. Tested: `git -C . push --force` and `git -C . branch -D`
are blocked by the hook's built-in rules. The team's custom rule for pushes to
`main` does not see through `git -C` or `python -c`, so GitHub branch protection
on `main` (team/SETUP.md step 3) stays the real backstop.
