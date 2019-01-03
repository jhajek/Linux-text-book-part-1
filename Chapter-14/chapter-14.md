# OS Containers, Service Discovery, Secrets, and Applications - Rough Draft
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

At the conclusion of this chapter you will have gained an understanding of how non-trivial applications are creeated, maintained, and securely deployed using Operating System Containers.  You will have learned the basic differences and advantages of OS Containers and Virtual Machines and will be able to use industry standard tools that demonstrate these concepts.

### Operating System Containers and Virtual Machines

In the class so far, we have made extensive use of virtual machines.  This technology greatly reduced our needs for physical lab space and extra computers.  And the technology is execllent and mature from a hardware point of view.  If we want to test installing an Apache Webserver or Nginx or even FreeBSD, we can do so in using a virtual machine.  We can use Packer and Vagrant to automate the creation of these virtual machines.  This is is a huge advantage when we look at things operationally.  But IT operations doesn't just run servers, they run applications which are the lifeblood of any business.  When we look at virtual machines from an application point of view we begin to see some redundancies.  For instance I can launch multiple Ubuntu and Debian and other Linux virtual machines and have isolated applications.  But each operating system has virtualized hardware, drivers, BIOS, even a virtual floppy disk driver (which can be exploited, see VENOM).  

![*Virtual Machine*](images/Chapter-14/docker/container-vm-whatcontainer_2.png "Virtual Machine Diagram")

\newpage

All of these virtual devices create overhead, and while you have created seperation, you haven't increased the speed of your application.  The reason is the abstraction is wrong.  Essentially virtualization is about hardware consolidation, even the name, *virtual machine* tells you what you are getting.  When you look at an applicaiton, due to the operating system, it is abstracted away from the hardware by design.

When you look at Linux binaries such as ```ls``` or ```grep``` they are precompiled executables.  They contain all the needed code to execute on a Linux system.  You could copy the binary to another location or machine and expect it to work, thereby making a new abstraction.  Instead of the machine being virtual, why not make the operating system virtual?  If you compare the bulk of the size of an operating system, the majority of the size is in the kernel and in the drivers.  But an operating system can be stripped down to 100 megabytes at the most of needed binaries.  This lead to the concept of **Operating System Containers.**

![*OS Containers*](images/Chapter-14/docker/docker-containerized-appliction-blue-border_2.png "docker containerized appliction")

### Where did Containers come from

We know the birthday of containers.  it started in 4.1 BSD in 1984.  Bill Joy submited the code to create the ancestor of containers, the ```chroot``` command.  This command was used to *contain* a user or application into a certain directory structure, while allowing multiple users to still share the same system.  The ```chroot``` command gave wat to FreeBSD ```jails``` command which essentially was used to contain vulnerable or misbehaving software.  This would allow you to *jail* and application such as a webserver or FTP server so that there processes would not effect other users.

Taking the idea of a BSD Jail, SUN developed a further extension for [Solaris called Zones](https://docs.oracle.com/cd/E36784_01/html/E36848/zones.intro-2.html#scrolltoc "Oracle Solaris Zones Docs") in 2004. The purpose of Zones is stated as "*...partitioning technology (is) used to virtualize operating system services and provide an isolated and secure environment for running applications[^159].*" This technology lives on in IllumOS based distributions today. Zones were an improvement over FreeBSD Jails.  But were still postiioned as an IT tool for consolidating servers and reducing costs.  

This all changed in 2013.  A failing Platform as a Service company called DotCloud make a last minute attempt to save itself by opensourcing and presenting their OS Container management tool, called **Docker**.  It was at this presentation that OS Containers were no longer seen as an operations tool, but was presented in a format that allowed developers to see OS Containers as a way to package up software dependencies and application code and deploy it almost as a single binary.  The anology of a shipping container is not lost.  Once shipping was standardized into container weights and heights, world wide shipping on boats, trains, and trucks became vastly streamlined.  In Figure 7.3 you see that applicaitons are using th esame kernel.  This is possible because of the way Linux is constructed.  Linux is a kernel, and therefore you can place any operating system on top of it.  In addition to this natural structure, Linux uses a technology called **cgroups** to create **namespaces** which further allow for isolation of applications.

[Docker](https://docker.io "Docker") showed that OS Containers were essentially a development deployment tool and a way to make a portable "binary" of your application.  We can install Docker on any Linux based operating system.  Let's try this on an Ubuntu 18.04 system.

```bash

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo systemctl enable docker

```

```docker pull ubuntu```
```docker run --name ubuntu1804 -it ubuntu```

-i for interactive -t for a pseudo-TTY  

https://docs.docker.com/engine/reference/commandline/run/#examples

https://www.docker.com/resources/what-container

### Service Mesh and Service Discovery

As applications move from single systems to distributed systems, then to multi-tiers, the issue of IP addresses comes into focus.  What happens when you have services being launch and virtual systems being destroyed?  How do you manage the IP addresses?  Well on the internet we have DNS for name resolution and lookup.  If you look up [https://youtube.com](https://youtube.com "YouTube.com") you do not need to know the IP address, as the DNS service will look it up for you.  Now, think about the internals of YouTube itself.  Extra servers need to come online all the time to handle surges in requests or QPS (queries per second).  How do they handle IP allocation internally?  They use some kind of **service discovery** or **service mesh**.  

The concept of service discovery is essentially an internal or local DNS.  Each system hard codes its own localized DNS entry then via a protocol called *gossip*, agents talk to each other and "spread" the local DNS entries.  An application can simpley make a ```curl``` or http based request to the internal agent and resolve the IP internally.

Hashicorp created a software package called [Consul](https://www.consul.io "Consul") to do just this.  With datacenters, Virtual Machines, even OS Containers able to be spun up and down with the touch of a button, manual configuration of servers is no longer an option.  

> *Consul is a distributed service mesh to connect, secure, and configure services across any runtime platform and public or private cloud[^157].*

### Secret Sharing

One of the biggest problems in computers and cyber security is the sharing of *secrets*.  A secret is generally anything that gives privillege to a user, such as a username and password combo, or and authentication token, or a URL. Not only do you have the trouble of keeping this secure from hackers and being exploited, but you also have the problem of distributing them securely.  If you share a secret, then it is not a secret anymore.  But in launching multiple distributed servers, how do you give each instance access to these secrets?  A second question is how do you manage these secrets? Hashicorp created a product called [Vault](https://www.vaultproject.io "Hashicorp Vault") that begins to tackle this problem.

> *Vault helps to secure, store and tightly control access to tokens, passwords, certificates, encryption keys for protecting secrets and other sensitive data using a UI, CLI, or HTTP API[^158]*.

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
