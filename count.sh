#!/bin/bash

while read line
do
    echo "each line is : $line"
done < example.txt

file="example.txt"
totalwords=$(wc -w < example.txt)

echo "total words: $totalwords"


read -a WORDS -d "" < example.txt
echo ${WORDS}
for word in "${WORDS[@]}"
do 
    echo $word
done