# Local Development Setup — Automania.qa

---

## Prerequisites

- A modern browser (Chrome, Firefox, Safari, Edge)
- A code editor (VS Code recommended)
- Git

That's it. No Node.js, npm, or any framework needed.

---

## First-Time Setup

```bash
# Clone the repo
git clone https://github.com/gitlearning-gsr/automania-qa.git
cd automania-qa

# Open in VS Code (optional)
code .

# Open in browser
open index.html        # macOS
start index.html       # Windows
xdg-open index.html    # Linux
```

---

## Local Brochure PDFs

Brochure PDFs are not in the GitHub repo (too large). To serve them locally:

1. Get the PDF archive from the project owner (shared via Google Drive or USB)
2. Extract it so the folder structure matches:
   ```
   automania-qa/
   ├── Toyota/
   │   └── Land_Cruiser_Brochure.pdf
   ├── BYD/
   │   └── BYD_ATTO3_Brochure.pdf
   └── ...
   ```
3. Brochure download buttons will now work locally

> Without PDFs, the brochure buttons simply won't appear (the code hides them if `car.pdf === ''`)

---

## Recommended VS Code Extensions

- **Live Server** (ritwickdey.LiveServer) — auto-reload on save
  - After install: right-click `index.html` → **Open with Live Server**
- **Prettier** — code formatting
- **Auto Rename Tag** — keeps HTML tags in sync

---

## How the SPA Works

`index.html` is a Single Page Application. Everything lives in one file:

1. **CSS** — in `<style>` tags at the top
2. **HTML** — multiple `<div class="page">` sections (only one is `.active` at a time)
3. **JavaScript** — at the bottom in `<script>` tags

Page navigation:
```javascript
showPage('browse')   // switches visible page
showPage('home')
showPage('ev')
showPage('consult')
```

---

## Making Changes

### To update a car's info:
Search for the car's model name in `index.html`, find its object in `CARS[]`, edit the fields.

### To update styling:
Find the CSS variable or class in the `<style>` block at the top of `index.html`.

### To add a section to a page:
Find the relevant `<div class="page" id="page-xxx">` block and add HTML inside it.

---

## Testing Checklist

After any change, verify:

- [ ] Home page loads and shows featured cars
- [ ] Brand pills filter correctly (Toyota, Nissan, Kia, etc.)
- [ ] Browse page search works
- [ ] Car modal opens on click (shows specs + brochure button)
- [ ] Compare feature works (add cars, open compare modal)
- [ ] EV Hub tab loads
- [ ] Consulting form opens
- [ ] Dark mode toggle works
- [ ] Logo shows correctly in header AND footer
- [ ] Tagline "Choose the car. Protect the dream." visible in hero

---

## File Sizes

| File | Size |
|---|---|
| `index.html` | ~150 KB (including all data) |
| `logo.png` | ~15 KB |
| `images/` | ~1.1 MB |
| PDF brochures | ~2.8 GB (not in repo) |
