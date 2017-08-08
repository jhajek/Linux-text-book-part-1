# Networking, Webservers, and Intro to Databases ROUGH DRAFT
![*Some people just have aquariums...*](images/Chapter-Header/Chapter-13/network-2.png "Virus Aquarium")

### Objectives

  * Understand how to configure and display basic network settings for the two major Linux distribution families and in BSD
  * Understand how to use basic network troubleshooting tools
  * Understand how to configure and deploy major webserver platforms for Linux and BSD
  * Compare and contrast two major opensource webservers and be able to discuss their uses in industry
  * Understand how to install, manage, and configure basic major SQL and NOSQL databases

### Outcomes

  At the conclusion of this chapter you will have explored the nature of the network settings for the two major Linux distribution families and for BSD.  You will be comfortable using various commandline troubleshooting tools to help solve network issues and problems.  You will deploy two major webserver platforms and understand the differences between Apache and Nginx in their memory models and request handling models.  Finally you will have gained experience deploying, installing, and configuring MySQL and MariaDB SQL databases and a popular NoSQL database Mongodb.

## Networking

Former CEO of SUN, Scott McNealy once famously said, "The network is the computer."  This was in 1990.  He could not have been more correct.  With this in mind basic networking skills are mandatory.  We will briefly cover topics in this order:

  * IP addresses
      + Static and DHCP
  * NETMASK and CIDR
  * Gateways
  * DNS   
  * Compare configuration of these settings across operating systems
  * Various network troubleshooting tools


### IP Addresses

Every network interface, or NIC, which is the physical or virtual place where your device connects to the network.  Each NIC in turn needs an IP address to communicate on a network. IP addresses come in two flavors, a **static** IP is a 4 octet number looking something like this: ```192.168.1.100```.  

> Exercise
Open a command prompt and type this command to find your IP address: ```ip address show```.  This command can be abbreviated ```ip a sh``` as well.

The types of addresses come in two types, static IP and DHCP.  A static address is one that you assign and configure.  If you are the system admin you can and should map each device on your network with its own IP address.  For instance any servers you have, webservers, database servers, load balancers, routing equipment should have statically set IP information.

But what if you have transient or ephemeral nodes (computers) on your network?  Then you need to use the **Dynamic Host Control Protocol**.  Setting your computer to use DHCP allows it to negotiate for a lease on a shared IP address.  Their is a DHCP server (configuring one is beyond the scope of this chapter), that will listen for DHCP broadcasts and answer with an offer of an IP.  Once your system (network card) accepts the offer it gains access to that IP address and all other necceary IP configuration--which is relinqueshes upon your physically leaving the network.   DHCP allows you to pool IPs when you might not have enough and share or allow for the auto-registration to make managing large scale IP deployments easy.  For instance at a university every student has a laptop and most likely a phone too, you could manually assign each an address but the number of students goes into the thousands and tens of thousands, and it not practical to manage--DHCP makes this scale manageable.

Settings these values statically in each operating system is different but the concept is the same.  You need to enter an IP Address, Netmask/CIDR, Network Gateway, and DNS.  Each of these concepts is explained below.

#### Ubuntu

