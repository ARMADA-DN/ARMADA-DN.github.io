# Design

The site's visual system first, then the components built on it. Read this
before changing markup or styles.

## Principles

- **Quiet, with a little depth.** Structure comes from type, whitespace and
  thin rules. The page is lightly tinted, and the things you can click (cards,
  follow links) are white paper resting on it with a faint shadow. No gradients
  or tinted panels in the content area; the hero is the one place for colour
  and image, and the deep indigo footer closes the page.
- **One accent, used sparingly.** Dusty grape marks what is current or
  interactive, and where a section starts: heading icons, the current page in
  the nav, a hovered link, the bar on each section's rule.
- **Few shapes.** One radius (`--radius`), one rule (`--rule`). A new component
  uses these before adding its own.
- **Sizes from the scale.** Text sizes come from `--step-*`.

## Stylesheets

Every page loads, in this order:

1. Google Fonts: one stylesheet for Archivo Black, Montserrat and Space Grotesk.
2. Font Awesome 5.6.3 from its CDN, for icons (`<i class="fas fa-…">`).
3. `/pure-min.css`: Pure 3.1.0, a reset (normalize.css) and the `pure-g` grid.
4. `/grids-responsive-min.css`: Pure's responsive units (`pure-u-md-*`,
   `pure-u-lg-*`).
5. `/styles.css`: the site's own styles.

Both Pure files are vendored: replace them with a newer release, never edit
them. Every change goes in `styles.css`.

Pure deliberately has no typography, so `styles.css` sets the base: a root
size of 16px rising to 17, 18, 19 and 20px at 576, 768, 992 and 1200px,
heading sizes, spacing (`--space`), lists, figures and `.container`. There is
no dark mode: the site is designed for light only.

## Colour

### Palette

Defined once in `:root` in `styles.css`. Nothing outside `:root` writes a hex
value.

| Token | Value | Used for |
| - | - | - |
| `--space-indigo` | `#272649` | Headings, body text, dark shadows |
| `--vintage-grape` | `#52506d` | Header background, secondary text |
| `--dusty-grape` | `#6f58a1` | The accent, through `--accent-color` |
| `--pacific-blue` | `#6ab0b7` | Link underlines, hover borders, meta icons |
| `--spicy-orange` | `#d74e09` | Not used: tried as the accent and dropped as too loud |
| `--bright-lemon` | `#ffeb3b` | Not used yet |
| `--azure-mist` | `#e1eff1` | Photo backgrounds while loading |
| `--platinum` | `#f7f9fc` | Text on dark, the base of the page tint |
| `--white` | `#ffffff` | Paper: cards and follow links |

### Roles

Rules use a role where one fits, and a palette name only where the colour
itself matters (a gradient between two named colours, say).

| Role | Resolves to |
| - | - |
| `--primary-color` | `--space-indigo` |
| `--primary-color-light` | `--pacific-blue` |
| `--secondary-color` | `--azure-mist` |
| `--white-color` | `--platinum` |
| `--page-color` | azure mist 40% into platinum: the page background |
| `--paper-color` | `--white` |
| `--text-color` | `--space-indigo` |
| `--dark-color` | `--space-indigo` |
| `--dark-color2` | `--vintage-grape` |
| `--accent-color` | `--dusty-grape` |

### Tints

A translucent version of a palette colour uses its channel token, never an
`rgba()` literal:

```css
border-bottom: 1px solid rgb(var(--space-indigo-rgb) / 0.12);
```

Channel tokens: `--space-indigo-rgb` (0.12 in `--rule`, 0.04 to 0.06 in
`--shadow-paper`) and `--platinum-rgb` (text and rules on the indigo footer, at
0.15 to 0.78). A tint of another palette colour adds its channel token to
`:root` beside these, with the same three numbers as the hex value.

The sticky nav is opaque on purpose: a translucent background with
`backdrop-filter` has to be re-blurred on every frame and makes scrolling
stutter.

## Type

- **Body:** `"Montserrat", "Space Grotesk", sans-serif`.
- **Headings** (`h1` to `h6`, `.sub-heading`): `"Montserrat", "Archivo Black",
  sans-serif`, weight 800, in `--primary-color`, with balanced line breaks
  (`text-wrap: balance`) so a title never ends on one word alone. In `<main>`,
  `h1` and `h2` are tracked in by 0.02em and `h3` by 0.01em. An icon at the start of a
  heading in `<main>` takes `--accent-color`.
- **Body copy** in `<main>` is `--text-color`. Outside `<main>`, `p`, lists and
  similar are `--dark-color2`.
- **Links** in `<main>` take the text colour, underlined in pacific blue with a
  small offset; the underline turns to the accent on hover.
- **Labels** (the nav, stats labels, "Follow ARMADA"): uppercase, weight 700, letter-spacing
  0.06em, at `--step--1` or `--step--2`.

