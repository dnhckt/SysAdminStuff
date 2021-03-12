#! /bin/bash -i

# Creates a new bash alias
# This maps one command to another, e.g. shortcuts or redirects

read -p "Enter the alias name: " aliasName
read -p "Enter the command to map it to: " command
echo "alias $aliasName='$command'" >> ~/.bashrc 

echo "$aliasName mapped to "$command"" >> ~/.alias_list # Keep list of aliases 

#echo "Run 'source ~/.bashrc' to use your new alias!"
echo "Run 'less ~/.alias_list' to see your aliases!"
