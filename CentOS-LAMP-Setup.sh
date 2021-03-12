#!/bin/bash

# L = CentOS

# A = Apache

sudo yum install httpd httpd-tools -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "Welcome to this site!" > /var/www/html/index.html
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
sudo systemctl reload firewalld
chown apache:apache /var/www/html -R

# M = MySQL
sudo yum install mariadb-server mariadb -y
sudo systemctl start mariadb
sudo systemctl enable mariadb

echo "don't forget mysql_secure_installation"

# P = PHP
sudo yum install php php-fpm php-mysqlnd php-opcache php-gd php-xml php-mbstring -y
sudo systemctl start php-fpm
sudo systemctl enable php-fpm

sudo systemctl restart httpd
setsebool -P httpd_execmem 1
