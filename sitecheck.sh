#!/bin/bash

### Usage: ./sitecheck www.domain.com

site=$1;
echo "$site";


# Chop out http:// and / paths so that it parses correctly

if (( $(echo "$site" | grep -c '//') > 0 ));
then
    site=$(echo "$site" | cut -d '/' -f 3) # Gives the bit after http:// (and before a trailing /)
    echo "$site";
elif (( $(echo "$site" | grep -c '/') > 0 ));
then
    site=$(echo "$site" | cut -d '/' -f 1) # Gives the bit before a trailing /
    echo "$site";
else
    true 
fi


IP=$(dig $site +short); 

echo "";
echo "IP";
echo "===";
echo $IP;

echo "";

echo "Hosting Provider"
echo "===";
whois $IP | grep -i "desc\|netname"; 

echo "";

echo "HTTP Response / Load Time";
echo "===";

time curl -sIL $site | grep -i http/
