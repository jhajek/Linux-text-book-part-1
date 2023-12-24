# Review Questions - Chapter 12

1.  Using the ip2 suite of tools, which commands would show your IP address?
    a.  `ifconfig`
    b.  `ipconfig`
    c.  `ip address show`
    d.  `ip a sh`
1.  Using the ip2 suite of tools, which command would show your routing table?
    a.  `ss`
    b.  `route`
    c.  `ip route show`
    d.  `ip -r`
1.  What tool could you use to establish if a server is responding to requests?
    a.  `pong`
    b.  `ping`
    c.  `google`
    d.  `traceroute`
1.  What is the purpose of a subnet mask?
    a.  Creates a logical subdivision of an IP network. The practice of dividing a network into two or more networks
    b.  To store the value of your network's default router
    c.  Allows you to resolve domain names to IP addresses
    d.  To store your network cards 48-bit hardware address
1.  What is the purpose of DNS?
    a.  Creates a logical subdivision of an IP network. The practice of dividing a network into two or more networks
    b.  To store the value of your network's default router
    c.  Allows you to resolve domain names to IP addresses
    d.  To store your network cards 48-bit hardware address
1.  What is the name of the systemd firewall?
    a.  systemd-firewalld
    b.  systemd-firewall
    c.  firewalld-cmd
    d.  ufw
1.  What would be the command to list all of the firewalld public zone ports in use?
    a.  `sudo systemctl status firewalld`
    b.  `sudo firewalld-cmd --zone=public --list-all`
    c.  `sudo firewall-cmd --zone=public --list-all`
    d.  `sudo firewall-cmd --list-all`
1.  If you had a CIDR block of /24 and a network address of 192.168.1.0, how many IP addresses would you have?
    a.  10
    b.  0
    c.  24
    d.  256
1.  What is the default port for HTTPS (TLS/SSL)?
    a.  80
    b.  3000
    c.  8080
    d.  443
1.  What is the name of the protocol that automatically discovers and gives you an IP address on the network upon boot/resume?
    a.  `dns`
    b.  `ipconfig`
    c.  `dhcp`
    d.  `networkctl`
1.  Using the ip2 suite, what command can be used to monitor and examine all current local ports and TCP/IP connections?
    a.   `ss`
    b.   `net`
    c.   `wireshark`
    d.   `netstat`
1.  Where is the name of the network layer abstraction software created by Canonical and used by Ubuntu?
    a.  NetworkManager
    b.  netman
    c.  netplan
    d.  nmcli
1.  What is the default service for managing your network in Fedora Workstation?
    a.  NetworkManager
    b.  netman
    c.  netplan
    d.  nmcli
1.  What is the default service for managing your network in Ubuntu Server?
    a.  NetworkManager
    b.  netman
    c.  systemd-networkd
    d.  nmcli
1.  What are the two major opensource webservers?
    a.  Apache, Nginx
    b.  openhttpd, Nginx
    c.  Apache, IIS
    d.  Apache, Tomcat
1.  What are two related and major opensource relational databases?
    a.  SQL and MySQL
    b.  MariaDB and MySQL
    c.  MySQL and Oracle DB
    d.  Nginx and MySQL
1.  What command would you type to get to the MySQL command line prompt as the root user?
    a.  `sudo mysql -u root`
    b.  `sudo mysql`
    c.  `sudo mysql root`
    d.  `mysql`
1.  What is the file location that the system uses as a local DNS for resolving IP?
    a.  `etc/systemd/hostd`
    b.  `/etc/hosts`
    c.  `/etc/allow`
    d.  `/etc/etc/etc`
1.  What flag would you add to this command to make it survive a reboot: `sudo firewall-cmd --zone=public --add-port=22/tcp`
    a.  `--peppermint`
    b.  `--permenant`
    c.  `--allow`
    d.  `--list-all`
1.  Before systemd, NIC interface naming schemes depended on a driver based enumeration process. They switched to a predictable network interface naming process that depends on what for the interface names?
    a.  driver loading order
    b.  interface names depend on physical location of hardware (PCIe bus enumeration)
    c.  kernel version
    d.  What ever Lennart Poettering feels like naming them
1.  What is the iproute2 suite replacement for `netstat`?
    a.  `ip -r`
    b.  `ip -n`
    c.  `net`
    d.  `ss`
1.  What is the iproute2 suite replacement for the `route` command?
    a.  `ip -r`
    b.  `ip -n`
    c.  `net`
    d.  `ss`
1.  What is the default port that HTTPS (TLS) operates on?
    a.  80
    b.  22
    c.  443
    d.  3000
1.  What is the default port that MySQL operates over?
    a.  80
    b.  3309
    c.  3306
    d.  1024
