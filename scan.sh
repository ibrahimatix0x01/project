#!/bin/bash

echo "Enter a domain name:"
read domain
echo "[*] Launching Amass..."
# Use amass to gather subdomains
amass enum -passive -norecursive -noalts -d $domain >> subdomains.txt
echo "[*] Launching Subfinder..."
# Use subfinder to gather subdomains
subfinder -d $domain >> subdomains.txt

# Remove duplicates
sort subdomains.txt | uniq > subdomains_deduped.txt

# Rename deduped file to original name
mv subdomains_deduped.txt subdomains.txt
echo "[*] Launching httpx..."
cat subdomains.txt | httpx -o live-subdomains.txt
