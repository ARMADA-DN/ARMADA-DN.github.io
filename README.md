# ARMADA-DN.github.io

Website of the ARMADA doctoral network, Reliable Conversational Data
Exploration, served at [armada-dn.eu](https://armada-dn.eu).

Hand-written HTML and CSS with no build step.

## Preview locally

Pages link their assets with root-relative paths (`/styles.css`), so serve the
repository root rather than opening the files directly:

```sh
python3 -m http.server 8000
```

Then open <http://localhost:8000/>.

## Deployment

Every push to `main` runs `.github/workflows/pages.yml`, which stages the site
with `.github/pages-stage.sh`: everything is copied into `_site/` except what
`.pagesignore` lists, and the deploy fails if a `doc` asset below would be
published anyway. A push to `main` is a deployment.

The Pages source is **GitHub Actions** (since 2026-10-04, PR #11). The custom
domain `armada-dn.eu` and **Enforce HTTPS** are set in **Settings → Pages**;
with Actions the `CNAME` file no longer decides the domain, but is kept.

### Checking a deploy

1. **Actions → Pages**: the run for the push is green.
2. <https://armada-dn.eu/> loads with its styles.
3. Doc assets are not published: <https://armada-dn.eu/AGENTS.md> and
   <https://armada-dn.eu/docs/voice.md> return 404.

To fall back to publishing the branch as-is, set the source to **Deploy from a
branch**, `main`, `/ (root)`. Doc assets are then public again.

## Assets

Every path in the repository root is either published as part of the site or
is a `doc` asset that describes it. Each `doc` row must be matched in
`.pagesignore`.

| Path | Kind | What |
| - | - | - |
| `index.html`, `call.html`, `2026-univr-winterschool.html` | site | Pages |
| `styles.css` | site | The site's own styles |
| `pure-min.css`, `grids-responsive-min.css` | site | Pure 3.1.0, vendored, replaced, never edited |
| `logos/`, `images/`, `armada-logo.png`, `euflag.png` | site | Images |
| `redirects/` | site | Short paths to external URLs |
| `CNAME`, `LICENSE` | site | Domain record, licence |
| `README.md` | doc | This file |
| `AGENTS.md` | doc | Rules for coding agents |
| `docs/` | doc | Voice, design and content guides |
| `.github/` | doc | Pages workflow and stage script |
| `.githooks/` | doc | Commit hooks |
| `.gitignore` | doc | Git ignore list |
| `.gitidentity.example` | doc | Commit identity template |
| `.pagesignore` | doc | What the deploy leaves out |
