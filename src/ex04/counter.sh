#!/bin/sh
# Exercise 04: Descriptive statistics
# Counts unique values of the "name" column in hh_positions.csv (the result of
# exercise 03) and sorts the table by that count in descending order.
# The result is saved into hh_uniq_positions.csv with the header
# "name","count" in the first row.
#
# Allowed tools: no restrictions

BASEDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
SRC="$BASEDIR/../ex03/hh_positions.csv"
DST="$BASEDIR/hh_uniq_positions.csv"

echo '"name","count"' > "$DST"
# Extract the name column (strip the surrounding CSV quotes), count occurrences
# of every unique value and sort by the count in descending order.
tail -n +2 "$SRC" | awk -F',' '{ n = $3; gsub(/^"|"$/, "", n); print n }' | \
    sort | uniq -c | sed 's/^ *\([0-9]*\) \(.*\)/\1\t\2/' | sort -t"$(printf '\t')" -k1,1nr | \
    awk -F'\t' '{ print "\"" $2 "\"," $1 }' >> "$DST"
