
printf "Installing RDP Be Patience... " >&2
{

sudo apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
apt install --assume-yes xfce4 desktop-base
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo apt install nautilus nano -y 



toolsDir="/opt"
echo "[*] INSTALLING DEPENDENCIES IN \"$toolsDir\"..."

mkdir -p "$toolsDir"

apt install -y phantomjs xvfb dnsutils nmap

echo "[*] INSTALLING GO DEPENDENCIES (OUTPUT MAY FREEZE)..."

wget -q -O - https://git.io/vQhTU | bash
sleep 2
source ~/.bashrc
cd /usr/local
wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.15.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go get github.com/jaeles-project/jaeles
go get -u github.com/KathanP19/Gxss
go get -u github.com/lc/gau
go get -u github.com/tomnomnom/gf
go get -u github.com/jaeles-project/gospider
go get -u github.com/projectdiscovery/httpx/cmd/httpx
go get -u github.com/tomnomnom/qsreplace
go get -u github.com/haccer/subjack
go get -u github.com/tomnomnom/assetfinder
go get github.com/hakluke/hakrawler
go get -u github.com/OWASP/Amass/v3/...
go get -u github.com/ffuf/ffuf
go get -u github.com/ethicalhackingplayground/bxss
git clone https://github.com/projectdiscovery/httpx.git; cd httpx/cmd/httpx; go build; mv httpx /usr/local/bin/; httpx -version
cd $GOPATH/src/github.com/OWASP/Amass
go install ./...


echo "[*] INSTALLING RUSTSCAN..."

wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
dpkg -i rustscan_2.0.1_amd64.deb

echo "[*] INSTALLING GIT DEPENDENCIES..."

git clone https://github.com/hahwul/dalfox
cd dalfox
go install
go build

git clone https://github.com/chvancooten/BugBountyScanner
### Nuclei (Workaround -https://github.com/projectdiscovery/nuclei/issues/291)
cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
git clone -q https://github.com/projectdiscovery/nuclei.git
cd nuclei/v2/cmd/nuclei/ || { echo "Something went wrong"; exit 1; }
go build
mv nuclei /usr/local/bin/

### Nuclei templates
cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
git clone -q https://github.com/projectdiscovery/nuclei-templates.git
nuclei --update-templates 
### Gf-Patterns
cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
git clone -q https://github.com/1ndianl33t/Gf-Patterns
mkdir ~/.gf
cp "$toolsDir"/Gf-Patterns/*.json ~/.gf

pip3 install telegram-send

echo "[*] SETUP FINISHED."

sudo adduser ALOK chrome-remote-desktop
} &> /dev/null &&
printf "\nSetup Complete " >&2 ||
printf "\nError Occured " >&2
printf '\nCheck https://remotedesktop.google.com/headless  Copy Command Of Debian Linux And Paste Down\n'
read -p "Paste Here: " CRP
su - ALOK -c """$CRP"""
printf 'Check https://remotedesktop.google.com/access/ \n\n'
if sudo apt-get upgrade &> /dev/null
then
    printf "\n\nUpgrade Completed " >&2
else
    printf "\n\nError Occured " >&2
fi
