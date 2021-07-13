#!/bin/bash

###################################
# Ubuntu Test Server Setup Script #
#       ./testbox-setup.sh        #
###################################

G="\e[32m" # Green
N="\e[0m" # White

###
# Backing up system files we'll be editing
###

echo ""
echo -e "${G}Backing up /etc/profile, .bashrc and .vimrc to *.bak ${N}"  
echo ""

cp ~/.bashrc{,.bak}
cp ~/.vimrc{,.bak}
cp /etc/profile{,.bak}

###
# Install common packages
###

echo -e "${G}Installing juicy packages ${N}"  
echo ""

sudo apt update -y
sudo apt install -qyf dnsutils whois openssl nmap netcat atop apache2 nginx mariadb-server python python3 tmux vim cowsay fortune fortunes-off

###
# Install custom scripts
###

echo -e "${G}Installing scripts from github.com/dnhckt/SysAdminStuff ${N}"  
echo ""

scripts=("https://raw.githubusercontent.com/dnhckt/abuseipdb-cli/master/abusecheck.sh https://raw.githubusercontent.com/dnhckt/SysAdminStuff/main/custom-bash-prompt https://raw.githubusercontent.com/dnhckt/SysAdminStuff/main/talking-cow-login https://raw.githubusercontent.com/dnhckt/SysAdminStuff/main/sshkeygen.sh https://raw.githubusercontent.com/dnhckt/SysAdminStuff/main/basicnmap.sh https://raw.githubusercontent.com/dnhckt/SysAdminStuff/main/bashscriptgen.sh" "https://raw.githubusercontent.com/dnhckt/SysAdminStuff/main/sitecheck.sh" "https://raw.githubusercontent.com/dnhckt/SysAdminStuff/main/aliasgen.sh")

mkdir /tmp/scripts;
cd /tmp/scripts;


for i in $scripts; do 

j=$(echo $i | cut -f7 -d'/')    

echo ""
echo "installing $j";
echo ""

wget --quiet $i;

done

# Make scripts executable & copy to /usr/local/bin

echo ""
echo -e "${G}Installing scripts from github.com/dnhckt/SysAdminStuff ${N}"  
echo ""

chmod +x /tmp/scripts/*.*
chmod -x /tmp/scripts/*-*

for i in $(ls -l /tmp/scripts | awk '{print $9}' | grep "\.[a-z]"); do cp $i /usr/local/bin/$(echo $i | cut -f1 -d'.'); done

# Set API key for abuseipdb script 

read -p "Enter your AbuseIPDB API Key:" ipdbkey
echo $ipdbkey;
touch ~/.ipdbkey.txt
echo $ipdbkey > ~/.ipdbkey.txt
echo ~/.ipdbkey.txt

cd;

### 
# Set custom aesthetics 
###

echo ""
echo -e "${G}Making things look better... ${N}"  
echo ""

# Set MOTD
cp /tmp/scripts/talking-cow-login /etc/motd.sh
chmod +x /etc/motd.sh
echo "/etc/./motd.sh" >> /etc/profile

# Set custom bash prompt

cat /tmp/scripts/custom-bash-prompt >> ~/.bashrc

# Set vim as default, use nicer colours
echo "export VISUAL=vim" >> ~/.bashrc
echo 'export EDITOR="$VISUAL"' >> ~/.bashrc
echo "set background=dark" >> ~/.vimrc

echo ""
echo -e "${G}Done! ${N}"  
echo ""

echo ""
echo -e 'I just need you to run: export ABUSE_API_KEY=$(cat ~/.ipdbkey.txt)'  
echo ""
