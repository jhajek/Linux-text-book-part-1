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

The most important being the __Depends__ option which controls dependencies and can prevent installation of these conditions cannot be met.  The second component includes the binary or pre-cimpiled portion of the code.  
You can install a package directly through dpkg but their are other tools that build on top of dpkg that are recommended to use.   

You can download a .deb file from the Vivaldi website here: [https://vivaldi.com/download/](https://vivaldi.com/download/ "Vivaldi.com") Vivaldi is a new browser from the team that brought us Opera browser.  The packages are not available in the Ubuntu or Gnome Software stores but you can download the .deb. file directly and install through dpkg.  

> __Example Usage:__
```bash
sudo dpkg -i ./vivaldi-package name
```
You will notice an error message here - what is it any why?  (Hint think 3P's from the previous chapter)

> __Example Usage:__ 
```bash
sudo dpkg -l ./links_2.8-2_amd64.deb
```
Note that this command installs properly without any error message.  GET LINKS DEB URL

> __Example Usage:__ 
sudo dpkg -r or --remove
sudo dpkg -P or --purge
sudo dpkg -l or --list
dpkg --status links


dpkg -l | grep linux-image


sudo apt-get purge linux-image-x.x.x-xx-generic

#### RPM
The same concepts and direction was created by the Red Hat company and called RPM (Originally Red Hat Package Manager - now know as RPM Package Manager.)  Red Hat created their own package manger that is used accross those systems that are Fedora or RHEL derivatives.  RPM is also used on IBM's AIX Unix distribution too.  RPM code and FAQ can be found at [http://rpm.opg](http://rpm.org "RPM.org") RPM was released first in 1998 as a consolidation of previous package managers.

List all installed packages:
    rpm -qa


List information about an installed package:
    rpm -qi pkgname

Install a package from a local file
    rpm -i file.rpm

Remove a package from the system
    rpm -e pkgname              (saves copies of modified config files)

Get information about a remote package
    rpm -qpi <url>


https://wiki.debian.org/RPM

#### Installers 
 
   Package Managers were a great step forward in making Linux usable beyond the ranks of Thompson, Ritchie, and Stallman.  But as shown in the example above, they still don't handle the dependency issue--as they don't understand the context of auto-dependecy retrieval.  Various solutions were created but every Linux distro has pretty much settled on two families of Installers--that match the major families.  Fedora based distros use Yum and now use DNF (as of Fedora 23) and Debian based distros use APT.  
 
### apt 

APT was released in 1998, the same time that RedHat released its package manager (giving Devian a leg up and a few year advance).  APT simplifies the installation process. Something we have seen through out this book, handling not only dependencies but also the resolution of dependencies and the installation of them as well.  APT will never leave you hanging in that sense.  APT is mentioned as one of the key user based features for Debian based distros and Debian's founder Ian Murdock consider's APT to be one of the best contributions of Linux.  

https://wiki.debian.org/Apt

Apt (for Advanced Package Tool) is a set of core tools inside Debian. Apt makes it possible to: 
•Install applications 
•Remove applications 
•Keep your applications up to date 

Apt, which basically resolves dependency problems and retrieves the requested packages, works with dpkg, another tool, which handles the actual installation and removal of packages (applications). Apt is very powerful, and is primarily used on the command line (console/terminal). 


Others aptitude 

apt-get install 
apt-get remove
apt-cache search pattern
apt-get update
apt-get upgrade
apt-get dist-upgrade
sudo do-release-upgrade

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
  