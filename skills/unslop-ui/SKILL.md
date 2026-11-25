---
name: unslop-ui
description: Twenty fixes that make an AI-built interface look deliberately designed instead of generic - cut filler badges, redundant labels, random italics and stray monospace; use the design system; show the real product; build hierarchy, spacing, contrast, CTA emphasis and one accent colour; get radii, icons, headline wrapping, optical alignment and tabular numbers right; add loading states and useful motion. Each fix has how to spot it and a check. Use when building, polishing or reviewing any UI, page or component.
---

# Unslop UI

Our own wording. The list of twenty was suggested by a "20 Ways to Unslop AI
Designs" chart the owner shared; none of that chart's text is copied. The fixes
draw on common visual-design practice and WCAG 2.2.

Where this skill differs from `team/UX.md`, CLAUDE.md or team/TEAM.md, those win.
On public marketing pages `design-taste-frontend` owns art direction; this list
still applies as the finishing pass.

## Why AI designs look like slop

A model fills every gap with the most common choice it has seen: a pill badge over
the headline, an italic accent word, a gradient, an icon card grid, a monospace
caption, three equal buttons. Each is harmless; together they say nobody decided
anything. Every fix below replaces a default with a decision.

## How to use it

Each fix has:
- **Spot**: what slop looks like, often with a grep you can run on the diff.
- **Fix**: what to do instead.
- **Check**: a pass/fail test. **[blocking]** checks fail a ux-designer branch
  review; the rest are suggestions.

Run it as a pass over screenshots at 1280 px and 375 px plus a read of the diff.
Greps are hints, not verdicts: look before you flag.

---

## Cut

### 1. Delete filler badges
**Spot:** "New", "Beta", "AI-powered", "✨", "Pro" chips that carry no
information or decision; a pill above the hero headline.
**Fix:** keep a badge only when it tells the user something they act on (a
status, a count, a real plan restriction). Otherwise delete it or put the fact in
the sentence.
**Check:** every badge on the screen answers "what would the user do differently
because of this?"

### 2. Drop redundant labels
**Spot:** a field with an "Email" label, an envelope icon and placeholder "Enter
your email"; a "Dashboard" heading under a "Dashboard" tab; "Click here to"; a
section titled "Features" above obvious features.
**Fix:** say each thing once. Keep the visible label (accessibility needs it),
drop the duplicate placeholder and decorative icon. Remove headings that repeat
the navigation.
**Check:** no text on the screen repeats what an adjacent label, heading or icon
already says. Every input still has a programmatic label **[blocking if
missing]**.

### 3. Unitalicize random words
**Spot:** one word in a headline set in italic, serif, gradient or a different
colour for "flair". Grep: `<em>|<i>|italic` inside `h1`–`h3`.
**Fix:** one face, one weight per headline. Let the words carry emphasis. Italic
stays for real uses: titles of works, terms being defined, quoted voice.
**Check:** no styled accent word in headings unless `team/UX.md` defines it as a
brand rule.

