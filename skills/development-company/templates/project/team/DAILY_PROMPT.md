# The daily scheduled prompt

This is the exact text the scheduled task sends each morning. `<OWNER>/<REPO>` is
filled in when the task is created (`/development-company schedule` does this for you).

---

Run the daily sprint for the GitHub repo <OWNER>/<REPO>.

1. Clone or update the repo, then work from its root so CLAUDE.md and the
   project's `.claude/settings.json` are loaded. The team's agents
   (`development-company:<role>`) come from the development-company plugin: the
   settings file enables it on machines where it's installed, and cloud sessions get
   it from the owner's Claude account.
   If the `development-company:*` agents are not available, stop and report that the plugin
   is not installed in this environment.
2. Run `/development-company run`. If slash commands aren't available, do what it does:
   check out the `team-state` branch if it exists (otherwise create it from
   `develop`, or from `main` if develop doesn't exist yet); you are the Scrum
   Master; follow the daily loop in team/TEAM.md exactly: recover → standup →
   owner input → plan → build loop → wrap.
3. Spawn the specialist agents by their plugin names; don't do their work
   yourself. Checkpoint team/ to the `team-state` branch after every ticket.
4. Never push to or merge into `main`. Never force-push or delete branches.
5. Keep going until project-manager says STOP, the board is empty, or you run out
   of usage. Before stopping for any reason you can foresee, run the wrap step
   (integrator PR, then reporter).
6. Finish by stating the path of today's report and its "Needs you" items.