The Canonical company that develops Ubuntu keeps an excellent wiki with this information, [https://help.ubuntu.com/community/InternetAndNetworking](https://help.ubuntu.com/community/InternetAndNetworking "Ubuntu Network Wiki").

There are multiple ways to discover this information.  There are two suites of tools.  The original is ```net-tools``` the newer group is called the ```iproute2``` tools.  If you have used a computer before, from BSD to Windows (which used the BSD TCP-stack) these commands will be familiar.  But the *net-tools* suite development was actively **ceased** in 2001 in favor of *iproute2*.

```ipconfig -a```

```ip link show```

```ifconfig [-v] interface [aftype] options | address```
```ip [ OPTIONS ] OBJECT { COMMAND | help }```

This is where the similarities end.  The *ifconfig* command is a single command.  To view other details such as the ARP table, RARP command, view or change routes you would have to use additional commands.  As a contrast the *iproute2* handles all of that from the *ip* command.  Older Linux (pre-2015) definately have net-tools installed.  That is quickly changing as some distributions are only including the iproute2 package.  One good example is net-tools was created before IPv6 became a standard.

```lshw```

> lshw is a small tool to extract detailed information on the hardware configuration  of  the  machine.  It  can report  exact  memory  configuration,  firmware version, mainboard configuration, CPU version and speed, cache configuration, bus speed, etc. on DMI-capable x86 or IA-64 systems and on some PowerPC machines  (PowerMac  G4 is known to work).

http://www.itzgeek.com/how-tos/mini-howtos/change-default-network-name-ens33-to-old-eth0-on-ubuntu-16-04.html

Contents of the ```/etc/network/interfaces``` file

```
auto eth0
iface eth0 inet static
     address 192.168.0.42
     network 192.168.0.0
     netmask 255.255.255.0
     broadcast 192.168.0.255
     gateway 192.168.0.1
```

Note the change in device name due to systemd
auto enp0s8
iface enp0s8 inet static
     address 192.168.0.42
     network 192.168.0.0
     netmask 255.255.255.0
     broadcast 192.168.0.255
     gateway 192.168.0.1

Using the same laptop, Ubuntu 14.04 and Ubuntu 16.04 named my ethernet cards differently.  This is due to systemd's policy of naming devices due to their position on the system bus (motherboard).      

The systemd group [argued here](https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/ "ethernet argument"):

> The classic naming scheme for network interfaces applied by the kernel is to simply assign names beginning with "eth0", "eth1", ... to all interfaces as they are probed by the drivers. As the driver probing is generally not predictable for modern technology this means that as soon as multiple network interfaces are available the assignment of the names "eth0", "eth1" and so on is generally not fixed anymore and it might very well happen that "eth0" on one boot ends up being "eth1" on the next. This can have serious security implications, for example in firewall rules which are coded for certain naming schemes, and which are hence very sensitive to unpredictable changing names. 

> The following different naming schemes for network interfaces are now supported by udev natively: 
1) Names incorporating Firmware/BIOS provided index numbers for on-board devices (example: eno1) 
1) Names incorporating Firmware/BIOS provided PCI Express hotplug slot index numbers (example: ens1) 
1) Names incorporating physical/geographical location of the connector of the hardware (example: enp2s0) 
1) Names incorporating the interfaces's MAC address (example: enx78e7d1ea46da) 
1) Classic, unpredictable kernel-native ethX naming (example: eth0)

> What you gain by using this standard:
1) Stable interface names across reboots 
1) Stable interface names even when hardware is added or removed, i.e. no re-enumeration takes place (to the level the firmware permits this)
1) Stable interface names when kernels or drivers are updated/changed 
1) Stable interface names even if you have to replace broken ethernet cards by new ones 

There is a short technical explanation of how these names are devised in the comments of the [source code here](https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L20 "Source Code").

#### Red Hat

How to configure a static address

```/etc/sysconfig/network-scripts/ifcfg-eth0```

This was the naming convention under pre-systemd init systems.  Systemd decided their was a marked advantage to enumerate PCI devices via their bus slot on the motherboard, in this way a device will always have a guranteed and predictable device name.  The down side is you loose readability.
```/etc/sysconfig/network-scripts/ifcfg-enp5s0```

this is due to systemd changing the way network cards are enumerated.  Instead of devices have a driver name (eth0 is the common way to name a device driver of X)  systemd names each device by their position on the PCI bus.  Lennary Poeterring explains why here, "Find explanation"

#### FreeBSD

How to configure a static address/dhcp


#### NETMASK

The netmask value or subnet of your network is actually a part of you Ip address. So that routers know how to route packets to your network the netmask or network mask effectively blocks off a portion of your Ip address.  Traditionally netmasks were blocked into simple Class A, B, C, and D blocks, each one representing one fo the IP octets.  But this turned out to be highly inneficient.   If you had a subnet of class A, your subnet would be 255.0.0.0.  This means that you would be assigned a fidxed value from 1-254 in your first IP octect and the remaining three octets would be variable.  Apple famously has the 16.x.y.z Class A giving them access to 255*255*255 IP addresses - 16 million?  way more than they could possibly ever need.   

Class B subnet is 255.255.0.0 and gives you access to 16,000 IP addresses (254*254) with the first two octets set.  An example would be 172.24.x.y.   

Class C address has 1 octet available and 3 octets preset.  A common class C subnet you see mostly in home routing devices is 192.168.1.x which gives you 254 addresses.  

For our purposes we won't worry about class D and E in this book.

