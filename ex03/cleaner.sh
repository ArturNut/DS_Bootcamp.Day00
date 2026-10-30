#!/bin/sh
# Exercise 03: Replacing strings in a file
# Takes hh_sorted.csv (from exercise 02) and replaces every position name with
# the seniority extracted from it: "Junior", "Middle" and/or "Senior" (all of
# them are kept if several occur, e.g. "Middle/Senior Data Scientist" ->
# "Middle/Senior"). If the name contains none of these words, "-" is used.
# The result is saved into hh_positions.csv with the header kept in the first row.
#
# Allowed tools: no restrictions

BASEDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
SRC="$BASEDIR/../ex02/hh_sorted.csv"
DST="$BASEDIR/hh_positions.csv"

# The name is the third CSV column. For every row we extract Junior / Middle /
# Senior from the name: all matching words are kept and joined with "/",
# otherwise "-". If a name contains commas or quotes (CSV-quoted field), it
# never matches any of the three keywords, so such rows get "-" and the whole
# quoted field (which may span several awk fields) is replaced correctly.
awk -F',' 'NR==1 { print; next }
     {
         # Locate the quoted name field: from $3 up to the field ending with a quote
         start = 3
         if ($3 ~ /^"/) {
             end = start
             while (end <= NF && $end !~ /"$/) end++
         } else {
             end = start
         }
         name = $start
         for (i = start + 1; i <= end; i++) name = name "," $i
         out = ""
         if (name ~ /[Jj]unior/) out = out (out == "" ? "" : "/") "Junior"
         if (name ~ /[Mm]iddle/) out = out (out == "" ? "" : "/") "Middle"
         if (name ~ /[Ss]enior/) out = out (out == "" ? "" : "/") "Senior"
         if (out == "") out = "-"
         # Rebuild the row: id, created_at, cleaned name, then the remaining fields
         res = $1 "," $2 ",\"" out "\""
         for (i = end + 1; i <= NF; i++) res = res "," $i
         print res
     }' "$SRC" > "$DST"
