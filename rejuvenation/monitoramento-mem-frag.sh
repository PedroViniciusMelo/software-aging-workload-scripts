#!/bin/bash

result=$(stap memFrag.stp)

#print the first and second separetly row of the result to the file
used_pages=$(echo "$result" | head -n 1)
total_pages=$(echo "$result" | tail -n 1)
echo "$used_pages;$total_pages;$date_time" >>logs/monitoramento-memFrag.txt
