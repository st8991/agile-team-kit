---
name: ux-laws-and-motion
description: Twenty principles for how an interface moves and how people use it - the twelve classic animation principles applied to UI motion, and eight UX laws (Fitts, hit areas, Hick, Miller, Doherty, Postel, Jakob, frequency of use). Each has how to apply it in a spec or build and how to check it in review. Use when specifying, building or reviewing any screen, component, interaction or animation.
---

# UX laws and motion

Our own wording. The animation ideas come from the twelve principles of animation
described by Frank Thomas and Ollie Johnston in *The Illusion of Life* (1981),
translated here from character animation to interface motion. The UX laws are
published research and long-standing heuristics, named after the people who
described them. The list of twenty was suggested by a "20 Principles of UX &
Animation" chart the owner shared; none of that chart's text is copied.

Where this skill differs from `team/UX.md`, CLAUDE.md or team/TEAM.md, those win.
Numbers below are defaults: if `team/UX.md` sets its own (durations, easing,
target sizes), use those.

## How to use it

Every principle has three parts:
- **Means**: the idea in one or two lines.
- **Apply**: what to write in a UX spec or build in code.
- **Check**: what a reviewer looks for. Checks marked **[blocking]** are failures
  in a ux-designer branch review; the rest are suggestions.

Motion is a tool for explaining change, not decoration. Before adding any
animation, finish this sentence: "Without it, the user would not notice / would
not understand ___." If you can't, leave it out (see `unslop-ui` #20).

### Motion defaults (unless team/UX.md overrides)

| Kind | Duration | Easing |
|---|---|---|
| Press, hover, toggle, focus (micro) | 80–150 ms | ease-out |
| Element enters (menu, toast, popover) | 150–250 ms | ease-out (decelerate) |
| Element leaves | 100–200 ms, shorter than its entrance | ease-in (accelerate) |
| Element moves or resizes on screen | 200–350 ms | ease-in-out |
| Screen or large panel transition | 250–400 ms | ease-in-out |
| Continuous (spinner, progress, indeterminate bar) | looped | linear |

- Animate `transform` and `opacity`. Animating `width`, `height`, `top`, `left`
  or `box-shadow` on large elements drops frames.
- **[blocking]** Honour `prefers-reduced-motion: reduce`: replace movement,
  scaling and parallax with an instant change or a short fade. Nothing essential
  may exist only in the animation.
- **[blocking]** Nothing flashes more than three times a second (WCAG 2.3.1).
- Motion never delays input: the user can click the next thing while a
  transition is still playing.

---

## Part A · Animation principles for interfaces

### 1. Squash and stretch
**Means:** objects that deform a little when they hit, press or land feel
physical and responsive. Their volume stays the same.
**Apply:** a pressed button scales to 0.96–0.98 and back; a toggle knob stretches
slightly along its travel; a dropped card compresses for one frame. Keep it subtle
on productivity screens, livelier on playful or consumer products.
**Check:** deformation is under ~5% on work screens, never distorts text
legibility, and is turned off under reduced motion.

### 2. Anticipation (wind-up)
**Means:** a small preparatory move tells the user something is about to happen,
so the main action doesn't surprise them.
**Apply:** a drawer handle shifts a few pixels on hover before it opens; a
destructive "hold to delete" fills before firing; a pull-to-refresh shows tension
before it triggers. Hover and focus states are anticipation: every interactive
element has one.
**Check:** every clickable element has a visible hover and focus state; long or
irreversible actions show what is about to happen before it happens.

### 3. Staging the focus
**Means:** present one idea at a time so the user's eye goes exactly where it
should.
**Apply:** when a modal opens, dim the page behind it; when a step completes,
move focus (visual and keyboard) to the next step; only one element animates at a
time in a given area. In a spec, name the single focal point of each state.
**Check:** in each screenshot, one element is clearly the focus; no two things
compete with simultaneous motion; keyboard focus lands on the new focal element
**[blocking when focus is lost or trapped behind a modal]**.

### 4. Pose to pose
**Means:** design the key states first (start, end, maybe one in between), then
let the transition interpolate them. The opposite, "straight ahead", improvises
frame by frame.
**Apply:** in the UX spec, list the states of each animated component (closed,
opening, open, error) and what changes between them. Build transitions as CSS
transitions or keyframes between those named states, not ad hoc JS tweaks.
**Check:** every animated component has its end states designed and usable
without the animation; the code maps to named states (`data-state="open"`,
classes or variants), not scattered inline style changes.

