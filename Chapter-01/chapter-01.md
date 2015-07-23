## Chapter 1 - Measuring and Troubleshooting Resource Usage
![Measure twice, cut once - *Proverb*](http://imgs.xkcd.com/comics/abstraction.png "Understanding the Technology and Philosophy of Linux")

### 1.1.0 - Operating Systems and Capacity Planning

Every journey begins with a plan. Every international vacation down to a simple trip to the grocery store. And yet that plan is only as good as your equipment and tools right?  In determining how to organize this book, we took an approach focusing on the tools at hand needed to accomplish your task as a system administrator.  In this chapter we want discuss and explain the ins and outs of the bedrock of your network operation, your operating system.  In addition we want to explore and discuss some Linux tools that can be used for resource measurement. Being able to determine the correct operating system is vital in any operation.  

Objectives
    * (list all chapter headers here)
    *
    *
    *
    *


__1.1.1 - Difference between Server and Desktop Operation Systems__

  The majority of us have grown up using Windows and Macs on our desktops, laptops, and school computers.  On our phones and tablets we have GUI operating systems that give us pictures and make use of mice.  The reason you have a GUI is that you intend to interact directly with the operating system directly.   When it comes to "production" or "servers" you have a different paradigm.  These systems are meant to be running services, such as a web server, an email server, a caching server, or a DNS server.  You will not be checking your email or playing funny cat videos on these systems.  You will be interacting with them via your network or the internet - using TCP/IP.  
  
  This then there is no need for a GUI them.  This helps you because it reduces the size of your install, and also increases your security footprint by removing uneeded desktop apps.  
You need to determine what you need to use.  The first job is knowing what you need.  While our first book focused on Linux using desktop linux--we will be focusing on server editions.

__1.1.2 - Operating System Families__

  Linux itself is not technically an operating system.  Linux itself is a kernel.  In computing, the kernel is a computer program that manages I/O (input/output) requests from software, and translates them into data processing instructions for the central processing unit and other electronic components of a computer. The kernel is a fundamental part of a modern computer's operating system.[1](https://en.wikipedia.org/wiki/Kernel_(operating_system))

  You cannot do anthing will a kernel - you need applications, compilers, and userland interfaces.  This ironically was provided by the GNU projects and GNU tools.  

__1.1.3 - Installation Overview

Netinstall 

iso-install

### 1.2.0 Tools of Troubleshooting 

__1.2.1 - Measure CPU usage

top c
htop
atop
cat /proc/cpuinfo

netstat
pstree
ps
w
lsof
uptime
sar

1.2.1 - Measure memory usage
memfree
cat /proc/meminfo
top m
vmstat

1.2.2 - Measure disk I/O
iostat

1.2.3 - Measure network I/O
netstat 

1.2.4 - Measure firewalling and routing throughput


1.2.5 - Map client bandwidth usage


1.2.6 - Match / correlate system symptoms with likely problems
uptime

1.2.7 - Estimate throughput and identify bottlenecks in a system including networking

### 1.3.0 Predict Future Resource Needs

1.3.1 - Use collectd to monitor IT infrastructure usage

1.3.2 - Predict capacity break point of a configuration

1.3.3 - Observe growth rate of capacity usage

1.3.4 - Graph the trend of capacity usage

1.3.5 - Awareness of monitoring solutions such as Nagios, MRTG and Cacti

1.3.6 - Monitoring tools such as Ganglia and Vect

### 1.4.0 - Chapter Conclusion and Summary

1.4.1 - Review Questions

1.4.2 - Podcast Review Questions


1.4.3 - Review Lab

- - - 
