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
cd project; chmod +x installer.sh scan.sh
sudo ./installer.sh
```

### Usage
```text
#> bash scan.sh
Select the recon type:
1. Organization based
2. Domain based
3. Subdomain based
Enter your selection: 2
Enter a domain name: abu.edu.ng
[*] Launching Amass...
[*] Launching Subfinder...

               __    _____           __         
   _______  __/ /_  / __(_)___  ____/ /__  _____
  / ___/ / / / __ \/ /_/ / __ \/ __  / _ \/ ___/
 (__  ) /_/ / /_/ / __/ / / / / /_/ /  __/ /    
/____/\__,_/_.___/_/ /_/_/ /_/\__,_/\___/_/ v2.5.5

		projectdiscovery.io

Use with caution. You are responsible for your actions
Developers assume no liability and are not responsible for any misuse or damage.
By using subfinder, you also agree to the terms of the APIs used.

[INF] Loading provider config from '/root/.config/subfinder/provider-config.yaml'
[INF] Enumerating subdomains for 'abu.edu.ng'
[INF] Found 386 subdomains for 'abu.edu.ng' in 2 seconds 804 milliseconds
[+] Amass and Subfinder found 400 subdomains
[*] Launching httpx...

    __    __  __       _  __
   / /_  / /_/ /_____ | |/ /
  / __ \/ __/ __/ __ \|   /
 / / / / /_/ /_/ /_/ /   |
/_/ /_/\__/\__/ .___/_/|_|
             /_/              v1.2.5

		projectdiscovery.io

Use with caution. You are responsible for your actions.
Developers assume no liability and are not responsible for any misuse or damage.
https://acentdfb.abu.edu.ng
https://abucauc.abu.edu.ng
https://agriceconomics.abu.edu.ng
https://artsandsocialscienceeducation.abu.edu.ng
https://administration.abu.edu.ng
https://agricextension.abu.edu.ng
https://abucuhsr.abu.edu.ng
.
.
.
```

<a href="https://www.buymeacoffee.com/ibrahimatix" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