### 5. Follow through and overlapping action
**Means:** parts don't all stop at the same instant. Things settle, trailing parts
arrive slightly later, and that reads as natural.
**Apply:** a list's items enter with a 20–40 ms stagger (cap the total at ~300 ms
however long the list); a sheet overshoots by a few pixels and settles; a badge
pops after its container lands.
**Check:** staggers don't make the user wait: the last item is in place within
~400 ms; overshoot is small enough not to look like a bug.

### 6. Slow in and slow out
**Means:** real objects accelerate and decelerate. Linear motion looks mechanical.
**Apply:** use the easing table above. Entrances decelerate (they arrive and
rest), exits accelerate (they get out of the way), on-screen moves ease both ways.
Put the curves in `team/UX.md` as tokens (`--ease-out`, `--ease-in-out`).
**Check:** no `linear` easing except on continuous loops; easing comes from tokens,
not a different cubic-bezier in every file.

### 7. Moving in arcs
**Means:** natural movement follows curves, not perfectly straight lines.
**Apply:** an item flying to a cart or a floating action button expanding into a
sheet moves on a gentle arc (animate x and y with different easings, or use a
motion path). Use it for large, travelling moves only; small UI shifts stay
straight.
**Check:** long-distance moves don't slide stiffly across the screen; short moves
don't wobble.

### 8. Secondary action
**Means:** a smaller motion supports the main one and adds meaning without
stealing attention.
**Apply:** when a message sends (main action), the send icon tilts or the counter
ticks (secondary); when a file uploads, the row expands while a check mark draws.
**Check:** the secondary motion is visibly smaller and later than the main one,
and removing it loses no information.

### 9. Snappy timing
**Means:** timing carries weight and mood. Interfaces should feel quick: slow
motion feels like lag.
**Apply:** use the duration table; scale duration with distance and size (a
tooltip is faster than a full-screen panel). Frequent interactions get the
shortest timings, or none.
**Check:** no UI transition over ~400 ms unless it is a deliberate one-time moment
(onboarding, success celebration); repeated actions (typing, tab switching, list
navigation) feel instant.

### 10. Exaggerated feedback
**Means:** push important feedback a little past realistic so it can't be missed.
**Apply:** an invalid password field shakes briefly (2–3 cycles, ~300 ms) and
shows the message; a success state gets a clear check animation; a counter that
changes pulses once. Pair every exaggerated motion with text or an icon so it is
not motion-only.
**Check:** errors and successes are noticeable in a screenshot as well as in
motion; exaggeration is reserved for things that matter (not every hover).

### 11. Solid drawing (depth and volume)
**Means:** objects should feel like they have consistent form, weight and
lighting, even in a flat UI.
**Apply:** define an elevation scale in `team/UX.md` (e.g. 0 page, 1 card,
2 dropdown, 3 modal) with one shadow per level and one implied light source
(usually top). Higher elevation sits above lower in both shadow and z-index. 3D
transforms keep a consistent perspective.
**Check:** shadows all point the same way; a popover never has a smaller shadow
than the card it sits on; z-index order matches elevation; no random one-off
shadows.

### 12. Overall appeal
**Means:** the sum of the details: the interface is pleasant, coherent and has a
clear personality the user can trust.
**Apply:** one motion personality per product, written in `team/UX.md` (calm and
precise, or bouncy and playful), applied everywhere. Run `unslop-ui` before
calling a screen finished.
**Check:** motion, type, colour and copy feel like one product; nothing looks
borrowed from a different design language.

---

## Part B · UX laws

### 13. Fitts's law
**Means:** the time to hit a target depends on its distance and its size. Big,
close targets are fast; small, far ones are slow and error-prone.
**Apply:** put the primary action near where the user's attention or pointer
already is (end of the form, beside the selection); make frequent targets larger;
use screen edges and corners for menus on desktop; keep destructive actions away
from frequent ones.
**Check:** primary actions sit at the end of the flow they complete; "Delete" is
not next to "Save"; on mobile, primary actions are within thumb reach (lower half).

### 14. Bigger hit areas
**Means:** the clickable area can and often should be larger than the visible
element.
**Apply:** minimum target 24 × 24 CSS px with spacing (WCAG 2.2 SC 2.5.8, AA);
aim for 44 × 44 px on touch screens. Grow the hit area with padding or a
`::before` overlay, not by making the icon bigger. Make whole rows and cards
clickable when they lead to one place; link the label to its checkbox or radio.
**Check:** **[blocking]** any interactive target under 24 × 24 px without enough
spacing. Measure with Playwright
(`el.getBoundingClientRect()`) or the browser's element inspector, at 375 px wide.

