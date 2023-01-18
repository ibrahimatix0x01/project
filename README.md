# Automatic Web Application Vulnerability Scanner
[![](https://img.shields.io/twitter/follow/ibrahimatix0x01?color=blue&label=Twitter&logo=twitter&style=plastic)](https://twitter.com/ibrahimatix0x01)&nbsp;&nbsp;
[![](https://img.shields.io/github/followers/ibrahimatix0x01?color=gray&label=GitHub&logo=github&style=plastic)](https://github.com/ibrahimatix0x01)&nbsp;&nbsp;
[![](https://img.shields.io/badge/Sponsor-GitHub-green?style=plastic&logo=github)](https://github.com/sponsors/ibrahimatix0x01)&nbsp;&nbsp;


 "Automatic Web Application Vulnerability Scanner" is my final year project, the Bash script that will first the user to choose the type of scan he want to perform, simultaneously execute various subdomain enumeration tools (Amass & Subfinder), aggregate the results, and write entries to a file free of duplicates, filter live  subdomains, scan for low hanging bugs using projectdiscovery Nuclei, gather all urls using Waybackurls and Gau, scan for xss vulnerabilities is each parameter on those urls gathered .... Also you will get notification on Discord for each step done.

**Tools used:**
* [Amass](https://github.com/OWASP/Amass)
* [Subfinder](https://github.com/projectdiscovery/subfinder)
* [httpx](https://github.com/projectdiscovery/httpx)
* [Nuclei](https://github.com/projectdiscovery/nuclei)
* [Waybackurls](https://github.com/tomnomnom/waybackurls)
* [Gau](https://github.com/lc/gau)
* [Notify](https://github.com/lc/gau)

### Install
Written for Debian-based Linux distributions (*Kali*, *Parrot Sec* & *Ubuntu*):

```text
git clone https://github.com/ibrahimatix0x01/project
cd scan; chmod +x install.sh scan.sh
sudo ./install.sh
```

### Usage
```text
#> ./howtofindbugs.sh example.com

```

<a href="https://www.buymeacoffee.com/ibrahimatix" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

