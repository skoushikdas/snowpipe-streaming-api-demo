#!/bin/bash

set -e

INPUT_FILE="$1"

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "❌ File not found: $INPUT_FILE"
  exit 1
fi

# Get base filename (without full dir)
FILENAME=$(basename "$INPUT_FILE")  # e.g., file.csv or file.csv.gz
EXT="${FILENAME##*.}"

# Extract filename.csv (removing .gz if present)
if [[ "$FILENAME" == *.gz ]]; then
  CSV_FILENAME="${FILENAME%.gz}"  # file.csv
else
  CSV_FILENAME="$FILENAME"
fi

# Output paths
HEADER_OUT="original/${CSV_FILENAME}.hdt"
DATA_OUT="unprocessed/${CSV_FILENAME}"

# Ensure output dirs exist
mkdir -p original
mkdir -p unprocessed

# Handle .gz vs normal file
TMPFILE=$(mktemp /tmp/temp_csv_XXXXXX)

if [[ "$FILENAME" == *.gz ]]; then
  cp "$INPUT_FILE" "$TMPFILE.gz"
  gunzip -f "$TMPFILE.gz"  # Produces $TMPFILE
else
  cp "$INPUT_FILE" "$TMPFILE"
fi

# Extract header and data
head -n 1 "$TMPFILE" > "$HEADER_OUT"
sed '1d;$d' "$TMPFILE" > "$DATA_OUT"

# Cleanup
rm -f "$TMPFILE"

echo "✅ Header saved to: $HEADER_OUT"
echo "✅ Data saved to:   $DATA_OUT"
