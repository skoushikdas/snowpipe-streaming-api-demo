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

  # Unzip to temp file
  gunzip -c "$INPUT_FILE" > "${BASENAME}_tmp.csv"

  # Header
  head -n 1 "${BASENAME}_tmp.csv" > "${INPUT_FILE}.hdt"
  # Footer
  tail -n 1 "${BASENAME}_tmp.csv" > "${INPUT_FILE}.fdt"
  # Data (remove header and footer)
  sed '1d;$d' "${BASENAME}_tmp.csv" > "${BASENAME}"

  # Re-compress data file (same name as input, minus .gz)
  gzip -f "${BASENAME}"

  # Cleanup
  rm -f "${BASENAME}_tmp.csv"

  echo "✅ Done: Data -> ${BASENAME}.gz | Header -> ${INPUT_FILE}.hdt | Footer -> ${INPUT_FILE}.fdt"

# Handle plain CSV (not compressed)
else
  # Header
  head -n 1 "$INPUT_FILE" > "${INPUT_FILE}.hdt"
  # Footer
  tail -n 1 "$INPUT_FILE" > "${INPUT_FILE}.fdt"
  # Data (in-place overwrite without header/footer)
  TMP_DATA="${INPUT_FILE}.tmp"
  sed '1d;$d' "$INPUT_FILE" > "$TMP_DATA"
  mv "$TMP_DATA" "$INPUT_FILE"

  echo "✅ Done: Data -> $INPUT_FILE | Header -> ${INPUT_FILE}.hdt | Footer -> ${INPUT_FILE}.fdt"
fi
