# Changelog

## 0.2.0 · 2026-11-15

- Two new team skills, written by us: `ux-laws-and-motion` (twelve animation
  principles for UI motion plus eight UX laws: Fitts, hit areas, Hick, Miller,
  Doherty, Postel, Jakob, frequency of use) and `unslop-ui` (twenty fixes that
  stop interfaces looking AI-generated). Every principle has how to apply it and
  a check, with the failures that block a review marked.
- ux-designer preloads both and uses them for UX criteria, specs and its branch
  review. Developers load them on UX-flagged tickets; QA loads
  `ux-laws-and-motion` to check target sizes and loading feedback.
- `team/UX.md` template gains Motion and Interaction sections. Run
  `/development-company templates` to see the change in an existing project.
- Includes 0.1.1, the 2026-11-15 weekly skill update: `modernize` for the
  developer, six addyosmani skills and ui-ux-pro-max re-pinned.

## 0.1.0 · 2026-11-08

First release as a Claude plugin. Until now this repo was a kit you copied into
your project; it is now the plugin and its own marketplace.

- Installs from your Claude account (Customize → Plugins → Add marketplace) or from
  Claude Code's `/plugin`.
- `/development-company` command: `setup`, `run`, `sync`, `status`, `schedule`, `templates`.
- 13 agents ship in the plugin (`development-company:<role>`); 42 team skills ship in the
  plugin with their licenses and notices, no longer copied into projects.
- The cc-safety-net hook ships in the plugin and only acts in projects that
  `/development-company setup` initialised.
- Projects keep `team/`, `CLAUDE.md`, `.claude/settings.json` (now enables the
  plugin) and `.cc-safety-net/`.
- Includes the 2026-11-08 weekly skill update: i-have-adhd for the reporter,
  ui-ux-pro-max re-pinned to 4f2dbb6.
- New "Team settings" in `team/CONVENTIONS.md` for max lanes and model overrides,
  since adopters no longer edit agent files.
- Safety-hook policy template drops the project-level `audit` key, which
  cc-safety-net ignores at project scope and warned about on every blocked command.
