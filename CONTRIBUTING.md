# Contributing

Thanks for helping improve the kit. It gets better from real use, so reports from
projects that run it are the most valuable thing you can send.

## Ways to help

- **Report a problem** with the process, an agent or a guardrail: open an issue.
  Say what the team did, what you expected, and paste the relevant lines from the
  daily report or standup (remove anything private first).
- **Skill feedback:** a vendored skill helped or got in the way. Open an issue
  with the `skill-feedback` template. The weekly skill-research routine reads
  these.
- **Skill request:** a skill repo you think the team should use. Open an issue
  with the `skill-request` template.
- **Pull requests** for fixes and improvements. Open an issue first for anything
  larger than a typo, so we can agree on the approach.

## What a good change looks like

The kit is prompts and process, so a change is judged by how agents and adopters
will read it:

- **One source of truth per rule.** The process lives in `team/TEAM.md`; an
  agent file says how that role does its part. Don't restate a rule in two
  places; point to it.
- **Keep the guardrails.** No change may weaken the `deny` list in
  `.claude/settings.json`, the safety hook, the "nobody pushes to `main`" rule or
  the review and QA gates. Proposals to change them need a clear reason and will
  get a careful review.
- **One level of delegation.** Agents never spawn agents; the scrum master does.
- **Unattended by default.** The daily run has no human present. Anything
  interactive belongs in a live session (like the product sync), and questions
  for the owner go to "Needs you".
- **Plain words.** Short sentences, full words, no jargon a new adopter must
  decode. Templates in `team/` stay templates: no project data.
- **Test it.** Run at least one `Run the daily sprint` session on a scratch repo
  with your change, and say in the PR what you saw.

## Vendored skills

Skills in `.claude/skills/` change only through the process in
[`team/SKILLS.md`](team/SKILLS.md):

- Copy a skill at a pinned commit, never a branch, and keep its `LICENSE` and
  any `NOTICE` in the folder.
- Only copy skills under a license that allows redistribution (MIT, Apache-2.0,
  BSD, CC BY or CC BY-SA). For a source with no license, write your own version
  from the ideas instead of copying text.
- Record any change as an "In this repo" note under the frontmatter, and add a
  `NOTICE` that states your changes when the license requires it (Apache-2.0,
  CC BY-SA).
- Update the registry in `team/SKILLS.md` and the table in
  `THIRD_PARTY_NOTICES.md` in the same PR.
- Say in the PR what the skill can do on a machine: scripts, network calls,
  hooks, telemetry. Skills that install binaries with `curl | bash`, phone home,
  or nest subagents won't be accepted.

## Pull request checklist

- [ ] The PR says what changed, why, and what you tested.
- [ ] No secrets, tokens, personal data or details from your own project.
- [ ] `team/` files are still generic templates.
- [ ] New or changed skills: registry and notices updated, license allows it.
- [ ] Docs updated (`README.md`, `docs/GETTING_STARTED.md`, `team/SETUP.md`) if
      adopters need to do something differently.

## License of contributions

By submitting a contribution, you agree it is licensed under the repository's
[MIT License](LICENSE), except changes inside a vendored skill's folder, which
are licensed under that skill's own license.

## Security

Please don't open a public issue for a way to get an agent past the guardrails
(pushing to `main`, reading secrets, running destructive commands). Use GitHub's
"Report a vulnerability" button on the Security tab of this repo instead.