### Scale

| Token | Size | For |
| - | - | - |
| `--step--2` | 0.75rem | Labels, card meta |
| `--step--1` | 0.875rem | Nav, secondary text, project titles |
| `--step-0` | 1rem | Body, card names |
| `--step-1` | 1.25rem | Section `h3`, work package icons |
| `--step-2` | 1.6rem | Work package `h2`, figures |
| `--step-3` | 2.2rem | Spare, for a page `h1` that needs one |

Outside the scale on purpose: the hero's display sizes (`h1` 3rem, 4rem on
wide screens; `.sub-heading` 1.75rem, 2.5rem) and the base heading sizes
(`h1` 2rem to `h6` 1rem), which components override from the scale.

## Shape

- `--radius` (0.375rem): cards, follow links and photos. Sections have no
  radius.
- `--rule` (1px of space indigo at 12%): card and follow link borders, the line
  above each section and entry, under the nav.
- `--shadow-paper`: a faint two-layer indigo shadow, at rest, on paper (cards,
  follow links). Nothing else casts a shadow.
- **Accent bar**: each `.section` has a 2.5rem by 3px bar in the accent over
  the start of its rule, drawn by `.section::before`.

## Layout

Every page has the same frame:

```html
<body>
  <header>
    <div class="hero"><div class="hero-content">…</div></div>
    <svg class="bottom">…</svg>   <!-- the wave into the page -->
  </header>
  <nav class="site-nav" aria-label="Primary">…</nav>
  <main>…</main>
  <footer>…</footer>
</body>
```

The nav sits between `<header>` and `<main>`, not inside the header: it is
sticky, and a sticky element only sticks within its parent.

Layout uses Pure's grid: a `pure-g` holds units (`pure-u-*`) whose widths are
fractions, with responsive ones applying from a breakpoint. Add `gutters` to the
`pure-g` for space between units.

```html
<div class="pure-g gutters">
  <section class="main pure-u-1 pure-u-lg-2-3">…</section>
  <section class="aside pure-u-1 pure-u-lg-1-3">…</section>
</div>
```

- **Main and aside**: two thirds and one third from 64em (1024px), full width
  below. `.main` and `.aside` name the role; the `pure-u-*` classes size them.
- **Inset**: `class="main inset …"` indents a main column by one twelfth from
  64em, for the home page's rows under the intro.
- **Cards**: a `pure-g gutters` with one `pure-u-1 pure-u-lg-1-3` per card, the
  card inside it.
- **Container**: `.container`, at most 510, 700, 920 and 1130px wide at 576,
  768, 992 and 1200px.

Breakpoints: Pure's 35.5em (568px), 48em (768px), 64em (1024px) and 80em
(1280px) for the grid; in `styles.css`, 1025px (wider only, the hero), 480px
(the nav) and the root size steps. Use one of these before adding a new one.

## Components

Classes name what a thing is, not which page it is on. Each component is styled
once in `styles.css` and used wherever the pattern appears.

| Component | Class | Used on |
| - | - | - |
| Site navigation | `.site-nav` | every page |
| Header and hero | `body > header`, `.hero` | every page |
| Section | `.section` | call, candidates |
| Entry | `.entry` | index, winter school |
| Card | `.card` | candidates |
| Meta | `.meta` | candidates, call |
| Stats | `.stats` | candidates |
| Note | `.note` | candidates |
| Tasks | `.tasks` | call |
| Item list | `.item-list` | index, call, winter school |
| Logo strip | `.logo-strip` | index |
| Follow | `.follow` | index |
| Footer | `body > footer` | every page |

### Site navigation: `.site-nav`

Right after `<header>`. A single row of uppercase text links on the page
background, with a rule underneath. It scrolls up with the page and then sticks
to the top of the viewport. The current page's link carries
`aria-current="page"`, which underlines it in the accent; hover underlines in
pacific blue. The link list is copied into every page, so adding a page to the
nav means adding its link to all of them.

Only the main sections are in the nav: Home and Doctoral Candidates. The call
page and event pages are reached from links in the content, and keep the nav
on their own pages.

### Header and hero: `body > header`, `.hero`, `.hero-content`

The header is the gradient image `logos/armada-bg-gradient.png` over
`--dark-color2`, scrolling with the page: no `background-attachment: fixed`,
which made the image stand still while the page moved. The hero holds the white
logo (`#h-logo`, inside the `h1`) and a `.sub-heading`, both in
`--white-color`. The `svg.bottom` wave beneath it draws the transition into the
page background.

### Section: `.section`

A block opened by a rule, with no background, border or shadow. Used for each
work package and, on `candidates.html`, for the programme details and the
closing contact line.

```html
<section class="section wp-efficiency">
  <h2><i class="fas fa-tachometer-alt"></i> WP1: Efficiency</h2>
  …
</section>
```

