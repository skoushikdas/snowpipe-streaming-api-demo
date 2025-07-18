#!/bin/bash

INPUT_FILE="$1"

# Extract base filename (no folder path)
BASE_NAME=$(basename "$INPUT_FILE")  # filename.csv or filename.csv.gz
FILE_NAME_NO_GZ="${BASE_NAME%.gz}"   # filename.csv
FILE_NAME_NO_EXT="${FILE_NAME_NO_GZ%.csv}"  # filename

# Create output filenames (prepend "unprocess/" or "original/" accordingly)
HEADER_FILE="original/${FILE_NAME_NO_GZ}.hdt"
if [[ "$INPUT_FILE" == *.gz ]]; then
  DATA_FILE="unprocess/${FILE_NAME_NO_GZ}.gz"
else
  DATA_FILE="unprocess/${FILE_NAME_NO_GZ}"
fi

# Processing
if [[ "$INPUT_FILE" == *.gz ]]; then
  gunzip -c "$INPUT_FILE" | head -1 > "$HEADER_FILE"
  gunzip -c "$INPUT_FILE" | sed '1d;$d' | gzip > "$DATA_FILE"
else
  head -1 "$INPUT_FILE" > "$HEADER_FILE"
  sed '1d;$d' "$INPUT_FILE" > "$DATA_FILE"
fi

echo "✅ Header saved to: $HEADER_FILE"
echo "✅ Data saved to  : $DATA_FILE"
