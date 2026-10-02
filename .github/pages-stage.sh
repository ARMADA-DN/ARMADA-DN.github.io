#!/bin/sh
# Stage the site for GitHub Pages: copy the repository into _site/, leaving out
# what .pagesignore lists, then fail if a doc asset from the README's asset
# table would be published anyway.
set -eu

[ -f .pagesignore ] || { echo "pages-stage: no .pagesignore" >&2; exit 1; }
[ -f README.md ] || { echo "pages-stage: no README.md, so no asset table to check" >&2; exit 1; }

rm -rf _site
mkdir _site
rsync -a --exclude-from=.pagesignore ./ _site/

status=0
for path in $(awk -F'|' '$3 ~ /^ *doc *$/ { gsub(/[ `]/, "", $2); print $2 }' README.md); do
  if [ -e "_site/$path" ]; then
    echo "pages-stage: $path is a doc asset in README.md but would be published;" \
      "add it to .pagesignore" >&2
    status=1
  fi
done
exit "$status"
