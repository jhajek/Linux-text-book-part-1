# Networking, Webservers, and Intro to Databases

![*Some people just have aquariums...*](images/Chapter-Header/Chapter-12/network-2.png "Virus Aquarium")

## Objectives

* Explain how to configure and display basic network settings for the two major Linux distribution families
* Identify basic network troubleshooting tools
* Explain configuring and deploying major webserver platforms
* Compare and contrast major opensource webservers and be able to discuss their uses in industry
* Explain how to install, manage, and configure basic major SQL and NOSQL databases
* Identify the types of desktop based firewalls
* Explain how to configure desktop based firewalls 

## Outcomes

At the conclusion of this chapter you will have explored the nature of the network settings for the two major Linux distribution families and for BSD.  You will be comfortable using various commandline troubleshooting tools to help solve network issues and problems.  You will deploy two major webserver platforms and understand the differences between Apache and Nginx in their memory models and request handling models.  Finally you will have gained experience deploying, installing, and configuring MySQL and MariaDB SQL databases and a popular NoSQL database MongoDB.

## Networking

Former CEO of Sun Microsystems, Scott McNealy once famously said, "*The network is the computer.*" This was in 1990. He could not have been more correct. With this in mind, basic networking skills are mandatory. We will briefly cover topics in this order:

* IP addresses
  * Static and DHCP
  * MAC Address
* NETMASK and CIDR
* Gateway
* DNS

### IP Addresses

Every network interface, or NIC, which is the physical or virtual place where your device connects to the network.  Each NIC in turn needs an IP address to communicate on a network. IP addresses come in two flavors, a **static** and a **dynamic** IP address. An IPv4 or IP address is a 4 octet number looking something like this: `192.168.1.100`.

> Exercise: Open a command prompt and type this command to find your IP address: `ip address show`. This command can be abbreviated `ip a sh` as well.

A static address is one that you assign and configure based on your network. If you are the system administrator you can and should map each device on your network with its own IP address. For instance any servers you have, webservers, database servers, load balancers, routing equipment should have statically set IP information.

> Exercise: Open a command prompt and type this command to find your MAC address or Ethernet Address `ip l sh` which is short for `ip link show`. You can find all the options to display by typing `man ip`.

But what if you have transient or ephemeral nodes (computers) on your network? Then you need to use the **Dynamic Host Configuration Protocol**.  Setting your computer to use DHCP allows it to negotiate for a lease on a shared IP address. This is a good idea for transient devices or paces where the total number of IPs needed is less than the total number of devices, but all of those devices will not be present at the same time.

There is a DHCP server (configuring one is beyond the scope of this chapter), that will listen for DHCP broadcasts from your client and answer with an offer of an IP. Once your system (network card) accepts the offer it gains access to that IP address and all other necessary IP configuration--which is relinquishes upon your physically leaving the network for the most part. DHCP allows you to pool IPs when you might not have enough and share or allow for the auto-registration to make managing large scale IP deployments easy.

For instance at a university every student has a laptop and most likely a phone too, you could manually assign each an address but the number of students goes into the thousands and tens of thousands, and it not practical to manage--DHCP makes this scale manageable. Settings these values statically in each operating system is different but the concept is the same. You need to enter an IP Address, Netmask/CIDR, Network Gateway, and DNS.  Each of these concepts is explained below.

### MAC Address

Each network interface card or NIC has a 48 bit hardware address assigned to it. This is unique and split into two parts. The first three octets are the OUI, Organizational Unit Identifier, which is given to a particular company to help identify their products. The last three octets are random numbers that are chosen by the manufacturer after the OUI is assigned for each device they manufacture. In some cases MAC addresses can be set via software. MAC addresses are used by switches to convert the last leg of a TCP/IP connection to an actual physical port and are at the second layer of the TCP/IP model.

![*Mac Addresses*](images/Chapter-12/mac/mac.png "Mac Addresses")

### Netmask

*A subnetwork or subnet is a logical subdivision of an IP network. The practice of dividing a network into two or more networks is called subnetting[^ch12f158].* The netmask value or subnet of your network is actually a part of your IP address. So that routers know how to route packets to your network the netmask or network mask effectively blocks off a portion of your IP address. Traditionally netmasks were blocked into simple Class A, B, C, and D blocks, each one representing one of the IP octets.  But this turned out to be highly inefficient. If you had a subnet of class A, your subnet would be 255.0.0.0. This means that you would be assigned a fixed value from 1-254 in your first IP octet and the remaining three octets would be variable. Apple famously has the 16.0.0.0 Class A giving them access to 255x255x255 IP addresses and Amazon recently received control of the 3.0.0.0 address block from GE.

Class B subnet is 255.255.0.0 and gives you access to 16,000 IP addresses (254*254) with the first two octets set.  An example would be 172.24.x.y.

Class C address has 1 octet available and 3 octets preset.  A common class C subnet you see mostly in home routing devices is 192.168.1.x which gives you 254 addresses. For our purposes we won't worry about class D and E in this book.

The problem is classes (A, B, C) unfortunately leads to many wasted addresses. So a new way to divide blocks into smaller parts came along called [CIDR blocks](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing "CIDR Blocks") or blocking. CIDR lets you split the classes into arbitrary blocks. A business might have a subnet or CIDR block of /23. This looks almost like a class C subnet, but its not. Class C in CIDR would be /24. The /23 gives us control of two 256 block of IP addresses. /23 can be written as 255.255.254.0 as well.

### Gateway

The gateway value is your networks default router.  This value is literally the gateway in and out of your network. Usually this IP address ends in a .1 or a .254, but does not have to.

### DNS

