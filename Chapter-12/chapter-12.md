# Networking, Webservers, and Intro to Databases

![*Some people just have aquariums...*](images/Chapter-Header/Chapter-12/network-2.png "Virus Aquarium")

## Objectives

* Understand how to configure and display basic network settings for the two major Linux distribution families
* Understand how to use basic network troubleshooting tools
* Understand how to configure and deploy major webserver platforms for Linux and BSD
* Compare and contrast major opensource webservers and be able to discuss their uses in industry
* Understand how to install, manage, and configure basic major SQL and NOSQL databases

## Outcomes

At the conclusion of this chapter you will have explored the nature of the network settings for the two major Linux distribution families and for BSD.  You will be comfortable using various commandline troubleshooting tools to help solve network issues and problems.  You will deploy two major webserver platforms and understand the differences between Apache and Nginx in their memory models and request handling models.  Finally you will have gained experience deploying, installing, and configuring MySQL and MariaDB SQL databases and a popular NoSQL database MongoDB.

## Networking

Former CEO of Sun Microsystems, Scott McNealy once famously said, "*The network is the computer.*"  This was in 1990.  He could not have been more correct.  With this in mind, basic networking skills are mandatory.  We will briefly cover topics in this order:

* IP addresses
  * Static and DHCP
  * MAC Address
* NETMASK and CIDR
* Gateway
* DNS

### IP Addresses

Every network interface, or NIC, which is the physical or virtual place where your device connects to the network.  Each NIC in turn needs an IP address to communicate on a network. IP addresses come in two flavors, a **static** and a **dynamic** IP address. An IPv4 or IP address is a 4 octet number looking something like this: ```192.168.1.100```.  

> Exercise: Open a command prompt and type this command to find your IP address: ```ip address show```.  This command can be abbreviated ```ip a sh``` as well.

A static address is one that you assign and configure based on your network.  If you are the system administrator you can and should map each device on your network with its own IP address.  For instance any servers you have, webservers, database servers, load balancers, routing equipment should have statically set IP information.

> Exercise: Open a command prompt and type this command to find your MAC address or Ethernet Address ```ip l sh``` which is short for ```ip link show```.  You can find all the options to display by typing ```man ip```.

But what if you have transient or ephemeral nodes (computers) on your network?  Then you need to use the **Dynamic Host Configuration Protocol**.  Setting your computer to use DHCP allows it to negotiate for a lease on a shared IP address.  This is a good idea for transient devices or paces where the total number of IPs needed is less than the total number of devices, but all of those devices will not be present at the same time.  

There is a DHCP server (configuring one is beyond the scope of this chapter), that will listen for DHCP broadcasts from your client and answer with an offer of an IP.  Once your system (network card) accepts the offer it gains access to that IP address and all other necessary IP configuration--which is relinquishes upon your physically leaving the network for the most part.  DHCP allows you to pool IPs when you might not have enough and share or allow for the auto-registration to make managing large scale IP deployments easy.  

For instance at a university every student has a laptop and most likely a phone too, you could manually assign each an address but the number of students goes into the thousands and tens of thousands, and it not practical to manage--DHCP makes this scale manageable. Settings these values statically in each operating system is different but the concept is the same.  You need to enter an IP Address, Netmask/CIDR, Network Gateway, and DNS.  Each of these concepts is explained below.

### MAC Address

Each network interface card or NIC has a 64 bit hardware address assigned to it.  This is unique and split into two parts.  The first three octets are the OUI, Organizational Unit Identifier, which is given to a particular company to help identify their products.  The last three octets are random numbers that are chosen by the manufacturer after the OUI is assigned for each device they manufacture.    In some cases MAC addresses can be set via software.   MAC addresses are used by switches to convert the last leg of a TCP/IP connection to an actual physical port and are at the second layer of the TCP/IP model.

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

"*Basic idea is that unlike previous \*nix naming scheme where probing for hardware occurs in no particular order and may change between reboots, here interface name depends on physical location of hardware and can be predicted/guessed by looking at ```lspci``` or ```lshw``` output[^145].*"

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

* Stable interface names across reboots
* Stable interface names even when hardware is added or removed
  * no re-enumeration takes place (to the level the firmware permits this)
* Stable interface names when kernels or drivers are updated/changed
* Stable interface names even if you have to replace broken ethernet cards by new ones

There is a short technical explanation of how these names are devised in the comments of the [source code here](https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L20 "Source Code").

What does this mean?  Well let us take a look at the output of the ```ip a sh``` command.  Lets try it on Ubuntu 18.04, 16.04, Fedora 30, CentOS 7, and using ```ifconfig``` on FreeBSD 11 what do you see?  On some of these you see eth0 some you see enp0sX.  Why?  Though all of the these oses are using systemd, not FreeBSD, a few of them might have the value ```biosdevname=0``` set in their ```/etc/default/grub``` file, which we covered in chapter 10. The way to reset the values is listed below:

* Edit ```/etc/default/grub```
* At the end of ```GRUB_CMDLINE_LINUX``` line append ```net.ifnames=0 biosdevname=0```
* Save the file
* Type ```grub2-mkconfig -o /boot/grub2/grub.cfg```
* or type ```grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg```
* reboot

