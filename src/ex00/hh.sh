#!/bin/sh
# Exercise 00: First shell script
# Downloads information about the first 20 vacancies corresponding to the search
# parameters (default: 'data scientist') from the HeadHunter API and stores the
# result in hh.json. The JSON is pretty-printed with jq so that every field
# is placed on a separate line.
#
# Usage: ./hh.sh [vacancy name]
# Allowed tools: curl, jq

QUERY="${1:-data scientist}"
OUTDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
HHJSON="$OUTDIR/hh.json"

# URL-encode spaces in the search query
ENCODED_QUERY=$(printf '%s' "$QUERY" | sed 's/ /+/g')

curl -s -A "Mozilla/5.0" \
    -H "Accept: application/json" \
    "https://api.hh.ru/vacancies?text=${ENCODED_QUERY}&per_page=20" | jq '.' > "$HHJSON"
