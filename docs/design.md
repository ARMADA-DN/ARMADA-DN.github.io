# Design

The site's visual system first, then the components built on it. Read this
before changing markup or styles.

Lines marked (unverified) were filled in from the site as it stood when this
file was generated: confirm or correct them, then drop the mark.

## Style guide

### Stylesheets

- `styles.css`: the site's own
- `flexboxgrid.min.css`: vendored, replace it and never edit it (unverified)
- `pico.min.css`: vendored, replace it and never edit it (unverified)

A vendored stylesheet is replaced with a newer release, never edited. Changes go
in the site's own.

### Custom properties

- `--space-indigo: #272649ff` in `styles.css`
- `--vintage-grape: #52506dff` in `styles.css`
- `--dusty-grape: #6f58a1ff` in `styles.css`
- `--pacific-blue: #6ab0b7ff` in `styles.css`
- `--spicy-orange: #d74e09ff` in `styles.css`
- `--bright-lemon: #ffeb3bff` in `styles.css`
- `--azure-mist: #e1eff1ff` in `styles.css`
- `--platinum: #f7f9fcff` in `styles.css`
- `--primary-color: var(--space-indigo)` in `styles.css`
- `--primary-color-light: var(--pacific-blue)` in `styles.css`
- `--secondary-color: var(--azure-mist)` in `styles.css`
- `--accent-color: var(--spicy-orange)` in `styles.css`
- `--accent-color2: var(--bright-lemon)` in `styles.css`
- `--accent-color3: var(--platinum)` in `styles.css`
- `--white-color: var(--platinum)` in `styles.css`
- `--text-color: var(--space-indigo)` in `styles.css`
- `--text-color2: var(--dusty-grape)` in `styles.css`
- `--dark-color: var(--space-indigo)` in `styles.css`
- `--dark-color2: var(--vintage-grape)` in `styles.css`

_To fill in: the colours, type scale and spacing, by the custom property that
holds each one._

### Typography

- `"Montserrat", "Space Grotesk", sans-serif`
- `"Montserrat", "Archivo Black", sans-serif`

## Components

Each component: where its markup is used, where it is styled, and what it
exposes as custom properties so a new use can retune it without copying it.

- `.bottom`: on 3 pages, no styles found (unverified)
- `.col-md-2`: on 3 pages, no styles found (unverified)
- `.col-md-4`: on 3 pages, no styles found (unverified)
- `.col-md-8`: on 3 pages, no styles found (unverified)
- `.col-md-offset-2`: on 3 pages, no styles found (unverified)
- `.col-xs-12`: on 3 pages, no styles found (unverified)
- `.container`: on 3 pages, no styles found (unverified)
- `.eu-logo`: on 3 pages, styled in `styles.css` (unverified)
- `.fas`: on 3 pages, no styles found (unverified)
- `.hero`: on 3 pages, styled in `styles.css` (unverified)
- `.hero-content`: on 3 pages, styled in `styles.css` (unverified)
- `.intro`: on 3 pages, styled in `styles.css` (unverified)
- `.logo`: on 3 pages, styled in `styles.css` (unverified)
- `.row`: on 3 pages, no styles found (unverified)
- `.side`: on 3 pages, styled in `styles.css` (unverified)

_To fill in: for each component, what it is for and what may be changed._
