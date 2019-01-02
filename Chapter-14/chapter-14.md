# Installing Linux Applications and Language Frameworks ROUGH DRAFT
![*Creating technology to support technology.*](images/Chapter-Header/Chapter-14/tech_loops-2.png "Tech Loops")

## Objectives

* Service Discovery and Service mesh
* Secret Sharing
  + Packer
  + Vault
* Docker OS Containers
* Application deployment
    + VuePress
    + GatsbyJS
    + React
    + Nodejs
  * Python
    + django
  * PHP
  * Ruby
     + Jekyll
     + Ruby on Rails
  
## Outcomes


## Automating the Install Answer Process With Preseed and Kickstart  

### Consul for Service Mesh/Discovery

As applications moved from single systems to distributed systems, then to multi-tiers, the issue of IP addresses comes into focus.  What happens when you have services being launch and virtual systems being destroyed?  How do you manage the IP addresses?  Well on the internet we have DNS for name resolution and lookup.  If you look up [https://youtube.com](https://youtube.com "YouTube.com") you do not need to know the IP address, as the DNS service will look it up for you.  Now, think about the internals of YouTube itself.  Extra servers need to come online all the time to handle surges in requests or QPS (queries per second).  How do they handle IP allocation internally?  They use some kind of **service discovery** or **service mesh**.  

The concept of service discovery is essentially an internal or local DNS.  Each system hard codes its own localized DNS entry then via a protocol called *gossip*, agents talk to each other and "spread" the local DSN entries.  An application can simple make a ```curl``` or http based request to the internal agent and resolve the IP internally.

Hashicorp created a software called [Consol](https://www.consul.io "Consol").  

Description of Consol.

### Vault for Secret Sharing

One of the biggest problems in computers and cyber security is the sharing of *secrets*.  A secret is generally anything that gives privillege to a user, such as a username and password combo, or and authentication token, or an URL even. Not only do you have the trouble of keeping this secure from hackers and exploits, but you also have the problem of distributing them.  If you share a secret, then it is not a secret anymore.  But in launching multiple distributed servers, how to you give each instance access to these secrets?  A second question is how to you manage and expire them? 

This problem was solved by a service called Valut by Hashicorp.

Example

## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

  Questions go here

### Podcast Questions

See the presentation at: [https://www.youtube.com/watch?v=xXWaECk9XqM](https://www.youtube.com/watch?v=xXWaECk9XqM "Bryan Cantril Hashiconf 2017 Presentation"): The Container Revolution: Reflections After the First Decade by Bryan Cantrill.

1. ~0:30 Where does Bryan work, who recently bought that company, and what do they do?
1. ~1:33 What is the date of the birth of containers?
1. ~3:25 What was the next iteration of containers?
1. ~3:49 What is the purpose of a Jail?
1. ~5:10 What did SUN call their full application environment they created in 2002?
1. ~6:13 What is every application running on?
1. ~8:43 What did Amazon announce in 2006?
1. ~9:00 In 2006 what was Joyent using in 2006, and what was Amazon using?
1. ~9:25 What became defacto for the cloud?
1. ~11:18 What happens to the RAM when you give it to an operating system?
1. ~14:40 What does Joyent's Manta service allow you to do with containers and objects?
1. ~18:58 What command hadn't been created in 1986?
1. ~21:45 When did the world figure out containers and what was this product?
1. ~22:57 Why did the container revolution start with Docker?
1. ~24:07 Containers allow developers to do what?
1. ~26:00 What is Triton and what does it do?
1. ~31:42 What are the two approaches to the container ecosystem, and what is the difference?
1. ~33:25 What is the Hashi ethos?
1. ~37:00 What was the mistake that happened with the pilot operator release valve at 3 Mile Island?
1. ~39:05 With container based systems in what terms must we think in?
1. ~40:00 Why is scheduling containers inside of VMs a bad idea?
1. ~What is Joyents thoughts regarding VMs in the application stack?

### Lab

 Lab goes here

#### Footnotes
