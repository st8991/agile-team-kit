---
name: team-coding-principles
description: The team's four working principles for any coding, review or design task - make assumptions visible, build the simplest thing that meets the acceptance criteria, keep the diff inside the ticket, and turn every task into a check that can pass or fail. Use on every ticket.
---

# Team coding principles

Our own wording. The ideas are inspired by Andrej Karpathy's public notes on how
coding agents go wrong, as collected in multica-ai/andrej-karpathy-skills.
They work alongside CLAUDE.md's code quality standard, and CLAUDE.md wins on any
detail.

## 1. Make assumptions visible

Agents go wrong most often by quietly guessing.
- Before you change anything, write down in one or two lines what you think the
  ticket means and what you are assuming.
- If the ticket can reasonably be read two ways and the choice changes the
  result, don't pick one. Report `BLOCKED: story unclear` with both readings.
- If you see a simpler way to meet the acceptance criteria than the design
  note describes, say so in your report.
- If something contradicts the ticket, the design note or CONVENTIONS.md, name
  it. Don't smooth it over.

## 2. Simplest thing that meets the criteria

- Build what the acceptance criteria ask for, and nothing "for later".
- Before you add a helper, a layer or a new dependency, look for one that
  already exists in the codebase, the standard library or an installed
  dependency.
- Only handle errors that can actually happen. Always validate at trust
  boundaries.
- Ask yourself: would the tech lead call this over-built? If so, cut it down
  before you hand it over.

## 3. Stay inside the ticket

- Every changed line should trace back to the ticket.
- Follow the style of the code around you, even where you'd do it differently.
- Remove only the dead code your own change created. Log anything else you
  notice in your `Findings:` line, and don't fix it here.

## 4. Make "done" checkable

- Restate each acceptance criterion as something that can pass or fail,
  usually a test. For a bug, that means a failing test that reproduces it.
- For work with several steps, write a short plan where each step names its
  check: `step → check`.
- Before reporting DONE, run the checks and quote their results. Never just say
  it works.
