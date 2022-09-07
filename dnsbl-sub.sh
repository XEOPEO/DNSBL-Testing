#!/bin/bash
# File to read domains from
blocklist_file="wordfiles/$1"

# Count total domains in blocklist
blockedcount=0
percentage=0
testedcount=0

for domain in $(cat $blocklist_file)
do
  let testedcount++
  ip=$(dig +short $domain | tail -n1)
  if [ -z "$ip" ]
  then
    let blockedcount++
  fi
  sleep 0.2
done

echo "${blockedcount}"