### 15. Hick's law
**Means:** the more options presented at once, the longer it takes to choose.
**Apply:** show the few common choices and tuck the rest behind "More" or a
search; pick a sensible default; split long forms into steps; recommend one plan
or option. In the spec, say which options are primary and which are disclosed
progressively.
**Check:** no toolbar, menu or settings page shows a flat list of a dozen
equal-weight choices; each decision point has a default or a recommended option.

### 16. Miller's law
**Means:** working memory holds only a handful of items (often quoted as 7 ± 2;
newer research suggests nearer 4). Don't make people remember; chunk information.
**Apply:** chunk long numbers (card numbers, codes, phone numbers) with spaces;
group navigation and settings into labelled sections of a few items; keep the
information needed for a decision on the same screen instead of making users
remember it from the last one.
**Check:** long identifiers are chunked for display (and still copy cleanly);
users never need to carry a value from one screen to the next in their head. Not
a hard cap of seven items: a long list the user scans, not memorises, is fine.

### 17. Doherty threshold
**Means:** productivity soars when the system responds in under ~400 ms. Beyond
that, attention drifts.
**Apply:** acknowledge every input within 100 ms (pressed state, spinner,
optimistic update). For work over ~400 ms, show progress: a skeleton matching the
final layout, a determinate bar when the length is known. Use optimistic UI for
safe, reversible actions (likes, toggles, reordering) with rollback on failure.
Avoid spinner flashes: wait ~300 ms before showing one, then keep it at least
~500 ms. Pairs with `unslop-ui` #19.
**Check:** **[blocking]** an action that takes over 1 s with no visible
feedback. Throttle the network in Playwright (`page.route` with a delay, or CDP
network conditions) and check each async action shows a pending state and
blocks double-submit.

### 18. Postel's law
**Means:** be liberal in what you accept from users, conservative in what you show
back.
**Apply:** accept phone numbers with spaces, dashes or brackets; dates in common
formats; pasted values with stray whitespace; email in any case. Normalise on the
way in, then display one consistent format (the formatting rules in
`team/UX.md`). Validate on blur or submit, not on every keystroke, and say how to
fix it.
**Check:** try two or three reasonable input variants per field (leading spaces,
different separators, upper case); none is rejected when the meaning is clear;
error messages say what format works.

### 19. Jakob's law
**Means:** users spend most of their time on other products, so they expect yours
to work the same way.
**Apply:** use conventional placements and patterns: logo top-left links home,
search at the top, cart top-right, settings under the avatar, standard form
controls, underlined or clearly coloured links, Escape closes dialogs. Innovate
on what makes the product different, not on basic controls.
**Check:** no custom control where a native one works (custom select, checkbox or
scrollbar needs a reason in the spec); keyboard conventions work (Tab order,
Enter submits, Escape closes, arrow keys in menus).

### 20. Frequency of use
**Means:** design for what people do most. Frequent actions get the prime
position and the fewest steps; rare ones can live deeper.
**Apply:** in the spec, rank the actions on each screen by expected frequency
(from `team/PRODUCT.md` or analytics). Top actions get visible buttons and
keyboard shortcuts; rare and dangerous ones go in an overflow menu or settings.
Remember the user's last choice where it is safe to.
**Check:** the most frequent task on a screen takes the fewest clicks and needs no
menu; rare settings don't crowd the main view.

---

## Using this in the team

| Role | When | Use |
|---|---|---|
| ux-designer | Grooming | Turn relevant principles into UX acceptance criteria (e.g. "every async action shows a pending state within 100 ms"). |
| ux-designer | Design review | In `team/ux/<story>.md`, list each component's key states (#4), focal point (#3), motion (duration and easing tokens), action ranking (#20) and target sizes (#14). |
| ux-designer | Branch review | Run the **Check** lines for the principles the story touches; **[blocking]** items go under Blocking. |
| developer | Building a `Specialists: ux` ticket | Follow the spec; where it is silent, use the motion defaults and the Apply lines. |
| qa-engineer | Testing a `Specialists: ux` ticket | Run #14 and #17 checks with Playwright: target sizes at 375 px and pending states under a throttled network. |

Report principle numbers in findings so they're traceable, for example
`Blocking: - Settings › icon buttons 18×18 px (#14) → pad to 24×24`.
