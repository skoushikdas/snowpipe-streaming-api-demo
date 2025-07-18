#!/bin/bash

set -e

INPUT_FILE="$1"

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "❌ File not found: $INPUT_FILE" >&2
  exit 1
fi

# Handle .gz (compressed CSV)
if [[ "$INPUT_FILE" == *.gz ]]; then
  BASENAME="${INPUT_FILE%.gz}"

  # Unzip and process
  gunzip -c "$INPUT_FILE" > "${BASENAME}_tmp.csv"

  # Extract parts
  head -n 1 "${BASENAME}_tmp.csv" > "${INPUT_FILE}.hdt"
  tail -n 1 "${BASENAME}_tmp.csv" > "${INPUT_FILE}.fdt"

  # Extract data (excluding header and footer)
  TOTAL_LINES=$(wc -l < "${BASENAME}_tmp.csv")
  if [[ "$TOTAL_LINES" -gt 2 ]]; then
    tail -n +2 "${BASENAME}_tmp.csv" | head -n $((TOTAL_LINES - 2)) > "${BASENAME}"
  else
    > "${BASENAME}"
  fi

  # Zip back the data file
  gzip -f "${BASENAME}"

  # Cleanup
  rm -f "${BASENAME}_tmp.csv"

  echo "✅ Done: Data -> ${BASENAME}.gz | Header -> ${INPUT_FILE}.hdt | Footer -> ${INPUT_FILE}.fdt"

# Handle plain CSV (no zip/unzip needed)
else
  head -n 1 "$INPUT_FILE" > "${INPUT_FILE}.hdt"
  tail -n 1 "$INPUT_FILE" > "${INPUT_FILE}.fdt"

  TOTAL_LINES=$(wc -l < "$INPUT_FILE")
  if [[ "$TOTAL_LINES" -gt 2 ]]; then
    tail -n +2 "$INPUT_FILE" | head -n $((TOTAL_LINES - 2)) > "$INPUT_FILE.data"
  else
    > "$INPUT_FILE.data"
  fi

  echo "✅ Done: Data -> $INPUT_FILE.data | Header -> ${INPUT_FILE}.hdt | Footer -> ${INPUT_FILE}.fdt"
fi
