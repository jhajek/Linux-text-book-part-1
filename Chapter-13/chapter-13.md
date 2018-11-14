# Infrastructure Installation and IT Orchestration ROUGH DRAFT
![*Good thing we avoided that one...*](images/Chapter-Header/Chapter-13/2038-2.png "2038")

## Objectives

  Learn about:
  * Hashicorp Tech
    + Vagrant
    + Packer.io
    + Consul
    + Vault
  * Chef 
  * Ansible
  * Puppet
  * cfEngine
  * salt  
  * Docker OS Containers

## Outcomes

At the conlcusion of this chapter you will have a basic understanding of how to use infrastructure automation and orchestration tools.  You will be familiar and able to explain the concept of immutable infrastructure and will be able to explain cloud native development technologies as well as OS container technology.

### Automation

One of the main things that computers are good at is executing repetive tasks.  One of the things humans seem to dislike is repeating the same task.  So how to solve this when it comes to computers, where there are only a small number of tasks that are repeated over and over.  One of the problems that has been common is the divide between the developers (devs) and the operations (ops) people.  Developers need hardware to test their code on and then more hardware to run their code in production.  Operations people have to maintain those systems and the code and the lifecycle of the application.  Developers started to think, could we deploy our infrastructure in the same way we deploy code?  Could we automate the way out of this problem?  A young developer named Mitchel Hashimoto had the same problem.  

Image of Mitchell Hashimoto

Micthcell realized that while using Virtual Box, he could be productive by keeping copies of the production servers where his code would reside as a local vm on his system.  He realized their were some limitations to what Virtual Box would allow for in the way of access to the system.  Virtual Box just provided an interface to virtualize an operating system, and had no provisions for quickly deploying or automating an OS deployment.   At that time, [Hashicorp](https://hashicorp.com "Hashicorp") was born.  This was in 2010 and Mitchell's first task was easing the deployment, connection, and most importantly abstracting the network address translation bewtween host and guest operating systems.  He created [Vagrant](https://vagrantup.com "Vagrant") to do just this.  Vagrant initally was a VritualBox only porduct but has moved to be an abstraction layer now for multiple virtualization and container platforms

*
*
*
*

## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

  Questions go here

### Podcast Questions

Bryan Cantril Hashiconf Jails the first decade - Woot!

### Lab


#### Footnotes
