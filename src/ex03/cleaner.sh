#!/bin/bash

input_file="../ex02/hh_sorted.csv" 
output_file="hh_positions.csv"

head -n 1 "$input_file" > "$output_file"

extract_position() {
    local name="$1"
    local result=""
    
    if echo "$name" | grep -qi "junior"; then
        result="Junior"
    fi
    if echo "$name" | grep -qi "middle"; then
        if [[ "$result" == "-" || -z "$result" ]]; then
            result="Middle"
        else
            result="${result}/Middle"
        fi
    fi
    if echo "$name" | grep -qi "senior"; then
        if [[ "$result" == "-" || -z "$result" ]]; then
            result="Senior"
        else
            result="${result}/Senior"
        fi
    fi
    
    echo "${result:--}"
}

tail -n +2 "$input_file" | while IFS= read -r line; do
    id=$(echo "$line" | awk -F',' '{print $1}')
    created_at=$(echo "$line" | awk -F',' '{print $2}')
    name=$(echo "$line" | awk -F',' '{
        result = ""
        for (i = 3; i < NF; i++) {
            if (result == "") {
                result = $i
            } else {
                result = result "," $i
            }
        }
        gsub(/^"|"$/, "", result)
        print result
    }')
    has_test=$(echo "$line" | awk -F',' '{print $(NF-1)}')
    alternate_url=$(echo "$line" | awk -F',' '{print $NF}')
    
    position=$(extract_position "$name")
    
    echo "\"$id\",\"$created_at\",\"$position\",\"$has_test\",\"$alternate_url\"" >> "$output_file"
    
done