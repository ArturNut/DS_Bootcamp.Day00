#!/bin/sh
# Exercise 05: Partitioning and concatenation (part 1)
# Takes the result of exercise 03 (hh_positions.csv) as input and stores slices
# of data with different "created_at" dates in separate CSV files named for that
# date (e.g. hh_2020-04-11.csv). Every partition file has the header in its
# first row. The list of created partitions is written to partitions.txt so
# that concatenator.sh can pick them up.
#
# Allowed tools: no restrictions

BASEDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
SRC="$BASEDIR/../ex03/hh_positions.csv"

# Remove partitions from previous runs to keep the output clean and deterministic
rm -f "$BASEDIR"/hh_*.csv "$BASEDIR/partitions.txt"

HEADER=$(head -n 1 "$SRC")

LIST="$BASEDIR/partitions.txt"
: > "$LIST"

tail -n +2 "$SRC" | while IFS= read -r line; do
    # created_at is the second column, e.g. "2020-04-11T18:03:53+0300"
    date=$(printf '%s' "$line" | awk -F',' '{ print substr($2, 2, 10) }')
    part="$BASEDIR/hh_${date}.csv"
    if [ ! -f "$part" ]; then
        printf '%s\n' "$HEADER" > "$part"
        printf '%s\n' "${part##*/}" >> "$LIST"
    fi
    printf '%s\n' "$line" >> "$part"
done
