#!/bin/sh
# Exercise 02: Sorting a file
# Sorts hh.csv (from exercise 01) by the column "created_at" and then by "id"
# in ascending order, keeping the header in the first row. The result is saved
# into hh_sorted.csv.
#
# Allowed tools: cat, sort, head, tail

BASEDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
SRC="$BASEDIR/../ex01/hh.csv"
DST="$BASEDIR/hh_sorted.csv"

# Header goes first, data rows are sorted by created_at (field 2), then id (field 1)
head -n 1 "$SRC" > "$DST"
tail -n +2 "$SRC" | sort -t',' -k2,2 -k1,1 >> "$DST"
