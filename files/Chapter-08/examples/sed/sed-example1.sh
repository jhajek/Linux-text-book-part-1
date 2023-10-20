sed -e '/^#/d' hosts.deny | head

sudo sed -i "s/bantime = 600/bantime = 10000/g" /etc/fail2ban/jail.conf

sudo sed -i "s/joseph/Joseph/g" names.txt