#!/bin/bash

while read line
do
    echo "each line is : $line"
done < example.txt

file="example.txt"
totalwords=$(wc -w < example.txt)

echo "total words: $totalwords"


read -a WORDS -d "" < example.txt
for word in "${WORDS[@]}"
do 
 if [ -n "$word" ]
 then
            # Increment the count of the word in the associative array
    ((word_count["$word"]++))
 fi
done
counter=0
for word in "${!word_count[@]}"; do
    printf "%-10s : %d\n" "$word" "${word_count[$word]}"
    ((counter++))
    if [ $counter -eq 5 ]; then
        break
    fi
done

awk '{ for (i=1; i<=NF; i++) print $i }' "example.txt" | sort | uniq -c | sort -nr | head -n 5