# Networking, Webservers, and Intro to Databases
![*Some people just have aquariums...*](images/Chapter-Header/Chapter-13/network-2.png "Virus Aquarium")

## Objectives

  * Understand how to configure and display basic network settings for the two major Linux distribution families and in BSD
  * Understand how to use basic network troubleshooting tools
  * Understand how to configure and deploy major webserver platforms for Linux and BSD
  * Compare and contrast two major opensource webservers and be able to discuss their uses in industry
  * Understand how to install, manage, and configure basic major SQL and NOSQL databases

### Outcomes

  At the conclusion of this chapter you will have explored the nature of the network settings for the two major Linux distribution families and for BSD.  You will be comfortable using various commandline troubleshooting tools to help solve network issues and problems.  You will deploy two major webserver platforms and understand the differences between Apache and Nginx in their memory models and request handling models.  Finally you will have gained experience deploying, installing, and configuring MySQL and MariaDB SQL databases and a popular NoSQL database Mongodb.

## Networking

Former CEO of SUN, Scott McNealy once famously said, "The network is the computer."  This was in 1990~.  He could not have been more correct.  With this in mind basic networking skills are mandatory.  We will cover briefly topics in this order:

  * IP addresses
      + Static vs DHCP
  * NETMASK and CIDR
  * Gateways
  * DNS   
  * Compare configuration of these settings across operating systems
  * Various network troubleshooting tools

### IP Addresses

Each system has one and needs one.  They come in two flavors, a **static** IP is a 4 octet number.  Looking something like this: ```192.168.1.100```.  

> Exercise

Open a command prompt and type this command to find your IP address: ```ip address show```.  This command can be abbreviated ```ip a sh``` as well.

The types of addresses come in two types, static IP and DHCP.  A static address is one that you assign and configure.  If you are the system admin you can and should map each device on your network with its own IP address.  For instance any servers you have, webservers, database servers, load balancers, routing equipment should have staticly set IP information.

 But what if you have transient or ephemeral nodes (computers) on your network?  Then you need to use the **Dynamic Host Control Protocol**.  Setting your computer to use DHCP allows it to negotiate for a lease on a shared IP address.  Their is a DHCP server (configuring one is beyond the scope of this chapter), that will listen for DHCP broadcasts and answer with an offer of an IP.  Once your system (network card) accepts the offer it gains access to that IP address and all other necceary IP configuration--which is relinqueshes upon your physically leaving the network.   DHCP allows you to pool IPs when you might not have enough and share or allow for the autoregistration to make managing large scale IP deployments easy.  For instance at a university every student has a laptop and most likely a phone too, you could manually assign each an address but the number of students goes into the thousands and tens of thousands, and it not practical to manage--DHCP makes this scale managable.

Settings these values statically in each operating system is different but the concept is the same.  You need to enter an IP Address, Netmask/CIDR, Network Gateway, and DNS.  Each of these concepts is explained below.

#### Ubuntu

How to configure a static address
/etc/network/interface

#### Redhat

How to configure a static address

/etc/sysconfig/network-scripts/ifcfg-eth0

this may change and be listed something like
/etc/sysconfig/network-scripts/ifcfg-enp5s0

this is due to systemd changeing the way network cards are ennumerated.  Instead of devices have a driver name (eth0 is the common way to name a device driver of X)  systemd names each device by their position on the PCI bus.  Lennary Poeterring explains why here, "Find explanation"

#### FreeBSD

How to configure a static address/dhcp


#### NETMASK

The netmask value or subnet of your network is actually a part of you Ip address. So that routers knwo how to route packets to your network the netmask or network mask effectively blocks off a portion of your Ip address.  Traditionally netmasks were blocked into simple Class A, B, C, and D blocks, each one representing one fo the IP octets.  But this turned out to be highly innoficient.   If you had a subnet of class A, your subnet would be 255.0.0.0.  This means that you would be assigned a fidxed value from 1-254 in your first IP octect and the remaining three octets would be variable.  Apple famously has the 16.x.y.z Class A giving them access to 255*255*255 IP addresses - 16 million?  way more than they could possibly ever need.   

Class B subnet is 255.255.0.0 and gives you access to 16,000 IP addresses (254*254) with the first two octets set.  An example would be 172.24.x.y.   

Class C address has 1 octect avaialbe and 3 octects preset.  A common class C subnet you see mostly in home routing devices is 192.168.1.x which gives you 254 addresses.  

For our purposes we won't worry about class D and E in this book.

The problem is those devision of IP octets are very clean, unfortunately leads to many wasted addresses.  So a new way to divide blocks into smaller parts came along called CIDR blocks or blocking.  CIDR lets you split blocks in half.  The school where I work uses a subnet or CIDR block of 64.131.111.0/23  This looks like a class B subnet but it is a bit bigger.  Class B in CIDR would be /24.  /23 gives us control of 64.131.110.0 and 64.131.111.0 for 512 addresses.  /23 can be written as 255.255.254.0 as well.

#### Gateway

The gateway value is your networks default router.  This value is literally the gateway to your network.  Which IP do you send to get packets out of the network?  

#### DNS

DNS--Domain Name services  allow you to resolve written domain names.  google.com, web.iit.edu, twit.tv, etc, etc and turn those values via lookup into IP addresses that can then route packets to and from.   DNS is very important.  Without it you would have to remember the IP address of every single site your wanted to visit.  Very quickly this wouldn't scale and in fact this idea of domain names lead to the initial founding of Yahoo as the personal index of its founder Jerry Wang in 1990s.

#### Tools

Most of the time the network works fine, but when it doesn't you need to be able to use built in system tools to trouble shoot the problem and identify where the problem is. The first tool that should be in your tool box is **ping**.

> example
```ip address show```

Used to show what values are set currently

> exmaple
```ping www.google.com```  ```ping 192.168.0.1```

Ping just like the concept of a submarine using sonar to find objects - simple commiunicates with another IP address to see if the other system is "alive" and that your system and network are working properly to get the packet from your network to a different network.  Enhanced ping here: https://github.com/orf/gping

      traceroute
      dig-nslookup
      dhclient
      netstat


## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

  Questions go here

### Podcast Questions

systemd
[https://www.youtube.com/watch?v=S9YmaNuvw5U&feature=youtu.be](https://www.youtube.com/watch?v=S9YmaNuvw5U&feature=youtu.be "systemd")

### Lab

 Lab goes here

#### Footnotes
