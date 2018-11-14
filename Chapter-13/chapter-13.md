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

### Automation and Hashicorp

One of the main things that computers are good at is executing repetive tasks.  One of the things humans seem to dislike is repeating the same task.  So how to solve this when it comes to computers, where there are only a small number of tasks that are repeated over and over.  One of the problems that has been common is the divide between the developers (devs) and the operations (ops) people.  Developers need hardware to test their code on and then more hardware to run their code in production.  Operations people have to maintain those systems and the code and the lifecycle of the application.  Developers started to think, could we deploy our infrastructure in the same way we deploy code?  Could we automate the way out of this problem?  A young developer named Mitchel Hashimoto had the same problem.  

Image of Mitchell Hashimoto

Micthcell realized that while using Virtual Box, he could be productive by keeping copies of the production servers where his code would reside as a local vm on his system.  He realized their were some limitations to what Virtual Box would allow for in the way of access to the system.  Virtual Box just provided an interface to virtualize an operating system, and had no provisions for quickly deploying or automating an OS deployment.  

### Vagrant

 At that time, [Hashicorp](https://hashicorp.com "Hashicorp") was born.  This was in 2010 and Mitchell's first task was easing the deployment, connection, and most importantly abstracting the network address translation bewtween host and guest operating systems.  He created [Vagrant](https://vagrantup.com "Vagrant") to do just this.  Vagrant initally was a VritualBox only porduct but has moved to be an abstraction layer now for multiple virtualization and container platforms

* 1
* 1
* 1
* 1

Vagrant is just that, an abstraction layer between you and virtualbox.  It is written in the Ruby Language and comes as a self-contained binary that runs accorss all platforms.

Reasons to use Vagrant
List them here

Vagrant commands
List them here from OneNote

### Packer

While Vagrant is used to manage vms, there was no tool that could be used to quickly and reliably create vms.  The next tool that Hashicorp introduced was called [Packer](https://packer.io "Packer.io").  Packer, much like the name suggests, allows you to automate the installtion of operating systems.  Operating systems from Windows to Linux distros to BSD are made to be installed manually.  A few technologies for network based installs exist, but even these assume their is a physcial computer to correlate to.  Packer wen tone step further by allowing you to speficify all the answers to the installation questions, you could now have a repeatable installation.  You could now audit this install as well as take this same install (with minor modifications) and make artifacts that can exist on different platforms.  You could build a VirtualBox VM and at the same time have an Amazon Web Services artifact so that all of your developers, operations, testers, and QA can have access to the same machine.

Packer Reason to hav eit

Packer examples and example build code  https://github.com/jhajek/packer-vagrant-build-scripts

### Pressed and Kickstart

Examples

### Consol and Service Mesh/Discovery

[Consol](https://www.consul.io "Consol")

## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

  Questions go here

### Podcast Questions

Bryan Cantril Hashiconf Jails the first decade - Woot!

### Lab


#### Footnotes
