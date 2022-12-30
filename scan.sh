#!/bin/bash

echo "Enter a domain name:"
read domain

# Use amass to gather subdomains
amass enum -passive -norecursive -noalts -d $domain >> subdomains.txt

# Use subfinder to gather subdomains
subfinder -d $domain >> subdomains.txt

# Use assetfinder to gather subdomains
assetfinder --subs-only $domain >> subdomains.txt


# Remove duplicates
sort subdomains.txt | uniq > subdomains_deduped.txt

# Rename deduped file to original name
mv subdomains_deduped.txt subdomains.txt
