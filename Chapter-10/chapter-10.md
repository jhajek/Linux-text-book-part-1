# Package Managers and Package Installation
![*Always check the package dependencies...*](images/Chapter-Header/Chapter-10/debian_main-2.png "Dependencies")

__Chapter 10 Objectives__

  * Learn the features of dnf, yum, and apt to install packages and dependecies in Linux
  * Understand the nature of GNU tools gcc and make 
  * Understand how to use the Python lanuguage interpreter in order to run python based install scripts 
  * Understand how to use tar, gzip, and bzip2 for extracting packages containing source code
  * Compiling code from source
  
__Outcomes__

  At the conclusion of this chapter you will be able to install packages and manage dependecies through using standard package managers dnf, yum, and apt.  You will also be comfortable compiling software from source using a tar ball and python setup tools.

## Package Managers

  One of the initial claims against using Linux and Unix was that software install was a nightmare.  Software had been distributed in tarballs (*.tar.gz) which was convenient but lacked any knowledge of system state. So you could compile source code but the code had no idea ahead of time if the proper software libraries were installed in the correct locations or if the proper versions of those libraries were installed. And each additional library needed had it's own dependencies and those had dependencies too.  You see how this could get ugly quickly.  Initially there was a build system developed by a companion of Thompson and Ritchie's named Stuart Feldman is the creator of the computer software program make for UNIX systems. He was also an author of the first Fortran 77 compiler, and he was part of the original group at Bell Labs that created the Unix operating system.[2] Feldman was the Vice President of Computer Science at IBM Research. He was also Vice President, Engineering, East Coast, at Google for a time [^105].  Feldman realized building software was difficult and created the ```make``` build system.  The ```make``` system uses a file named a ```makefile``` that includes instrcutions and ordered steps that can be repeated everytime software is built.  This attributes software to be portable accross systems (ideally anyway).  Make is a utility that automatically builds executable programs and libraries from source code by reading files called Makefiles which specify how to derive the target program [^106].  Makefiles have an arcane syntax that not all people enjoy and over the years many people have modified and rewritten their own ```make``` system.
  
 ```makefile
     all: helloworld

    helloworld: helloworld.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

    clean: FRC
	rm -f helloworld helloworld.o

    # This is an explicit suffix rule. It may be omitted on systems
    # that handle simple rules like this automatically.
    .c.o:
	$(CC) $(CFLAGS) -c $<

    FRC:
    .SUFFIXES: .c
```

Clear as mud right?  Like many things in the Unix world, this sysetm has been modified and augmented but still persists as the way software project are installed.  By 1988 the GNU project had released their Free Software version of ```make``` called GNU Make and this is included in all standard Linux distrobutions and is even required for compiling the Linux Kernel.  There are other versions of ```make``` including the Unix version, ```pmake``` and ```bmake``` on the BSD Unix variants and even Microsoft has its own build tool that can be used called ```nmake```.

  Software is more complicated

  Linux distributions took to making software installation and distribution easier by introducing something initally called __Package Managers__.  These were meant to eliminate all of the above process by solving two key probelms. First it would solve the re-compilation of code and supporting of make and build tools--you technically wouldn't even need any C compiler or build tools installed.  Second package managers would solve the dependency issues by keeeping track of the dependency trail and be smart enough to follow that trail before installation.  The first package manager was ___dpkg__ which was created by Matt Welsh, Carl Streeter and Ian Murdock (founder of Debian) in 1994 as a replacement for an earlier primative package manager.  The program ```dpkg``` is used to install, remove, and provide information about .deb packages.
 
 A Debian package (or ```.deb``` file) is really just made up of two tarballs [^107].  One is the control data which is listed as such:
```
     Package: hello
     Priority: optional
     Section: devel
     Installed-Size: 45
     Maintainer: Adam Heath <doogie@debian.org>
     Architecture: i386
     Version: 1.3-16
     Depends: libc6 (>= 2.1)
     Description: The classic greeting, and a good example
     The GNU hello program produces a familiar, friendly greeting. 
```      

