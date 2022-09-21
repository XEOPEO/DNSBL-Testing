#!/bin/bash
# File to read domains from
read -p "Blocklist name to use: " blocklist_file

# Count total domains in blocklist
#rowcount_blocklist=$(cat stevenblackbl | wc -l)
read -p "DNS ServerIP: " dnsip

blockedcount=0
percentage=0
testedcount=0

for domain in $(cat $blocklist_file)
do
  let testedcount++
  echo "Domain: $domain"
  ip=$(dig @$dnsip +short $domain | tail -n1)
  if [ -z "$ip" ] || [ "$ip" == "0.0.0.0" ] || [ "$ip" == "198.251.90.71" ] || [ "$ip" == "103.224.182.210" ] || [ "$ip" == "2.2.2.2" ] || [ "$ip" == "52.212.6.220" ] || [ "$ip" == "52.17.217.207" ]; then
    let blockedcount++
  fi
  blockrate=$((100*blockedcount/testedcount))
  echo $ip
  sleep 0.2
done

let percentage=100*blockedcount/testedcount

echo "The DNS Server blocked ${blockedcount} domains"
echo "This is a ${percentage}% block rate"
