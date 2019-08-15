# Networking, Webservers, and Intro to Databases

![*Some people just have aquariums...*](images/Chapter-Header/Chapter-12/network-2.png "Virus Aquarium")

## Objectives

* Understand how to configure and display basic network settings for the two major Linux distribution families and in BSD
* Understand how to use basic network troubleshooting tools
* Understand how to configure and deploy major webserver platforms for Linux and BSD
* Compare and contrast two major opensource webservers and be able to discuss their uses in industry
* Understand how to install, manage, and configure basic major SQL and NOSQL databases

## Outcomes

At the conclusion of this chapter you will have explored the nature of the network settings for the two major Linux distribution families and for BSD.  You will be comfortable using various commandline troubleshooting tools to help solve network issues and problems.  You will deploy two major webserver platforms and understand the differences between Apache and Nginx in their memory models and request handling models.  Finally you will have gained experience deploying, installing, and configuring MySQL and MariaDB SQL databases and a popular NoSQL database MongoDB.

### Networking

Former CEO of SUN, Scott McNealy once famously said, "*The network is the computer.*"  This was in 1990.  He could not have been more correct.  With this in mind basic networking skills are mandatory.  We will briefly cover topics in this order:

* IP addresses
  * Static and DHCP
  * MAC Address
* NETMASK and CIDR
* Gateway
* DNS

### IP Addresses

Every network interface, or NIC, which is the physical or virtual place where your device connects to the network.  Each NIC in turn needs an IP address to communicate on a network. IP addresses come in two flavors, a **static** and a **dynamic** IP address. An IPv4 or IP address is a 4 octet number looking something like this: ```192.168.1.100```.  

> Exercise
Open a command prompt and type this command to find your IP address: ```ip address show```.  This command can be abbreviated ```ip a sh``` as well.

> Exercise
Open a commmand prompt and type this command to find your MAC address or Ethernet Address ```ip l sh``` which is short for ```ip link show```.  You can find al lthe options to disply by typing ```man ip```.

A static address is one that you assign and configure based on your network.  If you are the system administrator you can and should map each device on your network with its own IP address.  For instance any servers you have, webservers, database servers, load balancers, routing equipment should have statically set IP information.

But what if you have transient or ephemeral nodes (computers) on your network?  Then you need to use the **Dynamic Host Control Protocol**.  Setting your computer to use DHCP allows it to negotiate for a lease on a shared IP address.  This is a good idea for transient devices or paces where the total number of IPs needed is less than the total number of devices, but all of those devices will not be present at the same time.  

There is a DHCP server (configuring one is beyond the scope of this chapter), that will listen for DHCP broadcasts from your client and answer with an offer of an IP.  Once your system (network card) accepts the offer it gains access to that IP address and all other necceary IP configuration--which is relinqueshes upon your physically leaving the network for the most part.  DHCP allows you to pool IPs when you might not have enough and share or allow for the auto-registration to make managing large scale IP deployments easy.  For instance at a university every student has a laptop and most likely a phone too, you could manually assign each an address but the number of students goes into the thousands and tens of thousands, and it not practical to manage--DHCP makes this scale manageable.

Settings these values statically in each operating system is different but the concept is the same.  You need to enter an IP Address, Netmask/CIDR, Network Gateway, and DNS.  Each of these concepts is explained below.

### MAC Address

Each network interface card or NIC has a 64 bit hardware address assigned to it.  This is unique and split into two parts.  The first three octets are the OUI, Organizational Unit Identifier, which is given to a particular company to help identifyt their products.  The last three octets are random numbers that are chosend by the manufacturer after the OUI is assigned for each device they manufacture.    In some cases MAC addresses can be set via software.   MAC addresses are used by switches to convert the last leg of a TCP/IP connection to an actual physical port and are at the second layer of the TCP/IP model.

![*Mac Addresses*](images/Chapter-12/mac/mac.png "Mac Addresses")

#### Ubuntu

