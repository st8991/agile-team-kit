# Weekly product sync

Your weekly meeting with the product manager. Every Monday's run adds a new file
here, named `YYYY-MM-DD.md`. Read it, then write your answers under
**Owner decisions** at the bottom (edit it on GitHub).
The next run applies them to the backlog and logs lasting decisions in
`team/PRODUCT.md`. Want to talk it through live instead? Open a Claude session
on the repo and say "Product sync".

Planning levels: **Epic** (roadmap item, e.g. E3 Reporting) → **Feature**
(something you can see and name, e.g. F-21 CSV export) → **Story** (one
sprint-sized slice of a feature, e.g. S-026).

---

## Template (product-manager fills everything except Owner decisions)

```
# Product sync · YYYY-MM-DD · Sprint NN day D/5

## Since last sync (completed)
- F-nn <feature> — Done. You can now <what the owner can do>. (S-0xx, S-0xx · N pts)
- S-0xx <story> — <one line> (feature F-nn, still in progress)

## In progress
Sprint goal: <goal> · <done>/<committed> pts · On track | At risk: <why>
- S-0xx <story> — <status> (F-nn)

## Roadmap
| Epic | Done | Next feature |
|---|---|---|
| E1 Foundation | 80% | F-nn <name> |

## Recommendations
- **Next story:** S-0xx <title> (N pts). Why: <value/dependency/risk>. Alternative: S-0xx <title>.
- **Next feature:** F-nn <name> (≈N pts, S-0xx–S-0xx). Why: … Alternative: F-nn <name>.
- **Next epic:** E<n> <name>. Why: … Alternative: E<n> <name>.
- Owner-only: <anything that changes a CLAUDE.md decision or costs money, else "none">

## Questions for you
1. <question>? Recommended: <answer>.

## Owner decisions
<!-- Write one line per decision, e.g.
- Agree with next story / feature / epic.
- Next epic should be E6 before E5.
- Q1: yes.
The product manager marks each line [applied → ...] on the next run. -->
```
