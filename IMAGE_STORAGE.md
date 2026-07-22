# Automania — Car Image Storage Guide

> For developers who need to check, update, or add car images.

---

## Where Images Are Stored

All car images are stored in **Supabase Storage** (object storage, like AWS S3) — not in the PostgreSQL database.

| What | Where |
|---|---|
| **Image files** | Supabase Storage bucket `car-images` |
| **Image URLs** | `cars.img` column in Supabase PostgreSQL DB |
| **Fallback URLs** | `LOCAL_CARS_FALLBACK[]` array in `index.html` (~line 735) |

---

## Supabase Project Details

| Field | Value |
|---|---|
| Project ID | `jqtdcfbecagpdtzfvvow` |
| Storage bucket | `car-images` |
| Bucket visibility | **Public** (no auth needed to view images) |
| Dashboard | https://supabase.com/dashboard/project/jqtdcfbecagpdtzfvvow/storage/buckets/car-images |

---

## Image URL Format

Every car image follows this naming pattern:

```
https://jqtdcfbecagpdtzfvvow.supabase.co/storage/v1/object/public/car-images/car-{id}.{ext}
```

Examples:
```
car-1.png     → Toyota Land Cruiser 300
car-2.jpg     → Nissan Patrol 2025
car-72.webp   → Dongfeng 007
car-125.png   → 212 T01 BAW
```

Supported extensions: `.jpg`, `.png`, `.webp`, `.avif`

---

## How Image Loading Works at Runtime

```
Page loads
    ↓
Fetch cars table from Supabase DB
    ↓ (each row has an img URL)
Browser loads image from Supabase Storage
    ↓ (if Supabase DB is unreachable)
Falls back to LOCAL_CARS_FALLBACK in index.html
    ↓ (if Supabase Storage image 404s)
Falls back to local images/ folder (car-{id}.jpg)
    ↓ (if that also fails)
Shows SVG placeholder with brand colour
```

---

## How to Update an Existing Car's Image

### Option A — Via Supabase Dashboard (quickest)

1. Go to https://supabase.com/dashboard/project/jqtdcfbecagpdtzfvvow/storage/buckets/car-images
2. Delete the old file (e.g. `car-5.jpg`)
3. Upload the new file — **name it exactly** `car-{id}.{ext}` (e.g. `car-5.png`)
4. Copy the public URL from the dashboard
5. In the Supabase SQL editor, run:
   ```sql
   UPDATE cars SET img = 'https://jqtdcfbecagpdtzfvvow.supabase.co/storage/v1/object/public/car-images/car-5.png'
   WHERE id = 5;
   ```
6. Also update the matching entry in `LOCAL_CARS_FALLBACK[]` in `index.html` and commit

### Option B — Via upload script (batch)

Use the `.command` scripts in the project root. They download images from source URLs, upload to Supabase Storage with the correct filename, and update both `index.html` and generate `update_cars.sql` for the DB.

```
fix_final_v3.command   ← most recent batch upload script
apply_new_urls.py      ← updates index.html + generates update_cars.sql
update_cars.sql        ← paste into Supabase SQL editor after running scripts
```

---

## How to Add an Image for a New Car

1. Get a clean image from the manufacturer's official website (no Wikipedia — images can be outdated)
2. Name it `car-{id}.{ext}` where `id` is the car's integer ID
3. Upload to Supabase Storage bucket `car-images`
4. Update `cars.img` in the DB with the public URL
5. Update the `img` field in `LOCAL_CARS_FALLBACK[]` in `index.html`
6. Commit and push `index.html`

---

## Checking Which Cars Are Missing or Have Bad Images

Run this SQL in the Supabase SQL editor to find cars with no image set:

```sql
SELECT id, brand, model, img
FROM cars
WHERE img IS NULL OR img = ''
ORDER BY id;
```

To check cars still pointing at old Wikipedia URLs:

```sql
SELECT id, brand, model, img
FROM cars
WHERE img LIKE '%wikipedia%'
ORDER BY id;
```

---

## upload_results.json

The file `upload_results.json` in the project root tracks which cars have been successfully uploaded to Supabase Storage. Check it to see which IDs are done:

```json
{
  "ok": [
    { "id": 1, "filename": "car-1.png", "newUrl": "https://..." },
    ...
  ]
}
```

---

## Contact

Any questions about storage setup or access — contact **Ganesh Singh** · hello@automania.qa · +974 50979699
