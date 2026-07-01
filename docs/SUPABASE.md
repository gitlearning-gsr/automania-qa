# Supabase Setup Guide — Automania.qa

Move car data from the hardcoded `CARS[]` array in `index.html` to a Supabase PostgreSQL database, and store brochure PDFs in Supabase Storage.

---

## Why Supabase?

- Free tier: 500 MB database + 1 GB file storage
- REST API auto-generated from your tables (no backend code needed)
- Works perfectly with a vanilla HTML/JS frontend
- Brochure PDFs (2.8 GB) can be migrated to Supabase Storage with public URLs

---

## Step 1 — Create Your Supabase Project

1. Go to [https://supabase.com](https://supabase.com) → Sign up / Log in
2. Click **New Project**
3. Name: `automania-qa`
4. Password: (save this securely)
5. Region: **Middle East (Bahrain)** `me-south-1` — closest to Qatar
6. Click **Create Project** and wait ~2 minutes

---

## Step 2 — Create the Cars Table

Go to **SQL Editor** in your Supabase dashboard and run:

```sql
-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- Cars table
create table cars (
  id          integer primary key,
  brand       text not null,
  model       text not null,
  type        text not null check (type in ('suv','sedan','pickup','luxury','ev','mpv','sports','chinese')),
  badge       text check (badge in ('Hybrid','PHEV','EV') or badge is null),
  price       integer not null,
  featured    boolean default false,
  upcoming    boolean default false,
  wiki        text,
  img         text,
  pdf         text,
  specs       jsonb,
  created_at  timestamptz default now()
);

-- Enable Row Level Security (but allow public reads)
alter table cars enable row level security;
create policy "Public read access" on cars for select using (true);

-- Index for fast filtering
create index cars_brand_idx on cars(brand);
create index cars_type_idx  on cars(type);
create index cars_price_idx on cars(price);
```

---

## Step 3 — Seed the Database

Export the current CARS array and insert it. Run this in **SQL Editor**:

```sql
-- Paste the INSERT statements generated from the CARS array
-- (use the data-export script in docs/scripts/export-cars.js)
INSERT INTO cars (id, brand, model, type, badge, price, featured, upcoming, wiki, img, pdf, specs)
VALUES
  (1,'Toyota','Land Cruiser 300','suv','Hybrid',280000,true,false,
   'Toyota Land Cruiser 300',
   'https://tmna.aemassets.toyota.com/is/image/toyota/toyota/jellies/relative/2027/landcruiser/base.png',
   'Toyota_Qatar/Land_Cruiser_Brochure.pdf',
   '{"engine":"3.5L V6 Twin-Turbo","power":"305 hp","torque":"650 Nm","transmission":"10-Speed Auto","drive":"4WD","fuel":"Petrol"}'
  ),
  -- ... repeat for all 65 cars
;
```

> **Shortcut:** Copy the `CARS` array from `index.html` and use ChatGPT/Claude to convert it to SQL INSERT statements.

---

## Step 4 — Get Your API Keys

In your Supabase dashboard → **Settings → API**:

- **Project URL:** `https://xxxxxxxxxxxx.supabase.co`
- **anon public key:** `eyJhbGciOiJIUzI1NiIs...` (safe to expose in frontend)

---

## Step 5 — Update index.html to Fetch from Supabase

Replace the hardcoded `const CARS=[...]` block with a fetch call:

```html
<!-- Add this in <head> -->
<script>
const SUPABASE_URL = 'https://xxxxxxxxxxxx.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIs...'; // anon public key

let CARS = [];  // Will be populated from API

async function loadCarsFromSupabase() {
  const res = await fetch(
    `${SUPABASE_URL}/rest/v1/cars?select=*&order=id.asc`,
    { headers: { 'apikey': SUPABASE_KEY, 'Authorization': 'Bearer ' + SUPABASE_KEY } }
  );
  CARS = await res.json();
  // Initialize app after data loads
  initBrowseDropdowns();
  renderBrandStrip();
  renderHomeSections();
}

// Call on page load
document.addEventListener('DOMContentLoaded', loadCarsFromSupabase);
</script>
```

---

## Step 6 — Upload Brochures to Supabase Storage

1. In Supabase dashboard → **Storage → New bucket**
2. Name: `brochures`
3. Set to **Public**
4. Upload your PDF folders (Toyota/, BYD/, Kia/, etc.)

After uploading, update PDF paths in the database from:
```
Toyota_Qatar/Land_Cruiser_Brochure.pdf
```
to:
```
https://xxxxxxxxxxxx.supabase.co/storage/v1/object/public/brochures/Toyota_Qatar/Land_Cruiser_Brochure.pdf
```

You can do this with a SQL UPDATE:
```sql
UPDATE cars
SET pdf = REPLACE(
  'https://xxxxxxxxxxxx.supabase.co/storage/v1/object/public/brochures/' || pdf,
  'https://xxxxxxxxxxxx.supabase.co/storage/v1/object/public/brochures/',
  'https://xxxxxxxxxxxx.supabase.co/storage/v1/object/public/brochures/'
)
WHERE pdf != '' AND pdf NOT LIKE 'http%';
```

---

## Step 7 — Filter / Search via API

Instead of filtering client-side, you can query Supabase directly:

```javascript
// Filter by brand
const brand = 'Toyota';
fetch(`${SUPABASE_URL}/rest/v1/cars?brand=eq.${brand}&select=*`,
  { headers: { apikey: SUPABASE_KEY } }
)

// Filter by type + price range
fetch(`${SUPABASE_URL}/rest/v1/cars?type=eq.suv&price=gte.100000&price=lte.200000&select=*`,
  { headers: { apikey: SUPABASE_KEY } }
)

// Full text search on brand + model
fetch(`${SUPABASE_URL}/rest/v1/cars?or=(brand.ilike.*${q}*,model.ilike.*${q}*)&select=*`,
  { headers: { apikey: SUPABASE_KEY } }
)
```

---

## Environment Variables (for future Node/Vite setup)

```env
VITE_SUPABASE_URL=https://xxxxxxxxxxxx.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIs...
```

---

## Supabase Dashboard Quick Reference

| Task | Where |
|---|---|
| Run SQL | SQL Editor |
| Browse/edit data | Table Editor |
| Upload files | Storage |
| Get API keys | Settings → API |
| View API logs | Logs → API |
| Manage auth | Authentication |
