#!/usr/bin/env bash
set -euo pipefail

# Resolve repo root (this script is in scripts/)
ROOT="$(cd "$(dirname "$0")/.."; pwd)"
DATA_DIR="$ROOT/composer/data/lessons"
CONTENT_DIR="$ROOT/content/lessons"

# Ensure mikefarah yq v4
if ! yq --version 2>/dev/null | grep -qi 'mikefarah'; then
  echo "Please install yq v4 (mikefarah). On macOS: brew install yq"
  exit 1
fi

slugify() {
  # e.g. "mansfield:bliss-opening" -> "mansfield-bliss-opening"
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g'
}

shopt -s nullglob
for yf in "$DATA_DIR"/*.yaml "$DATA_DIR"/*.yml; do
  # Read either top-level list or {lessons: [...]}
  while IFS=$'\t' read -r id date lastmod; do
    [[ -z "${id:-}" ]] && continue
    slug="$(slugify "${id/:/-}")"
    md="$CONTENT_DIR/$slug.md"
    if [[ ! -f "$md" ]]; then
      echo "• skip (no stub): $md"
      continue
    fi

    # Build a yq filter only for fields we have
    filter="."
    changed=0
    if [[ -n "${date:-}" ]]; then
      filter="$filter | .date = \"$date\""
      changed=1
    fi
    if [[ -n "${lastmod:-}" ]]; then
      filter="$filter | .lastmod = \"$lastmod\""
      changed=1
    fi

    if [[ $changed -eq 1 ]]; then
      yq -i eval --front-matter=process "$filter" "$md"
      echo "✓ synced: $slug  (date=${date:-keep} lastmod=${lastmod:-keep})"
    else
      echo "• no changes: $slug"
    fi
  done < <(
    # Output TSV: id \t date \t lastmod
    yq -o=tsv '(.lessons // .)[] | [.id, (.date // ""), (.lastmod // "")] | @tsv' "$yf" 2>/dev/null || true
  )
done