### 4. Mono only where needed
**Spot:** monospace captions, labels, buttons or numbers used for a "techy" look.
Grep: `font-mono|monospace|Mono` outside code components.
**Fix:** monospace only for code, commands, file paths, hashes and IDs the user
may copy. Numbers that need to align use tabular figures (#18), not monospace.
**Check:** every monospace element contains something a user might type or copy
character for character.

### 13. Remove embellishments
**Spot:** gradient blobs, glows, glassmorphism, noise textures, decorative
borders, emoji in headings, drop shadows on everything, divider lines between
already separated groups.
**Fix:** delete decoration that carries no meaning. If the screen looks empty
afterwards, the content or hierarchy needs work (#6, #7, #8), not more ornament.
**Check:** each remaining visual effect has a job (elevation, grouping, state,
brand rule in `team/UX.md`).

---

## Structure

### 5. Use a design system
**Spot:** a different hex, radius, shadow or font size in every component.
Grep the diff: `#[0-9a-fA-F]{3,8}\b`, `rgb\(`, raw `px` font sizes, one-off
`rounded-[` or `shadow-[` values.
**Fix:** take colour, type scale, spacing, radius, elevation and motion from the
tokens in `team/UX.md` (or the existing component library). If a needed value is
missing, add it to the tokens via the ux-designer, not inline.
**Check:** new UI code uses tokens or library components only; raw values appear
only in the token definitions. Raw values where tokens exist are **[blocking]**
once `team/UX.md` has tokens.

### 6. Show the actual product
**Spot:** abstract illustrations, stock photos, fake 3D shapes or lorem-ipsum
dashboards where the real interface or real output could be shown; placeholder
data like "John Doe" and "$1,234".
**Fix:** use real screenshots or live components of the product, and realistic
sample data that matches `team/PRODUCT.md`'s users (names, amounts, lengths that
stress the layout).
**Check:** a visitor can tell what the product looks like and does from the
screen alone; sample data includes a long name and a large number.

### 7. Enlarge the main feature
**Spot:** everything the same size: three equal cards, equal buttons, equal
headings; the most important element no bigger than the rest.
**Fix:** decide the one thing each screen is for and make it clearly dominant in
size, position and contrast. Supporting elements get smaller and quieter.
**Check:** squint test: blur the screenshot (or view at 25%), and the main
element is still the first thing you see.

### 8. Group with spacing
**Spot:** cards inside cards, borders and dividers everywhere, equal gaps between
everything so nothing groups.
**Fix:** use proximity: space inside a group is smaller than space between groups
(e.g. 8 / 16 / 32 px from the spacing scale). Remove borders and boxes that
spacing already explains.
**Check:** related items sit closer to each other than to unrelated ones; no more
than one level of card nesting; gaps come from the spacing scale.

---

## Words and emphasis

### 9. Make headlines specific
**Spot:** "Unlock the power of…", "Supercharge your workflow", "The future of X
is here", "Seamless", "Effortless", "Revolutionary".
**Fix:** say what it does, for whom, with a concrete outcome: "Split a group bill
in under a minute", "See every failing test in one list". Use the user's words
from `team/PRODUCT.md`.
**Check:** the headline would be wrong for a competitor's product; it contains no
buzzword from the list above.

### 10. Emphasize the CTA
**Spot:** two or three equally loud buttons; the main action styled like the
secondary ones; vague labels ("Submit", "Learn more", "Get started" everywhere).
**Fix:** one primary action per view, in the accent colour (#11), with a verb and
an object ("Create invoice", "Save changes"). Secondary actions use a quieter
style; tertiary ones are links.
**Check:** each view has exactly one primary-styled button; its label says what
happens when you press it.

### 11. Add an accent colour
**Spot:** an all-grey interface where nothing stands out, or a rainbow where
everything does.
**Fix:** neutrals for most of the surface, one accent for the primary action,
links, selection and key states (plus semantic colours for success, warning and
error). Keep the accent to a small share of the screen. Define it as a token.
**Check:** the accent marks only interactive or key elements; colour is never the
only signal of a state (WCAG 1.4.1) **[blocking if it is]**.

---

## Craft

### 12. Keep icons consistent
**Spot:** icons from two sets, mixed outline and filled styles, different stroke
widths or sizes in one toolbar, emoji used as icons.
**Fix:** one icon set (named in `team/UX.md`), one style per context, one stroke
width, sizes from the type scale (16 / 20 / 24 px), aligned to the text they sit
beside. Icon-only buttons get an accessible name.
**Check:** all icons in the diff import from one library; icon-only buttons have
`aria-label` or visible text **[blocking if missing]**.

### 14. Inner radius = outer radius − padding
**Spot:** a rounded card holding a rounded image or button with the same radius,
so the gap between the curves looks uneven (thick at the corners).
**Fix:** for nested rounded shapes, `inner radius = outer radius − padding`. A
card with 16 px radius and 8 px padding holds an 8 px-radius child. If the result
is 0 or less, use a square inner corner.
**Check:** every nested rounded element follows the formula (read the CSS or
measure in the browser).

### 15. Improve text contrast
**Spot:** light grey body text on white, grey on grey, text over images without a
scrim, disabled-looking secondary text.
**Fix:** body text at least 4.5:1 against its background; large text (24 px, or
18.66 px bold) and UI component edges at least 3:1 (WCAG 2.2 AA). Add a scrim or
solid band behind text on images.
**Check:** **[blocking]** any text or control below those ratios. Run axe
(`@axe-core/playwright`) or compute the ratio from the token colours.

### 16. Wrap headlines properly
**Spot:** a headline with one orphaned word on its last line; ragged lines of very
different lengths; body text lines running the full width of a wide screen.
**Fix:** `text-wrap: balance` on headings, `text-wrap: pretty` on paragraphs;
keep body text to about 45–75 characters a line (`max-width: 65ch`); add a
manual break only where the meaning splits.
**Check:** at 1280 px and 375 px, no heading ends on a single short word and body
lines stay within the measure.

### 17. Align by eye, not pixels
**Spot:** things that are mathematically centred but look off: a play triangle in
a circle, an icon beside text, a circle next to a square of the same height, a
quote mark pushing the first line inward.
**Fix:** adjust optically: nudge the triangle right, align icons to the text's
cap height or x-height rather than its line box, make circles slightly larger than
squares to look equal, hang punctuation into the margin.
**Check:** zoom to 200% on a screenshot and look at icons in buttons, avatars in
rows and the left edge of text blocks; anything that looks off is off, whatever
the numbers say.

### 18. Use tabular numbers
**Spot:** numbers in tables, prices, timers, counters or charts that jiggle
or don't line up because each digit has a different width.
**Fix:** `font-variant-numeric: tabular-nums` (Tailwind `tabular-nums`) wherever
numbers align in columns or change in place; right-align numeric columns; use the
number formatting rules in `team/UX.md`.
**Check:** numeric columns and live counters use tabular figures and stay aligned
as values change.

---

## Feedback

### 19. Add loading states
**Spot:** a blank area or frozen button while data loads; a full-page spinner for
a small fetch; content jumping when it arrives; double submissions.
**Fix:** a skeleton that matches the final layout for content; a pending state on
the button that started the action (spinner or text change, disabled against
double submit); reserved space so nothing shifts. Design empty, error and stale
states too. Timing rules are in `ux-laws-and-motion` #17.
**Check:** **[blocking]** any async view or action without a loading state or
any layout shift when content arrives. Throttle the network in Playwright and
screenshot each state.

### 20. Animate useful feedback
**Spot:** things that fade and slide in on scroll for no reason; decorative
looping animations; important changes (saved, deleted, moved) that happen
silently.
**Fix:** spend motion on feedback: confirm an action, show where something went,
connect a cause to its effect, draw attention to a change the user would miss.
Use the durations, easing and reduced-motion rules in `ux-laws-and-motion`.
**Check:** every animation in the diff answers "what would the user miss without
it?"; reduced motion is respected **[blocking]**.

---

## Using this in the team

| Role | When | Use |
|---|---|---|
| ux-designer | Setting up `team/UX.md` | Record the decisions this list depends on: tokens (#5), accent (#11), icon set (#12), number formats (#18). |
| ux-designer | Design review | Write the spec so slop never starts: one focal element (#7), one primary action (#10), real sample data (#6), every loading state (#19). |
| ux-designer | Branch review | Run all twenty checks over screenshots and the diff; **[blocking]** items go under Blocking, the rest under Suggestions. |
| developer | Building a `Specialists: ux` ticket | Run the Spot greps on your own diff before reporting DONE, and fix what they find. |

Report fix numbers in findings so they're traceable, for example
`Suggestions: - Pricing › three equal cards (#7) → enlarge the recommended plan`.
