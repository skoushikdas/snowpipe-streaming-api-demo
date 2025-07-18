#!/bin/bash

INPUT_FILE="$1"

# Extract base name
BASE_NAME=$(basename "$INPUT_FILE")                   # e.g. filename.csv or filename.csv.gz
FILE_NAME_NO_GZ="${BASE_NAME%.gz}"                    # e.g. filename.csv
FILE_NAME_NO_EXT="${FILE_NAME_NO_GZ%.csv}"            # e.g. filename

# Final output paths (blob-style "folders" in filename only)
HEADER_FILE="original_${FILE_NAME_NO_GZ}.hdt"
DATA_FILE="unprocess_${FILE_NAME_NO_GZ}"

# If gz, decompress and re-compress data part
if [[ "$INPUT_FILE" == *.gz ]]; then
    gunzip -c "$INPUT_FILE" | head -1 > "$HEADER_FILE"
    gunzip -c "$INPUT_FILE" | sed '1d;$d' | gzip > "${DATA_FILE}.gz"
    echo "✅ Header: $HEADER_FILE"
    echo "✅ Data  : ${DATA_FILE}.gz"
else
    head -1 "$INPUT_FILE" > "$HEADER_FILE"
    sed '1d;$d' "$INPUT_FILE" > "$DATA_FILE"
    echo "✅ Header: $HEADER_FILE"
    echo "✅ Data  : $DATA_FILE"
fi
