#!/bin/bash
# File to read domains from
blocklist_file="<dns_blocklist_file>"

blockedcount=0
percentage=0
testedcount=0

for domain in $(cat $blocklist_file)
do
  let testedcount++
  echo "Domain: ${domain}"
  ip=$(dig +short $domain | tail -n1)
  if [ -z "$ip" ]
  then
    let blockedcount++
    echo "Blocked"
    echo "${blockedcount}/${testedcount}"
  else
    echo "${blockedcount}/${testedcount}"
  fi
  blockrate=$((100*blockedcount/testedcount))
  echo "Blockrate: ${blockrate}%"
  #sleep 0.05
done

let percentage=100*blockedcount/testedcount

echo "The DNS Server blocked ${blockedcount} domains"
echo "This is a ${percentage}% block rate"
