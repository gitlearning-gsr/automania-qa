# Deployment Guide — Automania.qa

How to publish the Automania website live on the internet.

---

## Recommended: Netlify (Free)

Netlify auto-deploys from GitHub on every push. Zero config needed.

### Step 1 — Connect GitHub
1. Go to [https://netlify.com](https://netlify.com) → **Sign up with GitHub**
2. Click **Add new site → Import an existing project**
3. Choose **GitHub** → Select `gitlearning-gsr/automania-qa`
4. Branch: `main`
5. Build command: *(leave empty — no build step)*
6. Publish directory: `.` *(root)*
7. Click **Deploy site**

Your site is live in ~30 seconds at `https://random-name.netlify.app`

### Step 2 — Set Custom Domain (automania.qa)

1. In Netlify dashboard → **Domain settings → Add custom domain**
2. Enter: `automania.qa`
3. Netlify will give you DNS records (2 × A records or a CNAME)
4. Log in to your domain registrar (where you bought automania.qa)
5. Add the DNS records Netlify provides
6. DNS propagation takes 10–60 minutes
7. Netlify automatically enables HTTPS (SSL) via Let's Encrypt — free

### Step 3 — Auto-deploy on Push

After this setup, every `git push origin main` automatically redeploys the site within 30 seconds. No manual steps needed.

---

## Alternative: Vercel (also Free)

Same process as Netlify:

1. Go to [https://vercel.com](https://vercel.com) → Sign in with GitHub
2. **New Project → Import** `gitlearning-gsr/automania-qa`
3. Framework preset: **Other**
4. Click **Deploy**

Custom domain setup is identical — add DNS records from Vercel to your registrar.

---

## Alternative: GitHub Pages (Free, simplest)

If you don't want to use Netlify/Vercel:

1. Go to your GitHub repo → **Settings → Pages**
2. Source: **Deploy from a branch**
3. Branch: `main` / root `/`
4. Save — site is live at `https://gitlearning-gsr.github.io/automania-qa/`

> Note: GitHub Pages supports custom domains too, but Netlify/Vercel offer better performance and easier HTTPS.

---

## Brochure PDFs

PDFs are excluded from the GitHub repo (too large). Two options:

### Option A — Supabase Storage (Recommended)
Upload all PDF folders to Supabase Storage (see `docs/SUPABASE.md`).  
Update `pdf:` fields in the database to full Supabase Storage URLs.

### Option B — Netlify Large Media / LFS
Not recommended for 418 files / 2.8 GB.

### Option C — External CDN (Cloudflare R2, AWS S3)
Upload PDFs to an S3 bucket or Cloudflare R2, make them public, update `pdf:` fields.

---

## Environment Checklist Before Going Live

- [ ] `logo.png` is in the repo root
- [ ] `index.html` phone number is correct (`+974 50979699`)
- [ ] `index.html` email is correct (`hello@automania.qa`)
- [ ] All `img:` URLs in CARS array return valid images
- [ ] All `pdf:` fields point to accessible URLs (not local paths)
- [ ] No broken links in header/footer navigation
- [ ] Test on mobile (responsive layout)
- [ ] Test dark mode toggle
- [ ] Test brand filter pills
- [ ] Test compare feature (add 2–3 cars, open compare modal)
- [ ] Test consulting form (WhatsApp link opens correctly)

---

## Rollback

```bash
# Revert to previous working version
git log --oneline          # find the commit hash
git revert <commit-hash>   # creates a new commit that undoes changes
git push origin main       # auto-deploys the reverted version
```
