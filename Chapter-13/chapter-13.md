# Infrastructure Installation and IT Orchestration ROUGH DRAFT
![*Good thing we avoided that one...*](images/Chapter-Header/Chapter-13/2038-2.png "2038")

## Objectives

* IT Orchestration and Automation tools
  + Vagrant
  + Packer.io
  + Consul
  + Vault
  + Additional automation tools

## Outcomes

At the conlcusion of this chapter you will have a basic understanding of how to use infrastructure automation and orchestration tools.  You will be familiar and able to explain the concept of immutable infrastructure and will be able to explain cloud native development technologies as well as OS container technology.

### Automation and Hashicorp

One of the main things that computers are good at is executing repetive tasks.  One of the things humans seem to dislike is repeating the same task.  So how to solve this when it comes to computers, where there are only a small number of tasks that are repeated over and over.  One of the problems that has been common is the divide between the developers (devs) and the operations (ops) people.  Developers need hardware to test their code on and then more hardware to run their code in production.  Operations people have to maintain those systems and the code and the lifecycle of the application.  Developers started to think, could we deploy our infrastructure in the same way we deploy code?  Could we automate the way out of this problem?  A young developer named Mitchell Hashimoto had the same problem.  

![*Mitchell Hashimoto*](images/Chapter-13/people/mh.png "mitchell hashimoto")[^1]

Micthcell realized that while using Virtual Box, he could be productive by keeping copies of the production servers where his code would reside as a local vm on his system.  He realized their were some limitations to what Virtual Box would allow for in the way of access to the system.  Virtual Box just provided an interface to virtualize an operating system, and had no provisions for quickly deploying or automating an OS deployment. He set out to solve this problem.

![*Hashicorp Stack*](images/Chapter-13/hashi/hashistack.png "hashi-stack")

### Vagrant

#### What is the problem?

The problem is that we have high levels of computing available to us yet we are not really using any of it.  Our own laptops are fully powered and used as primary workstations.  Yet when it comes to developers writing code, QA testers, Operations and Security people, these resources are not being used--we have ad-hoc efforts to gain some hardware, any hardware, for testing.  This leads to a fractured development and inconsistent experiences, which often lead to short cuts and compromises that your are forced to pay later.    

