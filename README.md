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

**Status (2026-10-01): moving from "Deploy from a branch" to "GitHub Actions".**
Until the switch below is done, `main` is still published as-is, including the
files listed as `doc` in the table below.

Once switched, every push to `main` runs `.github/workflows/pages.yml`, which
stages the site with `.github/pages-stage.sh`: everything is copied into
`_site/` except what `.pagesignore` lists, and the deploy fails if a `doc` asset
below would be published anyway. A push to `main` is a deployment.

### Switching the Pages source

1. Merge the branch that adds `.github/workflows/pages.yml` into `main` only
   when ready to do steps 2 and 3 straight after.
2. In the repository on GitHub: **Settings → Pages → Build and deployment →
   Source**, choose **GitHub Actions**.
3. On the same page, check that **Custom domain** still reads `armada-dn.eu`
   and that **Enforce HTTPS** is on. With Actions the domain comes from this
   setting; the `CNAME` file is kept but no longer decides it.
4. **Actions → Pages → Run workflow** on `main`, or push to `main`, and wait
   for the deploy to go green.
5. Check that <https://armada-dn.eu/> loads with its styles, and that
   <https://armada-dn.eu/AGENTS.md> and <https://armada-dn.eu/docs/voice.md>
   now return 404.
6. Update the status line above.

To go back, set the source to **Deploy from a branch**, `main`, `/ (root)`.

## Assets

Every path in the repository root is either published as part of the site or
is a `doc` asset that describes it. Each `doc` row must be matched in
`.pagesignore`.

| Path | Kind | What |
| - | - | - |
| `index.html`, `call.html`, `2026-univr-winterschool.html` | site | Pages |
| `styles.css` | site | The site's own styles |
| `pico.min.css`, `flexboxgrid.min.css` | site | Vendored, replaced, never edited |
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
