#! /bin/bash

# Scan open ports on an IP 

read -p "Enter the IP to scan": ipAddress

touch $ipAddress.txt

nmap -sV -sC -A $ipAddress > $ipAddress.txt

#cat $ipAddress.txt
