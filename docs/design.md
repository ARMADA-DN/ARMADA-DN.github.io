# Design

The site's visual system first, then the components built on it. Read this
before changing markup or styles.

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
| `--dusty-grape` | `#6f58a1` | Not used yet |
| `--pacific-blue` | `#6ab0b7` | Accents, card borders, pills, icons |
| `--spicy-orange` | `#d74e09` | Not used yet |
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

### Tints

A translucent version of a palette colour uses its channel token, never an
`rgba()` literal:

```css
background: rgb(var(--pacific-blue-rgb) / 0.14);
```

Channel tokens exist for `--space-indigo-rgb`, `--vintage-grape-rgb`,
`--pacific-blue-rgb`, `--azure-mist-rgb` and `--platinum-rgb`. Adding one for
another palette colour means adding it to `:root` beside the others, with the
same three numbers as the hex value.

Opacities in use: pacific blue at 0.14 to 0.35 for fills, borders and focus
rings, and 0.75 for a hovered border. Space indigo at 0.055 to 0.2 for shadows.
Azure mist and platinum at 0.72 to 0.98 for card gradients.

## Type

- **Body:** `"Montserrat", "Space Grotesk", sans-serif`.
- **Headings** (`h1` to `h6`, `.sub-heading`): `"Montserrat", "Archivo Black",
  sans-serif`, weight 900, in `--primary-color`.
- **Body copy** in `<main>` is `--text-color`. Outside `<main>`, `p`, lists and
  similar are `--dark-color2`.
- **Links** are underlined and take the text colour, not a separate link colour.
- **Sizes** are in `rem`, except the nav, which sets `--nav-font-size` in `px`.
  There is no type scale yet: about twenty sizes are in use, most of them in
  the candidate cards. Reuse a size already used by a similar element before
  adding a new one.

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

Breakpoints in `styles.css`: 1100px, 1025px (wider only), 900px, 640px, 480px
and 420px. Most of them exist for the candidate cards. Use one of these before
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
over `--dark-color2`. The hero holds the white logo (`#h-logo`, inside the
`h1`) and a `.sub-heading`, both in `--white-color`. The `svg.bottom` wave
beneath it draws the transition into the page background.

### Content panel: `article.wp-container`

On `index.html`, `call.html` and `2026-univr-winterschool.html`. A block on an
`--secondary-color` background, for a work package or a programme item.

### Programme details: `.program-details-inline`, `.program-detail-list`, `.program-funding`

On `candidates.html`, in the intro. Each item in the detail list is a `<p>`
holding a small label (`span`) over a value (`strong`), in a pacific blue tinted
box.

### Work package section: `.wp-wrapper`, `.wp-section`, `.wp-header`, `.wp-icon`

On `candidates.html`. One `.wp-section` per work package, each also carrying a
`wp-<name>` class (`wp-efficiency`, `wp-grounding`, `wp-explainability`,
`wp-soundness`, `wp-guidance`). These classes have no styles yet. The header
pairs a Font Awesome icon in a gradient tile with an `h2`.

### Candidate card: `.candidate-grid`, `.candidate-card`

On `candidates.html`, in a `.grid.candidate-grid` inside each work package
section. The whole card is a link (`<a class="candidate-card">`) to the
candidate's profile:

- `.candidate-top`: `.candidate-photo` (a portrait from
  `images/candidates/dc<N>.<ext>`, in a gradient frame) and `.candidate-title`
  (`h3` name).
- `.candidate-meta`: pills, each a `span` holding an icon and text:
  `fa-university` for the host institution, `fa-map-marker-alt` for the
  country, `fa-flag` for nationality.
- `.candidate-project`: the project title.

The left edge stripe is `::before`. Hover lifts the card and strengthens its
border, and keyboard focus draws a pacific blue outline.

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
- **No type scale.** See Type.
- **Mixed paths.** Most assets use root-relative paths (`/styles.css`), but some
  `img` tags use relative ones (`logos/…`, `./images/…`). Both work from the
  root. New markup uses root-relative.
- **Mixed indentation** in `styles.css`: rules are indented by two spaces up to
  the footer and start at column 0 after it. Match the surrounding block.
