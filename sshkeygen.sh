#!/bin/bash

read -rp "key name: " keyname
dir="$HOME/.ssh/"
mkdir -p $dir/"$keyname"

ssh-keygen -b 2048 -t rsa -f $dir/"$keyname"/"$keyname" -q -N ""

echo "your SSH Key is in ~/.ssh/$keyname."
echo "Add this public key to ~/.ssh/authorized_keys on the remote box:"
echo ""
cat ~/.ssh/"$keyname"/"$keyname".pub

echo ""
echo "To ssh, run 'ssh [user@host] -i [key]'"
