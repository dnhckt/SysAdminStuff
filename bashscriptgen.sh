#!/bin/bash

# Creates a new, blank bash script

read -p "Enter your script name: " scriptName

touch $scriptName

echo "#! /bin/bash" >> $scriptName

chmod u+x $scriptName

read -p "Open file now (y/n)?" choice

case "$choice" in 

  y|Y ) echo "Opening";

  vi $scriptName;;

  n|N ) echo "Quitting";;
 
 * ) echo "Invalid input, deleting script";
  rm $scriptName;;

esac
