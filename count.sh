#!/bin/bash

cat example.txt | while read line
do
    echo "each line is : $line"
done