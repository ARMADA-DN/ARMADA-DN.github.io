# Design

The site's visual system first, then the components built on it. Read this
before changing markup or styles.

## Principles

- **Flat and quiet.** Structure comes from type, whitespace and thin rules, not
  from boxes. No gradients, shadows or tinted panels in the content area; the
  hero is the one place for colour and image.
- **One accent, used sparingly.** Dusty grape marks what is current or
  interactive: heading icons and a hovered link.
- **Few shapes.** One radius (`--radius`), one rule (`--rule`). A new component
  uses these before adding its own.
- **Sizes from the scale.** Text sizes come from `--step-*`.

## Stylesheets

Every page loads, in this order:

1. Google Fonts: one stylesheet for Archivo Black, Montserrat and Space Grotesk.
2. Font Awesome 5.6.3 from its CDN, for icons (`<i class="fas fa-…">`).
3. `/pico.min.css`: Pico, the base styles and the `.grid` layout.
4. `/flexboxgrid.min.css`: the `row` and `col-*` grid. Every page except
   `candidates.html` loads it, since that page uses only Pico's `.grid`.
5. `/styles.css`: the site's own styles.

`pico.min.css` and `flexboxgrid.min.css` are vendored: replace them with a newer
release, never edit them. Every change goes in `styles.css`.

## Colour

### Palette

Defined once in `:root` in `styles.css`. Nothing outside `:root` writes a hex
value.

| Token | Value | Used for |
| - | - | - |
| `--space-indigo` | `#272649` | Headings, body text, dark shadows |
| `--vintage-grape` | `#52506d` | Header background, secondary text |
| `--dusty-grape` | `#6f58a1` | The accent, through `--accent-color` |
| `--pacific-blue` | `#6ab0b7` | Accents, card borders, pills, icons |
| `--spicy-orange` | `#d74e09` | Not used: tried as the accent and dropped as too loud |
| `--bright-lemon` | `#ffeb3b` | Not used yet |
| `--azure-mist` | `#e1eff1` | Pale panels, photo backgrounds |
| `--platinum` | `#f7f9fc` | Page background, text on dark |

### Roles

Rules use a role where one fits, and a palette name only where the colour
itself matters (a gradient between two named colours, say).

| Role | Resolves to |
| - | - |
| `--primary-color` | `--space-indigo` |
| `--primary-color-light` | `--pacific-blue` |
| `--secondary-color` | `--azure-mist` |
| `--white-color` | `--platinum` |
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

The one channel token is `--space-indigo-rgb`, used at 0.12 in `--rule`. A
tint of another palette colour adds its channel token to `:root` beside it,
with the same three numbers as the hex value.

## Type

- **Body:** `"Montserrat", "Space Grotesk", sans-serif`.
- **Headings** (`h1` to `h6`, `.sub-heading`): `"Montserrat", "Archivo Black",
  sans-serif`, weight 900, in `--primary-color`. An icon at the start of a
  heading in `<main>` takes `--accent-color`.
- **Body copy** in `<main>` is `--text-color`. Outside `<main>`, `p`, lists and
  similar are `--dark-color2`.
- **Links** in `<main>` take the text colour, underlined in pacific blue with a
  small offset; the underline turns to the accent on hover.
- **Labels** (figure labels): uppercase, weight 700, letter-spacing
  0.06em, at `--step--1` or `--step--2`.

### Scale

| Token | Size | For |
| - | - | - |
| `--step--2` | 0.75rem | Labels, card meta |
| `--step--1` | 0.875rem | Secondary text, project titles |
| `--step-0` | 1rem | Body, card names |
| `--step-1` | 1.25rem | Section `h3`, work package icons |
| `--step-2` | 1.6rem | Work package `h2`, figures |
| `--step-3` | 2.2rem | Spare, for a page `h1` that needs one |

Outside the scale on purpose: the hero's display sizes (`h1` 3rem, 4rem on
wide screens; `.sub-heading` 1.75rem, 2.5rem) and the footer's 0.8rem.

## Shape

- `--radius` (0.375rem): cards and photos. Sections have no radius.
- `--rule` (1px of space indigo at 12%): card borders, the line above each
  section.

## Layout

Every page has the same frame:

```html
<body>
  <header>
    <nav class="site-nav" aria-label="Primary">…</nav>
    <div class="hero"><div class="hero-content">…</div></div>
    <svg class="bottom">…</svg>   <!-- the wave into the page -->
  </header>
  <main>…</main>
  <footer>…</footer>
</body>
```

