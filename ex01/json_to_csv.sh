#!/bin/sh
# Exercise 01: Transforming JSON to CSV
# Runs jq with the filter from filter.jq over ../ex00/hh.json and saves
# the result (5 columns: id, created_at, name, has_test, alternate_url)
# into hh.csv. The first row contains the headers.
#
# Allowed tools: jq

BASEDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

jq -r -f "$BASEDIR/filter.jq" "$BASEDIR/../ex00/hh.json" > "$BASEDIR/hh.csv"
