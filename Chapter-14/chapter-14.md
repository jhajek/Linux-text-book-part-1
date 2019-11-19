# OS Containers, Secret Management, and Applications

![*Creating technology to support technology.*](images/Chapter-Header/Chapter-14/tech_loops-2.png "Tech Loops")

## Objectives

* OS Containers
  * [Docker](https://docker.com "Docker website")
* Application Deployment in Containers
  * [VuePress](https://vuepress.vuejs.org/ "Vuepress website")
  * [Gatsby](https://www.gatsbyjs.org/ "GatsbyJS website")
  * [Jekyll](https://jekyllrb.com/ "jekyllrb website")
  * [Vault](https://www.vaultproject.io/ "Vault Website")

## Outcomes

At the conclusion of this chapter you will have gained an understanding of how non-trivial applications are created, maintained, and securely deployed using Operating System Containers.  You will have learned the basic differences and advantages of OS Containers and Virtual Machines and will be able to use industry standard tools that demonstrate these concepts.

## Changing the Way We Think About Abstractions

Through this book we have studied about computing philosophy, technology, and computing paradigms.  In the last chapters we are going to look at a new way, a new abstraction in computing that began in 2013.  This is a paradigm with accompanying and as anything new, it changes rapidly.  The reason we put this in an introduction text book is to expose you to these tools and add them to your own toolbox. You may go to work at companies where they don't use certain technologies.  You may work at places that are cutting edge; the important thing to remember is: whatever you use, it is essentially a tool to help you complete your job.  Some tools work better than others to get jobs done.  

## Operating System Containers and Virtual Machines

In the class so far, we have made extensive use of virtual machines.  This technology has greatly reduced our need for physical lab space or extra computers.  If we want to test installing an Apache Webserver or Nginx or even FreeBSD, we can do so using a virtual machine.  We can use Packer and Vagrant to automate the creation of our virtual machines.  This is is a huge advantage when we look at things operationally.  But IT operations doesn't just run servers alone, they run **applications** which are the lifeblood of any business.  When we look at virtual machines from an application point of view we begin to see redundancies.  For instance, I can launch multiple Linux virtual machines with the push of a button.  But consider this, each operating system has virtualized hardware drivers, kernel, BIOS, even a virtual floppy disk driver.  

![*Virtual Machine*](images/Chapter-14/docker/container-vm-whatcontainer_2.png "Virtual Machine Diagram")

\newpage

All of these virtual devices create software overhead and a translation layer of software. While you have created separation, you haven't increased the speed of your application.  The reason is the **abstraction** is wrong.  Essentially, virtualization is about hardware consolidation, even the name, *virtual machine* tells you what you are getting.  When you look at an application, due to the operating system, it is abstracted away from the hardware by design.

When you look at Linux binaries such as ```ls``` or ```grep``` they are precompiled executables.  They contain all the code needed to execute.  You could copy the binary to another location or machine and expect it to work, why not with the entire application? Instead of the machine being virtual, why not make the operating system virtual?  If you analyze the bulk of the size of an operating system, the majority is in the kernel and in the drivers.  What if you didn't virtualize the entire hardware stack and kernel, but just the operating system binaries? This is what lead to the concept of **Operating System Containers.**

![*OS Containers*](images/Chapter-14/docker/docker-containerized-appliction-blue-border_2.png "docker containerized appliction")

### Where did Containers Come From

We know the birthday of containers.  It started in 4.1 BSD in 1984.  Bill Joy submitted the code to create the ancestor of containers, the ```chroot``` command.  This command was used to *contain* a user or application into a certain directory structure, while allowing multiple users to still share the same system.  The ```chroot``` command gave way to the FreeBSD ```jails``` command, which essentially was used to contain vulnerable or misbehaving software.  This would allow you to *jail* an application such as a webserver or FTP server so that the processes would not effect other users.

Taking the idea of a BSD Jail, SUN developed a further extension for their Solaris UNIX, [called Zones](https://docs.oracle.com/cd/E36784_01/html/E36848/zones.intro-2.html#scrolltoc "Oracle Solaris Zones Docs") in 2004. The purpose of Zones is stated as "*...partitioning technology (is) used to virtualize operating system services and provide an isolated and secure environment for running applications[^159].*" This technology lives on in IllumOS based distributions today. Zones were an improvement over FreeBSD Jails.  But were still positioned as an Operations tool for consolidating servers and thereby cost reduction.  

In 2008, in Linux kernel 2.6, LXC, [Linux Container](https://en.wikipedia.org/wiki/LXC "Linux Containers Wikipedia page") was introduced to offer similar functionality as BSD Jails and Solaris Zones, but on Linux.  Using cgroups and namespaces they were able to recreate the same functionality.  But LXC was largely seen and positioned as a hardware consolidation technology.  

This point of view, in which OS Containers were posited as a cost reduction methodology, changed in 2013.  A failing Platform as a Service (PaaS) company called DotCloud made a last ditch attempt to save itself by opensourcing their platform management tool, called [Docker](https://en.wikipedia.org/wiki/Docker_(software) "docker software wikipedia article").  Docker was introduced at a [five minute lightning talk](https://www.youtube.com/watch?v=wW9CAH9nSLs "Solomon Hykes 5-miunute lightning talk at PyCon") at a [PyCon](https://us.pycon.org/ "PyCon python convention website") Python convention.  It was at this presentation where Docker showed that OS Containers should no longer be seen as an operations tool, but as a developer tool.  Presented in a format that allowed developers to see OS Containers as a way to package up software dependencies and application code and deploy it almost as a single binary.  The analogy of a shipping container is not lost.  Once shipping was standardized into container weights and heights, world wide shipping on boats, trains, and trucks became vastly streamlined.  In *Figure 14.3* you see that applications are using the same kernel.  This is possible because of the way Linux is constructed.  Linux is a kernel, and therefore you can place any operating system on top of it.  In addition to this natural structure, Linux uses a technology called **cgroups** to create **namespaces** which further allow for isolation of applications.   Containers then lead t the concept of immutable infrastructure.  Since they are so small you simply build them and if there is a problem, you re-build and redeploy.  No need for individual management.  For more details, [What is an OS Container?](https://www.docker.com/resources/what-container "What is an OS Container?").

## Docker Containers

[Docker](https://docker.io "Docker") showed that OS Containers were essentially a developer deployment tool and a way to make a portable "binary" of your application.  We can install Docker on any Linux based operating system.  Let's try this on an Ubuntu 18.04 system.  This shell script can be found in the source code directory for the textbook under: files > Chapter-14 > install-docker.sh.

```bash
#!/bin/bash
# Bash Script to install docker-ce from URL

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo systemctl enable docker

```

What can you do with docker?  The [commandline reference](https://docs.docker.com/engine/reference/commandline "Docker CLI reference") is pretty complete.  Once installed you have a few commands that are needed to get up and running.  To get started with we will pull some pre-made docker containers from the Docker registry, called [Docker Hub](https://hub.docker.com/ "Docker Hub website"), and work with them.  Some of the common commands are listed below:

* Get Docker container images
  * ```docker pull```
* List Docker container images
  * ```docker images```
  * ```docker ps```
* Start, stop and run container images
  * ```docker run```
  * ```docker run -d```
  * ```docker start | stop```
  * ```docker rm```

From the commandline I can issue the command: ```docker pull ubuntu```.  This will go the the Docker registry, not unlike the Vagrant Box registry, and pull an Ubuntu 18.04 container (~35mb) to your system.  Try it and see what happens.

Let us try to pull some other containers, this time containing an application:

* `sudo docker pull nginx`
* `sudo docker pull node`
* `sudo docker pull jekyll/jekyll`
* `sudo docker pull gatsbyjs/gatsby`
* `sudo docker pull wordpress`

You can now list the container images by issuing the ```docker images``` command.  When you do, what do you see?  Try to pull someother containers.  Try ```docker pull mysql```, or ```docker pull alpine```, or ```docker pull jenkins```.  What happens?  How to interact with them?  

We issue the command: ```docker run```.  The entire ```docker run``` documentation is explained [https://docs.docker.com/engine/reference/commandline/run/#examples](https://docs.docker.com/engine/reference/commandline/run/#examples "Docker run documentation"). There are two ways to run containers.  They can be run as a background process accessible over the network or the can be run with an interactive remote shell.  This leads to a concept of [immutable infrastructure](https://www.digitalocean.com/community/tutorials/what-is-immutable-infrastructure "Digital Ocean article explaining immutable infrastructure"). Generally a Docker container will be created and run without manual intervention, but we will show you how you can login and modify a container to learn about how containers work.  

Let's run the command: ```docker run --name my-apache-server -it ubuntu```.  What happens? The ```--name``` flag allows us to give us a reference name for this instance of the container.  The ```-i``` flag allows us to have an interactive shell and the ```-t``` gives us a psuedo-TTY; or a terminal.  Note that this is a root shell and you can pass commands remotely wihtout needing an interactive shell.  Simple remove the ```-i -t or -it``` flags to do so. In another terminal window run the command: ```docker ps``` and note that this screen shows us the running container instances.

If this were a virtual machine, we would begin to install our application infrastructure such as Apache2 or MySql via apt or yum.  We will login an do this, but there is another way, we can create a dockerfile and when we run the container, it will take all the values listed as well as install any pre-reqs we require.

The question about containers becomes, since it is an OS abstraction, how to we deal with disk and permanent storage.  This is one of the key points of this abstraction.  Docker is not meant to deal with *state*.  Meaning you can mount external disk into the container.  This is one way to get code or data preconfigured into the container.  You would not clone your code into the container, but clone it to the local system and then mount that folder into the Docker Container.  This way you can pull new code anytime without having to rebuild your container.  This has advantages of not having to have extra package dependencies for Git inside of your container, thereby reducing the size of the container and the speed in which it can be deployed.

Here is a sample Dockerfile and the [reference page](https://docs.docker.com/engine/reference/builder/ "Dockerfile reference page"), which can be found in: files > Week-14 > Dockerfile:

These are the supported commands in a Dockerfile, which is always capital by default.

Header                         Description of header  
-------------     --------------------------------------------------------------------------------------------------------
CMD               There is only one CMD. Used to execute or start a service.  Containers do not have systemd.
COPY              Copies code from a local file system into a container 
ENV               Used for setting ENV variables or passing in credentials
EXPOSE            Expose ports via port forwarding to other containers internally only
FROM              Which base Docker Hub container to pull and work from
LABEL             This is a way to label your containers
VOLUME            Creates a mount point and holds externally mounted volumes from native hosts
WORKDIR           Sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions.

```yaml
FROM node:12.2.0-stretch
MAINTAINER Jarron Bailey <baileyjarron@gmail.com>
WORKDIR /app
COPY ./src/package* /app/
RUN npm install
COPY ./src/ /app
```

Now how to we get the website to render?  You will notice that one of the advantages of a Virtual Machine is that each VM has its own networking stack and this makes the abstraction easy to grasp.  In the case of OS Containers, there is only one networking stack, so we need to ALLOW or open containers upon internal networking ports--similar to the concept of port forwarding.  You can do this by adding the ```-p``` flag and then a port mapping such as ```80:80``` which will tell Docker to send requests on port 80 to port 80 inside the container or that can be defined in the Dockerfile.

There are two commands to run:  `docker build .` to build the custom image and `docker run` to run an instance from the custom image. These commands should be executed in the directory where the `Dockerfile` resides:

`sudo docker images`
`sudo docker ps`
`sudo docker build .`
`sudo docker images`
`sudo docker ps`
`sudo docker run -d --name apache-webserver ubuntu`

### Developing and Deploying Applications

* VuePress
* GatsbyJS
* Jekyll
* Vault

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

* Complete this tutorial [https://learn.hashicorp.com/consul/](https://learn.hashicorp.com/consul/ "Consul Tutorial")
* Complete this tutorial [https://learn.hashicorp.com/vault/](https://learn.hashicorp.com/vault/ "Vault Tutorial")

#### Footnotes

[^157]: [https://www.consul.io/](https://www.consul.io/ "Hashicorp Consul")

[^158]: [https://www.vaultproject.io](https://www.vaultproject.io "Hashicorp Vault")

[^159]: [https://docs.oracle.com/cd/E36784_01/html/E36848/zones.intro-2.html#scrolltoc](https://docs.oracle.com/cd/E36784_01/html/E36848/zones.intro-2.html#scrolltoc "Oracle Solaris Zones Docs")
