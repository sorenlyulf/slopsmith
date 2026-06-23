#!/usr/bin/env bash
# Regenerate static/tailwind.min.css from the project's content globs.
# This is a maintainer task — the generated CSS is committed, so end
# users / Docker / desktop builds never run this. Required when adding
# new Tailwind utility classes that aren't yet present in committed
# source.
#
# Pin to Tailwind 3.x so the input/config syntax matches what was
# already shipped via the Play CDN (Tailwind 4 has breaking changes).
set -euo pipefail
cd "$(dirname "$0")/.."
# Pin to the exact version used to generate the committed CSS — committed
# artifacts must rebuild byte-stable for diff-friendly maintenance. The
# pinned version is the one that produced the current static/tailwind.min.css
# (visible in its top-of-file header comment); bump deliberately when you
# want to track upstream Tailwind 3.x updates, and regenerate the CSS in
# the same commit.
exec npx -y tailwindcss@3.4.19 \
    -c tailwind.config.js \
    -i static/_tailwind.src.css \
    -o static/tailwind.min.css \
    --minify
