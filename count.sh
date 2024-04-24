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
    echo "$word"
done

awk '{ for (i=1; i<=NF; i++) print $i }' "example.txt" | sort | uniq -c | sort -nr | head -n 5