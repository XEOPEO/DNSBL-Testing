#!/bin/bash
results=$(ls results/)
totalblocked=0
count=0

for result in $results
do
  count=$(cat results/$result)
  totalblocked=$(($totalblocked+$count))
done

totalrecords=$(cat <dns_blocklist_file> | wc -l)

let percentage=$((100*totalblocked/totalrecords))

echo "Blockrate is ${percentage}%"
echo "Ratio: ${totalblocked}/${totalrecords}"
