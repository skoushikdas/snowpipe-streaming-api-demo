#!/bin/bash

FILE="$1"

# Extract base name and extension
BASENAME=$(basename "$FILE")
EXT="${BASENAME##*.}"
FILENAME_NO_GZ="${BASENAME%.gz}"
FILENAME_NO_EXT="${FILENAME_NO_GZ%.csv}"

# Define file paths
HEADER_FILE="original\\${FILENAME_NO_GZ}.hdt"
OUTPUT_FILE="unprocess\\${FILENAME_NO_GZ}"

echo "Processing: $FILE"
echo "Header will be saved to: $HEADER_FILE"
echo "Data will be saved to: $OUTPUT_FILE"

if [[ "$EXT" == "gz" ]]; then
    # Process gzipped CSV file
    gunzip -c "$FILE" > "/tmp/${FILENAME_NO_GZ}"

    # Extract header
    head -n 1 "/tmp/${FILENAME_NO_GZ}" > "$HEADER_FILE"

    # Remove header and footer and re-gzip the output
    sed '1d;$d' "/tmp/${FILENAME_NO_GZ}" | gzip > "${OUTPUT_FILE}.gz"

    rm "/tmp/${FILENAME_NO_GZ}"
else
    # Extract header
    head -n 1 "$FILE" > "$HEADER_FILE"

    # Remove header and footer and save as CSV
    sed '1d;$d' "$FILE" > "$OUTPUT_FILE"
fi

echo "Done!"
