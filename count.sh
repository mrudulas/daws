#!/bin/bash

while read line
do
    echo "each line is : $line"
done < example.txt

file="example.txt"
totalwords=$(wc -w < example.txt)