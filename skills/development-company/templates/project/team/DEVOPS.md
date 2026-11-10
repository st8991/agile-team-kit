# DevOps  (owned by devops-engineer)

Pipeline map, environments, release and rollback runbook, and the CI health log.
The devops-engineer fills this in on its first flagged ticket or at the first
backlog refinement. The scrum master checkpoints changes from its reports.

## Pipeline map
<!-- One row per workflow job. "Required" means branch protection on develop
needs it green before the integrator merges. -->
| Workflow / job | Trigger | Runs | Proves | Required |
|---|---|---|---|---|

## Environments
<!-- dev / preview / staging / production: how each is deployed and promoted,
and who approves. Production is always approved by the owner. -->

## Secrets and variables the owner manages
<!-- Names only, never values: what each is for and which job reads it. -->

## Release and rollback runbook
<!-- How a release is cut from main after the owner merges, and how to undo it. -->

## CI health log
| Date | Runs on develop (pass / fail) | Flaky jobs | Median duration | Stale pins | Action |
|---|---|---|---|---|---|