Canonical, that develops Ubuntu, keeps an excellent wiki with this information, [Ubuntu Network Wiki](https://help.ubuntu.com/community/InternetAndNetworking "Ubuntu Network Wiki").

There are multiple ways to discover this information.  There are two suites of tools.  The original is ```net-tools``` the newer group is called the ```iproute2``` tools.  If you have used a computer before, from BSD to Windows (which used the BSD TCP-stack) these commands will be familiar.  But the *net-tools* suite development was actively **ceased** in 2001 in favor of *iproute2*.

### Comparison of Net-tools and iproute2

These look familiar don't they? The ```ifconfig``` command is a single command.  To view other details such as the ARP table, RARP command, view or change routes you would have to use additional commands.  As a contrast, the *iproute2* command handles all of that from the *ip* command.  Older Linux (pre-2015) definately have net-tools installed.  That is quickly changing as some distributions are only including the ```iproute2``` package.  One good example why to use the ```iproute2``` tools, is ```net-tools``` was created before IPv6 became a standard.  There is a [iproute2 cheatsheet](https://github.com/dmbaturin/iproute2-cheatsheet "iproute2 cheatsheet") too.

#### Replacement Commands Table

  Net-Tools Deprecated Commands           Ip2-route Replacement Commands
---------------------------------   -----------------------------------------
         ```arp```                        ```ip n``` (ip neighbor)
       ```ifconfig```                     ```ip a``` (ip addr)
                                          ```ip link```
                                          ```ip s``` (ip -stats)
        ```iptunnel```                    ```ip tunnel```
        ```iwconfig```                     ```iw```
        ```nameif```                       ```ip link``` or ```ifrename```
        ```netstat```                      ```ss```
                                           ```ip route``` (for netstat -r)
                                           ```ip -s link``` (for netstat -i)
                                           ```ip maddr``` (for netstat -g)
         ```route```                       ```ip r``` (ip route)

Table:  [Commands and Their Replacements](https://www.tecmint.com/deprecated-linux-networking-commands-and-their-replacements/ "Networking Commands and their replacements")

### udev and ethernet naming conventions under systemd

With the adoption of systemd, the convention for naming network cards changed from a driver based enumeration to [Predictable Network Interface Names](https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/ "Predicatable Network Interface Names").

"*Basic idea is that unlike previous *nix naming scheme where probing for hardware occurs in no particular order and may change between reboots, here interface name depends on physical location of hardware and can be predicted/guessed by looking at ```lspci``` or ```lshw``` output[^145].*"

"*The classic naming scheme for network interfaces applied by the kernel is to simply assign names beginning with "eth" to all interfaces as they are probed by the drivers. As the driver probing is generally not predictable for modern technology this means that as soon as multiple network interfaces are available the assignment of the names is generally not fixed anymore and it might very well happen that "eth0" on one boot ends up being "eth1" on the next. This can have serious security implications...[^146]*"

The systemd group [argued here](https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/ "ethernet argument"):

The classic naming scheme for network interfaces applied by the kernel is to simply assign names beginning with "eth0", "eth1", ... to all interfaces as they are probed by the drivers. As the driver probing is generally not predictable for modern technology this means that as soon as multiple network interfaces are available the assignment of the names "eth0", "eth1" and so on is generally not fixed anymore and it might very well happen that "eth0" on one boot ends up being "eth1" on the next. This can have serious security implications, for example in firewall rules which are coded for certain naming schemes, and which are hence very sensitive to unpredictable changing names.

The following different naming schemes for network interfaces are now supported by udev natively:

1) Names incorporating Firmware/BIOS provided index numbers for on-board devices (example: eno1)
1) Names incorporating Firmware/BIOS provided PCI Express hotplug slot index numbers (example: ens1)
1) Names incorporating physical/geographical location of the connector of the hardware (example: enp2s0)
1) Names incorporating the interfaces's MAC address (example: enx78e7d1ea46da)
1) Classic, unpredictable kernel-native ethX naming (example: eth0)

What you gain by using this standard:

1) Stable interface names across reboots 
1) Stable interface names even when hardware is added or removed, i.e. no re-enumeration takes place (to the level the firmware permits this)
1) Stable interface names when kernels or drivers are updated/changed
1) Stable interface names even if you have to replace broken ethernet cards by new ones

There is a short technical explanation of how these names are devised in the comments of the [source code here](https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L20 "Source Code").

What does this mean?  Well let us take a look at the output of the ```ip a sh``` command.  Lets try it on Ubuntu 18.04, 16.04, Fedora 28, Centos 7, and using ```ifconfig``` on FreeBSD 11 what do you see?  On some of these you see eth0 some you see enp0sX.  Why?  Though all of the these oses are using systemd, not FreeBSD, a few of them might have the value ```biosdevname=0``` set in their ```/etc/default/grub``` file, which we covered in chapter 10.    The way to reset the values is listed below:

* Edit ```/etc/default/grub```
* At the end of ```GRUB_CMDLINE_LINUX``` line append ```net.ifnames=0 biosdevname=0```
* Save the file
* Type ```grub2-mkconfig -o /boot/grub2/grub.cfg```
* or type ```grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg```
* reboot

