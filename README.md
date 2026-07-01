# Automania.qa — Qatar's Premier Auto Marketplace

> ✦ Choose the car. Protect the dream. ✦

A single-page web application (SPA) for browsing, comparing, and consulting on cars available in Qatar. Built with vanilla HTML, CSS, and JavaScript — no build tools required.

---

## Quick Start (Local)

```bash
# 1. Clone the repo
git clone https://github.com/gitlearning-gsr/automania-qa.git
cd automania-qa

# 2. Open in browser (no server needed for basic use)
open index.html

# 3. For brochure PDFs — download from Supabase Storage (see docs/SUPABASE.md)
#    or request the PDF archive from the project owner
```

---

## Project Structure

```
automania-qa/
├── index.html              ← Entire SPA (HTML + CSS + JS in one file)
├── logo.png                ← Automania logo (transparent PNG, 996×195px)
├── images/                 ← Miscellaneous UI images
├── assets/                 ← Static assets
├── docs/
│   ├── SETUP.md            ← Local development guide
│   ├── SUPABASE.md         ← Database migration & API integration
│   ├── DEPLOYMENT.md       ← Deploy to Netlify / Vercel
│   └── CONTRIBUTING.md     ← How to add cars, brands, fix bugs
└── .gitignore
```

> **Note:** PDF brochures (~2.8 GB, 418 files) are NOT in this repo. They are excluded via `.gitignore`.  
> Store them in Supabase Storage or a CDN. See `docs/SUPABASE.md`.

---

## Key Features

| Feature | How it works |
|---|---|
| 65 cars across 30+ brands | `CARS[]` array in `index.html` (~line 590) |
| Brand filter pills | `filterByBrand()` + `renderBrowse()` |
| Category chips (SUV/Sedan…) | `showPageFilter(type)` |
| Car comparison (up to 3) | `compareList[]` + `renderCompareModal()` |
| EV Hub | `renderEvCars()`, `renderCharging()` |
| PDF Brochure download | `car.pdf` field — supports local paths & external URLs |
| Free Consulting form | `showPage('consult')` → WhatsApp/email submit |
| Hero search | `doSearch()` reads `#hsBrand`, `#hsType`, `#hsBudget` |
| Dark mode | CSS `prefers-color-scheme` + manual toggle |
| Logo | `logo.png` (header) + white-filtered version (footer) |

---

## Car Data Schema

Each car in the `CARS[]` array follows this schema:

```javascript
{
  id: 1,                          // Unique integer
  wiki: 'Toyota Land Cruiser 300',// Wikipedia page name (for fallback image)
  brand: 'Toyota',                // Must match a BRANDS[] entry
  model: 'Land Cruiser 300',      // Display name
  type: 'suv',                    // suv | sedan | pickup | luxury | ev | mpv | sports | chinese
  badge: 'Hybrid',                // Hybrid | PHEV | EV | null
  price: 280000,                  // QAR (integer)
  featured: true,                 // Show in Featured section on home page
  upcoming: false,                // Show in Upcoming section (orange "Upcoming" badge)
  pdf: 'Toyota_Qatar/brochure.pdf', // Local path OR full https:// URL. '' = no brochure
  img: 'https://...',             // Direct image URL (manufacturer CDN preferred)
  specs: {                        // Optional — shown in car detail modal
    engine: '3.5L V6 Twin-Turbo',
    power: '305 hp',
    torque: '650 Nm',
    transmission: '10-Speed Auto',
    drive: '4WD',
    fuel: 'Petrol'
  }
}
```

---

## How to Add a New Car

1. Open `index.html` and find the `CARS` array (search for `const CARS=[`)
2. Copy an existing car object as a template
3. Assign a new `id` (next integer after the last one)
4. Fill in all fields (see schema above)
5. Add a brochure PDF to the appropriate brand folder if available
6. If the brand is new, add it to the `BRANDS[]` array (search for `const BRANDS=[`)
7. Save and test in browser

See `docs/CONTRIBUTING.md` for full details.

---

## How to Add a New Brand

Find `const BRANDS=[` in `index.html` and add:

```javascript
{name:'YourBrand', color:'#hexcolor'}
```

The `color` is used for the brand pill background on the home page.

---

## Technology Stack

- **Frontend:** Vanilla HTML5, CSS3, JavaScript (ES6+) — zero dependencies
- **Images:** Loaded from manufacturer CDNs; Wikipedia API used as fallback
- **PDFs:** Served from local folder or Supabase Storage (see docs)
- **Database (planned):** Supabase (PostgreSQL) — see `docs/SUPABASE.md`
- **Deployment:** Netlify or Vercel — see `docs/DEPLOYMENT.md`

---

## Contact

**Automania.qa** · Doha, Qatar  
📞 +974 50979699 · ✉️ hello@automania.qa
