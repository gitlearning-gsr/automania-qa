# Contributing Guide — Automania.qa

Everything a developer needs to add cars, fix bugs, or extend the site.

---

## Workflow Overview

```
Edit index.html → Test in browser → Commit → Push to GitHub → Deploy (auto via Netlify/Vercel)
```

No build step. No npm install. No framework. Open the file, edit, refresh browser.

---

## Adding Cars

### Step 1 — Find the CARS array
In `index.html`, search for:
```
const CARS=[
```
It starts around line 590.

### Step 2 — Add your car object

```javascript
{
  id: 66,                           // ← next integer after last car
  wiki: 'Toyota Fortuner',          // Wikipedia article name (for image fallback)
  brand: 'Toyota',                  // ← must match BRANDS[] entry exactly
  model: 'Fortuner 2025',
  type: 'suv',                      // suv|sedan|pickup|luxury|ev|mpv|sports|chinese
  badge: null,                      // 'Hybrid'|'PHEV'|'EV'|null
  price: 145000,                    // QAR
  featured: false,
  upcoming: false,
  pdf: 'Toyota/Fortuner_2025.pdf',  // relative path OR full URL. '' = no brochure
  img: 'https://global.toyota/pages/models/images/fortuner/fortuner_kv.jpg',
  specs: {
    engine: '2.8L Diesel Turbo',
    power: '204 hp',
    torque: '500 Nm',
    transmission: '6-Speed Auto',
    drive: '4WD',
    fuel: 'Diesel'
  }
}
```

> Tip: Use `featured: true` for top 6 cars shown on the home page hero.  
> Use `upcoming: true` for models not yet available in Qatar.

### Step 3 — Add the brochure PDF (optional)
Place the PDF in the matching brand folder:
```
automania-qa/Toyota/Fortuner_2025.pdf
```

### Step 4 — Test
Open `index.html` in browser → browse → search for the car name → verify card shows correct image and brochure link works.

---

## Fixing / Updating Car Images

Each car has:
```javascript
img: 'https://manufacturer-cdn.com/path/to/image.jpg'
```

Rules:
- Use **official manufacturer CDN** URLs (toyota.com, kia.com, hyundai.com, etc.)
- Do NOT use Wikipedia, Wikipedia Commons, or news site images as primary
- Prefer `jpg` or `webp` from the manufacturer's own media server
- The `wiki:` field is only the **fallback** — set it to the correct Wikipedia page name for that model

If a manufacturer CDN URL breaks, update to the current URL from the car's official website.

---

## Adding a New Brand

Find `const BRANDS=[` (around line 595 in `index.html`):

```javascript
{name:'NewBrand', color:'#2563eb'}
```

Choose a hex color that matches the brand's identity. The color appears in brand filter pills on the home page.

---

## Editing the Car Filter / Browse Logic

Key functions:

| Function | Purpose |
|---|---|
| `filterByBrand(b)` | Called by brand pill click — sets `browseFilters.brand` |
| `showPageFilter(type)` | Called by type chip click — sets `browseFilters.type` |
| `renderBrowse()` | Reads `browseFilters`, filters CARS[], renders grid |
| `renderHomeSections()` | Renders sectioned cards on home page |
| `applyChip(filter, el)` | Home page category chip handler |

The `browseFilters` global object controls all active filters:
```javascript
browseFilters = { search:'', type:'', brand:'', minP:0, maxP:9999999 }
```

---

## CSS Variables (Theme)

```css
--orange: #f05a1a     /* Primary accent — used for CTAs, badges, highlights */
--navy:   #1a2744     /* Dark background — header, footer, EV hub */
--bg:     #faf9f7     /* Page background (ivory white) */
--text:   #1a1a1a     /* Primary text */
--muted:  #6b7280     /* Secondary text */
--border: #e5e5e5     /* Card borders */
```

---

## Common Tasks

### Change phone number
Search for `50979699` in `index.html` — appears in 3 places (topbar, WhatsApp link, footer).

### Change email
Search for `hello@automania.qa`.

### Update the logo
Replace `logo.png` in the root folder. Keep it transparent PNG.  
Recommended size: ~1000×200px (wide landscape logo).

### Add a new page/section
1. Add a `<div class="page" id="page-yourpage">` block in the HTML
2. Add a nav item: `<div class="hn-item" onclick="showPage('yourpage',this)">Label</div>`
3. Add `if(pageId==='yourpage'){renderYourPage();}` in `showPage()`
4. Write the `renderYourPage()` function in the script section

---

## Git Workflow

```bash
# Before starting work
git pull origin main

# After making changes
git add index.html logo.png docs/
git commit -m "feat: add Toyota Fortuner 2025"
git push origin main

# Netlify/Vercel auto-deploys on push to main
```

### Commit message format
```
feat: add [car/feature name]
fix: [what was broken and how fixed]
update: [what changed]
docs: [documentation update]
```
