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

# https://dev.mysql.com/doc/refman/8.0/en/create-user.html
sudo mysql -e "CREATE USER '$DBUSER'@'localhost' IDENTIFIED BY '$DBPASS';"
sudo mysql -e "CREATE DATABASE records;"
# https://dev.mysql.com/doc/refman/8.0/en/grant.html
sudo mysql -e "GRANT CREATE, SELECT, UPDATE, DELETE, INSERT ON records.* TO '$DBUSER'@'localhost';"  
sudo mysql -e "FLUSH PRIVILEGES;"

# Customization to disable password auth over ssh
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config.d/diable-password-auth.conf
