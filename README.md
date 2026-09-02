# ayanich.github.io

Personal site for Asher T. Yanich. Plain static HTML — no build step, no dependencies.

Live URL once deployed: **https://ayanich.github.io**

## Files

- `index.html` — the whole site, single file
- `404.html` — friendly not-found page
- `.nojekyll` — tells GitHub Pages to skip Jekyll processing (we don't need it)
- `README.md` — this file

## Deploy to GitHub Pages

This is a **user site**, so the repo name must match your username exactly.

> **Convention:** all GitHub repos live under `~/src/`. Move (or copy) this
> folder there before pushing.

```bash
# 0. Move the working copy into ~/src (one-time)
mkdir -p ~/src
mv "/Users/asher/Library/Application Support/Claude/local-agent-mode-sessions/65a0b245-dcce-42ce-9c83-3b3fb4ecd370/0c1d0341-163a-4857-9b6e-69138f2ad00b/local_5f13569a-f7f4-44e6-b06f-8d1ca4820fc9/outputs/ayanich.github.io" ~/src/

# 1. Work from the canonical location
cd ~/src/ayanich.github.io

# 2. Initialize git
git init -b main

# 3. Create the repo on GitHub
#    Repo name MUST be: ayanich.github.io
#    Visibility: public
#    Do NOT initialize with a README (we already have one)
#    https://github.com/new

# 4. Wire up the remote and push
git remote add origin git@github.com:ayanich/ayanich.github.io.git
git add .
git commit -m "Initial site"
git push -u origin main
```

GitHub Pages auto-publishes user sites from the `main` branch. Within 1–2 minutes the site will be live at https://ayanich.github.io.

If it doesn't appear, go to **Settings → Pages** on the repo and confirm:
- Source: **Deploy from a branch**
- Branch: **main** / `/ (root)`

## Editing the site

Everything lives in `index.html`. The structure is:

| Section | Anchor | What lives there |
| --- | --- | --- |
| Hero | top | Name, tagline, summary, CTA buttons |
| About | `#about` | Two short paragraphs |
| Experience | `#experience` | Each role is a `<div class="role">` block |
| Skills | `#skills` | Skill cards (`<div class="skill-card">`) |
| Education | `#education` | One `<div class="edu">` |
| Contact | `#contact` | Contact cards |

To add a role, copy any `<div class="role">…</div>` block and edit the title, company, dates, and bullets.

## Custom domain (optional)

If you buy a domain (e.g. `asheryanich.com`):

1. Add a `CNAME` file at the repo root containing only the domain (e.g. `asheryanich.com`).
2. At your DNS provider, create:
   - 4 `A` records on the apex pointing to GitHub Pages: `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - A `CNAME` record on `www` pointing to `ayanich.github.io`
3. In **Settings → Pages**, set the custom domain and enable **Enforce HTTPS**.

## Local preview

No build needed. Either:

```bash
cd ~/src/ayanich.github.io
python3 -m http.server 8000
# then open http://localhost:8000
```

…or just double-click `index.html`.