[Source](https://unix.stackexchange.com/questions/81834/how-can-i-change-the-default-ens33-network-device-to-old-eth0-on-fedora-19 "how to reset to old names")
[Source](http://www.itzgeek.com/how-tos/mini-howtos/change-default-network-name-ens33-to-old-eth0-on-ubuntu-16-04.html "how to reset to old names")

### Network Configuration Troubles

Here is where things get tricky.  In the future I would like to think this is will all be sorted out, but for now, buckle up.  So networking was always controlled by a service under sysVinit, that was usually ```sudo service networking restart```. This was common accross all Linux.  This worked fine when network connections were static and usually a 1 to 1 realtionship with a computer or pc.  That all changed as wireless connections became a reality, and the mobility of computers to move from network to network, and even virtual machines, that could be created and destroyed rapidly, all began to change how networking was done.  In November of 2004 Fedora introduced **Network Manager** to be the main instrument to handle their network configurations.  Debian and Ubuntu would eventually follow behind and Network Manager became the default way to manage network connections.  It uses a YAML like file structure to give values to the network service.  Debian and Ubuntu maintained support for Network Manager, but always allowed fall back for compatibility reasons for the sysVinit script to manage the network.  

As of Ubuntu 18.04 there is a Network Manager replacement.  It is called [netplan.io](https://netplan.io "netplan").  Netplan is an Ubuntu style version of Network manager which reads YAML stule files from a network configuration located in ```/etc/netplan/*.yaml```.  Netplan works on top of Network Manager as well as systemd-networkd.  

Systemd-networkd is the systemd utitlity to take over network service and IP address authority.  It is still a work in progress which has implemented many of the Network Manager features but not all of them.  You can disable Network Manager as a service and enable/start systemd-networkd.  Systemd-networkd will look for run time localized overwrites of default values located in ```/etc/systemd/network```.  That directory is blank by default as systemd-networkd is not enabled by default.  Files in that directory need to end in a .network extension. The entire systemd-networkd documentations is [described here](https://www.freedesktop.org/software/systemd/man/systemd.network.html "systemd-networkd documentation"). The systemd-networkd .network file has an INI style value structure[^147]:

```bash
# Name of the file /etc/systemd/network/20-wired.network
[Match]
Name=enp1s0

[Network]
DHCP=ipv4
```

```bash
Wired adapter using a static IP
/etc/systemd/network/20-wired.network
[Match]
Name=enp1s0

[Network]
Address=10.1.10.9/24
Gateway=10.1.10.1
DNS=10.1.10.1
#DNS=8.8.8.8
```

This is the structure of the ```/etc/network/interfaces``` file for Ubuntu and Debian:

```bash
auto eth0
iface eth0 inet static
     address 192.168.0.42
     network 192.168.0.0
     netmask 255.255.255.0
     broadcast 192.168.0.255
     gateway 192.168.0.1
```

Note the change in device name due to systemd

```bash
auto enp0s8
iface enp0s8 inet static
     address 192.168.0.42
     network 192.168.0.0
     netmask 255.255.255.0
     broadcast 192.168.0.255
     gateway 192.168.0.1
```

Here is the basic structure for the Network Manager based Fedora/CentOS systems located at[^148]: ```/etc/sysconfig/network-scripts/ifcfg-eth0``` or ```/etc/sysconfig/network-scripts/ifcfg-enp5s0```

```bash
DEVICE="eth0"
BOOTPROTO="dhcp"
ONBOOT="yes"
TYPE="Ethernet"
PERSISTENT_DHCLIENT="yes"
```

```bash
# Not all of these options are required
TYPE=Ethernet
BOOTPROTO=none
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
NAME=p3p1
UUID=7622e20e-3f2a-4b5c-83d8-f4f6e22ed7ec
ONBOOT=yes
DNS1=10.0.0.1
IPADDR0=10.0.0.2
PREFIX0=24
GATEWAY0=10.0.0.1
HWADDR=00:14:85:BC:1C:63
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes
```

#### Netplan.io

Not to be out done, the sample template from Netplan.io looks similar to systemd-networkd[^149]. To configure ```netplan```, save configuration files under ```/etc/netplan/``` with a .yaml extension (e.g. ```/etc/netplan/config.yaml```), then run ```sudo netplan apply```. This command parses and applies the configuration to the system. Configuration written to disk under ```/etc/netplan/``` will persist between reboots.  By defualt in Ubuntu 18.04 Network Manager is used for actively managing network connections, Netplan is "on" but allowes Network Manager to manage by default unless specifically altered below.

```bash
# To let the interface named ‘enp3s0’ get an address via DHCP, create a YAML file with the following:
network:
  version: 2
  renderer: networkd
  ethernets:
    enp3s0:
      dhcp4: true
```

To instead set a static IP address, use the addresses key, which takes a list of (IPv4 or IPv6), addresses along with the subnet prefix length (e.g. /24). Gateway and DNS information can be provided as well:

```bash
network:
  version: 2
  renderer: networkd
  ethernets:
    enp3s0:
      addresses:
        - 10.10.10.2/24
      gateway4: 10.10.10.1
      nameservers:
          search: [mydomain, otherdomain]
          addresses: [10.10.10.1, 1.1.1.1]
```

#### Netmask

The netmask value or subnet of your network is actually a part of you Ip address. So that routers know how to route packets to your network the netmask or network mask effectively blocks off a portion of your Ip address.  Traditionally netmasks were blocked into simple Class A, B, C, and D blocks, each one representing one fo the IP octets.  But this turned out to be highly inneficient.   If you had a subnet of class A, your subnet would be 255.0.0.0.  This means that you would be assigned a fixed value from 1-254 in your first IP octect and the remaining three octets would be variable.  Apple famously has the 16.0.0.0 Class A giving them access to 255*255*255 IP addresses and Amazon recently received control of the 3.0.0.0 address block from GE. 

Class B subnet is 255.255.0.0 and gives you access to 16,000 IP addresses (254*254) with the first two octets set.  An example would be 172.24.x.y.

Class C address has 1 octet available and 3 octets preset.  A common class C subnet you see mostly in home routing devices is 192.168.1.x which gives you 254 addresses.  

For our purposes we won't worry about class D and E in this book.

The problem is those division of IP octets are very clean, unfortunately leads to many wasted addresses.  So a new way to divide blocks into smaller parts came along called [CIDR blocks](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing "CIDR Blocks") or blocking.  CIDR lets you split blocks.  The school where I work uses a subnet or CIDR block of 64.131.111.0/23  This looks like a class B subnet but it is a bit bigger.  Class B in CIDR would be /24.  /23 gives us control of 64.131.110.0 and 64.131.111.0 for 512 addresses.  /23 can be written as 255.255.254.0 as well.

#### Gateway

The gateway value is your networks default router.  This value is literally the gateway in and out of your network. Usually this IP address ends in a .1 or a .254, but does not have to.

#### DNS

DNS--Domain Name services  allow you to resolve written domain names.  The sites google.com, web.iit.edu, twit.tv, etc, etc, turn those values via lookup into IP addresses that can then route packets to and from.   DNS is very important.  Without it you would have to remember the IP address of every single site your wanted to visit.  Very quickly this wouldn't scale and in fact this idea of domain names lead to the initial founding of Yahoo as the personal index of its founder Jerry Wang in 1990s.  DNS is now a native part of the internet and is maintained by core DNS servers that are scattered world wide.   The predominant software being used for DNS is called BIND9 form the ISC, Internet Software Consortium.   We will not configure DNS servers in this book, but focus on client configuration. Your ISP provides DNS for you, those come with some gray area of allowing ISPs to sell advertising on HTTP 404 error pages, or even inject advertising code into non-https based connections.  There is a small list of alternative DNS services that give you free DNS in exchange for analyzing certain data in aggregate--beware before using them.

* Google has two public DNS services, [8.8.8.8 and 8.8.4.4](https://developers.google.com/speed/public-dns/ "Google Public DNS")
* [Cloud Flare 1.1.1.1](https://1.1.1.1 "CloudFlare DNS")
* [IBM Quad9 9.9.9.9](https://www.quad9.net/ "IBM Quad9")
* [OpenDNS servers](https://www.opendns.com/ "Opendns")

DNS is set and configured as noted above in the various networking files.  Note that DNS was not an initial part of TCP/IP networking so it was not natively contained in the network service configuration, DNS came later to the internet.

#### iputils

Most of the time the network works fine, but when it doesn't you need to be able to use builtin system tools to troubleshoot the problem and identify where the problem is.  Those tools are seperate from the iproute2 suite and are called [iputils](https://github.com/iputils/iputils "iputils"). The tools included are listed here but all of them might be installed by default.

* arping
* clockdiff
* ninfod
* ping
* rarpd
* rdisc
* tftpd
* tracepath
* traceroute
* traceroute6

The first tool that should be in your tool box is *ping*.

> ```ping``` example
```ping www.google.com```  
```ping 192.168.0.1```

Ping, just like the concept of a submarine using sonar to find objects, communicates with another IP address to see if the other system is "alive" and that your system and network are working properly to get the packet from your network to a different network.  There are many tools to enhance the output of ping as well such as [gping](https://github.com/orf/gping "Ping with graph").

The ```traceroute``` tool is used to report each router hop that a packet takes on its way to its final destination.  Useful for checking if there are routing problems along the path of your traffic. Try these commands and describe the output:

```bash
traceroute www.yahoo.com
traceroute www.yahoo.co.jp
```

There are additional tools that extend basic troubleshooting features such as:

* iptraf-ng - Network traffic visualization
* tcpdump – Detailed Network Traffic Analysis

## Webservers

August 6th 1991, Tim Berners-Lee deployed the first webpage and the created the first websaerver.  For history's sake, an early copy of it was found on an old system and [restored](http://info.cern.ch/hypertext/WWW/TheProject.html "First webpage").  He was working at the [CERN](https://en.wikipedia.org/wiki/CERN "CERN") research lab in Switzerland.  He did so with the idea to be able to freely share text data amongst researchers and national research labs world-wide.  To do this he created the Hypertext Transfer Protocol -- [HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol "HTTP Protocol") protocol for sending and receiving requests as well as a webserver named, NCSA, that would receive and process those requests, returning text to a client browser to be rendered.  

The first webserver gave rise to a commercial company called Netscape started by the now famous investor Marc Andreeson, with research coming out of the University of Illinois.  Famous for their Netscape Navigator browser, they were also the pioneers of the first webserver software. This software had been commercially available before at a high price and was limited to those who already could afford a large hardware investment.  The Apache webserver came out of this code base and became the name and the first product of the Apache Opensource Foundation.  When we look to two technologies that were used by the dotcom compnaies that survived the first and second crashes, we find that both Tyhe Apache webserver along with the MySQL database made the web possible.  

Applcations have grown enourmously beyond just serving simple html webpages.  System have even have begun bypassing webservers in echange for beconign application servers and serving traffic or aggregating traffic directly on a per request basis.  We will cover in deatil in the next chapters som eof those application servers.  For now let us start with webservers. They listen for requests on port 80.  When receiving a request, they serve (they are webservers...) or render a page of HTML code and return that to a client (you) viewing a page through a web browser.  The webserver by default will serve pages out of the ```/var/www/html``` directory on Linux and ```/var/www``` on FreeBSD.

### Apache

Without Apache, companies such as Google, Facebook, Twitter, and many others started upon opensource never would have been able to get started.

Apache has over time grown and had to add new functions while shedding old functionality.  The memory model of how it processes requests has changed over time as the frequency and amount of requests on a webserver has changed.  Some may criticze Apache webserver for being a bit old, but there is a large body of knowledge out there on how to customize and manage it.  

The Apache webserver can be installed via package managers.  There is even a version of it available for Windows.   Note that though the same application, Ubuntu refers to the Apache webserver as ```apache2``` and RedHat products refer to it as ```httpd```, which is not to be confused with the OpenBSD custom built webserver also named ```httpd```.

> ```sudo apt-get install apache2```

> ```sudo yum install httpd```

```bash
#FreeBSD 11 using Ports
sudo portsnap fetch
sudo portsnap extract
sudo portsnap update
cd /usr/ports/www/apache2
make install
```

Webservers have various configurable components.  The basic configuration out of the box is very conservative about resources and is not much use beyond for testing.  You will need to tune the different settings as you go along as no two work loads are the same, unfortunately there is no direct tutorial you can just configure and run a large business with.  For our purposes in class the default configurations will suffice, but in the real world you will need to find additional documents or books to guide you along.

Apache has extendable modules so its base features can be enhanced without needing to recompile the entire program.  Using ```apt-get``` you can add modules that you can use to render the PHP language or modules to enable HTTP/2 capabilities for instance.  

> Let's try installing apache2 and php at the same time and look at the dependecy list:

* ```sudo apt-get install apache2 php```
* ```sudo systemctl reload apache2``` -- (as opposed to restart)  just re-reads the configurable

See the sample code in the back of the book for a sample PHP webpage or copy and paste this code in to a file named: index.php located in ```/var/www/html```

```php
// Two slashes is a comment
<?php

echo phpinfo();

?>

```

You should be able to load this page in the browser in your virtual machine by accessing: ```http://localhost/index.php```

#### HTTP/2

"*Websites that are efficient minimize the number of requests required to render an entire page by minifying (reducing the amount of code and packing smaller pieces of code into bundles, without reducing its ability to function) resources such as images and scripts. However, minification is not necessarily convenient nor efficient and may still require separate HTTP connections to get the page and the minified resources. HTTP/2 allows the server to "push" content, that is, to respond with data for more queries than the client requested. This allows the server to supply data it knows a web browser will need to render a web page, without waiting for the browser to examine the first response, and without the overhead of an additional request cycle.*" 

"*Additional performance improvements in the first draft of HTTP/2 (which was a copy of SPDY) come from multiplexing of requests and responses to avoid the head-of-line blocking problem in HTTP 1 (even when HTTP pipelining is used), header compression, and prioritization of requests. HTTP/2 no longer supports HTTP 1.1's chunked transfer encoding mechanism, as it provides its own, more efficient, mechanisms for data streaming[^152].*"

The best resource I found was a technical deep-dive on HTTP/2 by [Steve Gibson at Security Now Podcast episode 495](https://twit.tv/shows/security-now/episodes/495 "SN 495")

#### Self-signed Certs

One of the major innovations Netscape made with their original webserver product was the creation of SSL, secure socket layer technology.   This allowed for sensitive data to be encypted and decrypted securely--which enabled commerce over the internet to take off.  HTTP connection using SSL have the prefix ```https://```.  SSL has long been depricated and replaced with TLS - (Transport Layer Security) 1.2 and 1.3, but many people still use the phrase *SSL* when they really mean *TLS*.

You can configure your system to generate SSL certs, but they will be missing a key component of Certificates you can buy or receive from a third party.  In that they don't have a chain of trust about them.  Self-signed certs will also trigger a browser to throw a security warning and block entry to that web-site.  Now you have the option of overriding this and or accepting these self-signed browers into your operating systems certificate store.  Some companies so this to secure internal traffic that does not go to the outside internet, but stays inside a company network.  

There is an [EFF](https://www.eff.org/ "EFF") led iniative called [Let's Encrypt](https://letsencrypt.org/ "Lets Encrypt") that will give you free SSL certs for your public site.  They offer wildcard domains and easy setup via ```apt```, ```yum```, and ```dnf``` to make this experience easy and remove all reasons to not encrypt web traffic.  [You can see the adoption curve](https://letsencrypt.org/stats/ "Lets encrypt stats") of TLS/SSL since Let's Encrypt became widely available. 

* [TLS 1.3 Podcast on Security Now](https://twit.tv/shows/security-now/episodes/656 "TLS 1.3")
* [Lets Encrypt Explanation Podcast](https://twit.tv/shows/security-now/episodes/483 "Lets encrypt explanation podcast")
* [SSL Labs](https://www.ssllabs.com/ "SSL Labs") is a free service that will check your TLS cert and server settings.
 + You can use SSL labs to check the Let's Encrypt cert for [my own tech blog, forge.sat.iit.edu](https://forge.sat.iit.edu "Forge.sat.iit.edu").

Without having a public IP address you can't use Let's Encrypt, but you can generate a self-signed SSL/TLS certificate following these tutorials.  Note that your broweser will complain and send you dire warnings, you will have the option to accept the cert anyway and then the warnings will not persist.

* [Digital Ocean Nginx Self-Signed SSL Cert](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-18-04 "Nginx Self-signed CERT")
* [Digital Ocean Apache Self-Signed SSL Cert](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-18-04 "Apache Self-signed CERT")

Just like anything you can, can automate the creation of a self-signed cert:

```bash

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key \ -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=US/ST=Illinois/L=Chicago/O=IIT-Company/OU=Org/CN=www.school.com"

```

### Nginx

Started in 2004 by Igor Sysoev, this product came out of a Russian company who found their unique webserving needs couldn't be met by Apache.  It is licensed under the [2 Clause BSD license](https://en.wikipedia.org/wiki/Simplified_BSD_License "2 Clause BSD"). Apache had a memory model that was created when serving webpages in the the mid-1990s, and the nature of the web, including serving more dynamically generated pages, and information from multiple streams pushed Apache to the edge of its capability. Nginx was developed to overcome these limitiations and solve the [C10K problem](https://en.wikipedia.org/wiki/C10k_problem "C10K").  Nginx has the ability to do load-balancing and reverse-proxying natively.  Nginx achieves its speed increase by sacrificing the flexibility that Apache has.  

Centos and Fedora will need to add the ```epel-release``` package first, ```sudo yum install epel-release``` or ```sudo dnf install epel-release```.  For Ubuntu use ```apt-get```.

For instructions on configuring and installing the php library for nginx, [https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04 "Digitla Ocean 18.04 nginx php").

### OpenBSD httpd Process

The OpenBSD project which values security and home grown solutions over pure availability.  Instead of trusting others code, the OpenBSD project built and maintain [their own webserver](https://bsd.plumbing/about.html#features "OpenBSD httpd").

## Database and NoSQL

Databases come in two types: **Relational databases** and **Non-relational databases (NoSQL)**. The relational database structure uses a query language called SQL [link here], *Structured Query Language* which allows you to make queries on structured data.  Structured data assumes that data is stored in typed fields such as integer, varchar, decimal, datetime, and so forth.  These structured rows and columns are then stored in a table and accesed via the SQL syntax either via the command line or integrated into a programming language.

* SQL example - ```SELECT answers FROM finalexam``` or ```SELECT * FROM EMPLOYEES WHERE ID=6000```
* NoSQL sample: ```db.inventory.find( { status: { $in: [ "A", "D" ]}})```

### Mysql and MariaDB

Installation of a databadse is straight forward using package managers, there are two pieces of the Relational Database (RDBMS) the client and the server.  These parts do what they say, if you are accesing a database remotely, you do not need to install the entire server just the client tools to use the applications.

```bash
sudo apt-get install mariadb  
sudo apt-get install mysql

sudo apt-get install mariadb-client
sudo apt-get install mariadb-server

sudo dnf install mariadb mariadb-server
sudo dnf install mariadb-client
# make sure to start and enable the maria or mysql service on Fedora/Centos
```

MySQL was started by [Michael "Monte" Widens](https://en.wikipedia.org/wiki/Michael_Widenius "Monte Mysql").  The company was one of the first major companies to become succesful with an opensource model, especially for a database product in a crowded market.  MySQL the company was sold to SUN in 2009 [link here], which then was inherited by Oracle in their purchase of SUN in 2010.  Monte was not happy with Oracle's stewardship of MySQL and decided to fork the codebase and begin a new yet familiar product called MariaDB.  MariaDB continued the MySQL legacy by essentially restarting the MySQL company.  MariaDB is for all purposes a drop in replacement for MySQL, even using the same commands to run the database. You can create a database and a table directly from the ```mysql``` cli.

* Log in
* Enter your password at the prompt
* Enter commands at the CLI
* Quit

```bash
sudo mysql -u root -p
CREATE DATABASE records;
USE records;
create table tutorials_tbl(
   tutorial_id INT NOT NULL AUTO_INCREMENT,
   tutorial_title VARCHAR(100) NOT NULL,
   tutorial_author VARCHAR(40) NOT NULL,
   submission_date DATE,
   PRIMARY KEY ( tutorial_id )
  );
quit;
```

### PostgreSQL

As always in technology, product names often have a joke or a story behind them. PostgreSQL is no different.  One of the original RDBMs, Ingress, was a product and a company in the 1980s.  The succesor to that project was PostgreSQL (see the pun?).  PostgreSQL has the added advantage of being opensouce, backed by a commercial company, as well as not being MySQL which is owned by Oracle.  Installation is provided in custom repos that need to added to a system before using a package manager.

* [PostgreSQL Downloads for Ubuntu and Fedora/Centos](https://www.postgresql.org/download/ "PostgreSQL downloads")

### SQLite

Is an intersting small database.  It aschews some of the bigger features to be mean and lean. "SQLite is an in-process library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine[^150]."  It is meant to store and retrieve data and that is about it.  This makes it very small and very compact, which makes it great for using on the mobile platform Android or iOS since it is a single binary file, and can be installed on mobile devices and tablets as part of an application.  Sqlite3 has the unique licensing of being the [Public Domain](https://sqlite.org/copyright.html "Public Domain for Sqlite3").  You can install SQlite3 via the normal package mechanism and it is usually close to being up to date.  Note that SQlite3 doesn't listen on external ports by default it is included as an external library in your application.

* ```sudo apt-get install sqlite3```
* ```sudo yum install sqlite```
* ```sudo dnf install sqlite```

### MongoDB

Though there are many in this category, I have selected one NoSQL database.  The difference here is that data is not stored in tables or typed fields but as simple untyped records--the NoSQL really refers to no relations or relational structure[^151].  This means that records can be of any type or length.  You access the data not through a Structured Query Language but using HTTP requests via REST; GET, PUT, PATCH and DELETE which mirror the functionality of CRUD--Create, Retrieve, Update, and Delete. This allows you to integrate your "query" lanugage directly into your application code.  REST is the outgrowth of the succesful spread of HTTP as a protocol.

MongoDB packages are maintained by MongoDB -- and are released outside of Linux distro release cycles.  The installation process is different for Ubuntu and CentOS.  The instructions to add a custom repository are located here:

* [https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/ "Install on Ubuntu")
* [https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/ "Install on RedHat Centos")
* Make sure to start the mongod service
* [https://docs.mongodb.com/manual/mongo/](https://docs.mongodb.com/manual/mongo/ "Mongo Shell")
 + [Run Mongo insert sample](https://docs.mongodb.com/manual/tutorial/insert-documents/ "Mongo Insert Sample")
 + [Run Mongo query sample](https://docs.mongodb.com/manual/tutorial/query-documents/ "Mongo query example")

## Firewall

Used to block exteral communication on you system ports.   Not unlike plugs in the wall of your home, your server has ports that different services connect to and communication on.  This allows the operating system and applications to communicate as well with multiple programs.  There are 65000 ports available to use.  The first 1024 ports are reserved for well known services.  These numbers are useful to know, but applications have changed.  For instance SMTP is no longer unencrypted and used over port 25,but port 567 or 995.  Also the use of Git over http has replaced the need for FTP/SFTP/SSH and other protocols to send and retrieve data.

* SSH - 22
* FTP - 21
* SMTP - 25 (depricated not used as it is an unsecured transport method)
* DNS - 53
* HTTP - 80
* HTTPS - 443 (HTTP with TLS/SSL)
* SMTP over SSL - 990
* MongoDB - 27017
* PostgreSQL - 5432
* MySQL - 3306
* Oracle DB - 1521

You can use rules to deny or allows traffic based on source IP, source Port, Destination IP, or Destination Port.   Some people urge turning the firewall off because of complexity.  I do not recommend this.  If you are going to run a business, you need to understand what ports are open and why--opening them all is not a solution and could be a violation of laws regarding security, privacy, and government regulation.  

### Firewalld

Distributions using systemd have switched to [firewalld](https://firewalld.org/ "firewalld") as their main firewall interface.  There had been previous ways to interface with a firewalld and firewalld seeks to abstract these away and present a unified interface to your systems firewall.    Fedora turns their firewall on by default, Centos 7 does not.  

Firewalld uses the ```firewall-cmd``` command and not firewallctl like you would expect.  It has a concept of *zones* which allow you to predefine a collection of rules that can be applied to different zones. Permanent configuration is loaded from XML files in ```/usr/lib/firewalld``` or ```/etc/firewalld```  When declaring a new rule you need to declare if the rule is permananet or will be reset when the firewalld service is reloaded.  The firewalld system contains zones:

* trusted or untrusted
* drop
  + incoming packets are dropped, outbound packets are allowed
* block
  + incoming packets are rejected with an icmp-host-prohibited response
* public
* work
* home
* internal

```sudo firewall-cmd --zone=public --add-port=22/tcp --permanent```

Firewalld includes a standard interface so third party tools and build integration into your firewall.  Fail2ban is a anti-bruteforce tool for systems that have their connections exposed to the public network, such as mysql and openssh-server.  It allows you do ban IP{ addresses that are trying to brute force hack your system. You can do permananet banning or a timeout based banning. ```Fail2ban``` has a firewalld integration where you can add firewall rules to block bad IPs automatically.

```bash

# you may need the epel-release package on Fedora/Centos
sudo dnf install fail2ban fail2ban-firewalld
sudo apt-get install fail2ban fail2ban-firewalld
sudo yum install fail2ban fail2ban-firewalld

sudo systemctl enable fail2ban
sudo systemctl start fail2ban

```

### Ubuntu UFW

Ubuntu uses [UFW (Uncomplicated Firewall)](https://help.ubuntu.com/community/UFW "Ubuntu UFW"). It is installed but not enabled by default.  You can enable it:  ```sudo ufw enable``` and print out the status via ```sudo ufw status```.  Syntax examples include:

* Allow or deny by port number
  + ```sudo ufw allow 53```
  + ```sudo ufw deny 53```
* Allow or deny by service
  + sudo ufw allow ssh
  + sudo ufw deny ssh 
* Allow from IP
 + ```sudo ufw allow from 207.46.232.182```
* Allow from subnet/CIDR block
  + ```sudo ufw allow from 192.168.1.0/24```
  + ```sudo ufw allow from 192.168.0.4 to any port 22```
  + ```sudo ufw allow from 192.168.0.4 to any port 22 proto tcp```
* Enable/Disable ufw logging
  + ```sudo ufw logging on```
  + ```sudo ufw logging off```

```Firewalld``` can be installed on ubuntu via apt-get and then enabled and started as a service in place of UFW if you want to maintain that service and not use UFW.

## Chapter Conclusions and Review

In this chapter we learned about the basic components of networking. We learned how to configure these settings and general network troubleshooting.

### Review Questions

1. What tool would you use in order to display your IP address if you were using RHEL 7?
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
1. How does CIDR block addressing differ from Class based networking (A-D)?
1. What tool is used to release a dhcp address from the command line?
  a.  rhclient
  b.  ipconfig /release
  c.  dhclient -r
  d.  xclient -r
1. What tool is used to monitor and examine all current local ports and TCP/IP connections?
  a.  stat
  b.  net
  c.  wireshark
  d.  netstat
1. Where are your network card settings located on Ubuntu 16.04 by default?
1. Where are you network card settings located by default in CentOS 7.1?
1. Where are your network settings located by default in FreeBSD 11.0?
1. What are the three major opensource webservers?
  a. Apache, Nginx, and openhttpd
  b. httpd, Nginx, openhttpd
  c. Apache, IIS, Nginx
  d. Apache, Lighttd, Nginx
1. What are two related and major opensource databases?
  a. SQL and MySQL
  b. MariaDB and MySQL
  c. MySQL and Oracle DB
  d. Nginx and MySQL
1. Name one major No-SQL database mentioned in this chapter?

### Podcast Questions

View or listen to this Podcast about Nginx: [http://twit.tv/show/floss-weekly/283](http://twit.tv/show/floss-weekly/283 "Nginx on Twit.tv")

1. ~2:02 What is Nginx?
1. ~3:22 What percentage of the world's websites are served with Nginx?
1. ~4:57 What was the challenge that lead to the creation of Nginx?
1. ~5:33 What is the main architectural difference between Nginx and Apache webservers?
1. ~8:32 What are some of the main use cases for Nginx?
1. ~11:00 When did Sarah get involved in Nginx?
1. ~12:56 Where did Nginx come from?
1. ~17:41 What is "caching" in relation to websites?
1. ~19:45 What is "proxying" in relation to websites?
1. ~29:36 What was the founder's motive to opensource Nginx?
1. ~34:00 What is the difference in the opensource Nginx and the commercial version? (Freemium?)
1. ~40:19 Are there Linux Distro packages for Nginx? 
1. ~53:10 Can Apache and Nginx co-exist or is it a winner take all?

### Lab

1. Using firewalld open port 22 permanantly to allow SSH connections to your Fedora or Centos system.
1. Install mysql-server, PHP, and Nginx, and a self-signed cert.  
  i. Create a sample webpage that displays ```phpinfo()``` at https://localhost/index.php
  i. Locate the file index.php in ```/var/www/html```

#### Footnotes

[^145]: [https://askubuntu.com/questions/704361/why-is-my-network-interface-named-enp0s25-instead-of-eth0?rq=1](https://askubuntu.com/questions/704361/why-is-my-network-interface-named-enp0s25-instead-of-eth0?rq=1 "why-is-my-network-interface-named-enp0s25-instead-of-eth0?")

[^146]: [https://unix.stackexchange.com/questions/134483/why-is-my-ethernet-interface-called-enp0s10-instead-of-eth0](https://unix.stackexchange.com/questions/134483/why-is-my-ethernet-interface-called-enp0s10-instead-of-eth0 "why-is-my-ethernet-interface-called-enp0s10-instead-of-eth0")

[^147]: [https://wiki.archlinux.org/index.php/Systemd-networkd](https://wiki.archlinux.org/index.php/Systemd-networkd "systesmd-networkd")

[^148]: [https://superuser.com/questions/645487/static-ip-address-with-networkmanager](https://superuser.com/questions/645487/static-ip-address-with-networkmanager "Static NetMan IP")

[^149]: [https://netplan.io/examples](https://netplan.io/examples "netplan examples")

[^150]: [https://sqlite.org/about.html](https://sqlite.org/about.html "Sqlite3")

[^151]: [https://en.wikipedia.org/wiki/NoSQL](https://en.wikipedia.org/wiki/NoSQL "NoSQL")

[^152]: [https://en.wikipedia.org/wiki/HTTP/2](https://en.wikipedia.org/wiki/HTTP/2 "HTTP/2")
