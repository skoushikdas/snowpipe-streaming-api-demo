#!/bin/bash
set -e

INPUT_FILE="$1"

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "❌ File not found: $INPUT_FILE"
  exit 1
fi

INPUT_DIR=$(dirname "$INPUT_FILE")
INPUT_NAME=$(basename "$INPUT_FILE")

# Handle .gz case
if [[ "$INPUT_NAME" == *.gz ]]; then
  BASE_NAME="${INPUT_NAME%.gz}"
  TMP_FILE=$(mktemp)
  gunzip -c "$INPUT_FILE" > "$TMP_FILE"

  # Header + footer extraction
  head -n 1 "$TMP_FILE" > "$INPUT_DIR/$BASE_NAME.hdt"
  tail -n 1 "$TMP_FILE" >> "$INPUT_DIR/$BASE_NAME.hdt"

  # Data-only extraction
  sed '1d;$d' "$TMP_FILE" > "$INPUT_DIR/$BASE_NAME"

  # Recompress data-only file
  gzip -f "$INPUT_DIR/$BASE_NAME"

  rm "$TMP_FILE"

  echo "✅ Extracted: $INPUT_DIR/$BASE_NAME.hdt"
  echo "✅ Data file (gz): $INPUT_DIR/$BASE_NAME.gz"

else
  BASE_NAME="$INPUT_NAME"

  # Header + footer extraction
  head -n 1 "$INPUT_FILE" > "$INPUT_DIR/$BASE_NAME.hdt"
  tail -n 1 "$INPUT_FILE" >> "$INPUT_DIR/$BASE_NAME.hdt"

  # Data-only overwrite
  TMP_FILE=$(mktemp)
  sed '1d;$d' "$INPUT_FILE" > "$TMP_FILE"
  mv "$TMP_FILE" "$INPUT_FILE"

  echo "✅ Extracted: $INPUT_DIR/$BASE_NAME.hdt"
  echo "✅ Data file (csv): $INPUT_FILE"
fi
