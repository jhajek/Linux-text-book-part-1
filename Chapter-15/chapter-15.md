# The Future of Free and Opensource Software ROUGH DRAFT

![*Always check the package dependencies...*](images/Chapter-Header/Chapter-15/authorization-2.png "Weakest Link?")

## Objectives

* RaspberryPi
* Certifications
* Android compile from command line
* Jenkins CI
* Service Discovery and Service Mesh
  * Consul
* Secret Sharing
  * Vault
  * note to self -- add gatsby demo

## Outcomes

At the conclusion of this chapter you will have a detailed overview of Service Discovery and the concept of Secret Sharing.  

### Service Mesh and Service Discovery

As applications move from single systems to distributed systems, then to multi-tiers, the issue of IP addresses comes into focus.  What happens when you have services being launch and virtual systems being destroyed?  How do you manage the IP addresses?  Well on the internet we have DNS for name resolution and lookup.  If you look up [https://youtube.com](https://youtube.com "YouTube.com") you do not need to know the IP address, as the DNS service will look it up for you.  Now, think about the internals of YouTube itself.  Extra servers need to come online all the time to handle surges in requests or QPS (queries per second).  How do they handle IP allocation internally?  They use some kind of **service discovery** or **service mesh**.  

The concept of service discovery is essentially an internal or local DNS.  Each system hard codes its own localized DNS entry then via a protocol called *gossip*, agents talk to each other and "spread" the local DNS entries.  An application can simpley make a ```curl``` or http based request to the internal agent and resolve the IP internally.

Hashicorp created a software package called [Consul](https://www.consul.io "Consul") to do just this.  With datacenters, Virtual Machines, even OS Containers able to be spun up and down with the touch of a button, manual configuration of servers is no longer an option.  

> *Consul is a distributed service mesh to connect, secure, and configure services across any runtime platform and public or private cloud[^157].*

### Secret Sharing

One of the biggest problems in computers and cyber security is the sharing of *secrets*.  A secret is generally anything that gives privillege to a user, such as a username and password combo, or and authentication token, or a URL. Not only do you have the trouble of keeping this secure from hackers and being exploited, but you also have the problem of distributing them securely.  If you share a secret, then it is not a secret anymore.  But in launching multiple distributed servers, how do you give each instance access to these secrets?  A second question is how do you manage these secrets? Hashicorp created a product called [Vault](https://www.vaultproject.io "Hashicorp Vault") that begins to tackle this problem.

> *Vault helps to secure, store and tightly control access to tokens, passwords, certificates, encryption keys for protecting secrets and other sensitive data using a UI, CLI, or HTTP API[^158]*.

## Where to go Now

* Linux+
* LPI

## Additional Resources

* [http://www.bsdnow.tv](http://www.bsdnow.tv "BSD Now")
* [http://twit.tv/floss](http://twit.tv/floss "FLOSS")
* [http://bsdtalk.blogspot.com/](http://bsdtalk.blogspot.com/ "BSD Talk")

## Chapter Conclusions and Review

Place holder

### Review Questions

Place Holder

### Podcast Questions

Kubernetes

[https://twit.tv/shows/floss-weekly/episodes/351?autostart=false](https://twit.tv/shows/floss-weekly/episodes/351?autostart=false "FLOSS Kubernetes")

1. ~8:37 What problem is Kubernetes solving and how does it solve it?
1. ~9:16 What is a "PaaS" and what does it do?
1. ~10:20 Was Kubernetes built from the ground up as an opensource project?
1. ~12:35 How does Kubernetes handle IP addressing for containers? 
1. ~14:35 What is the unit of abstraction with Kubernetes?
1. ~15:10 What does the word Kubernetes mean?
1. ~16:25 How does Kubernetes and Docker relate/intertwine?
1. ~24:00 What is the big selling point of using Kubernetes mentioned?
1. ~27:10 Does Kubernetes take care of all features needed to run an applicaiton or are additional software pieces needed?
1. ~28:55 What is the difference between an OS Container and a Virtual Machine?
1. ~31:01 How does Kubernetes deal with quality of service in relation to applications?
1. ~33:31 How does Kubernetes differ from SUN Solaris containers (zones)?
1. ~36:45 Does Kubernetes run on other cloud providers (Azure or AWS)?
1. ~37:42 How are customers using Kubernetes in production?
1. ~44:23 In what service does Kubernetes keep its system state in?
1. ~45:43 Why did Google decide to use its own Go language to develop Kubernetes?
1. ~52:02 What is the relationship between Google/Kubernetes and RedHat's OpenShift Paas?


### Lab

__Objectives:__

Place holder

__Outcomes:__

Place Holder

#### Footnotes