Inside `<main>`, the content pages use the flexboxgrid row: `.intro`
(`col-xs-12 col-md-8`) beside `.side` (`col-xs-12 col-md-4`), 8 and 4 of 12
columns from 64em (1024px) up and full width below. `index.html` also has
`.intro` rows offset by one column. `candidates.html` uses Pico's `.grid`.

Breakpoints in `styles.css`: 1025px (wider only) and 480px (the nav). Pico's
`.grid` puts its children side by side from 992px. Use one of these before
adding a new breakpoint.

## Components

Each entry says where the component is used and where it is styled.

### Site navigation: `.site-nav`

On every page. Fixed to the top of the viewport over the header gradient, with
white links. The current page's link carries `aria-current="page"`, which
underlines it. `--nav-font-size` is 16px, or 14px under 480px. The link list is
copied into every page, so adding a page means adding its link to all of them.

### Header and hero: `body > header`, `.hero`, `.hero-content`

On every page. The header is the gradient image `logos/armada-bg-gradient.png`
over `--dark-color2`, scrolling with the page: no `background-attachment: fixed`,
which made the image stand still while the page moved. The hero holds the white logo (`#h-logo`, inside the
`h1`) and a `.sub-heading`, both in `--white-color`. The `svg.bottom` wave
beneath it draws the transition into the page background.

### Section: `article.wp-container`, `.wp-section`

A block of content opened by a rule above it, with no background, border or
shadow. `article.wp-container` is used on `index.html`, `call.html` and
`2026-univr-winterschool.html`; `.wp-section` on `candidates.html`. Its `h3`
(on `call.html`) is `--step-1`, with a `<small>` on its own line for the lead
partner.

A task in a work package (`call.html`) is an `li.task` without a bullet:
`.task-name` in the text colour at weight 600, `.task-leader` smaller in
`--dark-color2`.

### Programme details: `.program-details-inline`, `.program-detail-list`, `.program-funding`

On `candidates.html`, in the intro. A row of figures: each item in the detail
list is a `<p>` with a label (`span`) and a value (`strong`). The value shows
large above the label, with a pacific blue line to the left. The markup keeps
the label first, so it reads in that order.

### Work package header: `.wp-wrapper`, `.wp-header`, `.wp-icon`

On `candidates.html`. Each work package is a `.wp-section` (see Section) that
also carries a `wp-<name>` class (`wp-efficiency`, `wp-grounding`,
`wp-explainability`, `wp-soundness`, `wp-guidance`), which has no styles. The
`.wp-header` sets a Font Awesome icon in the accent beside the `h2`.

### Candidate card: `.candidate-grid`, `.candidate-card`

On `candidates.html`, in a `.grid.candidate-grid` inside each work package
section. The whole card is a link (`<a class="candidate-card">`) to the
candidate's profile. A flat box: `--rule` border, `--radius`, no background.
Hover turns the border pacific blue; keyboard focus draws a pacific blue
outline.

- `.candidate-top`: `.candidate-photo` (a portrait from
  `images/candidates/dc<N>.<ext>`, with `--radius`) and `.candidate-title`
  (`h3` name, left-aligned).
- `.candidate-meta`: plain text at `--step--2` in `--dark-color2`, each part a
  `span` with its icon in pacific blue: `fa-university` for the host
  institution, on a line of its own, then `fa-map-marker-alt` for the country
  and `fa-flag` for nationality.
- `.candidate-project`: the project title.

### Partner logos: `.image-gallery`

On `index.html`. A wrapping row of partner logos from `logos/`, each at most
150 by 60px, or 250px wide with `class="wide"` for wide marks.

### Footer: `body > footer`, `.footer-grid`, `.eu-logo`

On every page, copied into each. The EU flag with "Funded by the European
Union", the grant agreement (101168951) linking to CORDIS, and the EU
disclaimer. That text is required by the grant: change it only on instruction.

## Known issues

To fix on purpose, not in passing:

- **SVG presentation attributes.** Each page's header wave sets
  `fill="#f7f9fc"` in the markup, and `call.html` also has a visible `svg.top`
  with `fill="#000A14"`, commented out on the other pages. That breaks the
  rule that presentation lives in the stylesheet. The fix is a `fill` rule in
  `styles.css` per wave and removing the attributes from every page.
- **Older sizes.** The scale covers the redesigned components. Rules outside
  them (the hero, the footer, the logo) still set their own sizes.
- **Mixed paths.** Most assets use root-relative paths (`/styles.css`), but some
  `img` tags use relative ones (`logos/…`, `./images/…`). Both work from the
  root. New markup uses root-relative.
- **Mixed indentation** in `styles.css`: rules are indented by two spaces up to
  the footer and start at column 0 after it. Match the surrounding block.
