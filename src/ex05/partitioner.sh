#!/bin/sh

input_file="../ex03/hh_positions.csv"
output_dir="partitions"

mkdir -p "$output_dir"

header=$(head -n 1 "$input_file")

tail -n +2 "$input_file" | while IFS= read -r line; do
    date=$(echo "$line" | cut -d',' -f2 | cut -d'T' -f1 | tr -d '"')
    
    output_file="${output_dir}/${date}.csv"
    
    if [ ! -f "$output_file" ]; then
        echo "$header" > "$output_file"
    fi
    
    echo "$line" >> "$output_file"
done
