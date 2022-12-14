#!/bin/bash
# File to read domains from
blocklist_file="wordfiles/$1"
dnsip="$2"

# Count total domains in blocklist
blockedcount=0
testedcount=0

for domain in $(cat $blocklist_file)
do
  let testedcount++
  ip=$(dig @$dnsip +short $domain | tail -n1)
  if [ -z "$ip" ] || [ "$ip" == "0.0.0.0" ] || [ "$ip" == "198.251.90.71" ] || [ "$ip" == "103.224.182.210" ] || [ "$ip" == "2.2.2.2" ] || [ "$ip" == "52.212.6.220" ] || [ "$ip" == "52.17.217.207" ] || [ "$ip" == "159.100.251.128" ]
  then
    let blockedcount++
  fi
  echo -e "${blockedcount}\n${testedcount}" > "results/result-$1.txt"
  sleep 0.4
done
