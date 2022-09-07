#!/bin/bash
count=0
files=$(ls wordfiles/)
for file in $files
do
  let count++
  /bin/bash dnsbl-sub.sh $file > "results/result${count}.txt"&
done
