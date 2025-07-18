#!/bin/bash

FILE="$1"  # e.g., original/filename.csv or original/filename.csv.gz

if [ ! -f "$FILE" ]; then
    echo "Error: File $FILE does not exist."
    exit 1
fi

# Extract filename and extension
BASENAME=$(basename "$FILE")
DIRNAME=$(dirname "$FILE")

# Remove .gz if exists
if [[ "$BASENAME" == *.gz ]]; then
    FILENAME_NO_GZ="${BASENAME%.gz}"
    IS_GZ=true
else
    FILENAME_NO_GZ="$BASENAME"
    IS_GZ=false
fi

# Extract header file path
HEADER_FILE="$DIRNAME/${FILENAME_NO_GZ}.hdt"

# Output data file (always in 'unprocess' dir, same file name and maybe gz)
OUTPUT_DIR="unprocess"
OUTPUT_FILE="$OUTPUT_DIR/$FILENAME_NO_GZ"

# Handle header and data extraction
if [ "$IS_GZ" = true ]; then
    # Extract header
    gunzip -c "$FILE" | head -n 1 > "$HEADER_FILE"
    # Extract data (without first and last lines)
    gunzip -c "$FILE" | sed '1d;$d' | gzip > "${OUTPUT_FILE}.gz"
else
    head -n 1 "$FILE" > "$HEADER_FILE"
    sed '1d;$d' "$FILE" > "$OUTPUT_FILE"
fi

echo "✅ Header saved to: $HEADER_FILE"
if [ "$IS_GZ" = true ]; then
    echo "✅ Data saved to: ${OUTPUT_FILE}.gz"
else
    echo "✅ Data saved to: $OUTPUT_FILE"
fi
