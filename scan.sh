#!/bin/bash

read -p "Enter a domain name: " domain

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

SUBRES=$(cat subdomains.txt | wc -l)
echo -e "\n[+] Amass and Subfinder found ${SUBRES} subdomains"

echo "[*] Launching httpx..."
cat subdomains.txt | httpx -o live-subdomains.txt

LIVESUB=$(cat subdomains.txt | wc -l)
echo -e "\n[+] httpx found ${LIVESUB} live subdomains"

echo "[*] Launching Nuclei..."

nuclei -list live-subdomains.txt -o nuclei_result.txt

echo "[*] Launching gau & waybackurls to gather urls..."

# Use gau to gather URLs for the specified domain
gau $domain > urls.txt

# Use waybackurls to gather additional URLs for the specified domain
waybackurls $domain >> urls.txt

# Sort and remove duplicates from the URLs list
sort -u urls.txt -o urls.txt

echo "URLs for $domain have been saved to urls.txt"
echo "[*] Launching kxss for xss scans..."
cat urls.txt | kxss > xss.txt
XSSRES=$(cat xss.txt | wc -l)
echo -e "\n[+] kxss found ${XSSRES} potential xss"
