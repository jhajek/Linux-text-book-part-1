#!/bin/bash 
set -e
set -v

# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is ubuntu
echo "%admin  ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/init-users
sudo groupadd admin
sudo usermod -a -G admin vagrant

##################################################
# Add User customizations below here
##################################################

sudo apt update
sudo apt install -y mysql-server

sudo systemctl enable mysql.service
sudo systemctl start mysql.service

sudo mysql -e "CREATE USER $DBUSER@'%' IDENTIFIED BY $DBPASS;"
sudo mysql -e "GRANT CREATE, SELECT, UPDATE, DELETE, and INSERT ON records.* TO $DBUSER@'127.0.0.1'"  
sudo mysql -e "FLUSH PRIVILEGES;"