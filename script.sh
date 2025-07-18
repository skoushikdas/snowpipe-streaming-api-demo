#!/bin/bash

INPUT_FILE="$1"
FILENAME=$(basename "$INPUT_FILE")                  # filename.csv or filename.csv.gz
FILENAME_NO_GZ="${FILENAME%.gz}"                    # filename.csv
FILENAME_NO_EXT="${FILENAME_NO_GZ%.*}"              # filename
INPUT_DIR=$(dirname "$INPUT_FILE")
OUTPUT_DIR="unprocessed"

mkdir -p "$OUTPUT_DIR"

# If input is .gz
if [[ "$INPUT_FILE" == *.gz ]]; then
  # Extract header
  gunzip -c "$INPUT_FILE" | head -1 > "$INPUT_FILE.hdt"

  # Extract middle data (without header/footer), then gzip again
  gunzip -c "$INPUT_FILE" | sed '1d;$d' > "$OUTPUT_DIR/$FILENAME_NO_GZ"
  gzip -f "$OUTPUT_DIR/$FILENAME_NO_GZ"

# If input is plain CSV
else
  # Extract header
  head -1 "$INPUT_FILE" > "$INPUT_FILE.hdt"

  # Extract middle data only
  sed '1d;$d' "$INPUT_FILE" > "$OUTPUT_DIR/$FILENAME"
fi
