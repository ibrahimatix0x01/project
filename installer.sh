#!/bin/bash

# Update package list
apt-get update

# Install Amass
apt-get install amass -y

# Install Subfinder
GO111MODULE=on go get -v -u github.com/projectdiscovery/subfinder/cmd/subfinder

# Install httpx
GO111MODULE=on go get -v -u github.com/projectdiscovery/httpx/cmd/httpx

# Install Nuclei
GO111MODULE=on go get -v -u github.com/projectdiscovery/nuclei/v2/cmd/nuclei

# Install Waybackurls
GO111MODULE=on go get -v -u github.com/tomnomnom/waybackurls

# Install Gau
GO111MODULE=on go get -v -u github.com/lc/gau

# Install Notify
github.com/projectdiscovery/httpx/cmd/notify
