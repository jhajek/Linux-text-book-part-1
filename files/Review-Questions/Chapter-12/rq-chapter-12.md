# Review Questions - Chapter 12

1) Using the ip2 suite of tools, which command would show your IP address?

   a. `ifconfig`
   b. `ipconfig`
   c. `ip address show`
   d. `ip a sh`

2) Using the ip2 suite of tools, which command would show your routing table?

   a. `ss`
   b. `route`
   c. `ip route show`
   d. `ip -r`

3) What tool could you use to establish if a server is responding to requests?

   a. `pong`
   b. `ping`
   c. `google`
   d. `traceroute`

4) What is the purpose of a netmask?

5) What is the purpose of DNS?

6) Which of the following is a valid class C network address?

   a. 10.0.0.0
   b. 172.24.0.0
   c. 192.168.1.0
   d. 221.0.0.0

7) If you had a network with a CIDR block of /23, how many IP addresses would you have control of?

   a. 23
   b. 254
   c. 512
   d. 256

8) If you had a CIDR block of /24 and a network address of 192.168.1.0, how many IP addresses would you have?

   a. 10
   b. 0
   c. 24
   d. 256

9) How does CIDR block addressing differ from class-based networking (A-D)?

10) What tool is used to release a DHCP address from the command line?

    a. `rhclient`
    b. `ipconfig /release`
    c. `dhclient -r`
    d. `xclient -r`

11) Using the ip2 suite, what command can be used to monitor and examine all current local ports and TCP/IP connections?

    a.  `ss`
    b.  `net`
    c.  `wireshark`
    d.  `netstat`

12) Where are your network card settings located on Ubuntu while using network manager?

13) Where are your network card settings located on CentOS/Fedora using network manager?

14) Where are your network card settings located on Ubuntu 18.04 using netplan?

15) What are the two major opensource webservers?

    a. Apache, Nginx
    b. openhttpd, Nginx
    c. Apache, IIS
    d. Apache, Tomcat

16) What are two related and major opensource relational databases?

    a. SQL and MySQL
    b. MariaDB and MySQL
    c. MySQL and Oracle DB
    d. Nginx and MySQL

17) Name one major NoSQL database mentioned in this chapter?

18) What is the file location that the system uses as a *local DNS* for resolving IP?

    a. `etc/systemd/hostd`
    b. `/etc/hosts`
    c. `/etc/allow`
    d. `/etc/etc/etc`

19) What is the name of the file that you would place in your home directory that allows you not to have to type your login password for a MySQL database?

    a. `~/my.cnf`
    b. `/etc/mysql/settings.conf`
    c. `~/allow`
    d. `~/.my.cnf`

20) Before systemd, NIC interface naming schemes depended on a driver based enumeration process. They switched to a predictable network interface naming process that depends on what for the interface names?

    a. driver loading order
    b. interface names depend on physical location of hardware (bus enumeration)
    c. kernel version
    d. What ever Lennart Poettering feels like naming them
