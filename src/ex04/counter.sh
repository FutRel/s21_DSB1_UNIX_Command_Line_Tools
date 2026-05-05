#!/bin/bash

input_file="../ex03/hh_positions.csv" 
output_file="hh_uniq_positions.csv"

echo '"name", "count"' > "$output_file"

tail -n +2 "$input_file" | cut -d',' -f3 | sort | uniq -c | awk '{print $2 "," $1}' >> "$output_file"

#or add |grep -v '"-"'| to not include '-' 'to result