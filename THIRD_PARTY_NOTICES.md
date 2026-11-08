# Third-party notices

The kit's own files (agents, `team/`, `CLAUDE.md`, docs, the hook wrapper and the
two own-rewrite skills) are under the MIT License in [`LICENSE`](LICENSE).

Most folders in `.claude/skills/` are copied from other people's repositories.
**Each of those keeps its own license**, which sits in the skill's folder as
`LICENSE` or `LICENSE.txt`, sometimes with a `NOTICE`. The repo's MIT License
does not replace them. When you copy the kit into your project, copy those files
with the skills.

Pinned commits, roles and the full list of our changes are in
[`team/SKILLS.md`](team/SKILLS.md). "Changed" below means we added an
"In this repo" note under the skill's frontmatter or removed a file; the body is
otherwise upstream's text.

## Skills by license

### MIT

| Skills | Copyright | Source |
|---|---|---|
| api-and-interface-design, browser-testing-with-devtools, ci-cd-and-automation, code-review-and-quality, documentation-and-adrs, planning-and-task-breakdown, security-and-hardening, shipping-and-launch, spec-driven-development, test-driven-development | Addy Osmani | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) @301b02b |
| chief-of-staff, diagnosing-bugs, domain-modeling, grill-with-docs, grilling, improve-codebase-architecture, retro, to-spec, to-tickets | Matt Pocock | [mattpocock/skills](https://github.com/mattpocock/skills) @4ae2317 |
| receiving-code-review, systematic-debugging, verification-before-completion, writing-skills | Jesse Vincent | [obra/superpowers](https://github.com/obra/superpowers) @22f0b46 |
| ponytail, ponytail-review | DietrichGebert | [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) @96608e0 |
| ui-ux-pro-max | Next Level Builder | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) @4f2dbb6 |
| design-taste-frontend | Leonxlnx | [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) @12af471 |
| owasp-security | agamm (the upstream LICENSE names no holder; see the skill's NOTICE) | [agamm/claude-code-owasp](https://github.com/agamm/claude-code-owasp) @1ae29cb |
| i-have-adhd | Ayoub Ghriss | [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) @1ecea19 |
| diagnose-ci-gate, github-actions-efficiency, github-actions-hardening, multi-stage-dockerfile | GitHub, Inc. | [github/awesome-copilot](https://github.com/github/awesome-copilot) @9654314 |

`writing-skills`: upstream ships `references/anthropic-best-practices.md`, a copy
of a page from Anthropic's documentation. We removed it and link to the page
instead, because that text is Anthropic's and not covered by the MIT grant.

`design-taste-frontend` lists photographs served by Lorem Picsum from Unsplash
(used under the Unsplash License) and links to public websites as references. It
contains no images; it stores URLs and photographer names.

### Apache License 2.0

| Skills | Copyright | Source | Changes |
|---|---|---|---|
| mcp-builder, webapp-testing | Anthropic, PBC | [anthropics/skills](https://github.com/anthropics/skills) @ca45fc4 | none |
| skill-creator | Anthropic, PBC | same | changed: "In this repo" note added (see the skill's NOTICE) |
| investigate-first, verify-and-stop | Julius Brussee | [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) @2e068f7 | none; upstream NOTICE kept |

### Creative Commons Attribution-ShareAlike 4.0 (CC BY-SA 4.0)

| Skills | Creator | Source | Changes |
|---|---|---|---|
| agentic-actions-auditor, property-based-testing | Trail of Bits | [trailofbits/skills](https://github.com/trailofbits/skills) @470419e | changed: "In this repo" note added |

These two adaptations stay under CC BY-SA 4.0 (see each skill's `LICENSE` and
`NOTICE`). If you change them further, your version must stay under CC BY-SA 4.0
too. ShareAlike applies only to these two folders, not to the rest of the kit or
to the code your team writes.

## Own work under the kit's MIT License

| Skill | Note |
|---|---|
| team-coding-principles | Own rewrite of ideas from [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills), which declares no license; no text copied |
| threat-modeling | Own rewrite of ideas from [anthropics/defending-code-reference-harness](https://github.com/anthropics/defending-code-reference-harness); no text copied |

## Tools downloaded at run time (not redistributed)

| Tool | License | How |
|---|---|---|
| [cc-safety-net](https://github.com/kenryu42/cc-safety-net) 2.7.3 | MIT | `.claude/hooks/cc-safety-net.sh` fetches the npm package once per machine and checks its sha512. The kit ships only its own wrapper and rule files. |
