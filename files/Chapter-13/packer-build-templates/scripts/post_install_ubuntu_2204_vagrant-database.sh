#!/bin/bash 
set -e
set -v

##################################################
# Add User customizations below here
##################################################

sudo apt update
sudo apt install -y mysql-server

sudo systemctl enable mysql.service
sudo systemctl start mysql.service

sudo mysql -e "CREATE USER '$DBUSER'@'localhost' IDENTIFIED BY '$DBPASS';"
sudo mysql -e "CREATE DATABASE records;"
sudo mysql -e "GRANT CREATE, SELECT, UPDATE, DELETE, and INSERT ON records.* TO '$DBUSER'@'localhost'"  
sudo mysql -e "FLUSH PRIVILEGES;"