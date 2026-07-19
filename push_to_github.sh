#!/bin/bash
# Run this once to push the News page fix to GitHub
cd ~/Downloads/automania
rm -f .git/index.lock
git add index.html
git commit -m "Move News to dedicated page; restore clean home"
git push origin main
echo ""
echo "✅ Done! GitHub Pages will update in ~60 seconds."
echo "Open: https://gitlearning-gsr.github.io/automania-qa/"
