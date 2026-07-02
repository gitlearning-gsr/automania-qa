# Automania Project Context (Imported from Claude.ai)

## Project Description
I am building **Automania.qa**, a Qatar-only car research platform. Find the official manufacturer page for this car model from its origin/global brand website, not reseller or marketplace sites. For the selected car, extract:
1. Official model page URL
2. Official specifications page
3. Official features page
4. Brochure or PDF if available
5. Trim/variant names
6. Engine, transmission, drivetrain, fuel type
7. Dimensions, seating, cargo, safety, infotainment
8. Latest model year
9. Official image gallery links
10. If sold in Qatar, also find the Qatar official dealer/distributor page for cross-checking

Prioritize official brand domains first, then official Qatar distributor/dealer pages second. Avoid classifieds, blogs, and third-party review sites. Return results in a structured table with source URLs.

---

## Project Instructions (System Prompt)
Find the official global manufacturer page and official Qatar dealer page for [BRAND] [MODEL].
I need verified specs and features for my car database.

Prioritize:
- Official brand website
- Official regional website
- Official Qatar distributor/dealer

Extract model year, trims, engine, transmission, drivetrain, dimensions, seating, safety features, infotainment, warranty, brochure PDF, and official images.

Ignore marketplace, classified, and review websites.

Refer to the website layout as cardekho.com — I want to make a site like that.

---

## Chat History

### Conversation 1: Car brochures in downloads

**User:** [Asked about car brochures in the Downloads folder]

**Claude:** I don't have access to your local Downloads folder — I can only see files you've explicitly uploaded to this conversation, and I don't see any attachments here.

If you'd like me to look through car brochures, you have a couple of options:

You can drag and drop the PDF files (or any brochure files) directly into the chat, and I'll be happy to search through them, extract specs, compare models, or pull out anything useful for automania.qa.

Alternatively, if you want to do this at scale on your own machine, here's a quick command you could run locally on macOS to find car-related PDFs in your Downloads folder:

```bash
find ~/Downloads -type f \( -iname "*.pdf" -o -iname "*brochure*" \) | xargs -I {} sh -c 'echo "=== {} ==="; mdls -name kMDItemTitle -name kMDItemKeywords "{}"'
```

Or if you want to search by content for car-related keywords:

```bash
mdfind -onlyin ~/Downloads "kind:pdf AND (brochure OR specifications OR horsepower OR sedan OR SUV)"
```

---

## Notes
- Website inspiration: [cardekho.com](https://www.cardekho.com)
- Target market: Qatar only
- Goal: Qatar-only car research platform (automania.qa)
