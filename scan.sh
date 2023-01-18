#!/bin/bash

while true; do
  # Display menu options to the user
  echo "Select the recon type:"
  echo "1. Organization based"
  echo "2. Domain based"
  echo "3. Subdomain based"

  # Read the user's selection
  read -p "Enter your selection: " selection

  # Use an if statement to perform an action based on the user's selection
  if [[ $selection == "1" ]]; then
    # Perform action for option 1
    cd org_based
    OUT_DIR=$(pwd)
    read -p "Enter a organization name: " org
    mkdir $org
    cd $org
    knockknock -n $org -p
    echo "[*] Launching Amass..." 
    # Use amass to gather subdomains
    amass enum -passive -norecursive -noalts -df domains.txt >> subdomains.txt

    echo "[*] Launching Subfinder..."
    # Use subfinder to gather subdomains
    subfinder -dL domains.txt >> subdomains.txt

    # Remove duplicates
    sort subdomains.txt | uniq > subdomains_deduped.txt

    # Rename deduped file to original name
    mv subdomains_deduped.txt subdomains.txt

    SUBRES=$(cat subdomains.txt | wc -l)
    echo -e "\n[+] Amass and Subfinder found ${SUBRES} subdomains" | notify -silent

    echo "[*] Launching httpx..."
    cat subdomains.txt | httpx -o live-subdomains.txt

    LIVESUB=$(cat subdomains.txt | wc -l)
    echo -e "\n[+] httpx found ${LIVESUB} live subdomains" | notify -silent

    mkdir nuclei
    cd nuclei
    echo "[*] Launching Nuclei..."
    nuclei -list $OUT_DIR/$org/live-subdomains.txt -severity low -o low.txt
    low=$(cat low.txt | wc -l)
    echo -e "\n[+] Nuclei found ${low} low bugs and the output is saved to $OUT_DIR/$domain/nuclei/low.txt" | notify -silent
    nuclei -list $OUT_DIR/$org/live-subdomains.txt -severity medium -o medium.txt
    medium=$(cat medium.txt | wc -l)
    echo -e "\n[+] Nuclei found ${medium} medium bugs and the output is saved to $OUT_DIR/$domain/nuclei/medium.txt" | notify -silent
    nuclei -list $OUT_DIR/$org/live-subdomains.txt -severity high -o high.txt
    high=$(cat high.txt | wc -l)
    echo -e "\n[+] Nuclei found ${high} high bugs and the output is saved to $OUT_DIR/$domain/nuclei/high.txt" | notify -silent
    nuclei -list $OUT_DIR/$org/live-subdomains.txt -severity critical -o critical.txt
    critical=$(cat critical.txt | wc -l)
    echo -e "\n[+] Nuclei found ${critical} critical bugs and the output is saved to $OUT_DIR/$org/nuclei/critical.txt" | notify -silent
    cd ../
    mkdir urls
    cd urls
    echo "[*] Launching gau & waybackurls to gather urls..."
    # Use gau to gather URLs for the specified subdomain
    cat $OUT_DIR/$org/domains.txt | gau > urls.txt

    # Use waybackurls to gather additional URLs for the specified subdomain
    waybackurls $OUT_DIR/$org/domains.txt >> urls.txt

    # Sort and remove duplicates from the URLs list
    sort -u urls.txt -o urls.txt

    urls=$(cat urls.txt | wc -l)
    echo -e "\n[+] Gau & Waybackurls found ${urls} URLs and the output is saved to $OUT_DIR/$org/urls/urls.txt" | notify -silent
    cd ../
    mkdir xss
    cd xss
    echo "[*] Launching Gxss and Dalfox for xss scans..."
    cat $OUT_DIR/$org/urls/urls.txt | httpx -silent | Gxss -c 100 -p Xss | sort -u | dalfox pipe > xss.txt
    XSSRES=$(cat xss.txt | wc -l)
    echo -e "\n[+] Gxss and Dalfox found ${XSSRES} potential xss" | notify -silent
    break
  elif [[ $selection == "2" ]]; then
    # Perform action for option 2
    cd domain_based
    OUT_DIR=$(pwd)
    read -p "Enter a domain name: " domain
    mkdir $domain
    cd $domain
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
    echo -e "\n[+] Amass and Subfinder found ${SUBRES} subdomains" | notify -silent

    echo "[*] Launching httpx..."
    cat subdomains.txt | httpx -o live-subdomains.txt

    LIVESUB=$(cat subdomains.txt | wc -l)
    echo -e "\n[+] httpx found ${LIVESUB} live subdomains" | notify -silent

    mkdir nuclei
    cd nuclei
    echo "[*] Launching Nuclei..."
    nuclei -list $OUT_DIR/$domain/live-subdomains.txt -severity low -o low.txt
    low=$(cat low.txt | wc -l)
    echo -e "\n[+] Nuclei found ${low} low bugs and the output is saved to $OUT_DIR/$domain/nuclei/low.txt" | notify -silent
    nuclei -list $OUT_DIR/$domain/live-subdomains.txt -severity medium -o medium.txt
    medium=$(cat medium.txt | wc -l)
    echo -e "\n[+] Nuclei found ${medium} medium bugs and the output is saved to $OUT_DIR/$domain/nuclei/medium.txt" | notify -silent
    nuclei -list $OUT_DIR/$domain/live-subdomains.txt -severity high -o high.txt
    high=$(cat high.txt | wc -l)
    echo -e "\n[+] Nuclei found ${high} high bugs and the output is saved to $OUT_DIR/$domain/nuclei/high.txt" | notify -silent
    nuclei -list $OUT_DIR/$domain/live-subdomains.txt -severity critical -o critical.txt
    critical=$(cat critical.txt | wc -l)
    echo -e "\n[+] Nuclei found ${critical} critical bugs and the output is saved to $OUT_DIR/$domain/nuclei/critical.txt" | notify -silent
    cd ../
    mkdir urls
    cd urls
    echo "[*] Launching gau & waybackurls to gather urls..."
    # Use gau to gather URLs for the specified subdomain
    gau $domain > urls.txt

    # Use waybackurls to gather additional URLs for the specified subdomain
    waybackurls $domain >> urls.txt

    # Sort and remove duplicates from the URLs list
    sort -u urls.txt -o urls.txt

    urls=$(cat urls.txt | wc -l)
    echo -e "\n[+] Gau & Waybackurls found ${urls} URLs and the output is saved to $OUT_DIR/$domain/urls/urls.txt" | notify -silent
    cd ../
    mkdir xss
    cd xss
    echo "[*] Launching Gxss and Dalfox for xss scans..."
    cat $OUT_DIR/$domain/urls/urls.txt | httpx -silent | Gxss -c 100 -p Xss | sort -u | dalfox pipe > xss.txt
    XSSRES=$(cat xss.txt | wc -l)
    echo -e "\n[+] Gxss and Dalfox found ${XSSRES} potential xss" | notify -silent

    break
  elif [[ $selection == "3" ]]; then
    # Perform action for option 3
    cd subdomain_based
    OUT_DIR=$(pwd)
    read -p "Enter a domain name: " subdomain
    mkdir $subdomain
    cd subdomain
    mkdir nuclei
    cd nuclei

    echo "[*] Launching Nuclei..."

    nuclei -u $subdomain -severity low -o low.txt
    low=$(cat low.txt | wc -l)
    echo -e "\n[+] Nuclei found ${low} low bugs and the output is saved to $OUT_DIR/$subdomain/nuclei/low.txt" | notify -silent
    nuclei -u $subdomain -severity medium -o medium.txt
    medium=$(cat medium.txt | wc -l)
    echo -e "\n[+] Nuclei found ${medium} medium bugs and the output is saved to $OUT_DIR/$subdomain/nuclei/medium.txt" | notify -silent
    nuclei -u $subdomain -severity high -o high.txt
    high=$(cat high.txt | wc -l)
    echo -e "\n[+] Nuclei found ${high} high bugs and the output is saved to $OUT_DIR/$subdomain/nuclei/high.txt" | notify -silent
    nuclei -u $subdomain -severity critical -o critical.txt
    critical=$(cat critical.txt | wc -l)
    echo -e "\n[+] Nuclei found ${critical} critical bugs and the output is saved to $OUT_DIR/$subdomain/nuclei/critical.txt" | notify -silent
    cd ../

    mkdir urls
    cd urls

    echo "[*] Launching gau & waybackurls to gather urls..."

    # Use gau to gather URLs for the specified subdomain
    gau $subdomain > urls.txt

    # Use waybackurls to gather additional URLs for the specified subdomain
    waybackurls $subdomain >> urls.txt

    # Sort and remove duplicates from the URLs list
    sort -u urls.txt -o urls.txt

    urls=$(cat xss.txt | wc -l)
    echo -e "\n[+] Gau & Waybackurls found ${urls} URLs and the output is saved to $OUT_DIR/$subdomain/urls/urls.txt" | notify -silent
    cd ../
    mkdir xss
    cd xss
    echo "[*] Launching Gxss and Dalfox for xss scans..."
    cat $OUT_DIR/$subdomain/urls/urls.txt | httpx -silent | Gxss -c 100 -p Xss | sort -u | dalfox pipe > xss.txt
    XSSRES=$(cat xss.txt | wc -l)
    echo -e "\n[+] Gxss and Dalfox found ${XSSRES} potential xss" | notify -silent
    break
  else
    # Display error message if selection is invalid and loop back to display menu again
    echo "Invalid selection. Please try again."
  fi
done
