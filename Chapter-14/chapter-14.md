# OS Containers, Service Discovery, Secrets, and Applications
![*Creating technology to support technology.*](images/Chapter-Header/Chapter-14/tech_loops-2.png "Tech Loops")

## Objectives

* OS Containers
  + Docker
* Service Discovery and Service Mesh
  + Consul
* Secret Sharing
  + Vault
* Application Deployment
  + Jenkins
  + VuePress
  + GatsbyJS
  + Jekyll

## Outcomes

At the conclusion of this chapter you will have gained an understanding of how non-trivial applications are creeated, maintained, and securely deployed using Operating System Containers.  You will have learned the basic differences and advantages of OS Containers and Virtual Machines and a representation of tools that demonstrate these concepts. 

### Operating System Containers

In the beginning of this book we saw the Mini-Computer, the PDP-7, which is what UNIX was designed to run on by ken Thompson and Dennis Rithcie.  UNIX made the change when computers migrated to IBM mainframes, then to Intel based servers, then to Virtual Machines.  But according to Bryan Cantrill, CTO of Samsung Joyent, Virtual Machines were initially sold to companies as hardware consolidation options.  Once everyting was consolidated any operational or financial advantages were lost.  You essentially moved your existing infrastructure into virtualized hardware.  

Hardware Virtualization was the idea that you would completely emulate an entire machine in software.  While this simplified the abstraction it resulted in the uneeded duplication of hardware in software.  You can see in Figure 7.2 the structure of Virtual Machines. 

![*Virtual Machine*](images/Chapter-14/docker/container-vm-whatcontainer_2.png "Virtual Machine Diagram")

\newpage

```docker pull ubuntu```
```docker run --name ubuntu1804 -it ubuntu```

-i for interactive -t for a pseudo-TTY  

https://docs.docker.com/engine/reference/commandline/run/#examples


### Service Mesh and Service Discovery

As applications move from single systems to distributed systems, then to multi-tiers, the issue of IP addresses comes into focus.  What happens when you have services being launch and virtual systems being destroyed?  How do you manage the IP addresses?  Well on the internet we have DNS for name resolution and lookup.  If you look up [https://youtube.com](https://youtube.com "YouTube.com") you do not need to know the IP address, as the DNS service will look it up for you.  Now, think about the internals of YouTube itself.  Extra servers need to come online all the time to handle surges in requests or QPS (queries per second).  How do they handle IP allocation internally?  They use some kind of **service discovery** or **service mesh**.  

The concept of service discovery is essentially an internal or local DNS.  Each system hard codes its own localized DNS entry then via a protocol called *gossip*, agents talk to each other and "spread" the local DNS entries.  An application can simpley make a ```curl``` or http based request to the internal agent and resolve the IP internally.

Hashicorp created a software package called [Consul](https://www.consul.io "Consul") to do just this.  With datacenters, Virtual Machines, even OS Containers able to be spun up and down with the touch of a button, manual configuration of servers is no longer an option.  

> *Consul is a distributed service mesh to connect, secure, and configure services across any runtime platform and public or private cloud[^157].*

### Secret Sharing

One of the biggest problems in computers and cyber security is the sharing of *secrets*.  A secret is generally anything that gives privillege to a user, such as a username and password combo, or and authentication token, or a URL. Not only do you have the trouble of keeping this secure from hackers and being exploited, but you also have the problem of distributing them securely.  If you share a secret, then it is not a secret anymore.  But in launching multiple distributed servers, how do you give each instance access to these secrets?  A second question is how do you manage these secrets? Hashicorp created a product called [Vault](https://www.vaultproject.io "Hashicorp Vault") that begins to tackle this problem.

> *Vault helps to secure, store and tightly control access to tokens, passwords, certificates, encryption keys for protecting secrets and other sensitive data using a UI, CLI, or HTTP API[^158]*.

### OS Containers
  
The concept of OS containers has been around since the early part of the 1980s.  Starting with the ```chroot``` command and then the advent of BSD Jails to isolate insecure applications co-habitating on a single system.  As the new century came about, SUN had moved the concept of containers further with that of Solaris Zones.  The purpose of Zones was for "*...partitioning technology is used to virtualize operating system services and provide an isolated and secure environment for running applications[^159].*"  But not until 2013 and the release of Docker did the world really understand what containers were good for and the paradigm revolution.  OS Containers had always been pushed as a way to reduce sever sprawl and as an Operations tool.  [Docker](https://docker.io "Docker") showed that OS Containers were essentially a development deployment tool and a way to make a protable "binary" of your application.  

![*OS Containers*](images/Chapter-14/docker/docker-containerized-appliction-blue-border_2.png "docker containerized appliction")

https://www.docker.com/resources/what-container

### Developing and Deploying Applications Using Containers

+ Jenkins
+ VuePress
+ GatsbyJS
+ Jekyll

## Chapter Conclusions and Review

Conclusion goes here

### Review Questions

Questions go here

### Podcast Questions

Docker - [https://twit.tv/shows/floss-weekly/episodes/330](https://twit.tv/shows/floss-weekly/episodes/330 "FLOSS Docker interview")

1. ~3:37 What is the overview of Docker and what does it do?
1. ~4:58 Linux Containers already existed, what does Docker do differently (who are they targeting)?
1. ~6:45 Is Docker language specific?
1. ~7:39 How is Docker similar to a static binary?
1. ~10:15-12:00 How do Docker containers shift the line between developers and operations people?
1. ~13:30 How does the analogy of Docker and cargo shipping containers relate?
1. ~22:15 How does source code get from Git to a Docker Container?
1. ~22:50 Is a container like a server or a binary?
1. ~25:20 How does Docker handle container orchestration?
1. ~28:00 What does Docker Swarm do?
1. ~28:33 What does Docker Compose do?
1. ~32:00 What features does Docker not contain out of the box?
1. ~33:30 What is the process to build container images that are identical too each other?
1. ~36:01 What can you do with Docker IDs to make a clean predictable starting point?
1. ~37:45 How does Docker prevent builds from differing over a large number of machines?
1. ~42:15 Can Docker run containers that are different than the host OS and why?
1. ~48:23 What language is Docker written in?
1. ~51:00 How is Docker developed, what is the project's example?

### Lab

* Complete this tutorial https://learn.hashicorp.com/consul/
* Complete this tutorial https://learn.hashicorp.com/vault/

#### Footnotes

[^157]: [https://www.consul.io/](https://www.consul.io/ "Hashicorp Consul")

[^158]: [https://www.vaultproject.io](https://www.vaultproject.io "Hashicorp Vault")

[^159]: [https://docs.oracle.com/cd/E36784_01/html/E36848/zones.intro-2.html#scrolltoc](https://docs.oracle.com/cd/E36784_01/html/E36848/zones.intro-2.html#scrolltoc "Oracle Solaris Zones Docs")