Enter Mitchell Hashimoto and Hashicorp.  They started in 2010 with a radical mission to automate everything they could into repeatable steps using single tools that handle abstractions.   Hashicorp was platform agnostic and focused on the process of automation.   They succeeded and are now considered the industry leaders in the arena.  Quite frankly there are no other tools that even compete in this space.  [https://www.hashicorp.com/files/DevOps-Defined.pdf](https://www.hashicorp.com/files/DevOps-Defined.pdf "Problem Hashi is solving").

At that time, [Hashicorp](https://hashicorp.com "Hashicorp") was born.  This was in 2010 and Mitchell's first task was easing the deployment, connection, and most importantly abstracting the network address translation bewtween host and guest operating systems.  He created [Vagrant](https://vagrantup.com "Vagrant") to do just this.  Vagrant initally was a VritualBox only porduct but has moved to be an abstraction layer now for multiple virtualization and container platforms

#### How Vagrant Benefits You[^2]

> *If you are a developer, Vagrant will isolate dependencies and their configuration within a single disposable, consistent environment, without sacrificing any of the tools you are used to working with (editors, browsers, debuggers, etc.). Once you or someone else creates a single Vagrantfile, you just need to vagrant up and everything is installed and configured for you to work. Other members of your team create their development environments from the same configuration, so whether you are working on Linux, Mac OS X, or Windows, all your team members are running code in the same environment, against the same dependencies, all configured the same way. Say goodbye to "works on my machine" bugs.*

> *If you are an operations engineer, Vagrant gives you a disposable environment and consistent workflow for developing and testing infrastructure management scripts. You can quickly test things like shell scripts, Chef cookbooks, Puppet modules, and more using local virtualization such as VirtualBox or VMware. Then, with the same configuration, you can test these scripts on remote clouds such as AWS or RackSpace with the same workflow. Ditch your custom scripts to recycle EC2 instances, stop juggling SSH prompts to various machines, and start using Vagrant to bring sanity to your life.*

> *If you are a designer, Vagrant will automatically set everything up that is required for that web app in order for you to focus on doing what you do best: design. Once a developer configures Vagrant, you do not need to worry about how to get that app running ever again. No more bothering other developers to help you fix your environment so you can test designs. Just check out the code, vagrant up, and start designing.*

Vagrant is just that, an abstraction layer between you and VirtualBox, Hyper-V, Docker, and even Vmware desktop.  It is written in the Ruby Language and comes as a self-contained binary that runs accross all platforms.

Vagrant commands
List them here from OneNote

### Packer

While Vagrant is used to manage vms, there was no tool that could be used to quickly and reliably create vms.  The next tool that Hashicorp introduced was called [Packer](https://packer.io "Packer.io").  Packer, much like the name suggests, allows you to automate the installtion of operating systems.  Operating systems from Windows to Linux distros to BSD are made to be installed manually.  A few technologies for network based installs exist, but even these assume their is a physcial computer to correlate to.  Packer wen tone step further by allowing you to speficify all the answers to the installation questions, you could now have a repeatable installation.  You could now audit this install as well as take this same install (with minor modifications) and make artifacts that can exist on different platforms.  You could build a VirtualBox VM and at the same time have an Amazon Web Services artifact so that all of your developers, operations, testers, and QA can have access to the same machine.

Packer Reason to have it

Packer examples and example build code https://github.com/jhajek/packer-vagrant-build-scripts.git

### Answer Files

Most operating system installations are designed for a manual install process.  This makes sense as for almost 40 years we have been using PC's (Personal Computers).  A first step in automating the install process is to automate the answering of the installation questions.  This is the most repetive process of the install, as well as something that is not conducive to the human, as you spend most of your time waiting.  

The first solution came from Sun in 198x and was called Jumpstart.  This was used to hold installtion information and as a target system was booted, it would communicate to the Jumpstart server and complete the entire install over the network, OS and handle configuration.

The next phase came in Linux with Fedora creating the Kickstart answer file system [Link here]   [Kickstart documentation](https://docs.fedoraproject.org/en-US/Fedora/18/html/Installation_Guide/s1-kickstart2-file.html) to handle not the OS install part, but at least the OS configuration and software retrieval.  Remember the SUN product was created before pervasive internet and package managers and had to rely on software being centrally available on the local network.  it can be generated from scratch or upon a successful install a default kickstart is located in /root/anaconda-ks.cfg

[Debian/Ubuntu pressed template](https://help.ubuntu.com/lts/installation-guide/amd64/apb.html "Preseed")  Debian created their own answer file system call [preeseed].  

In the source code repository see Files > Chapter 13 > answer-files for working kickstart and preseed examples.

You can interrupt a manual install and point to a kickstart file, but it needs to be done over the network.  When you are installing an operating system you don't yet have a filesystem to read files from!  

Example of preseed or kickstart

### Consul for Service Mesh/Discovery

As applications moved from single systems to distributed systems, then to multi-tiers, the issue of IP addresses comes into focus.  What happens when you have services being launch and virtual systems being destroyed?  How do you manage the IP addresses?  Well on the internet we have DNS for name resolution and lookup.  If you look up [https://youtube.com](https://youtube.com "YouTube.com") you do not need to know the IP address, as the DNS service will look it up for you.  Now, think about the internals of YouTube itself.  Extra servers need to come online all the time to handle surges in requests or QPS (queries per second).  How do they handle IP allocation internally?  They use some kind of **service discovery** or **service mesh**.  

The concept of service discovery is essentially an internal or local DNS.  Each system hard codes its own localized DNS entry then via a protocol called *gossip*, agents talk to each other and "spread" the local DSN entries.  An application can simple make a ```curl``` or http based request to the internal agent and resolve the IP internally.

Hashicorp created a software called [Consol](https://www.consul.io "Consol").  

Description of Consol.

### Vault for Secret Sharing

One of the biggest problems in computers and cyber security is the sharing of *secrets*.  A secret is generally anything that gives privillege to a user, such as a username and password combo, or and authentication token, or an URL even. Not only do you have the trouble of keeping this secure from hackers and exploits, but you also have the problem of distributing them.  If you share a secret, then it is not a secret anymore.  But in launching multiple distributed servers, how to you give each instance access to these secrets?  A second question is how to you manage and expire them? 

This problem was solved by a service called Valut by Hashicorp.

Example

### Network Based Install Tools

Cobbler -- a modern version of Jumpstart, which is good for network based install and configuration of static hardware.
MaaS - Metal as a DService.  This was built by Canonical (Ubuntu) to manage and deploy systems, it includes and builds upon Cobbler.  

Chef
Puppet
Ansible
CfEngine  Mark - In serch of Certainty

## Chapter Conclusions and Review

In this chapter we learned how a spread in technology lead to a desire to automate and ease installation and configuration. A new generation of technology brought a new generation of tools.  These tools are a part of what we called cloud-native, immutable infrastructure, and are the standard ways to deploy operating systems and hardware accross the industry.

### Review Questions

  Questions go here

### Podcast Questions

Bryan Cantril Hashiconf Jails the first decade - Woot!

### Lab

Complete Vagrant Tutorial, complete my Packer tutorial, complete Consol tutorial, complete Vault tutorial?

#### Footnotes

[^1]: [http://d13pix9kaak6wt.cloudfront.net/background/users/m/i/t/mitchellh_1370739801_5.jpg](http://d13pix9kaak6wt.cloudfront.net/background/users/m/i/t/mitchellh_1370739801_5.jpg "Mitchell Hashimoto")

[^2]: [https://www.vagrantup.com/docs/why-vagrant/](https://www.vagrantup.com/docs/why-vagrant/ "Why try Vagrant?")