DNS--Domain Name services allows you to resolve domain names to IP addresses. The sites, google.com, web.iit.edu, twit.tv, etc, etc, turn those values via lookup into IP addresses that can then route packets to and from. DNS is very important. Without it you would have to remember the IP address of every single site your wanted to visit. Very quickly this wouldn't scale and in fact this idea of domain names lead to the initial founding of Yahoo as the personal index of its founder Jerry Wang in 1990s. DNS is now a native part of the internet and is maintained by core DNS servers that are scattered world wide.

The predominant software being used for DNS is called BIND9 form the ISC, Internet Software Consortium. We will not configure DNS servers in this book, but focus on client configuration. Your ISP provides DNS for you, those come with some gray area of allowing ISPs to sell advertising on HTTP 404 error pages, or even inject advertising code into non-https based connections.  There is a small list of alternative DNS services that give you free DNS in exchange for analyzing certain data in aggregate--beware before using them.

* Google has two public DNS services, [8.8.8.8 and 8.8.4.4](https://developers.google.com/speed/public-dns/ "Google Public DNS")
* [Cloud Flare 1.1.1.1](https://1.1.1.1 "CloudFlare DNS")
* [IBM Quad9 9.9.9.9](https://www.quad9.net/ "IBM Quad9")
* [OpenDNS servers](https://www.opendns.com/ "Opendns")

DNS is set and configured as noted above in the various networking files.  Note that DNS was not an initial part of TCP/IP networking so it was not natively contained in the network service configuration, DNS came later to the internet.

### Comparison of Net-tools and iproute2

There are two suites of tools for viewing and configuring network information. The original suite is called `net-tools`. The current standard is called the `iproute2` tools. The *net-tools* suite development was actively **ceased** in 2001 in favor of [iproute2](https://baturin.org/docs/iproute2/ "webpage iproute2"). There is a lot of information on the web using the `net-tools` but we generally want to deprecate the use of `net-tools` on Linux.

The `iproute2` suite standardized on the singular `ip` command--unifying a disparate set of tools. Older Linux (pre-2015) definitely have `net-tools` installed. Now Linux distributions are only including the `iproute2` package.

* Red Hat Workstation includes `net-tools` and `ip-route2`
  * Almalinux (RHEL server) includes only `ip-route2`
* Debian Linux Desktop and Server only includes `ip-route2`
  * Ubuntu Desktop and Server only includes `ip-route2`
* openSuse Linux only includes `ip-route2`

One good example on why to use `iproute2` tools is that they have support for IPv6. `Net-tools` was created before IPv6 became a standard. There is a [iproute2 cheatsheet](https://github.com/dmbaturin/iproute2-cheatsheet "iproute2 cheatsheet").

#### Replacement Commands Table

         Net-Tools                              iproute2
---------------------------------   ----------------------------------
         `arp`                            `ip n` (ip neighbor)
        `ifconfig`                        `ip a` (ip addr)
                                          `ip link`
        `iptunnel`                        `ip tunnel`
        `iwconfig`                        `iw`
        `nameif`                          `ip link` or `ifrename`
        `netstat`                         `ss`
        `netstat -r`                      `ip route`
        `netstat -i`                      `ip -s link`
        `netstat -g`                      `ip maddr`
        `route`                           `ip route` (ip r)

Table:  [Net-Tools Commands and Replacements](https://www.tecmint.com/deprecated-linux-networking-commands-and-their-replacements/ "Networking Commands and their replacements")

### Udev and Ethernet Naming Conventions in Systemd

With the adoption of systemd, the convention for naming network cards changed from a driver based enumeration to [Predictable Network Interface Names](https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/ "Predicatable Network Interface Names").

"*Basic idea is that unlike previous \*nix naming scheme where probing for hardware occurs in no particular order and may change between reboots, here interface name depends on physical location of hardware and can be predicted/guessed by looking at `lspci` or `lshw` output[^145].*"

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
  * No re-enumeration takes place (to the level the firmware permits this)
* Stable interface names when kernels or drivers are updated/changed
* Stable interface names even if you have to replace broken ethernet cards by new ones

There is a short technical explanation of how these names are devised in the comments of the [source code here](https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L20 "Source Code").

What does this mean?  Well let us take a look at the output of the `ip a sh` command. Lets try it on Ubuntu Desktop, Server, and Fedora Workstation, and using `ifconfig` on FreeBSD what do you see?  On some of these you see eth0 some you see enp0sX. Why? Though all of the these OSes are using `systemd`, not FreeBSD, a few of them might have the value `biosdevname=0` set in their `/etc/default/grub` file.

#### Revert Predictable Network Interface Names

The way to reset the values:

* Edit `/etc/default/grub`
* At the end of `GRUB_CMDLINE_LINUX` line append `net.ifnames=0 biosdevname=0`
* Save the file
* Type `grub2-mkconfig -o /boot/grub2/grub.cfg`
* or type `grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg`
* reboot

[Source](https://unix.stackexchange.com/questions/81834/how-can-i-change-the-default-ens33-network-device-to-old-eth0-on-fedora-19 "how to reset to old names")
[Source](http://www.itzgeek.com/how-tos/mini-howtos/change-default-network-name-ens33-to-old-eth0-on-ubuntu-16-04.html "how to reset to old names")

### NetworkManager

Here is where things get tricky. In the future I would like to think this is will all be sorted out, but for now, buckle up. So networking was always controlled by a service under sysVinit, that was usually `sudo service networking restart`. This was common across all Linux. This worked fine when network connections were static and usually a 1 to 1 relationship with a computer or pc. That all changed as wireless connections became a reality, and with mobility of computers to move from network to network, and even virtual machines networking began to change.

In November of 2004 Fedora introduced [NetworkManager](https://opensource.com/article/22/4/networkmanager-linux "webpage for NetworkManager") to be the main instrument to handle their network configurations. Debian and Ubuntu would eventually follow and NetworkManager became the default way to manage network connections. It uses a YAML like file structure to give values to the network service. Debian and Ubuntu maintained support for NetworkManager, but always allowed fall back for compatibility reasons to the sysVinit script for managing your network.

### Systemd-networkd

The systemd project introduced **systemd-networkd**, which aspires to control the networking stack. Systemd-networkd will look for run time localized overwrites of default values located in `/etc/systemd/network`. Files in that directory need to end in a .network extension. The systemd-networkd `.network` file has an INI style value structure[^147]: The entire systemd-networkd documentations is [described here](https://www.freedesktop.org/software/systemd/man/systemd.network.html "systemd-networkd documentation").

#### Who uses what?

For the desktop Linux, Ubuntu and Fedora/Red Hat based, Network Manger is being used by default as of 2023, but systemd-networkd can be enabled. The server editions of Ubuntu are using `systemd-networkd` by default.

#### Systemd-networkd .network templates

```yaml
# Systemd-networkd .network file (not Ubuntu Netplan)
# Name of the file /etc/systemd/network/20-wired.network
[Match]
Name=enp1s0

[Network]
DHCP=ipv4
```

```yaml
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

### Debian Non-NetworkManager Non-Networkd

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
auto enp0s9
iface enp0s9 inet dhcp
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

### Ubuntu and Fedora Using NetworkManager

NetworkManager uses NMconnections for configuring its syntax, which looks similar to the Networkd style INI based syntax[^148]. The network configurations are no longer located in `/etc/sysconfig/network-scripts/ifcfg-eth0`. You would create a file named `*.nmconnections` located under the `/etc/NetworkManager/system-connections/` directory.

> *NetworkManager looks for its own interface connection files, located in the /etc/NetworkManager/system-connections directory. Most distributions, including Fedora, keep their network connection files in the /etc/NetworkManager/system-connections directory, using the network's name as the file name[^ch12f159].*

You can use the `nmcli` command in place of the `ip` and `ifconfig` commands.

```yaml
[connection]
id=Wired connection 2
uuid=8eef1819-764f-3558-813c-460fb96bb33e
type=ethernet
autoconnect-priority=-999
interface-name=enp0s8
timestamp=1698375734

[ethernet]

[ipv4]
method=auto

[ipv6]
addr-gen-mode=default
method=auto

[proxy]

[.nmmeta]
nm-generated=true
```

#### Netplan.io

To further confuse things, Ubuntu decided to write a YAML based file management abstraction layer for networking that can use the same configuration for either Network Manager or Networkd-Systemd. It is called [netplan.io](https://netplan.io "netplan").  Netplan reads YAML style files from a network configuration located in `/etc/netplan/*.yaml`.

Not to be out done, the sample template from Netplan.io looks similar to systemd-networkd[^149]. To configure `netplan`, save configuration files under `/etc/netplan/` with a .yaml extension (e.g. `/etc/netplan/config.yaml`), then run `sudo netplan apply`. This command parses and applies the configuration to the system. Configuration written to disk under `/etc/netplan/` will persist between reboots.  By default in Ubuntu 18.04 Network Manager is used for actively managing network connections, Netplan is "on" but allows Network Manager to manage by default unless specifically altered below.

```yaml
# Let NetworkManager manage all devices on this system
network:
  version: 2
  renderer: NetworkManager
```

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

To instead set a static IP address, use the addresses key, which takes a list of (IPv4 or IPv6), addresses along with the subnet prefix length (e.g. /16). Gateway and DNS information can be provided as well:

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp3s0:
      addresses:
        - 10.10.10.2/16
      gateway4: 10.10.10.1
      nameservers:
          search: [mydomain, otherdomain]
          addresses: [10.10.10.1, 1.1.1.1]
```

### /etc/hosts

Linux, inheriting from UNIX from a time before DNS existed, has a file for local DNS lookups: `/etc/hosts`. This file is owned by root. You can edit this and place three items: an IP address, a fully qualified domain name, a short name (just the hostname). This is enabled by default and is the first lookup for your system. This helps save network based DNS roundtrips and can be accessed by any application or script without needing modification or additional libraries.

```bash

# Sample /etc/hosts file from a system setting up a sample network

192.168.33.110 webserver1.iltech.edu webserver1
192.168.33.120 webserver2.iltech.edu webserver2
192.168.33.100 database1.iltech.edu database1

192.168.33.210 graphitea.iltech.edu graphitea
192.168.33.220 graphiteb.iltech.edu graphiteb
192.168.33.200 graphitemc.iltech.edu graphitec
```

#### iputils

Most of the time the network works fine, but when it doesn't you need to be able to use built in system tools to troubleshoot the problem and identify where the problem is. Those tools are separate from the iproute2 suite and are called [iputils](https://github.com/iputils/iputils "iputils"). The tools included are listed here but all of them might not be installed by default.

* arping
* clockdiff
* ping
* tracepath / traceroute

The first tool that should be in your tool box is *ping*.

* `ping` example
  * `ping www.google.com`  
  * `ping 192.168.0.1`

Ping, just like the concept of a submarine using sonar to find objects, communicates with another IP address to see if the other system is "alive" and that your system and network are working properly to get the packet from your network to a different network.  There are many tools to enhance the output of ping as well such as [gping](https://github.com/orf/gping "Ping with graph").

The `traceroute` tool is used to report each router hop that a packet takes on its way to its final destination.  Useful for checking if there are routing problems along the path of your traffic. Try these commands and describe the output:

```bash
traceroute www.yahoo.com
traceroute www.yahoo.co.jp
```

There are additional tools that extend basic troubleshooting features such as:

* [iftop](https://linuxblog.io/iftop-command-in-linux-w-examples/ "iftop usage web page")
* [Nethogs](https://github.com/raboof/nethogs "Webpage for Net Hogs")
* [iptraf-ng](https://wiki.ipfire.org/addons/iptraf-ng "iptraf-ng website") - Network traffic visualization
* [tcpdump](http://www.tcpdump.org/ "tcpdump website") – Detailed Network Traffic Analysis
* [tshark](https://tshark.dev/setup/install/ "Webpage for commandline Wireshark")

## Webservers

August 6th 1991, Tim Berners-Lee deployed the first webpage and the created the first webserver. For history's sake, an early copy of it was found on an old system and [restored](http://info.cern.ch/hypertext/WWW/TheProject.html "First webpage"). He was working at the [CERN](https://en.wikipedia.org/wiki/CERN "CERN") research lab in Switzerland. He did so with the idea to be able to freely share text data amongst researchers and national research labs world-wide. To do this he created the Hypertext Transfer Protocol -- [HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol "HTTP Protocol") protocol for sending and receiving requests as well as a webserver named, NCSA, that would receive and process those requests, returning text to a client browser to be rendered.

The first webserver gave rise to a commercial company called Netscape started by [Marc Andreeson](https://en.wikipedia.org/wiki/Marc_Andreessen "webpage for Marc Andreeson"), with research coming out of the University of Illinois. Famous for their Netscape Navigator browser, they were also the pioneers of the first webserver software. This software had been commercially available before at a high price and was limited to those who already could afford a large hardware investment. The Apache webserver came out of this code base and became the name and the first product of the Apache Opensource Foundation. When we look to two technologies that were used by the dotcom companies that survived the first and second crashes, we find that both the Apache webserver along with the MySQL database made the web possible.

Applications have grown enormously beyond just serving simple html webpages.  What was once a simple webserver has been exchanged becoming application servers and serving traffic or aggregating traffic directly on a per request basis.  We will cover in detail in the next chapters some of those application servers. For now let us start with webservers. They listen for requests on port 80.  When receiving a request, they serve (they are webservers...) or render a page of HTML code and return that to a client (you) viewing a page through a web browser.

### Apache

Without Apache, companies such as Google, Facebook, Twitter, and many others started upon opensource never would have been able to get started. Apache has over time grown and had to add new functions while shedding old functionality. The memory model of how it processes requests has changed over time as the frequency and amount of requests on a webserver has changed. Some may criticize Apache webserver for being a bit old, but there is a large body of knowledge out there on how to customize and manage it.

The Apache webserver can be installed via package managers. There is even a version of it available for Windows. Note that though the same application, Ubuntu refers to the Apache webserver as `apache2` and Red Hat products refer to it as `httpd`.

The commands to install webservers:

* Ubuntu and Debian-based distros
  * `sudo apt install apache2`
* Red Hat-based distros
  * `sudo dnf install httpd`
* After install check to make sure the services have been started properly using `systemctl`
  * Note you can't start two webservers at once -- only one service can listen on port 80 at a time
  * Open FireFox browser inside of the Virtual machine
  * Navigate to the URL: `http://127.0.0.1` to see the welcome page

Webservers have various configurable components. The basic configuration out of the box is very conservative about resources and is not much use beyond for testing. You will need to tune the different settings as you go along as no two work loads are the same, unfortunately there is no direct tutorial you can just configure and run a large business with. For our purposes in class the default configurations will suffice, but in the real world you will need to find additional documents or books to guide you along.

### Nginx

Started in 2004 by Igor Sysoev, this product came out of a Russian company who found their unique web-serving needs couldn't be met by Apache.  It is licensed under the [2 Clause BSD license](https://en.wikipedia.org/wiki/Simplified_BSD_License "2 Clause BSD"). Apache had a memory model that was created when serving webpages in the the mid-1990s, and the nature of the web, including serving more dynamically generated pages, and information from multiple streams pushed Apache to the edge of its capability. Nginx was developed to overcome these limitations and solve the [C10K problem](https://en.wikipedia.org/wiki/C10k_problem "C10K"). Nginx has the ability to do load-balancing and reverse-proxying natively.  Nginx achieves its speed increase by sacrificing the flexibility that Apache has.

* Ubuntu and Debian-based distros
  * `sudo apt install nginx`
* Red Hat-based distros
  * `sudo dnf install nginx`
* After install check to make sure the services have been started properly using `systemctl`
  * Note you can't start two webservers at once -- only one service can listen on port 80 at a time
  * Open FireFox browser inside of the Virtual machine
  * Navigate to the URL: `http://127.0.0.1` to see the welcome page

#### Sample HTTP site

To help out our brand new webserver -- lets get us some content. On our Ubuntu Desktop system, lets issue these commands from the terminal:

* `wget https://github.com/twbs/bootstrap/releases/download/v5.3.2/bootstrap-5.3.2-examples.zip`
  * To download the latest bootstrap CSS samples. 
* `unzip bootstrap-5.3.2-examples.zip`
  * Decompress the samples -- might need to install the zip package
* Issue the `cd` command into the `bootstrap` directory
  * Issue the copy command of the `assets` and `heroes` directory
  * Copy them to the `/var/www/html` directory as this is where Nginx on Ubuntu server its webpages from
* Open the FireFox browser in that virtual machine
  * Navigate to the URL: `http://127.0.0.1/heroes` to see the bootstrap sample page

#### TLS/HTTPS Certs

One of the major innovations Netscape made with their original webserver product was the creation of SSL, secure socket layer technology. This allowed for sensitive data to be encrypted and decrypted securely--which enabled commerce over the internet to take off. HTTP connection using SSL have the prefix `https://`. SSL has long been deprecated and replaced with TLS - (Transport Layer Security) 1.2 and 1.3, but many people still use the phrase *SSL* when they really mean *TLS*.

You can configure your system to generate SSL certs, but they will be missing a key component of Certificates you can buy or receive from a third party. In that they don't have a chain of trust about them. Self-signed certs will also trigger a browser to throw a security warning and block entry to that web-site. Now you have the option of overriding this and or accepting these self-signed certs into your operating systems certificate store.  Some companies so this to secure internal traffic that does not go to the outside internet, but stays inside a company network.  

There is an [EFF](https://www.eff.org/ "EFF") led initiative called [Let's Encrypt](https://letsencrypt.org/ "Lets Encrypt") that will give you free SSL certs for your public site.  They offer wildcard domains and easy setup via `apt`, `yum`, and `dnf` to make this experience easy and remove all reasons to not encrypt web traffic. [You can see the adoption curve](https://letsencrypt.org/stats/ "Lets encrypt stats") of TLS/SSL since Let's Encrypt became widely available.

* [TLS 1.3 Podcast on Security Now](https://twit.tv/shows/security-now/episodes/656 "TLS 1.3")
* [Lets Encrypt Explanation Podcast](https://twit.tv/shows/security-now/episodes/483 "Lets encrypt explanation podcast")
* [SSL Labs](https://www.ssllabs.com/ "SSL Labs") is a free service that will check your TLS cert and server settings.
  * You can use SSL labs to check the Let's Encrypt cert for [my own tech blog, jeremyhajek.com](https://jeremyhajek.com "Instructors Blog").

Without having a public IP address you can't use Let's Encrypt, but you can generate a self-signed SSL/TLS certificate following these tutorials.  Note that your browser will complain and send you dire warnings, you will have the option to accept the cert anyway and then the warnings will not persist.

* [Digital Ocean Nginx Self-Signed SSL Cert Tutorial](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-22-04 "Nginx Self-signed CERT")
* [Digital Ocean Apache Self-Signed SSL Cert Tutorial](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-22-04 "Apache Self-signed CERT")

#### Generate Self-Signed TLS Cert

Just like anything you can, can automate the creation of a self-signed cert:

```bash
# While using OpenSSL, you should also create a strong Diffie-Hellman (DH)
# group, which is used in negotiating Perfect Forward Secrecy with clients.
# You can do this by typing:
sudo openssl dhparam -out /etc/nginx/dhparam.pem 4096

# https://security.stackexchange.com/questions/74345/provide-subjectaltname-to-openssl-directly-on-the-command-line
# Script to auto answer the key request creation information - self-signed cert good for 365 days
sudo openssl req -subj "/C=US/ST=Illinois/L=Chicago/O=IIT-Company/OU=Org/CN=www.school.com" \
-newkey rsa:4096 -x509 -nodes -days 365 \
-keyout /etc/ssl/private/tls-selfsigned.key \
-out /etc/ssl/certs/tls-selfsigned.crt

```

### OpenBSD httpd Process

The OpenBSD project which values security and home grown solutions over pure availability.  Instead of trusting others code, the OpenBSD project built and maintain [their own webserver](https://bsd.plumbing/about.html#features "OpenBSD httpd").

### NodeJS

In late 2009/2010, a developer from [Joyent](https://www.joyent.com/ "joyent website") (later Samsung/Joyent) wanted to explore the probabilities of JavaScript. Up to this time JavaScript had been used in the WebBrowser, but creator Ryan Dahl saw an opportunity. He took the [V8 JavaScript rendering engine](https://v8.dev/ "V8 development website") out of the Chrome browser, added an event loop and I/O functions and made it a standalone server.  Now you could programmatically use JavaScript on the server-side as well as client-side called [Node.js](https://nodejs.org/en/ "NodeJS website"). A package manager for Node was added a year later and called the Node Package manager or [NPM](https://www.npmjs.com/ "NPM website").

The NodeJS package install information is here: [https://github.com/nodesource/distributions](https://github.com/nodesource/distributions "webpage for NodeJS").

```bash
##############################################################################
# Using Ubuntu and NodeJS 20
# https://github.com/nodesource/distributions#ubuntu-versions
##############################################################################
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
| sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

# Define Node 20 install
# Modify deb source package location line to fit the printing
NODE_MAJOR=20
PART1="deb [signed-by=/etc/apt/keyrings/nodesource.gpg]"
PART2=" https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main"
echo $PART1$PART2 | sudo tee /etc/apt/sources.list.d/nodesource.list

# Once Node package repository has been added then install nodejs
sudo apt-get update
sudo apt-get install nodejs -y
##############################################################################
# Using Fedora/RHEL Clones and NodeJS 20 
# https://github.com/nodesource/distributions#fedora-versions
##############################################################################
yum install gcc-c++ make
sudo yum install -y \
https://rpm.nodesource.com/pub_20.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm
sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1
##############################################################################
```

Using the NPM package manager, we can install additional plugins that allow our Node.js JavaScript application to have additional features.  For example:

```bash
##############################################################################
# Using NPM to install the ExpressJS JavaScript server
##############################################################################
sudo npm install express
##############################################################################
# Using NPM to install the Mysql connector to talk to a MySQL or MariaDB 
# database
##############################################################################
sudo npm install mysql2
##############################################################################
```

Now using vim or nano lets code a sample "Hello World" Node.js program, let's create a directory in the `Documents` directory named: **myapp**. Name the file **app.js**. Then type the code sample below:

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

### Staring the sample Express JS APP

With all the pre-reqs installed you are ready to start the ExpressJS server and begin serving our "Hello World!" app. Using the app.js file in our sample code located at `files > Chapter-12 > javascript > app.js` execute the commmand: `node app.js` and your application will begin to server.

## Database and NoSQL

Databases come in two types: **Relational databases** and **Non-relational databases (NoSQL)**. The major commercial databases you are familiar with: Oracle, MS SQL-Server, and IBM DB2 are relational databases but not opensource--they won't be covered here. The relational database structure uses a query language called SQL, *Structured Query Language* which allows you to make queries on structured data. Structured data assumes that data is stored in typed fields such as integer, varchar, decimal, datetime, and so forth. These structured rows and columns are then stored in a table and accessed via the SQL syntax either via the command line or integrated into a programming language. There are many opensource relational database systems here are the four major ones:

* [MySQL](https://www.mysql.com/ "website for mysql")
* [MariaDB](https://mariadb.org/ "website for mariadb")
* [SQLite](https://www.sqlite.org/index.html "webpage for sqlite")
* [PostgreSQL](https://www.postgresql.org/ "webpage for postgresql")

### Install MySQL and MariaDB

We will focus on the MySQL and MariaDB instances. They are interchangable and if you learn one of these you will be a way to learning other systems. Installation of a database is straight forward using package managers, there are two pieces of the Relational Database (RDBMS) the client and the server.  These parts do what they say, if you are accessing a database remotely, you do not need to install the entire server just the client tools to use the applications.

```bash
# Using Ubuntu or Debian based distros
# Install either mysql or mariadb
# Ubuntu 
sudo apt install mariadb-server
sudo apt install mysql-server

sudo apt install mariadb-client
sudo apt install mysql-client

# Installing on Fedora
sudo dnf install mariadb-server
sudo dnf install mariadb-client
sudo dnf install mysql-server
sudo dnf install mysql-client

# Make sure to start and enable the maria or mysql service!!!
```

### Opensource Relational Database History

MySQL was started by [Michael "Monte" Widens](https://en.wikipedia.org/wiki/Michael_Widenius "Monte Mysql"). The company was one of the first major companies to become successful with an opensource model, especially for a database product in a crowded market.  MySQL the company was [sold to Sun in 2009](https://www.cio.com/article/2374129/sun-buys-mysql.html "Sun Buys MySQL"), which then was inherited by Oracle in their purchase of Sun in 2010.  Monte was not happy with Oracle's stewardship of MySQL and decided to fork the codebase and begin a new yet familiar product called MariaDB.  MariaDB continued the MySQL legacy by essentially restarting the MySQL company. MariaDB is for all purposes a drop in replacement for MySQL, even using the same commands to run the database. You can create a database and a table directly from the `mysql` cli.

#### Common Administrative Commands

We will now go over some common adminsitrative commands that can be executed from the commandline in relation to a database after installation.

* Log in​
* Create a non-root user​
* Granting privileges​
* Creating a database, table, and adding some records​
* Make an SQL query​
* Quit 

#### User Accounts and Security Concerns

After the installation of MariaDB/MySQL, you can create user accounts with limited privilleges. This is a good idea as the `root` account doesn't have a password by default and is clearly recommended **NOT** to be used for anything other than administration.  So your application will need to use a non-root account. After you log in to the MySQL command-line using the command: `sudo mysql`, and after you have created a database (as in the example above), you can create users and assign access to particular databases and even particular tables. Linux distributions began eliminating a security hole by having the user provide a database root password at installation time. Instead access to the `root` user in a database is controlled by `sudo` access.

#### Login to Your Database

`sudo mysql` will log you into MariaDB and MySQL as the root user.

#### Create a User and Grant Permissions

```sql
-- This is a comment
-- This statement grants only SELECT privilleges, no edit privilleges 
-- creates a user named: worker
-- gives permission to all tables in the records database
-- from only the localhost IP address, 127.0.0.1
-- The basic permissions are: CREATE, SELECT, UPDATE, DELETE, and INSERT
-- As of MySQL 8.0 you can no longer implicitly create a user with a GRANT statement
CREATE USER 'worker'@'%' IDENTIFIED BY 'password-goes-here';
GRANT CREATE, SELECT, UPDATE, DELETE, and INSERT ON records.* TO 'worker'@'127.0.0.1'  
FLUSH PRIVILEGES;
```

You can place the previous SQL code that will create a table and enter a record into a single file. You can give it any name but convention says it should explain what the code does and end with *.sql. This code will be place into a file named `create-table.sql` and the sample is located in the `files > chapter-12 > sql` directory.

#### Create a Database

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
sudo mysql < ./create-table.sql
# or
sudo mysql < ./create-table-and-insert-records.sql
# or 
sudo mysql < ./insert-single-record.sql
```

#### Inline SQL commands

SQL commands can also be executed inline as well.

```bash
sudo mysql -e "CREATE DATABASE wordpress_db;"
sudo mysql -e "CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'password';"

# https://wordpress.stackexchange.com/questions/6424/
# I am splitting the long command up into two parts to fit it on the screen
# It should look like this:
# sudo mysql -e "GRANT SELECT INSERT UPDATE DELETE DROP ALTER ON wordpress_db.*
# TO 'wp_user'@'localhost'"

COMMAND1="GRANT CREATE, SELECT, INSERT, UPDATE, DELETE, DROP, ALTER ON wordpress_db.*"
COMMAND2=" TO 'wp_user'@'localhost';"
sudo mysql -e "$COMMAND1$COMMAND2"

# You can assign long commands to variables and execute them too
COMMAND="FLUSH PRIVILEGES;"
sudo mysql -e "$COMMAND" 
```

### PostgreSQL

As always in technology, product names often have a joke or a story behind them. PostgreSQL is no different. One of the original RDBMs, Ingress, was a product and a company in the 1980s. The successor to that project was PostgreSQL (see the pun?). PostgreSQL has the added advantage of being opensource, backed by a commercial company, as well as not being MySQL which is owned by Oracle.

* `sudo apt install postgresql`
* `sudo dnf install postgresql`

### SQLite

SQLite skips some of the bigger features to be mean and lean. *"SQLite is an in-process library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine[^150]."* It is meant to store and retrieve data and that is about it. This makes it very small and very compact, which makes it great for using on the mobile platform Android or iOS since it is a single binary file, and can be installed on mobile devices and tablets as part of an application. Sqlite3 has the unique licensing of being the [Public Domain](https://sqlite.org/copyright.html "Public Domain for SqLite3"). You can install SQLite3 via the normal package mechanism and it is usually close to being up to date. Note that SQLite3 doesn't listen on external ports by default it is included as an external library in your application.

* `sudo apt install sqlite3`
* `sudo dnf install sqlite`

### MongoDB

Though there are many in this category, I have selected one NoSQL database.  The difference here is that data is not stored in tables or typed fields but as simple untyped records--the NoSQL really refers to no relations or relational structure[^151].  This means that records can be of any type or length.  You access the data not through a Structured Query Language but using HTTP requests via REST; GET, PUT, PATCH and DELETE which mirror the functionality of CRUD--Create, Retrieve, Update, and Delete. This allows you to integrate your "query" language directly into your application code.  REST is the outgrowth of the successful spread of HTTP as a protocol.

MongoDB packages are maintained by MongoDB -- and are released outside of Linux distro release cycles.  The installation process is different for Ubuntu and CentOS.  The instructions to add a custom repository are located here:

* [https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/ "Install MongoDB Community Edition on Ubuntu")
* [https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/ "Install MongoDB Community Edition on Red Hat or CentOS")
* Make sure to start the mongod service
* [https://docs.mongodb.com/manual/mongo/](https://docs.mongodb.com/manual/mongo/ "Mongo Shell")
  * [Run Mongo insert sample](https://docs.mongodb.com/manual/tutorial/insert-documents/ "Mongo Insert Sample")
  * [Run Mongo query sample](https://docs.mongodb.com/manual/tutorial/query-documents/ "Mongo query example")

## Firewall

Used to block external communication on you system ports. Not unlike plugs in the wall of your home, your server has ports that different services connect to and communication on. This allows the operating system and applications to communicate as well with multiple programs. There are 65000 ports available to use. The first 1024 ports are reserved for well known services. These numbers are useful to know.

* SSH - 22
* FTP - 21
* SMTP - 25 (deprecated not used as it is an unsecured transport method)
* DNS - 53
* HTTP - 80 (becoming deprecated in browsers)
* HTTPS - 443 (HTTP with TLS/SSL)
* SMTP over SSL - 990
* MongoDB - 27017
* PostgreSQL - 5432
* MySQL/MariaDB - 3306
* Oracle DB - 1521
* ExpressJS - 3000

You can use rules to allow or deny traffic based on source IP, source Port, Destination IP, or Destination Port. Some people urge turning the firewall off because of complexity. I do not recommend this. If you are going to run a business, you need to understand what ports are open and why--opening them all is not a solution and could be a violation of laws regarding security, privacy, and government regulation.  

### Firewalld

Distributions using systemd have switched to [firewalld](https://firewalld.org/ "firewalld") as their main firewall interface. There had been previous ways to interface with a firewall and firewalld seeks to abstract these away and present a unified interface to your systems firewall Fedora turns their firewall on by default, CentOS 7 does not.

Firewalld uses the `firewall-cmd` command and not firewallctl like you would expect. It has a concept of *zones* which allow you to predefine a collection of rules that can be applied to different zones. Permanent configuration is loaded from XML files in `/usr/lib/firewalld` or `/etc/firewalld`. When adding a new rule you need to declare if the rule is permanent or it will be reset when the firewalld service is reloaded. The firewalld system contains zones such as:

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
sudo firewall-cmd --zone=public --add-port=3000/tcp --permanent
sudo firewall-cmd --zone=public --list-ports

# How to list all the ports that are open in your firewalld zone
sudo firewall-cmd --zone=public --list-all

# Needed to reload the process changes to the firewall
sudo firewall-cmd --reload
```

```bash
# specific IPs -- changes the semantics
# https://serverfault.com/questions/680780/block-all-but-a-few-ips-with-firewalld

firewall-cmd --zone=public --add-service=ssh --permanent
firewall-cmd --zone=public --add-source=192.168.56.105/32 --permanent
firewall-cmd --zone=public --add-source=192.168.56.120/32 --permanent
firewall-cmd --zone=public --remove-service=ssh --permanent
# Needed to reload the changed to the firewall
sudo firewall-cmd --reload
```

#### fail2ban

The main reason to have a firewall is to restrict traffic to your system or server. Firewalld includes a standard interface so third party tools can build integrations into your firewall. [Fail2ban](http://www.fail2ban.org/wiki/index.php/Main_Page "Fail2ban main documentation") is an anti-bruteforce tool for systems that have their connections exposed to the public network, such as MySQL and openssh-server. It allows you do ban IP addresses that are trying to brute force hack your system. You can do permanent banning or a timeout based banning.

```bash
# you may need the epel-release package on Fedora/CentOS

sudo dnf install fail2ban
sudo apt install fail2ban

sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

### Ubuntu UFW

Ubuntu uses [UFW (Uncomplicated Firewall)](https://help.ubuntu.com/community/UFW "Ubuntu UFW"). It is installed but not enabled by default.  You can enable it:  `sudo ufw enable` and print out the status via `sudo ufw status`.  Syntax examples include:

* Allow or deny by port number
  * `sudo ufw allow 53`
  * `sudo ufw deny 53`
* Allow or deny by service
  * sudo ufw allow ssh
  * sudo ufw deny ssh
* Allow from IP
  * `sudo ufw allow from 207.46.232.182`
* Allow from subnet/CIDR block
  * `sudo ufw allow from 192.168.1.0/24`
  * `sudo ufw allow from 192.168.0.4 to any port 22`
  * `sudo ufw allow from 192.168.0.4 to any port 22 proto tcp`
* Enable/Disable ufw logging
  * `sudo ufw logging on`
  * `sudo ufw logging off`

## Chapter Conclusions and Review

In this chapter we learned about the basic components of networking. We learned how to configure these settings and general network troubleshooting which will allow you to fully administer any system you come in contact with.

### Review Questions

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
    b.  `--permanent`
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

Structure of Assessment: For this assessment you will need to execute various setup steps and capture those commands as part of the final deliverable 

### Outcomes

In this assessment you will using Linux shell scripting to create a WordPress Blog on an Ubuntu Server 22.04 LTS 

### Lab Pre-requisites 

* You will need to create or use a fresh Ubuntu 22.04 LTS server virtual machine
  * You will need to enable an additional host-only network interface
  * And have installed and enabled openssh-server
  * Attach two new virtualdisks of 10GB each
* You can execute the setup commands remotely from a newly created Fedora Workstation virtual machine 
  * Also have an additional host-only network enabled.   
* For the next set of questions, you will need to SSH into the Ubuntu 22.04 LTS from your Fedora install 
  * Then configure various pieces of software then answer questions based on those installs on the Ubuntu Server 22.04 LTS remotely  

#### Deliverable: 

Submit a screenshot of the final blog post and the shell script that scripts the following to your chapter-12 folder in your private GitHub repo. These 11 steps need to be in your **final shell script**. 

We recommend you complete this once manually - taking note of all the steps, then create a single shell script to do all these steps in an automated fashion. This will require having fresh systems to start over with

#### Part One - Shell Script

* On the Ubuntu 22.04 format the new disks creating a single datapool named: `datapool1`
  * Change ownership and group of the newly created `/datapool` to your own user
  * Ensure you add the lines into /etc/fstab to mount datapool on reboot  
* Install all needed WordPress pre-reqs via the apt package manager (including vim, unzip, libapache2-mod-php, and php-mysqli)
  *  You won't need all of these but you can see here which ones WordPress requires -- [Server Dependencies list](https://make.wordpress.org/hosting/handbook/server-environment/ "website link for extra dependencies")
* Stop the MySQL service
* Copy the /var/lib/mysql directory to /datapool using the rsync command to preserve permissions
* Give ownership of the entire directory to MySQL and set permissions to 700
* Uncomment and change the line that specifies the path to the data directory in /etc/mysql/mysql.conf.d/mysqld.cnf
* Change the two lines in /etc/apparmor.d/usr.sbin.mysqld which allow data directory access
* Reload the apparmor service
* Start the MySQL service
* Use the MySQL inline option (-e) to create a database named: `wp`
* Use the MySQL inline option (-e) to create a non-root user named: `wp-user`
* Use the MySQL inline option (-e) to grant the user, wp-user, the proper permissions needed for WordPress (section 12.5.2.6)
* Retrieve the WordPress Installer Zip file 
* Extract the WordPress code 
* Move the extracted wordpress directory to `/var/www/html/`
* Rename the file wp-config-sample.php to wp-config.php in the `/var/www/html/wordpress` directory 
* Using the sed command find and replace in `/var/www/html/wordpress/wp-config.php` the place holders on line 23, 26, and 29 
* Install `firewalld` via the apt package manager – enable and start the service and permanently open port 80/tcp for http traffic on the public zone
* Using the `chown` command change the ownership of the directory `/var/www/html/wordpress` to have owner and group be `www-data`, which is the apache2 webserver's username
  * Make sure to use the `-R` flag to recursively change the ownership in all sub-directories as well

#### Part Two - Manual Configuration Steps

* From your Fedora system, open a web browser and navigate to http://IP-of-ubuntu-server/wordpress 
  * Complete the manual portion to setup a WordPress User, login to your new WordPress installation. 
  * Create a single new blog post that posts a picture of you and the University Logo at the bottom of your post 
    * The image in located in the textbook sample code: files > Chapter-14 > logos > illinois-tech-logo.jpg

#### Footnotes

[^ch12f158]: [https://www.gnu.org/software/grub/](https://www.gnu.org/software/grub/)

[^145]: [https://askubuntu.com/questions/704361/why-is-my-network-interface-named-enp0s25-instead-of-eth0?rq=1](https://askubuntu.com/questions/704361/why-is-my-network-interface-named-enp0s25-instead-of-eth0?rq=1 "why-is-my-network-interface-named-enp0s25-instead-of-eth0?")

[^146]: [https://unix.stackexchange.com/questions/134483/why-is-my-ethernet-interface-called-enp0s10-instead-of-eth0](https://unix.stackexchange.com/questions/134483/why-is-my-ethernet-interface-called-enp0s10-instead-of-eth0 "why-is-my-ethernet-interface-called-enp0s10-instead-of-eth0")

[^147]: [https://wiki)archlinux.org/index.php/Systemd-networkd](https://wiki)archlinux.org/index.php/Systemd-networkd "systesmd-networkd")

[^148]: [https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/assembly_networkmanager-connection-profiles-in-keyfile-format_configuring-and-managing-networking](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/assembly_networkmanager-connection-profiles-in-keyfile-format_configuring-and-managing-networking "Static NetMan IP")

[^149]: [https://netplan.io/examples](https://netplan.io/examples "netplan examples")

[^150]: [https://sqlite.org/about.html](https://sqlite.org/about.html "Sqlite3")

[^151]: [https://en.wikipedia.org/wiki/NoSQL](https://en.wikipedia.org/wiki/NoSQL "NoSQL")

[^157]: [https://tldp.org/LDP/nag/node140.html](https://tldp.org/LDP/nag/node140.html NFS description")

[^ch12f159]: [https://opensource.com/article/22/4/networkmanager-linux](https://opensource.com/article/22/4/networkmanager-linux "webpage for NetworkManager")