- The accent bar marks its start (see Shape).
- A direct `h2` sets its icon beside the title, in the accent at `--step-1`.
- A direct `h3` is `--step-1`. A `<small>` inside it sits on its own line in
  `--dark-color2`, for a subtitle such as the lead partner.
- The `wp-<name>` class (`wp-efficiency`, `wp-grounding`, `wp-explainability`,
  `wp-soundness`, `wp-guidance`) names a work package. No styles yet; it is
  the hook for giving each work package its own colour.

### Entry: `.entry`

One item of a kind in a list of them: the publication on `index.html`, each
keynote on `2026-univr-winterschool.html`. An `h3` title, with an optional
`<small>` subtitle (the speaker's affiliation), then paragraphs. Styled like a
section for now; a separate name so the two can diverge.

### Card: `.card`

A person, as one link to their profile: on `candidates.html`, three to a row
from 64em, each in its own Pure unit, which the card fills.

```html
<div class="pure-u-1 pure-u-lg-1-3">
  <a class="card" href="…">
    <div class="card-top">
      <div class="card-photo"><img src="/images/candidates/dc1.png" alt="Full Name" /></div>
      <div class="card-title"><h3>Full Name</h3></div>
    </div>
    <div class="meta">
      <span><i class="fas fa-university"></i> Host institution</span>
      <span><i class="fas fa-map-marker-alt"></i> Country</span>
      <span><i class="fas fa-flag"></i> Nationality</span>
    </div>
    <p class="card-text">Project title</p>
  </a>
</div>
```

White paper: `--paper-color`, `--rule` border, `--radius`, `--shadow-paper`. Hover turns the border
pacific blue; keyboard focus draws a pacific blue outline. The photo is about
5:5.7, cropped to fit. In a card, the first `.meta` part takes a line of its
own.

### Meta: `.meta`

Small facts about something: `--step--2`, weight 600, `--dark-color2`, each
fact optionally led by an icon in pacific blue. The card's institution, country
and nationality; a task's partner on `call.html` (`<span class="meta">`).

### Stats: `.stats`

A row of figures on `candidates.html`: a `pure-g stats` of `<p>` units, two per
row, four from 48em. Each `<p>` holds a label `<span>` and a value `<strong>`;
the value shows large above the uppercase label, with a pacific blue line to
the left. The markup keeps the label first, so it reads in that order.

### Note: `.note`

A secondary paragraph at `--step--1`, such as the funding details under the
stats.

### Tasks: `.tasks`

The task list of a work package on `call.html`: a `ul.tasks` of plain `li`
without bullets, each with a `.task-name` (weight 600) and a `span.meta` for
the partner.

### Item list: `.item-list`

A list whose items lead with a label: `<li><strong>Label:</strong> text</li>` or
a name in `<b>`. Key innovations and events on `index.html`, supervisors on
`call.html`, speakers on the winter school page. No styles of its own yet; it
is the hook for styling these lists together.

### Logo strip: `.logo-strip`

A wrapping row of partner logos on `index.html`, from `logos/`, each at most
150 by 60px, or 250px wide with `class="wide"` for wide marks.

### Follow: `.follow`

The project's LinkedIn and GitHub, prominent at the top of the home page's
aside: an uppercase label, then one `a.follow-link` per network, full width,
on paper like the cards, with the network's icon in pacific blue and an arrow in
the accent. The footer
repeats the same links in small; change both together.

### Footer: `body > footer`

A deep indigo band (`--dark-color`) closing every page, with platinum text at
78%, white links and strong text, and its rules in platinum at 15%. The same
markup on every page, copied into each:

- `.funding` (two thirds from 48em): the EU flag beside "Funded by the European
  Union", the Horizon Europe grant (101168951, linking to CORDIS) and the Swiss
  SERI co-funding (SBFI No. 24.00005).
- `.contact` (one third): the project address as a `mailto:` link, then
  LinkedIn and GitHub.
- `.fineprint`: the EU disclaimer and the copyright, small, under a rule.

The funding statement and the disclaimer are required by the grant: change
their wording only on instruction. A change to the footer is made on all four
pages.

## Known issues

To fix on purpose, not in passing:

- **SVG presentation attribute.** `call.html` has a visible `svg.top` with
  `fill="#000A14"` in the markup (commented out on the other pages), which
  breaks the rule that presentation lives in the stylesheet. The bottom wave
  already takes its fill from `styles.css` (`--page-color`).
- **Older sizes.** The hero and the side column logo still set their own
  sizes outside the scale.
- **Mixed paths.** Most assets use root-relative paths (`/styles.css`), but some
  `img` tags use relative ones (`logos/…`, `./images/…`). Both work from the
  root. New markup uses root-relative.
- **Mixed indentation** in `styles.css`: rules are indented by two spaces up to
  the footer and start at column 0 after it. Match the surrounding block.
