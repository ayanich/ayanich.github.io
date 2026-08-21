#!/usr/bin/env bash
# Link and anchor integrity for the site. Run from the repository root.
#
#   ./scripts/check-links.sh
#
# Checks two things, both deterministic and both cheap:
#
#   1. every href="#foo" resolves to an id="foo" in the same file. On a
#      single-page CV the nav IS the site, so a renamed section silently
#      breaks navigation with no error anywhere.
#   2. every external link in an <a> tag still answers.
#
set -euo pipefail
fail=0

# NOTE the `|| true` on every grep. grep exits 1 when it matches nothing, and
# under `set -o pipefail` + `set -e` that kills the script silently -- which is
# exactly what 404.html does, having no id= attributes at all.

echo "--- internal anchors ---"
broken=0
for f in $(git ls-files '*.html'); do
  ids=$(grep -oE 'id="[^"]+"' "$f" | sed 's/.*id="//;s/"//' | sort -u || true)
  anchors=$(grep -oE 'href="#[^"]+"' "$f" | sed 's/.*href="#//;s/"//' | sort -u || true)
  [ -z "$anchors" ] && continue
  for a in $anchors; do
    if ! printf '%s\n' "$ids" | grep -qx "$a"; then
      echo "  BROKEN  $f -> #$a"; broken=1; fail=1
    fi
  done
done
[ "$broken" = "0" ] && echo "  all anchors resolve"

echo "--- external links (<a> tags only) ---"
urls=$(grep -ohE '<a[^>]+href="https?://[^"]+"' $(git ls-files '*.html') \
       | grep -oE 'https?://[^"]+' | sort -u || true)
for u in $urls; do
  case "$u" in
    *linkedin.com*)
      echo "  SKIP  (LinkedIn answers datacenter IPs with 999 regardless)  $u"
      continue ;;
  esac
  code=$(curl -sSL -o /dev/null -w '%{http_code}' -m 20 --retry 2 "$u" || echo 000)
  case "$code" in
    2*|3*) echo "  OK    $code  $u" ;;
    *)     echo "  DEAD  $code  $u"; fail=1 ;;
  esac
done
exit "$fail"