The problem is those division of IP octets are very clean, unfortunately leads to many wasted addresses.  So a new way to divide blocks into smaller parts came along called CIDR blocks or blocking.  CIDR lets you split blocks in half.  The school where I work uses a subnet or CIDR block of 64.131.111.0/23  This looks like a class B subnet but it is a bit bigger.  Class B in CIDR would be /24.  /23 gives us control of 64.131.110.0 and 64.131.111.0 for 512 addresses.  /23 can be written as 255.255.254.0 as well.

#### Gateway

The gateway value is your networks default router.  This value is literally the gateway to your network.  Which IP do you send to get packets out of the network?  

#### DNS

DNS--Domain Name services  allow you to resolve written domain names.  google.com, web.iit.edu, twit.tv, etc, etc and turn those values via lookup into IP addresses that can then route packets to and from.   DNS is very important.  Without it you would have to remember the IP address of every single site your wanted to visit.  Very quickly this wouldn't scale and in fact this idea of domain names lead to the initial founding of Yahoo as the personal index of its founder Jerry Wang in 1990s.

Ubuntu pre 16.04 traditional networking (non-systemd)

systemd RedHat/Centos

FreeBSD

#### Tools

Most of the time the network works fine, but when it doesn't you need to be able to use built in system tools to trouble shoot the problem and identify where the problem is. The first tool that should be in your tool box is *ping*.

There are two sets of tools - **net tools** suite and the **iproute** suite.  **Net tools** goes way back as very beginning of TCP/IP based networking in BSD 4.  By default operating systems (RHEL 7+, Fedora 23+, and Ubuntu 16.04+) do not install these tools anymore.  They use the ```iproute``` package instead.  Where applicable I will attempt to show both.

> ```ip``` example
```ip address show``` or ```ip a sh``` for short.  You can find all usage patterns by typing ```man ip```.

> ```ifconfig``` example
```ifconfig -a``` or ```ifconfig --all```  you can find all usage patterns by typing ```man ifconfig```.

> ```ping``` example
```ping www.google.com```  
```ping 192.168.0.1```

Ping just like the concept of a submarine using sonar to find objects - simple communicates with another IP address to see if the other system is "alive" and that your system and network are working properly to get the packet from your network to a different network.  Enhanced ping here: https://github.com/orf/gping

> ```traceroute``` example
Tool used to report each router hop that a packet takes on its way to its final destination.  Useful for checking if there are routing problems along the path of your traffic.

> ```dig```

> ```nslookup```

> ```dhclient```
Used to release and renew a dhcp address

>  ```netstat``` used for examining the networking status of your machine
This command in various configurations can display the current state of all ports and network connection currently running on your system.

> ```route```

## Webservers

In 199x Tim Berners-Lee invented the first webpage and the created the first websaerver.  He was working at the CERN research lab in Switzerland.  He did so with the idea to be able to freely share text data amongst researchers and national research labs world-wide.  To do this he created the HTTP protocol for sending and receiving requests as well as a webserver named, NCSA, that would receive and process those requests, returning text to a client browser to be rendered.  

The first webserver gave rise to a commercial company called Netscape started by the now famous investor Marc Andreeson.  Famous for their Netscape Navigator browser, they were also the pioneers of the first webserver. This software had been commercially available before at a high price and was limited to those who already could afford a large hardware investment.  The Apache webserver was one of the opensoruce tools, along with the MySQL database, that made the first dot-com boom at the turn of the century possible.  

Webservers listen for requests on port 80.  When receiving a request, they serve (they are webservers...) or render a page of HTML code and return that to a client (you) viewing a page through a web browser.  The webserver by default will serve pages out of the ```/var/www/html``` directory on Linux and ```/var/www``` on FreeBSD.

### Apache

Without Apache, companies such as Google, Facebook, Twitter, and many other companies started upon opensource never would have been able to get started.

Apache has over time grown and had to add new function while shedding old functionality.  The memory model of how it processes requests has changed over time as the frequency and amount of requests on a webserver has changed.  Some may criticze Apache webserver for being a bit old, but there is a large body of knowledge out there on how to customize and manage it.  Apache holds a dominate percentage of market share of all webserver software in use.  

The apache webserver can be simply installed via Linux or BSD package manager.  There is even a version of it available for Windows.   Note that though the same application, Ubuntu refers to the Apache webserver as ```apache2``` and RedHat products refer to it as ```httpd```.

> sudo apt-get install apache2

> sudo yum install httpd

> ports (freebsd)

