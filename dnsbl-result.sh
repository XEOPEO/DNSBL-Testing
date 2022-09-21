#!/bin/bash
results=$(ls results/)
totalblocked=0
count=0
totalrecords=0

for result in $results
do
  count=$(cat results/$result | head -n1)
  records=$(cat results/$result | tail -n1)
  totalblocked=$(($totalblocked+$count))
  totalrecords=$(($totalrecords+$records))
done

let percentage=$((100*totalblocked/totalrecords))

echo "Blockrate is ${percentage}%"
echo "Ratio: ${totalblocked}/${totalrecords}"
