#!/bin/sh
# Exercise 05: Partitioning and concatenation (part 2)
# Takes as input the separate partition files produced by partitioner.sh and
# concatenates them into one CSV file (hh_concatenated.csv). The header is kept
# only once, in the first row, so the result is equal to the result of exercise 03.
#
# Allowed tools: no restrictions

BASEDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
DST="$BASEDIR/hh_concatenated.csv"

# Collect all partition files (hh_<date>.csv) and sort them by name, so that
# the concatenated result preserves the order of the original sorted data.
PARTS=$(ls "$BASEDIR"/hh_[0-9]*.csv 2>/dev/null | sort)

header_done=0
: > "$DST"
for part in $PARTS; do
    if [ "$header_done" -eq 0 ]; then
        head -n 1 "$part" >> "$DST"
        header_done=1
    fi
    tail -n +2 "$part" >> "$DST"
done
