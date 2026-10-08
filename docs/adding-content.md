# Adding content

How to add to the site without changing its design. Read this before adding a
page or an entry. What each component is, is in [design.md](design.md); how the
copy should read, in [voice.md](voice.md).

## Adding a page

The pages today: `index.html` (home), `candidates.html` (the doctoral
candidates), `call.html` (the 2025 call for candidates, now closed) and
`2026-univr-winterschool.html` (the 2026 winter school in Verona).

1. **Copy the page closest to the new one.** `call.html` or
   `2026-univr-winterschool.html` for a text page with a side column,
   `candidates.html` for a page of cards. Name an event page with its year
   first, as `2026-univr-winterschool.html` is.
2. **Set the `<head>`**, following "Head metadata" below: at least a title of
   its own.
3. **Keep the frame**: the header with hero and `svg.bottom` wave, then the
   nav, `<main>` and the footer, as described in
   [design.md](design.md#layout). Change only the hero's `.sub-heading` and the
   contents of `<main>`.
4. **Decide whether it goes in the nav.** Only main sections do (Home, Doctoral
   Candidates). A call or an event page stays out of it and is linked from the
   content instead, but still carries the nav itself. For a page that goes in,
   add its `<li>` to the nav on every page, with `aria-current="page"` on the
   new page's own link only.
5. **Use root-relative paths** for every asset and link (`/styles.css`,
   `/logos/…`), so the page works at any URL.
6. **Check it locally** (see the README) at both a wide window and a narrow
   one.

A new file or directory at the root that is not part of the site (notes,
sources, tooling) goes in `.pagesignore` and in the README's asset table as a
`doc` asset, in the same commit. Otherwise it is published.

## Head metadata

What every page has today: `charset`, `viewport` and a `<title>`. Nothing else.
None has a description, social preview tags (`og:*`), a canonical URL or a
favicon, and `call.html` uses the same title as `index.html`. Fixing that is
one change across all pages, and has not been decided yet. Ask before adding
any of these to one page only.

The pattern every page follows, in this order:

```html
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>ARMADA …</title>
<!-- Google Fonts: preconnect to both hosts, then one stylesheet -->
<!-- Font Awesome 5.6.3 -->
<link rel="stylesheet" href="/pure-min.css" />
<link rel="stylesheet" href="/grids-responsive-min.css" />
<link rel="stylesheet" href="/styles.css" />
```

Titles start with "ARMADA" and name the page: "ARMADA Doctoral Candidates",
"ARMADA Winter School 2026". The home page is "ARMADA: Reliable Conversational
Data Exploration".

## Adding a doctoral candidate

On `candidates.html`, inside the `pure-g gutters` grid of their work package
section.

1. **Photo**: `images/candidates/dc<N>.<ext>`, where `<N>` is the candidate's
   number (1 to 15 today). A portrait, cropped by the card to about 5:5.7.
2. **Card**: copy an existing card, the `<a class="card">` together with the
   `<div class="pure-u-1 pure-u-lg-1-3">` around it, and change, in order:
   - `href`: the candidate's public profile.
   - The photo `src`, and its `alt`: the candidate's full name.
   - The `h3`: the full name.
   - The three facts in `.meta`, in this order: host institution
     (`fa-university`), country of the host (`fa-map-marker-alt`), nationality
     (`fa-flag`).
   - `.card-text`: the project title. The existing titles mix title
     case and sentence case, and which one is meant is not decided yet: copy
     the title as the candidate gives it, and ask before changing the case of
     any.
3. Keep the cards in each section in order of candidate number.

## Adding a work package

On `candidates.html`, a `<section class="section wp-<name>">`, the `wp-<name>`
class naming it. It opens with `<h2><i class="fas fa-…"></i> WP<N>: <Name></h2>`,
then the grid of cards. A work package has the same icon on
every page: WP1 Efficiency `fa-tachometer-alt`, WP2 Grounding `fa-anchor`, WP3
Explainability `fa-comments`, WP4 Soundness `fa-shield-alt`, WP5 Guidance
`fa-compass`.

`call.html` is frozen: its copy is a record of the 2025 call and is not
edited (see [voice.md](voice.md)), so nothing is added to it. For reference,
each work package there is an `article.section`: an `h3` with the icon,
"WP<N>: <Name>" and a `<small>` naming the lead partner, then a `ul.tasks`.
Each task is an `li` with:

- `.task-name`: `<b>T<N>.<M>:</b>` and the task title,
- a `span.meta`: "Partner: <institution> (<short name>)",
- an em dash, then the application link, or "Call closed." with the deadline.

## Adding a publication

On `index.html`, in `ol.pub-list` under "Publications & Results". Add a new
`li.pub` at the top: the list is newest first. Copy the existing one and change
each part, as described in [design.md](design.md#publications-pub-list-pub):

- `.pub-meta`: the year, then the venue's acronym.
- `.pub-title`: the title, linking to the paper's PDF or, without one, its DOI.
- `.pub-authors`: every author, in the form "Surname, I.", in the paper's order.
- `.pub-venue`: the full venue name as the publisher gives it.
- `.pub-abstract`: one or two sentences.
- `.pub-links`: one link per resource that exists.

When there are more than a handful, the list moves to a page of its own; ask
before doing that.

## Adding a partner logo

On `index.html`, in `figure.logo-strip`.

1. Put the file in `logos/`, named with the partner's short name in lowercase
   (`kth.png`, `uzh.png`). PNG with a transparent background, unless the
   partner only supplies another format.
2. Add `<img src="/logos/<name>.png" alt="<partner's full name>" />`. Add
   `class="wide"` for a mark much wider than tall, so it gets 250px instead of
   150px.
3. The existing logos use the short name as `alt` (`alt="kth"`). A screen
   reader reads that out as is, so a new logo uses the full name instead.

## Adding a short link

`redirects/external-sites.json` maps short paths to external URLs (application
forms, say). Nothing in this repository reads it. Ask what does before adding
an entry, and how it should be tested.