The most important line being the __Depends__ option which controls dependencies and can prevent installation of these conditions cannot be met.  The second component includes the binary or pre-compiled portion of the code.  Usinbg ```dpkg``` is a clear step above using tarballs and compiling the code yourself. There are other tools that build on top of dpkg that are recommended to use.   Let's take a look at an example we have doen before in chapter 4 where we downloaded a .deb file for the Vivaldi web browser and installed it via the Ubuntu Software Center.  Now let's perform the same action again using the ```dpkg``` command.

> __Example Usage:__  You can download a .deb file from the Vivaldi website here: [https://vivaldi.com/download/](https://vivaldi.com/download/ "Vivaldi.com") Vivaldi is a new browser from the team that brought us Opera browser.  The packages are not available in the Ubuntu or Gnome Software stores but you can download the .deb. file directly and install through dpkg.  If it is previously installed you might have to use the Ubuntu Software Center to remove it and then complete this exercise.  In the command below we will introduice the install command or the ```-i``` flag, which stands for __install__.
```bash
sudo dpkg -i ./vivaldi-package name
```

After executing this command you will receive an error message. What is it telling you and why?  (Hint think 3P's from the previous chapter) You will notice that the dpkg foudn that it had a *dependecy*, can you locate that *dependecy* on [http://packages.ubuntu.com](http://packages.ubuntu.com "packages")?

> __Example Usage:__ 
```bash
sudo dpkg -i ./links_2.8-2_amd64.deb
```
Note that this command installs properly without any error message. [http://packages.ubuntu.com/vivid/links](http://packages.ubuntu.com/vivid/links "links")

> __Example Usage:__   There are other flags but the most common are these: ```sudo dpkg -r or --remove```, ```sudo dpkg -P or --purge```, ```sudo dpkg -l or --list```, and ```sudo dpkg --status links```

> __Example Usage:__ Let's use the ```dpkg``` command to list all kernel version we have installed and the ```purge``` command to remove those old kernels entirely.  
```bash
sudo apt-get dist-upgrade
dpkg -l | grep linux-image
# x.x.-xx is the verison that is not the most recent version as deleting that will make your system unbootable
sudo apt-get purge linux-image-x.x.x-xx-generic
```

#### RPM

 A few years after dpkg became standard on the Debian based distros, the Red Hat company created their own package manager our of neccesity in 1998 and called it RPM (Originally Red Hat Package Manager - now known as RPM Package Manager.)  Red Hat created their own package manger that is used accross those systems that are Fedora or RHEL derivatives.  RPM is also used on IBM's AIX Unix distribution too.  RPM code and FAQ can be found at [http://rpm.opg](http://rpm.org "RPM.org") [^113]. 

> __Example Usage:__ List all installed packages:
```rpm -qa```

> __Example Usage:__ List information about an installed package:
```rpm -qi pkgname```

> __Example Usage:__ Install a package from a local file:
```rpm -i file.rpm```

> __Example Usage:__ Remove a package from the system:
```rpm -e pkgname```             

> __Example Usage:__ Get information about a remote package
```rpm -qpi <url>```

Similar to the previous example let us download the Vivaldi RPM and install it locally.  [https://vivaldi.com/download/](https://vivaldi.com/download/ "Vivaldi.com").  After selecting the Vivaldi 64 bit rpm and using the ```-i``` flag to install it, what error message is printed?  

Let's try another rpm.  This one is a software called *Denyhosts* this is a brute force banning tool that will lock out IP addresses that attempt to brute force connect to your server.  The rpm is located at [http://pkgs.repoforge.com/denyhosts](http://pkgs.repoforge.com/denyhosts "Denyhosts").  You can download the denyhosts-2.6.5-el6.rf.noarch.rpm.  When you run the rpm based installer what happens?  Why? 

#### Installers 
 
   As you can see from above package managers were a great step forward in making Linux usable beyond the ranks of Thompson, Ritchie, and Stallman.  But they still don't handle the dependency issue--they don't understand the context of auto-dependecy retrieval.  Various solutions were created but every Linux distro has pretty much settled on two families of Installers--those that match the major families.  Fedora based distros use Yum and now use DNF (as of Fedora 23) and Debian based distros use APT.  
 
### APT

Apt (for Advanced Package Tool) is a set of core tools inside Debian. Apt makes it possible to: 
  
   *  Install applications 
   *  Remove applications 
   *  Keep your applications up to date

The APT installer was released in 1998, the same time that RedHat released its package manager (giving Debian a leg up and a few years head-start).  APT was the out growth of a research project called Diety run by the Debian developers.  It was planned to be a large GUI-like project, but it turns out that the APT CLI was implemented with such finese and simplicity that all GUI plans were dropped.  APT is mentioned as one of the key user based features for Debian based distros and Debian's founder Ian Murdock consider's APT to be one of the best contributions of Linux [^108].  APT stands for the Advanced Packagin Toolkit.  APT will interface with *dpkg* and has many similar commmands but extends the functionality of dpkg in a critical way.  

APT, which basically resolves dependency problems and retrieves the requested packages, works with dpkg under the hood. The main commands of APT are as follows:

  * apt-get update -- used to make sure your system is pointed to the latest repository versions. You should always run this before taking any other actions.
  * apt-get install -- used to install the application of choice
  * apt-get remove -- used to remove the application of choice
  * apt-cache search \[pattern\] -- used to search all yoru repositories for an app matching the given pattern
  * apt-get upgrade -- used to perform an upgrade of all current packages that have updates available (note in Yum this is the command update)
  * apt-get dist-upgrade -- this performs the same as the upgrade but will also update the kernel version and headers as well
  * do-release-upgrade -- this will update the entire distribution and move it to the next incremental version (Ubuntu 15.04 to 15.10)

#### Repositories

APT relies on the concept of repositories in order to find software and resolve dependencies. For apt, a repository is a directory containing packages along with an index file. This can be specified as a networked or local based location. The Debian project keeps a central repository of over 25,000 software packages ready for download and installation.  This includes ability to add non-free software repositories as well.    You can add additional repositories via the ```add-apt-repository``` command.  This is used to add community maintained PPA's--which stand for *personal package archive.*  These are for packages maintained outside of Debians's rigourous package checking standards and 1 to 2 year release window. Hence the cartoon at the beginning of the chapter.  

The package system and architecture is on of the reasons for Debian's long standing existance and credibility.  The packages just work. Ubuntu is a Debian derivative that utilizes this archive of packages.  Reemember that the founder of Ubuntu, Mark Shuttleworth, had been a Debian contributer at one point. Ubuntu builds on top of Debian's 25,000 packages by maintianing additional *downstream* repositories that add additional software and repositories to make up the Ubuntu distribution.  Ubuntu is a little more liberal on including non-free drivers for mainly high-end video cards.  Users can then add additional repositories or PPA's of their own choosing to extend APT functionality and expand that package base.  

Seeing as you may want to access a more recent build of an application that may not be in the standard Debian/Ubuntu distribution or not even submitted to a repository because the version is moving too fast or the maintainer just didn't want to package it up.  For example if you want to install a newer version of the php language on your system, you have to wait for another version of the OS oryou can find the maintaiers repository and add their PPA directly.  That way when you can update in real time with them or even install beta software. The example below will add the php5 latest repository for installation.  

You can manually edit the file ```/etc/apt/sources.list``` as well and enter PPAs manually.  Once a new PPA has been added you need to run ```sudo apt-get update``` so APT can see the new repositories and add them to it's cache.

> __Example Usage:__ 
```
sudo add-apt-repository ppa:ondrej/php5
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install php5
```

The command ```add-apt-repository``` doesn't come standard as part of an Ubuntu distribution  On 12.04 and earlier, install the python-software-properties package: [^109] ```sudo apt-get install python-software-properties```. On 14.04 and later: ```sudo apt-get install software-properties-common```.

> __Example Usage:__ [Gwibber.com](http://gwibber.com/ "Gwibber") is a microblogging aggregation application.  It has a PPA where they release daily or nightly builds of their software.  This is good if you are a developer or beta-tester or a user that needs access to cutting edge feature [^110].  If you were so inclined you can add their repository: ```sudo add-apt-repository ppa:gwibber-daily/ppa``` 

There is also a PPA for Linux-libre.  *"Linux-libre is an operating system kernel and a GNU package that is maintained from modified versions of the Linux kernel. The aim of the project is to remove from the Linux kernel any software that does not include its source code, has its source code obfuscated, or is released under proprietary licenses [^111]. The downside of removing proprietary firmware from the kernel is that it will cause loss of functionality of certain hardware that does not have a free software replacement available. This affects certain sound, video, TV tuner, and network (especially wireless) cards, as well as some other devices. When possible, free software replacement firmware is provided as a substitute, such as the openfwwf for b43, carl9170 and ath9k_htc wireless card drivers."*  

*"The resulting combination of the GNU Operating System and the kernel named Linux is the GNU+Linux operating system, although many (incorrectly) refer to it as "Linux": http://www.gnu.org/gnu/linux-and-gnu.html [^112]"*  

> __Example Usage:__ Let's set our kernel free...  
```
sudo add-apt-repository ppa:linux-libre/ppa
sudo apt-get update
sudo apt-get install linux-libre
sudo apt-get dist-upgrade
```

Here is a list of all the configuration and cache files related to APT and their location:

    * /etc/apt/sources.list: Locations to fetch packages from.
    * /etc/apt/sources.list.d/: Additional source list fragments.
    * /etc/apt/apt.conf: APT configuration file.
    * /etc/apt/apt.conf.d/: APT configuration file fragments.
    * /etc/apt/preferences: version preferences file. This is where you would specify "pinning", i.e. a preference to get certain packages from a separate source or from a different version of a distribution.
    * /var/cache/apt/archives/: storage area for retrieved package files.
    * /var/cache/apt/archives/partial/: storage area for package files in transit.
    * /var/lib/apt/lists/: storage area for state information for each package resource specified in sources.list
    * /var/lib/apt/lists/partial/: storage area for state information in transit.

###   yum  & dnf 


## Compling and Installing source code


### GNC GCC


### GNU Make


### Using Python to Install Python Based Programs



## Automating the Install Answer Process With Preseed and Kickstart  

  All the previous steps took maybe 10 to 15 minutes if you are on a fast machine; which is not bad at all.  But let us say you will be creating multiple virtual machines for research purposes. Or perhaps you will be recreating the same virtual machine many times.  There is a way to automate the install process.  This is called an *answer file* in the Windows world.  For Red Hat based systems this is called *kickstart* and Debian and Ubuntu use a file format called *preseed*.  None of these formats are compatible with each other but there has been some work to get limited kickstart support for Ubuntu.  
    
  [Debian/Ubuntu pressed template](https://help.ubuntu.com/lts/installation-guide/amd64/apb.html "Preseed")
  
  [Kickstart documentation(https://docs.fedoraproject.org/en-US/Fedora/18/html/Installation_Guide/s1-kickstart2-file.html) - it can be generated from scratch or upon a succesful install a default kickstart is located in /root/anaconda-ks.cfg
  
Screen shot showing you need to host the file on the web somewhere or include the file in install media

## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

  Questions go here

### Podcast Questions

 Questions go here

### Lab

 Lab goes here 
 
#### Footnotes
 
[^105]: [https://en.wikipedia.org/wiki/Stuart_Feldman](https://en.wikipedia.org/wiki/Stuart_Feldman)  
  
[^106]: [https://en.wikipedia.org/wiki/Make_(software)](https://en.wikipedia.org/wiki/Make_\(software\))  
  
[^107]: [https://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics](https://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics)  
  
[^108]: [https://wiki.debian.org/Apt](https://wiki.debian.org/Apt)  
  
[^109]: [http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them](http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them)  
  
[^110]: [http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them/40351#40351](http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them/40351#40351)
  
[^111]: [https://en.wikipedia.org/wiki/Linux-libre](https://en.wikipedia.org/wiki/Linux-libre)  
  
[^112]: [https://launchpad.net/~linux-libre/+archive/ubuntu/ppa](https://launchpad.net/~linux-libre/+archive/ubuntu/ppa)  
  
[^113]: [https://wiki.debian.org/RPM](https://wiki.debian.org/RPM)  
  
  
  