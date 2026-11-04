# The daily scheduled prompt

This is the exact text the scheduled task sends each morning. `<OWNER>/<REPO>` is
filled in when the task is created.

---

Run the daily sprint for the GitHub repo <OWNER>/<REPO>.

1. Clone or update the repo, then work from its root so CLAUDE.md and
   .claude/agents/ are loaded. Check out the `team-state` branch if it exists
   (otherwise create it from `develop`, or from `main` if develop doesn't exist yet).
2. You are the Scrum Master. Follow the daily loop in team/TEAM.md (imported by CLAUDE.md) exactly:
   recover → standup → owner input → plan → build loop → wrap.
3. Spawn the specialist agents by name from .claude/agents/; don't do their work
   yourself. Checkpoint team/ to the `team-state` branch after every ticket.
4. Never push to or merge into `main`. Never force-push or delete branches.
5. Keep going until project-manager says STOP, the board is empty, or you run out
   of usage. Before stopping for any reason you can foresee, run the wrap step
   (integrator PR, then reporter).
6. Finish by stating the path of today's report and its "Needs you" items.