[Source](https://unix.stackexchange.com/questions/81834/how-can-i-change-the-default-ens33-network-device-to-old-eth0-on-fedora-19 "how to reset to old names")
[Source](http://www.itzgeek.com/how-tos/mini-howtos/change-default-network-name-ens33-to-old-eth0-on-ubuntu-16-04.html "how to reset to old names")

### Network Configuration Troubles

Here is where things get tricky.  In the future I would like to think this is will all be sorted out, but for now, buckle up.  So networking was always controlled by a service under sysVinit, that was usually ```sudo service networking restart```. This was common across all Linux.  This worked fine when network connections were static and usually a 1 to 1 relationship with a computer or pc.  That all changed as wireless connections became a reality, and the mobility of computers to move from network to network, and even virtual machines, that could be created and destroyed rapidly, all began to change how networking was done.  In November of 2004 Fedora introduced **Network Manager** to be the main instrument to handle their network configurations.  Debian and Ubuntu would eventually follow behind and Network Manager became the default way to manage network connections.  It uses a YAML like file structure to give values to the network service.  Debian and Ubuntu maintained support for Network Manager, but always allowed fall back for compatibility reasons for the sysVinit script to manage the network.  

The control of the network has been unified once again in all major Linux distros under **systemd-networkd**, which being part of systemd you assume that it controls the networking stack. Systemd-networkd will look for run time localized overwrites of default values located in ```/etc/systemd/network```.  Files in that directory need to end in a .network extension. The systemd-networkd .network file has an INI style value structure[^147]: The entire systemd-networkd documentations is [described here](https://www.freedesktop.org/software/systemd/man/systemd.network.html "systemd-networkd documentation").

#### Who uses what?

For the desktop Linux, Ubuntu and Fedora/Red Hat based, Network Manger is being used by default as of late 2021, but systemd-networkd can be enabled.  The server edition of Ubuntu 20.04 use systemd-networkd.

#### Systemd-networkd network config file templates

```bash
# Systemd-networkd .network file (not Ubuntu Netplan)
# Name of the file /etc/systemd/network/20-wired.network
[Match]
Name=enp1s0

[Network]
DHCP=ipv4
```

```bash
# Wired adapter using a static IP
# /etc/systemd/network/20-wired.network
[Match]
Name=enp1s0

[Network]
Address=10.1.10.9/24
Gateway=10.1.10.1
DNS=10.1.10.1
#DNS=8.8.8.8
```

### Ubuntu non-netplan Network Manager Config

This is the structure of the ```/etc/network/interfaces``` file Network Manager based file for Ubuntu and Debian (deprecated):

```bash
auto eth0
iface eth0 inet static
     address 192.168.0.42
     network 192.168.0.0
     netmask 255.255.255.0
     broadcast 192.168.0.255
     gateway 192.168.0.1
```

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

To further confuse things, Ubuntu decided to write a YAML based file management abstraction layer for networking that can use the same configuration for either Network Manager or Networkd-Systemd.  It is called [netplan.io](https://netplan.io "netplan").  Netplan reads YAML style files from a network configuration located in ```/etc/netplan/*.yaml```.

Not to be out done, the sample template from Netplan.io looks similar to systemd-networkd[^149]. To configure ```netplan```, save configuration files under ```/etc/netplan/``` with a .yaml extension (e.g. ```/etc/netplan/config.yaml```), then run ```sudo netplan apply```. This command parses and applies the configuration to the system. Configuration written to disk under ```/etc/netplan/``` will persist between reboots.  By default in Ubuntu 18.04 Network Manager is used for actively managing network connections, Netplan is "on" but allows Network Manager to manage by default unless specifically altered below.

```yaml
# To let the interface named ‘enp3s0’ get an address
# via DHCP, create a YAML file with the following:
network:
  version: 2
  renderer: networkd
  ethernets:
    enp3s0:
      dhcp4: true
```

To instead set a static IP address, use the addresses key, which takes a list of (IPv4 or IPv6), addresses along with the subnet prefix length (e.g. /24). Gateway and DNS information can be provided as well:

```yaml
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

The netmask value or subnet of your network is actually a part of you IP address. So that routers know how to route packets to your network the netmask or network mask effectively blocks off a portion of your IP address.  Traditionally netmasks were blocked into simple Class A, B, C, and D blocks, each one representing one of the IP octets.  But this turned out to be highly inefficient.   If you had a subnet of class A, your subnet would be 255.0.0.0.  This means that you would be assigned a fixed value from 1-254 in your first IP octet and the remaining three octets would be variable.  Apple famously has the 16.0.0.0 Class A giving them access to 255*255*255 IP addresses and Amazon recently received control of the 3.0.0.0 address block from GE.

Class B subnet is 255.255.0.0 and gives you access to 16,000 IP addresses (254*254) with the first two octets set.  An example would be 172.24.x.y.

Class C address has 1 octet available and 3 octets preset.  A common class C subnet you see mostly in home routing devices is 192.168.1.x which gives you 254 addresses. For our purposes we won't worry about class D and E in this book.

The problem is those division of IP octets are very clean, unfortunately leads to many wasted addresses.  So a new way to divide blocks into smaller parts came along called [CIDR blocks](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing "CIDR Blocks") or blocking.  CIDR lets you split blocks.  A business might have a subnet or CIDR block of /23.  This looks like a class B subnet.  Class B in CIDR would be /24.  The /23 gives us control of 192.168.1.110 and 192.168.1.111 for 512 addresses.  /23 can be written as 255.255.254.0 as well.

#### Gateway

The gateway value is your networks default router.  This value is literally the gateway in and out of your network. Usually this IP address ends in a .1 or a .254, but does not have to.

#### DNS

DNS--Domain Name services  allow you to resolve written domain names.  The sites google.com, web.iit.edu, twit.tv, etc, etc, turn those values via lookup into IP addresses that can then route packets to and from.   DNS is very important.  Without it you would have to remember the IP address of every single site your wanted to visit.  Very quickly this wouldn't scale and in fact this idea of domain names lead to the initial founding of Yahoo as the personal index of its founder Jerry Wang in 1990s.  DNS is now a native part of the internet and is maintained by core DNS servers that are scattered world wide.   The predominant software being used for DNS is called BIND9 form the ISC, Internet Software Consortium.   We will not configure DNS servers in this book, but focus on client configuration. Your ISP provides DNS for you, those come with some gray area of allowing ISPs to sell advertising on HTTP 404 error pages, or even inject advertising code into non-https based connections.  There is a small list of alternative DNS services that give you free DNS in exchange for analyzing certain data in aggregate--beware before using them.

* Google has two public DNS services, [8.8.8.8 and 8.8.4.4](https://developers.google.com/speed/public-dns/ "Google Public DNS")
* [Cloud Flare 1.1.1.1](https://1.1.1.1 "CloudFlare DNS")
* [IBM Quad9 9.9.9.9](https://www.quad9.net/ "IBM Quad9")
* [OpenDNS servers](https://www.opendns.com/ "Opendns")

DNS is set and configured as noted above in the various networking files.  Note that DNS was not an initial part of TCP/IP networking so it was not natively contained in the network service configuration, DNS came later to the internet.

### /etc/hosts

Linux, inheriting from UNIX from a time before DNS existed, has a file for local DNS lookups: ```/etc/hosts```.  This file is owned by root.  You can edit this and place three items: an IP address, a fully qualified domain name, a short name (just the hostname).  This is enabled by default and is the first lookup for your system.  This helps save network based DNS roundtrips and can be accessed by any application or script without needing modification or additional libraries.

```bash

# sample /etc/hosts file from a system setting up a sample network

192.168.33.110 riemanna.example.com riemanna
192.168.33.120 riemannb.example.com riemannb
192.168.33.100 riemannmc.example.com riemannmc

192.168.33.210 graphitea.example.com graphitea
192.168.33.220 graphiteb.example.com graphiteb
192.168.33.200 graphitemc.example.com graphitemc

192.168.33.10  hosta.example.com hosta
192.168.33.20  hostb.exampe.com hostb

192.168.33.50 logstash.example.com logstash
192.168.33.51 ela1.example.com ela1
192.168.33.52 ela2.example.com ela2
192.168.33.53 ela3.example.com ela3

```

#### iputils

Most of the time the network works fine, but when it doesn't you need to be able to use built in system tools to troubleshoot the problem and identify where the problem is.  Those tools are separate from the iproute2 suite and are called [iputils](https://github.com/iputils/iputils "iputils"). The tools included are listed here but all of them might not be installed by default.

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

* [iptraf-ng](https://wiki.ipfire.org/addons/iptraf-ng "iptraf-ng website") - Network traffic visualization
* [tcpdump](http://www.tcpdump.org/ "tcpdump website") – Detailed Network Traffic Analysis

## Webservers

August 6th 1991, Tim Berners-Lee deployed the first webpage and the created the first webserver.  For history's sake, an early copy of it was found on an old system and [restored](http://info.cern.ch/hypertext/WWW/TheProject.html "First webpage").  He was working at the [CERN](https://en.wikipedia.org/wiki/CERN "CERN") research lab in Switzerland.  He did so with the idea to be able to freely share text data amongst researchers and national research labs world-wide.  To do this he created the Hypertext Transfer Protocol -- [HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol "HTTP Protocol") protocol for sending and receiving requests as well as a webserver named, NCSA, that would receive and process those requests, returning text to a client browser to be rendered.  

The first webserver gave rise to a commercial company called Netscape started by the now famous investor Marc Andreeson, with research coming out of the University of Illinois.  Famous for their Netscape Navigator browser, they were also the pioneers of the first webserver software. This software had been commercially available before at a high price and was limited to those who already could afford a large hardware investment.  The Apache webserver came out of this code base and became the name and the first product of the Apache Opensource Foundation.  When we look to two technologies that were used by the dotcom companies that survived the first and second crashes, we find that both the Apache webserver along with the MySQL database made the web possible.  

Applications have grown enormously beyond just serving simple html webpages.  What was once a simple webserver has been exchanged becoming application servers and serving traffic or aggregating traffic directly on a per request basis.  We will cover in detail in the next chapters some of those application servers.  For now let us start with webservers. They listen for requests on port 80.  When receiving a request, they serve (they are webservers...) or render a page of HTML code and return that to a client (you) viewing a page through a web browser.  The webserver by default will serve pages out of the ```/var/www/html``` directory on Linux and ```/var/www``` on FreeBSD.

### Apache

Without Apache, companies such as Google, Facebook, Twitter, and many others started upon opensource never would have been able to get started.

Apache has over time grown and had to add new functions while shedding old functionality.  The memory model of how it processes requests has changed over time as the frequency and amount of requests on a webserver has changed.  Some may criticize Apache webserver for being a bit old, but there is a large body of knowledge out there on how to customize and manage it.  

The Apache webserver can be installed via package managers.  There is even a version of it available for Windows.   Note that though the same application, Ubuntu refers to the Apache webserver as ```apache2``` and Red Hat products refer to it as ```httpd```, which is not to be confused with the OpenBSD custom built webserver also named ```httpd```.

> ```sudo apt-get install apache2```

> ```sudo yum install httpd```

```bash
#FreeBSD 12 using Ports
sudo portsnap fetch
sudo portsnap extract
sudo portsnap update
cd /usr/ports/www/apache2
make install
```

Webservers have various configurable components.  The basic configuration out of the box is very conservative about resources and is not much use beyond for testing.  You will need to tune the different settings as you go along as no two work loads are the same, unfortunately there is no direct tutorial you can just configure and run a large business with.  For our purposes in class the default configurations will suffice, but in the real world you will need to find additional documents or books to guide you along.

Apache has extendable modules so its base features can be enhanced without needing to recompile the entire program.  Using ```apt-get``` you can add modules that you can use to render the PHP language or modules to enable HTTP/2 capabilities for instance.  

> Let's try installing apache2 and php at the same time and look at the dependency list:

* ```sudo apt-get install apache2 php```
* ```sudo systemctl reload apache2``` -- (as opposed to restart)  just re-reads the configurable

Sample code is shown here for a sample PHP webpage or copy and paste this code in to a file named: index.php located in ```/var/www/html```

```php
// Two slashes is a comment
<?php

echo phpinfo();

?>

```

You should be able to load this page in the browser inside your virtual machine by accessing: ```http://localhost/index.php```

#### HTTP/2

"*Websites that are efficient minimize the number of requests required to render an entire page by minifying (reducing the amount of code and packing smaller pieces of code into bundles, without reducing its ability to function) resources such as images and scripts. However, minification is not necessarily convenient nor efficient and may still require separate HTTP connections to get the page and the minified resources. HTTP/2 allows the server to "push" content, that is, to respond with data for more queries than the client requested. This allows the server to supply data it knows a web browser will need to render a web page, without waiting for the browser to examine the first response, and without the overhead of an additional request cycle.*"

"*Additional performance improvements in the first draft of HTTP/2 (which was a copy of SPDY) come from multiplexing of requests and responses to avoid the head-of-line blocking problem in HTTP 1 (even when HTTP pipelining is used), header compression, and prioritization of requests. HTTP/2 no longer supports HTTP 1.1's chunked transfer encoding mechanism, as it provides its own, more efficient, mechanisms for data streaming[^152].*"

The best resource I found was a technical deep-dive on HTTP/2 by [Steve Gibson at Security Now Podcast episode 495](https://twit.tv/shows/security-now/episodes/495 "SN 495")

#### TLS Certs

One of the major innovations Netscape made with their original webserver product was the creation of SSL, secure socket layer technology.   This allowed for sensitive data to be encrypted and decrypted securely--which enabled commerce over the internet to take off.  HTTP connection using SSL have the prefix ```https://```.  SSL has long been deprecated and replaced with TLS - (Transport Layer Security) 1.2 and 1.3, but many people still use the phrase *SSL* when they really mean *TLS*.

You can configure your system to generate SSL certs, but they will be missing a key component of Certificates you can buy or receive from a third party.  In that they don't have a chain of trust about them.  Self-signed certs will also trigger a browser to throw a security warning and block entry to that web-site.  Now you have the option of overriding this and or accepting these self-signed certs into your operating systems certificate store.  Some companies so this to secure internal traffic that does not go to the outside internet, but stays inside a company network.  

There is an [EFF](https://www.eff.org/ "EFF") led initiative called [Let's Encrypt](https://letsencrypt.org/ "Lets Encrypt") that will give you free SSL certs for your public site.  They offer wildcard domains and easy setup via ```apt```, ```yum```, and ```dnf``` to make this experience easy and remove all reasons to not encrypt web traffic.  [You can see the adoption curve](https://letsencrypt.org/stats/ "Lets encrypt stats") of TLS/SSL since Let's Encrypt became widely available.

* [TLS 1.3 Podcast on Security Now](https://twit.tv/shows/security-now/episodes/656 "TLS 1.3")
* [Lets Encrypt Explanation Podcast](https://twit.tv/shows/security-now/episodes/483 "Lets encrypt explanation podcast")
* [SSL Labs](https://www.ssllabs.com/ "SSL Labs") is a free service that will check your TLS cert and server settings.
  * You can use SSL labs to check the Let's Encrypt cert for [my own tech blog, forge.sat.iit.edu](https://forge.sat.iit.edu "Forge.sat.iit.edu").

Without having a public IP address you can't use Let's Encrypt, but you can generate a self-signed SSL/TLS certificate following these tutorials.  Note that your browser will complain and send you dire warnings, you will have the option to accept the cert anyway and then the warnings will not persist.

* [Digital Ocean Nginx Self-Signed SSL Cert](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-18-04 "Nginx Self-signed CERT")
* [Digital Ocean Apache Self-Signed SSL Cert](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-18-04 "Apache Self-signed CERT")

Just like anything you can, can automate the creation of a self-signed cert:

```bash

sudo openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
-keyout /etc/ssl/private/apache-selfsigned.key \
-out /etc/ssl/certs/apache-selfsigned.crt \ 
-subj "/C=US/ST=Illinois/L=Chicago/O=IIT-Company/OU=Org/CN=www.school.com"

```

### Nginx

Started in 2004 by Igor Sysoev, this product came out of a Russian company who found their unique web-serving needs couldn't be met by Apache.  It is licensed under the [2 Clause BSD license](https://en.wikipedia.org/wiki/Simplified_BSD_License "2 Clause BSD"). Apache had a memory model that was created when serving webpages in the the mid-1990s, and the nature of the web, including serving more dynamically generated pages, and information from multiple streams pushed Apache to the edge of its capability. Nginx was developed to overcome these limitations and solve the [C10K problem](https://en.wikipedia.org/wiki/C10k_problem "C10K").  Nginx has the ability to do load-balancing and reverse-proxying natively.  Nginx achieves its speed increase by sacrificing the flexibility that Apache has.  

CentOS and Fedora will need to add the ```epel-release``` package first, ```sudo yum install epel-release``` or ```sudo dnf install epel-release```.  For Ubuntu use ```apt-get```.

### OpenBSD httpd Process

The OpenBSD project which values security and home grown solutions over pure availability.  Instead of trusting others code, the OpenBSD project built and maintain [their own webserver](https://bsd.plumbing/about.html#features "OpenBSD httpd").

### NodeJS

In late 2009/2010, a developer from Joyent (later Samsung/Joyent) wanted to explore the probabilities of JavaScript.  Up to this time JavaScript had been used in the WebBrowser, but creator Ryan Dahl saw an opportunity.  He took the [V8 JavaScript rendering engine](https://v8.dev/ "V8 development website") out of the Chrome browser, added an event loop and I/O functions and made it a standalone server.  Now you could programmatically use JavaScript on the server-side as well as client-side called [Node.js](https://nodejs.org/en/ "NodeJS website"). A package manager for Node was added a year later and called the Node Package manager or [NPM](https://www.npmjs.com/ "NPM website").

The Node.js release cycle is different then most major Linux distro's release cycles, so you need to go to the NodeJS site directly to get a newer version. For the latest 16.x LTS (long term support branch):

```bash
# Using Ubuntu
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v

# Using Debian, as root
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs
node -v

# Using Fedora/CentOS/Red Hat
sudo dnf install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -
sudo dnf install nodejs
node -v
```

Using the NPM package manager, we can install additional plugins that allow our Node.js JavaScript application to have additional features.  For example:

```bash
# Using NPM to install the ExpressJS JavaScript server
npm install express

# Using NPM to install the Mysql connector to talk to a MySQL or MariaDB database
npm install mysql2
```

Now using vim or nano lets code a sample "Hello World" Node.js program, let's create a directory in the *Documents* directory named: **myapp**. Name the file **app.js**. Then type the code sample below:

```javascript
// Simple sample app from
// http://expressjs.com/en/starter/hello-world.html
// You can access this by opening a webbrowser on your Virtual Machine
// from the directory where the app.js is located run: node app.js
// and go to http://127.0.0.1:3000

const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
```

## Database and NoSQL

Databases come in two types: **Relational databases** and **Non-relational databases (NoSQL)**. The relational database structure uses a query language called SQL, *Structured Query Language* which allows you to make queries on structured data.  Structured data assumes that data is stored in typed fields such as integer, varchar, decimal, datetime, and so forth.  These structured rows and columns are then stored in a table and accessed via the SQL syntax either via the command line or integrated into a programming language.

* SQL example - ```SELECT answers FROM finalexam``` or ```SELECT * FROM EMPLOYEES WHERE ID=6000```
* NoSQL sample: ```db.inventory.find( { status: { $in: [ "A", "D" ]} })```

### MySQL and MariaDB

Installation of a database is straight forward using package managers, there are two pieces of the Relational Database (RDBMS) the client and the server.  These parts do what they say, if you are accessing a database remotely, you do not need to install the entire server just the client tools to use the applications.

```bash
# Using Ubuntu or Debian based distros
# Install either mysql or mariadb
sudo apt-get install mariadb  
sudo apt-get install mysql

sudo apt-get install mariadb-client
sudo apt-get install mariadb-server

# Installing on Fedora
sudo dnf install mariadb mariadb-server
sudo dnf install mariadb-client
# make sure to start and enable the maria or mysql service on Fedora/CentOS
```

MySQL was started by [Michael "Monte" Widens](https://en.wikipedia.org/wiki/Michael_Widenius "Monte Mysql").  The company was one of the first major companies to become successful with an opensource model, especially for a database product in a crowded market.  MySQL the company was [sold to Sun in 2009](https://www.cio.com/article/2374129/sun-buys-mysql.html "Sun Buys MySQL"), which then was inherited by Oracle in their purchase of Sun in 2010.  Monte was not happy with Oracle's stewardship of MySQL and decided to fork the codebase and begin a new yet familiar product called MariaDB.  MariaDB continued the MySQL legacy by essentially restarting the MySQL company.  MariaDB is for all purposes a drop in replacement for MySQL, even using the same commands to run the database. You can create a database and a table directly from the ```mysql``` cli)

* Log in
* Enter your password at the prompt
* Enter commands at the CLI
* Quit

```sql
-- On mysql/mariadb 8.x Fedora and Ubuntu
-- sudo mysql -u root
CREATE DATABASE records;
USE records;
create table tutorials_tbl(
   tutorial_id INT NOT NULL AUTO_INCREMENT,
   tutorial_title VARCHAR(100) NOT NULL,
   PRIMARY KEY ( tutorial_id )
  );
-- quit;
```

#### User Accounts and Security Concerns

After the installation of MariaDB/MySQL, you can create user accounts with limited privilleges.  This is a good idea as the `root` account doesn't have a password by default and is clearly recommended **NOT** to be used for anything other than administration.  So your application will need to use a non-root account.

After you log in to the MySQL command-line using the command: `sudo msql -u root`, and after you have created a database (as in the example above), you can create users and assign access to particular databases and even particular tables.

```sql
-- This is a comment
-- This statement grants only SELECT privilleges, no edit privilleges 
-- creates a user named: worker
-- gives permission to all tables in the records database
-- from only the localhost IP address, 127.0.0.1
GRANT SELECT ON records.* TO worker@'127.0.0.1' IDENTIFIED BY 'password-goes-here'; flush privileges;
```

You can place the previous SQL code that will create a table and enter a record into a single file. You can give it any name but convention says it should explain what the code does and end with *.sql. This code will be place into a file named `create-table.sql` and the sample is located in the files > chapter-12 directory.

```sql
CREATE DATABASE records;
USE records;
CREATE TABLE tutorials_tbl(
   tutorial_id INT NOT NULL AUTO_INCREMENT,
   tutorial_title VARCHAR(100) NOT NULL,
   PRIMARY KEY ( tutorial_id )
  );

-- This code inserts a single record into the table for test purposes
INSERT INTO records(tutorial_title) VALUES('Best Book Ever');
```

```bash
# You can redirect input by having the create commands placed in a single file
sudo mysql -u root < ./create-table.sql
```

SQL commands can also be executed inline as well.

```bash
sudo mysql -u root -e "CREATE DATABASE wordpress_db;"
sudo mysql -u root -e "CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -u root -e "GRANT ALL ON wordpress_db.* TO 'wp_user'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"
```

### PostgreSQL

As always in technology, product names often have a joke or a story behind them. PostgreSQL is no different.  One of the original RDBMs, Ingress, was a product and a company in the 1980s.  The successor to that project was PostgreSQL (see the pun?).  PostgreSQL has the added advantage of being opensource, backed by a commercial company, as well as not being MySQL which is owned by Oracle.  Installation is provided in custom repos that need to added to a system before using a package manager.

* [PostgreSQL Downloads for Ubuntu and Fedora/CentOS](https://www.postgresql.org/download/ "PostgreSQL downloads")

### SQLite

SQLite skips some of the bigger features to be mean and lean. "SQLite is an in-process library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine[^150]."  It is meant to store and retrieve data and that is about it.  This makes it very small and very compact, which makes it great for using on the mobile platform Android or iOS since it is a single binary file, and can be installed on mobile devices and tablets as part of an application.  Sqlite3 has the unique licensing of being the [Public Domain](https://sqlite.org/copyright.html "Public Domain for Sqlite3").  You can install SQlite3 via the normal package mechanism and it is usually close to being up to date.  Note that SQlite3 doesn't listen on external ports by default it is included as an external library in your application.

* ```sudo apt-get install sqlite3```
* ```sudo yum install sqlite```
* ```sudo dnf install sqlite```

### MongoDB

Though there are many in this category, I have selected one NoSQL database.  The difference here is that data is not stored in tables or typed fields but as simple untyped records--the NoSQL really refers to no relations or relational structure[^151].  This means that records can be of any type or length.  You access the data not through a Structured Query Language but using HTTP requests via REST; GET, PUT, PATCH and DELETE which mirror the functionality of CRUD--Create, Retrieve, Update, and Delete. This allows you to integrate your "query" language directly into your application code.  REST is the outgrowth of the successful spread of HTTP as a protocol.

MongoDB packages are maintained by MongoDB -- and are released outside of Linux distro release cycles.  The installation process is different for Ubuntu and CentOS.  The instructions to add a custom repository are located here:

* [https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/ "Install MongoDB Community Edition on Ubuntu")
* [https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/ "Install MongoDB Community Edition on Red Hat or CentOS")
* Make sure to start the mongod service
* [https://docs.mongodb.com/manual/mongo/](https://docs.mongodb.com/manual/mongo/ "Mongo Shell")
  * [Run Mongo insert sample](https://docs.mongodb.com/manual/tutorial/insert-documents/ "Mongo Insert Sample")
  * [Run Mongo query sample](https://docs.mongodb.com/manual/tutorial/query-documents/ "Mongo query example")

### Network File System - NFS

> *NFS, the network filesystem, is probably the most prominent network services using RPC. It allows to access files on remote hosts in exactly the same way as a user would access any local files. This is made possible by a mixture of kernel functionality on the client side (that uses the remote file system) and an NFS server on the server side (that provides the file data). This file access is completely transparent to the client, and works across a variety of server and host architectures. NFS offers a number of advantages[^157]:*

* Data accessed by all users can be kept on a central host, with clients mounting this directory at boot time. For example, you can keep all user accounts on one host, and have all hosts on your network mount /home from that host. If installed alongside with NIS, users can then log into any system, and still work on one set of files.
* Data consuming large amounts of disk space may be kept on a single host. For example, all files and programs relating to LaTeX and METAFONT could be kept and maintained in one place.
* Administrative data may be kept on a single host.

### iSCSI

The [iSCSI protocol](https://en.wikipedia.org/wiki/ISCSI "iSCSI") is a reimplemntation of the SCSI disk communication protocol.  SCSI was an alternative that could move data faster than the then ATA (pre-SATA) standard.  Once SATA became available the SCSI based hardware was more expensive and was replaced by cheaper SATA and more standardized USB (for external devices). The SCSI bus was faster than the standardized ATA bus, but required a specialized adapter card and specialized cable to connect devices and external peripherals.  Think of it pre-USB (circa 1998).  This made SCSI desirable but expensive.  Also the SCSI standard continued to improve throughput but at the cost of not being backwards compatabile with older and other versions of SCSI, each had its own cabes and connectors. By the year 2000 the SCSI protocol was well known and heavily invested in for server class hardware.  In that year IBM and Cisco standardized the iSCSI protocol.  iSCSI integrated SCSI commands to external targets over Ethernet/IP.  Allowing you to seperate your disks from storage and access them over a local network via the iSCSI protocol.  Disks were formatted as LVMs or directly as a ZFS, Btrfs, or XFS based drives and then presented as __iSCSI targets__ over the network. iSCSI has two components, the __iSCSI target__ and the __iSCSi initiator__. The system that connects to a target in an __initiator__.   iSCSI devices can replace the need for SAN technology (Storage Area Networks) and work on commodity hardware over basic ethernet cables and switches.

This allows you top separate your storage and your compute.  You can even use iSCSI disks as your main hard drive and configure this during install time on most major Linux distros. All modern Operating Systems come with support for being either a target or an initiator.  A company called [iXsystems](https://www.ixsystems.com/ "iXsystems") has made a business out of providing ZFS based iSCSI storage devices running FreeBSD and TrueOS.

## Firewall

Used to block external communication on you system ports.   Not unlike plugs in the wall of your home, your server has ports that different services connect to and communication on.  This allows the operating system and applications to communicate as well with multiple programs.  There are 65000 ports available to use.  The first 1024 ports are reserved for well known services.  These numbers are useful to know, but applications have changed.  For instance SMTP is no longer unencrypted and used over port 25,but port 567 or 995.  Also the use of Git over http has replaced the need for FTP/SFTP/SSH and other protocols to send and retrieve data.

* SSH - 22
* FTP - 21
* SMTP - 25 (deprecated not used as it is an unsecured transport method)
* DNS - 53
* HTTP - 80 (becoming deprecated in browsers)
* HTTPS - 443 (HTTP with TLS/SSL)
* SMTP over SSL - 990
* MongoDB - 27017
* PostgreSQL - 5432
* MySQL - 3306
* Oracle DB - 1521
* ExpressJS - 3000

You can use rules to allow or deny traffic based on source IP, source Port, Destination IP, or Destination Port.   Some people urge turning the firewall off because of complexity.  I do not recommend this.  If you are going to run a business, you need to understand what ports are open and why--opening them all is not a solution and could be a violation of laws regarding security, privacy, and government regulation.  

### Firewalld

Distributions using systemd have switched to [firewalld](https://firewalld.org/ "firewalld") as their main firewall interface.  There had been previous ways to interface with a firewalld and firewalld seeks to abstract these away and present a unified interface to your systems firewall.    Fedora turns their firewall on by default, CentOS 7 does not.  

Firewalld uses the ```firewall-cmd``` command and not firewallctl like you would expect.  It has a concept of *zones* which allow you to predefine a collection of rules that can be applied to different zones. Permanent configuration is loaded from XML files in ```/usr/lib/firewalld``` or ```/etc/firewalld```  When declaring a new rule you need to declare if the rule is permanent or will be reset when the firewalld service is reloaded.  The firewalld system contains zones such as:

* trusted or untrusted
* drop
  * incoming packets are dropped, outbound packets are allowed
* block
  * incoming packets are rejected with an icmp-host-prohibited response
* public
* work
* home
* internal

```bash
# Firewalld Documentation and Examples
# https://firewalld.org/
# https://firewalld.org/documentation/

# Install firewalld on Ubuntu
sudo apt-get install firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld
```

```bash
# Commands to check the state/status of firewalls
sudo systemctl status firewalld
sudo firewall-cmd --state
sudo firewall-cmd --get-active-zones
```

```bash
# Firewalld any OS, how to add exceptions for services or ports
sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --zone=public --add-port=22/tcp --permanent
sudo firewall-cmd --zone=public --list-ports
```

```bash
# specific IPs -- changes the semantics
# https://serverfault.com/questions/680780/block-all-but-a-few-ips-with-firewalld

firewall-cmd --zone=public --add-service=ssh
firewall-cmd --zone=public --add-source=192.168.56.105/32
firewall-cmd --zone=public --add-source=192.168.56.120/32
firewall-cmd --zone=public --remove-service=ssh
```

#### fail2ban

The main reason to have a firewall is to restrict traffic to your system or server.  Note the commands above do not dictate in anyway who can connect to a system. Firewalld includes a standard interface so third party tools and build integration into your firewall.  [Fail2ban](http://www.fail2ban.org/wiki/index.php/Main_Page "Fail2ban main documentation") is a anti-bruteforce tool for systems that have their connections exposed to the public network, such as mysql and openssh-server.  It allows you do ban IP addresses that are trying to brute force hack your system. You can do permanent banning or a timeout based banning. ```Fail2ban``` has a firewalld integration where you can add firewall rules to block bad IPs automatically.

```bash
# you may need the epel-release package on Fedora/CentOS
# https://fedoraproject.org/wiki/Fail2ban_with_FirewallD
# https://unix.stackexchange.com/questions/268357/how-to-configure-fail2ban-with-systemd-journal

sudo dnf install fail2ban fail2ban-firewalld
sudo apt-get install fail2ban fail2ban-firewalld
sudo yum install fail2ban fail2ban-firewalld

sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

### Ubuntu UFW

Ubuntu uses [UFW (Uncomplicated Firewall)](https://help.ubuntu.com/community/UFW "Ubuntu UFW"). It is installed but not enabled by default.  You can enable it:  ```sudo ufw enable``` and print out the status via ```sudo ufw status```.  Syntax examples include:

* Allow or deny by port number
  * ```sudo ufw allow 53```
  * ```sudo ufw deny 53```
* Allow or deny by service
  * sudo ufw allow ssh
  * sudo ufw deny ssh
* Allow from IP
  * ```sudo ufw allow from 207.46.232.182```
* Allow from subnet/CIDR block
  * ```sudo ufw allow from 192.168.1.0/24```
  * ```sudo ufw allow from 192.168.0.4 to any port 22```
  * ```sudo ufw allow from 192.168.0.4 to any port 22 proto tcp```
* Enable/Disable ufw logging
  * ```sudo ufw logging on```
  * ```sudo ufw logging off```

```Firewalld``` can be installed on Ubuntu via apt-get and then enabled and started as a service in place of UFW if you want to maintain that service and not use UFW.

## Chapter Conclusions and Review

In this chapter we learned about the basic components of networking. We learned how to configure these settings and general network troubleshooting which will allow you to fully administer any system you come in contact with.

### Review Questions

1) Using the ip2 suite of tools, which command(s) would show your IP address?

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

6) What is the name of the systemd firewall?

   a. systemd-firewalld
   b. systemd-firewall
   c. firewalld-cmd
   d. ufw

7) What would be the command to list all of the firewalld public zone ports in use?

   a. `sudo systemctl status firewalld`
   b. `sudo firewalld-cmd --zone=public --list-all`
   c. `sudo firewall-cmd --zone=public --list-all`
   d. `sudo firewall-cmd --list-all`

8) If you had a CIDR block of /24 and a network address of 192.168.1.0, how many IP addresses would you have?

   a. 10
   b. 0
   c. 24
   d. 256

9) What is the default port for HTTPS (TLS/SSL)?

   a. 80
   b. 3000
   c. 8080
   d. 443

10) Using Network Manager, what tool is used to release a DHCP address from the command line?

    a. `rhclient`
    b. `ipconfig /release`
    c. `dhclient -r`
    d. `xclient -r`

11) Using the ip2 suite, what command can be used to monitor and examine all current local ports and TCP/IP connections?

    a.  `ss`
    b.  `net`
    c.  `wireshark`
    d.  `netstat`

12) Where are your network card settings located on Ubuntu while using Network Manager?

13) Where are your network card settings located on Fedora using Network Manager?

14) Where are your network card settings located on Ubuntu using Netplan?

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

17) What command would you type to get to the MySQL command line prompt?

18) What is the file location that the system uses as a *local DNS* for resolving IP?

    a. `etc/systemd/hostd`
    b. `/etc/hosts`
    c. `/etc/allow`
    d. `/etc/etc/etc`

19) What flag would you add to this command to make it survive a reboot: `sudo firewall-cmd --zone=public --add-port=22/tcp`

    a. `--peppermint`
    b. `--permenant`
    c. `--allow`
    d. `--list-all`

20) Before systemd, NIC interface naming schemes depended on a driver based enumeration process. They switched to a predictable network interface naming process that depends on what for the interface names?

    a. driver loading order
    b. interface names depend on physical location of hardware (bus enumeration)
    c. kernel version
    d. What ever Lennart Poettering feels like naming them

### Podcast Questions

View or listen to this Podcast about Nginx: [http://twit.tv/show/floss-weekly/283](http://twit.tv/show/floss-weekly/283 "Nginx on Twit.tv")

1) ~2:02 What is Nginx?
1) ~3:22 What percentage of the world's websites are served with Nginx (as of 2014)?
1) ~4:57 What was the challenge that led to the creation of Nginx?
1) ~5:33 What is the main architectural difference between Nginx and Apache webservers?
1) ~8:32 What are some of the main use cases for Nginx?
1) ~11:00 When did Sarah get involved in Nginx?
1) ~16:23 How do you pronounce "Nginx"?
1) ~17:41 What is "caching" in relation to websites?
1) ~19:45 What is "proxying" in relation to websites?
1) ~29:36 What was the founder's motive to opensource Nginx?
1) ~34:00 What is the difference in the opensource Nginx and the commercial version? (Freemium?)
1) ~40:19 Are there Linux distro packages for Nginx?
1) ~53:10 Can Apache and Nginx co-exist or is it a winner take all?

### Lab

#### Pre-reqs and Assumptions

Using two virtual machines, while powered off, in the VirtualBox settings, enable a second bridged network interface and set the type to **Bridged Adapter** (details are in last chapter and the VirtualBox networking details are in chapter 03).

1) Use the command to identify the IP address of each of the two systems

   a. Capture a screenshot of both systems IP addresses
   b. Use the `ping` tool to ping the each others IP and its results (ctrl +C to quit), take a screenshot of the results
   b. Modify the `/etc/hosts` file and add an entry for both system in both systems give them the hostname host1 and host2
   c. Execute the `ping` command again this time using the hostname declared in the `/etc/hosts` file and capture a screenshot of the results

2) Use the command to display you MAC address of the network connection used in question 1, and in your screenshot highlight the MAC address

3) Use the command to display your IP address of the network connection used in question 1, and in your screenshot highlight the Netmask/CIDR block

4) On Ubuntu Desktop, Fedora Desktop, and Ubuntu Server -- determine if you are running Systemd-Networkd or Network-Manager. On each system run these commands and take a screenshot of each results:

   a. `sudo systemctl status systemd-networkd`
   b. `sudo systemctl status NetworkManager`

5) On Ubuntu and Fedora Desktop, use the command: `sudo systemctl status firewalld` check to see if firewalld is enabled, if its not installed, use the package manager to install the package `firewalld`

6) Using firewalld, open port 22 permanently to allow SSH connections to your Fedora system, take a screenshot of the command `sudo firewalld-cmd --list-all` to show the port is open

7) Using firewalld, open port 80 permanently to allow SSH connections to your Fedora system, take a screenshot of the command `sudo firewalld-cmd --list-all` to show the port is open

8) If needed, install Nginx Webserver, and enable the proper firewall port (443) to serve pages over **https** following [this Digital Ocean configuration tutorial](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-20-04-1 "Digital Ocean Self-signed Nginx cert config").  Take a screenshot of the webbrowser showing the [https://127.0.0.1](https://127.0.0.1 "https example")

9) On an OS of your choice, install Node.js version 16.x and use NPM to install the `express` package.  Using the sample, "Hello World" code provided in the chapter, take a screenshot of the output of opening a browser on your Virtual Machine at the URL: http://127.0.0.1:3000 -- **Note** - from the directory where your app.js file is you will need to run `node app.js` to start the server and make sure that port 3000 is open in the firewall

10) Going to [Wordpress.org](https://wordpress.org "Wordpress install") and download the latest tar.gz file.  Follow the 5 minute setup to configure a working WordPress blog -- installing all the needed dependencies, initialize the WordPress system and create a simple blog post named: "Hello World" as the screenshot to prove the work was done on the OS of your choice

#### Footnotes

[^145]: [https://askubuntu.com/questions/704361/why-is-my-network-interface-named-enp0s25-instead-of-eth0?rq=1](https://askubuntu.com/questions/704361/why-is-my-network-interface-named-enp0s25-instead-of-eth0?rq=1 "why-is-my-network-interface-named-enp0s25-instead-of-eth0?")

[^146]: [https://unix.stackexchange.com/questions/134483/why-is-my-ethernet-interface-called-enp0s10-instead-of-eth0](https://unix.stackexchange.com/questions/134483/why-is-my-ethernet-interface-called-enp0s10-instead-of-eth0 "why-is-my-ethernet-interface-called-enp0s10-instead-of-eth0")

[^147]: [https://wiki)archlinux.org/index.php/Systemd-networkd](https://wiki)archlinux.org/index.php/Systemd-networkd "systesmd-networkd")

[^148]: [https://superuser.com/questions/645487/static-ip-address-with-networkmanager](https://superuser.com/questions/645487/static-ip-address-with-networkmanager "Static NetMan IP")

[^149]: [https://netplan.io/examples](https://netplan.io/examples "netplan examples")

[^150]: [https://sqlite.org/about.html](https://sqlite.org/about.html "Sqlite3")

[^151]: [https://en.wikipedia.org/wiki/NoSQL](https://en.wikipedia.org/wiki/NoSQL "NoSQL")

[^152]: [https://en.wikipedia.org/wiki/HTTP/2](https://en.wikipedia.org/wiki/HTTP/2 "HTTP/2")

[^157]: [https://tldp.org/LDP/nag/node140.html](https://tldp.org/LDP/nag/node140.html NFS description")
