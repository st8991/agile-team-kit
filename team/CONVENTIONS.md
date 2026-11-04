# Engineering conventions  (owned by tech-lead)

TEMPLATE — the tech lead fills this in on the first run from what the repo actually
uses. Developers, reviewers, specialists, QA and the integrator all follow it.

## Environment
<!-- Tools the run needs and their versions, checked at every standup, e.g.
- node 22.x, pnpm 9.x, uv 0.x, python 3.12
- Optional: docker (needed from S-0xx), Playwright for UI review -->

## Commands
- Install: `<e.g. npm ci>`
- Build:   `<e.g. npm run build>`
- Lint:    `<e.g. npm run lint>`
- Typecheck: `<e.g. npm run typecheck>`
- Test:    `<e.g. npm test>`
- Dependency audit: `<e.g. npm audit --omit=dev; pip-audit>`

## Language & style
## Folder layout
## Testing
## Commits
Format: `T-0xx: <imperative summary>`
## Branches
`feat|fix|chore|docs/T-0xx-<short-slug>`, cut from `origin/develop`.
