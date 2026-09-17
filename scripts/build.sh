#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
expected_version="$(tr -d '\r\n' < .hugo-version)"
installed_version="$(hugo version)"
version_token="${installed_version#hugo v}"
version_token="${version_token%% *}"
actual_version="${version_token%%[-+]*}"

if [[ "$actual_version" != "$expected_version" || "$version_token" != *+extended* ]]; then
  printf 'Expected Hugo Extended %s; found %s\n' "$expected_version" "$installed_version" >&2
  printf 'Set HUGO_VERSION=%s in both Cloudflare Pages environments.\n' "$expected_version" >&2
  exit 1
fi

hugo --environment production --minify --panicOnWarning "$@"
