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

Rise of Illumos slides [http://www.slideshare.net/bcantrill/fork-yeah-the-rise-and-development-of-illumos](http://www.slideshare.net/bcantrill/fork-yeah-the-rise-and-development-of-illumos "Illumos")
Video By Brian Cantrill [https://www.youtube.com/watch?v=-zRN7XLCRhc](https://www.youtube.com/watch?v=-zRN7XLCRhc "SmrtOS")

### Lab

 Lab goes here

#### Footnotes
