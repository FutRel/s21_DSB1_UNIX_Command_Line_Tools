#!/bin/sh

input_dir="partitions"
output_file="hh_concatenated.csv"

if [ ! -d "$input_dir" ]; then
    echo "Error"
    exit 1
fi

partition_files=$(find "$input_dir" -name "*.csv" | sort)

if [ -z "$partition_files" ]; then
    echo "Error"
    exit 1
fi

first_file=$(echo "$partition_files" | head -n 1)
head -n 1 "$first_file" > "$output_file"

for file in $partition_files; do
    tail -n +2 "$file" >> "$output_file"
done
