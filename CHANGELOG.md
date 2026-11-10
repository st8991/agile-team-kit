# Changelog

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
