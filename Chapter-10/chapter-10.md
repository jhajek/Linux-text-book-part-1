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
 
### APT

APT was released in 1998, the same time that RedHat released its package manager (giving Debian a leg up and a few years advance).  APT was the out growth of a research project called diety run by Debian developers.  It was planned to be a large GUI like prooject, but it turns out that the CLI implemented with such finese that the GUI portion was dropped.  APT simplifies the installation process. APT is mentioned as one of the key user based features for Debian based distros and Debian's founder Ian Murdock consider's APT to be one of the best contributions of Linux [^108].  APT stands for the Advanced Packagin Toolkit.  APT will interface with dpkg and has many similar commmands but extends the functionality of dpkg.  


    /etc/apt/sources.list: Locations to fetch packages from.
    /etc/apt/sources.list.d/: Additional source list fragments.
    /etc/apt/apt.conf: APT configuration file.
    /etc/apt/apt.conf.d/: APT configuration file fragments.
    /etc/apt/preferences: version preferences file. This is where you would specify "pinning", i.e. a preference to get certain packages from a separate source or from a different version of a distribution.
    /var/cache/apt/archives/: storage area for retrieved package files.
    /var/cache/apt/archives/partial/: storage area for package files in transit.
    /var/lib/apt/lists/: storage area for state information for each package resource specified in sources.list
    /var/lib/apt/lists/partial/: storage area for state information in transit.


APT relies on the concept of repositories in order to find software and resolve dependencies. For apt, a repository is a directory containing packages along with an index file. This can be specified as a networked or CDROM location. The Debian project keeps a central repository of over 25,000 software packages ready for download and installation.  This includes ability to add non-free software repositories as well.    You can add additionla repositories via the ```add-apt-repository``` command.  This is used to add community maintained PPA's stand for *personal package archive*  these are for packages maintained outside of Debians's rigourous package checking and standards maintaining. (hence the cartoon at the beginning of the chapter).  Ubuntu is a debian derivatie and utilizes thsi was archive of packages and is one of the reawsons for Debian's long standing usage.  Ubuntu maintians additional d*downstram* repositories that add additional software and repositories to maek up the Ubuntu distrivbution.  User's can then add additional repositories or PPA's to extend APT functionality.  Seeing as you may want to access a more recent build of an application that may not be in the standard Debian distribution or not even submitted to a repository becaus ethe version is moving too fast.  For example if you want to install a newer version of the php language on your system, you have to wait for another version of the OS oryou can find the maintaiers repository and add their PPA directly.  That way when you can update in real time with them or even install berta software. The example belwo will add the php5 repository and let you move to the latest.  

> __Example Usage:__ 

sudo add-apt-repository ppa:ondrej/php5
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install php5



    On 12.04 and earlier, install the python-software-properties package:

```sudo apt-get install python-software-properties```

    On 14.04 and later:

    sudo apt-get install software-properties-common





Any number of additional repositories can be added to APT's sources.list configuration file (/etc/apt/sources.list) and then be queried by APT. Graphical front-ends often allow modifying sources.list more simply (apt-setup). Once a package repository has been specified (like during the system installation), packages in that repository can be installed without specifying a source and will be kept up-to-date automatically.

In addition to network repositories, compact discs and other storage media (USB keydrive, hard disks...) can be used as well, using apt-cdrom[16] or adding file:/[17] to the source list file. Apt-cdrom can specify a different folder than a cd-rom, using the -d option (i.e. a hard disk or a USB keydrive). The Debian CDs available for download contain Debian repositories. This allows non-networked machines to be upgraded. Also one can use apt-zip.

Problems may appear when several sources offer the same package(s). Systems that have such possibly conflicting sources can use APT pinning to control which sources should be preferred.

 

Apt (for Advanced Package Tool) is a set of core tools inside Debian. Apt makes it possible to: 
  
   *  Install applications 
   *  Remove applications 
   *  Keep your applications up to date 

Apt, which basically resolves dependency problems and retrieves the requested packages, works with dpkg, another tool, which handles the actual installation and removal of packages (applications). Apt is very powerful, and is primarily used on the command line (console/terminal).   THe main commands of APT are as follows:

  * apt-get install 
  * apt-get remove
  * apt-cache search pattern
  * apt-get update
  * apt-get upgrade
  * apt-get dist-upgrade
  * do-release-upgrade

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
  
  