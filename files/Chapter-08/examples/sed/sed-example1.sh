#!/usr/bin/bash

# This example is similar to the AWK example to display all lines that do not have a # at the start
sed -e '/^#/d' hosts.deny | head

# This replaces the bantime =1h to bantime =10h 
sudo sed -i "s/bantime      = 1h/bantime      = 10h/g" /etc/fail2ban/jail.conf

# This will capitalize the name joseph to Joseph
sed -i "s/joseph/Joseph/g" names.txt
