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

wordfreq() {
   awk 'BEGIN { FS="[^a-zA-Z]+" } 
   { for (i=1; i<=NF; i++) { word = tolower($i); words[word]++ } 
   } 
   END 
   { for (w in words) printf("%3d %s\n", words[w], w) } ' | sort -rn; 
}