Webservers have various configurable components.  The basic configuration out of the box is very conservative about resources.  You will need to tune the different settings as you go along as no two work loads are the same.  For our purposes in class the default configurations will suffice, but in the real world you will need to find
additional documents or books to guide you along.

Apache has extendable modules so its base features can be extended without needing to recompile the entire program.  Using apt-get you can add modules that you can use to render the PHP language or modules to enable HTTP/2 capabilitie3s for instance.  

> Let's try

sudo apt-get install php5

sudo service apache2 reload (as opposed to restart)  jsut re-reads the configurable

(Advanced) Add code for HTTP/2 config

See the sample code in the back of the book for a sample PHP webpage or copy and paste this code in to a file named: index.php located in ```/var/www/html```

```php
// Two slashes is a comment
<?php   

echo phpinfo();

?>

```

You should be able to load this page in your webbrowser by accessing: ```http://localhost/index.php```

Also you can add SSL certs

Get Apache License

#### Apache in RedHat based Distros

Process is different in Redhat - things don't turn on by default and you have to add modules manually.

#### Lighttpd

This webserver does what it implies, it is essentially a stripped down version of Apache in all its functions.  It has lower overhead to deploy and is used in many cases for webservers that have a single function.  For instance it is popular for setting up for large websites that will serve just images to a main webpage.  

### Nginx

Nginx is a relative new comer in the server arena.  Started in the mid 2000s this product came our of a Russian company who found their unique webserving needs couldn't be met by Apache.  They set about to create a new webserver that had a different process handling HTTP connections.  They also created Nginx to be able to handle traffic as a reverse proxy by default.  This was done because the landscape of the *web* had changed from the time when Apache was created to the mid to late part of the 2000s.  

Nginx still has modules??  And you can add capacities for languages such as PHP or something called Fast-CGI (node JS)  as well as enable SSL

Show examples

Get Nginx license

#### Nginx on RedHat

  Figure this one out

### OpenBSD httpd process

The OpenBSD project which values security and home grown solutions over pure availability.  Instead of trusting others code, the OpenBSD project built and maintain their own webserver (ported to other BSD?)  Justification:
Read up from the OpenBSD docs


## Chapter Conclusions and Review

  In this chapter we learned about the basic components of networking. We learned how to configure these settings and general network troubleshooting.

### Review Questions

1.    What tool would you use in order to display your IP address if you were using RHEL 7?
  a.  ifconfig
  b.  ipconfig
  c.  ip address show
  d.  show address

1. What tool would you use in order to display your IP address if you were using a version of Ubuntu Linux before 16.04?
  a.  ifconfig
  b.  ipconfig
  c.  ip address show
  d.  ip -4 a

1. What tool would you use to establish if a server is reponding to requests
  a.  pong
  b.  ping
  c.  google
  d.  traceroute

1. What is the purpose of a NETMASK?

1. What is the purpose of DNS?

1. What is a valid class C address?
  a.  10.0.0.0
  b.  172.24.0.0
  c.  192.168.1.0
  d.  221.0.0.0

1. If you had a network with a CIDR block of /23 how many IP addresses would you have control of?
  a. 23
  b. 254
  c. 512
  d. 256

1. If you had a CIDR block of /24 and a network address of 192.168.1.0, how many IP addresses would you have?
  a.  10
  b.  0
  c.  24
  d.  256

1.  How does CIDR block addressing differ from Class based networking (A-D)?

1.  What tool is used to release a dhcp address from the command line?
  a.  rhclient
  b.  ipconfig /release
  c.  dhclient -r
  d.  xclient -r

1.  What tool is used to monitor and examine all current local ports and TCP/IP connections?
  a.  stat
  b.  net
  c.  wireshark
  d.  netstat

1.  Where are your network card settings located on Ubuntu 16.04 by default?

1.  Where are you network card settings located by default in CentOS 7.1?

1.  Where are your network settings located by default in FreeBSD 11.0?

1.  What are the three major opensource webservers?
  a. Apache, Nginx, and openhttpd
  b. httpd, Nginx, openhttpd
  c. Apache, IIS, Nginx
  d. Apache, Lighttd, Nginx

1.  What are two related and major opensource databases?
  a. SQL and MySQL
  b. MariaDB and MySQL
  c. MySQL and Oracle DB
  d. Nginx and MySQL

1.  Name one major No-SQL database mentioned in this chapter?

### Podcast Questions

Working on it

### Lab

Use the tools listed above.

#### Footnotes
