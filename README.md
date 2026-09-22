# Foundry Works — portfolio page

A single-page gallery of the Foundry VTT systems and modules published under
[github.com/mordachai](https://github.com/mordachai), with an image carousel per
project and an ES/EN language toggle. Built to be linked from a CV, LinkedIn or
an email to a recruiter.

## Files

```
index.html          the whole site (HTML + CSS + JS, no build step, no dependencies)
images/             screenshots served locally
fetch-images.sh     downloads the remaining README screenshots into images/
```

## Publish it on GitHub Pages

1. Create a repo — `mordachai.github.io` gives the cleanest URL
   (`https://mordachai.github.io`). Any other name works too and lands on
   `https://mordachai.github.io/<repo>/`.
2. Drop `index.html`, `images/` and `fetch-images.sh` in the root of the repo and push.
3. Repo → **Settings → Pages** → Source: *Deploy from a branch* → Branch: `main`,
   folder `/ (root)` → **Save**. The URL appears there after a minute or two.

## Images

Most screenshots currently load straight from the GitHub URLs in each README.
That works, but it depends on github.com staying reachable from wherever the
recruiter opens the page. Running

```bash
bash fetch-images.sh
```

downloads them into `images/<repo>/` and the page prefers those local copies
automatically — no edit needed. Anything it skips (video, jpeg, gif) you can
drop in by hand as `images/<repo>/rN.png`, matching the numbering in the script.

## Editing the content

Everything lives in two arrays near the bottom of `index.html`:

- `PROJECTS` — one object per package: `title`, `version`, `compat`, `tags`,
  the `en` / `es` descriptions, and the image list. Add a project by copying an
  entry; `kind: "system"` renders as a wide feature row, anything else as a card.
- `I18N` — interface strings. The English text is read from the page itself, so
  only the Spanish side is spelled out there.

Version numbers were taken from each repo's `module.json` / `system.json` in
September 2026 — worth refreshing when you cut new releases.
