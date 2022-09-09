#!/bin/bash
function ctrl_c()
{
  pkill -9 -f dnsbl-sub.sh
  exit 1
}
# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

# Request which DNS server to be used
read -p "DNS ServerIP: " dnsip

count=0
totalrecords=0
files=$(ls wordfiles/)
for file in $files
do
  subrecord=$(cat wordfiles/$file | wc -l)
  totalrecords=$(($totalrecords+$subrecord))
  let count++
  /bin/bash dnsbl-sub.sh $file $dnsip&
done

totalblocked=0
count=0
result_count=0
results=$(ls results/)

while [ $count -lt $totalrecords ]
do
  count=0
  totalblocked=0
  for result in $results
  do
    result_count=$(cat results/$result | head -n1)
    if [[ -z $result_count ]]; then
      result_count=0
    fi
    totalblocked=$(($totalblocked+$result_count))
    subcount=$(cat results/$result | tail -n1)
    if [[ -z $subcount ]]; then
      subcount=0
    fi
    count=$(($count+$subcount))
  done

  let percentage=$((100*totalblocked/count))
  let progress=$((100*count/totalrecords))

  clear
  echo "Blockrate is ${percentage}%"
  echo "Ratio: ${totalblocked}/${count}"
  echo "Progress: ${progress}%"
done
