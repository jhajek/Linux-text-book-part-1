#Package Managers and Package Installation
![*Always check the package dependencies...*](images/Chapter-Header/Chapter-10/debian_main-2.png "Dependencies")

## Objectives

  * Learn the features of dnf, yum, and apt to install packages and dependencies in Linux
  * Understand the nature of GNU tools gcc and make
  * Understand how to use the Python language interpreter in order to run Python based install scripts
  * Compiling code from source

### Outcomes

  At the conclusion of this chapter you will be able to install packages and manage dependencies through using standard package managers dnf, yum, and apt.  You will also be comfortable compiling software from source using a tar ball and python setup tools.

## Package Managers

  One of the initial claims against using Linux and Unix was that software install was a nightmare.  Software had been distributed in tarballs (\*.tar.gz) that were convenient but lacked any knowledge of system state. So you could compile source code but the code had no idea ahead of time if the proper software libraries were installed in the correct locations or if the proper versions of those libraries were installed. And each additional library had it's own dependencies and those had dependencies too.  You see how this could get ugly quickly.  Initially there was a build system developed by a companion of Thompson and Ritchie's named Stuart Feldman; named ```make```. He was also an author of the first Fortran 77 compiler, and he was part of the original group at Bell Labs that created the Unix operating system. Feldman was the Vice President of Computer Science at IBM Research. He was also Vice President, Engineering, East Coast, at Google for a time [^105].  

  Feldman realized building software was difficult and created the ```make``` build system.  The ```make``` system uses a file named ```makefile``` that includes instructions and ordered steps that can be repeated every time software is built.  This attributes software to be portable across systems (ideally anyway).  ```Make``` is a utility that automatically builds executable programs and libraries from source code by reading files called Makefiles which specify how to derive the target program [^106].  Makefiles have an arcane syntax that not all people enjoy and over the years many people have modified and rewritten their own ```make``` system.  Here is an example:

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

Clear as mud right?  Like many things in the Unix world, the ```makefile``` system has been modified and augmented but still persists as the way software project are built and installed some 30 years later.  By 1988 the GNU project had released their Free Software version of ```make``` called GNU Make or ```gmake```. GNU make is included in all standard Linux distributions and is even required for compiling the Linux Kernel.  There are other versions of ```make``` including the Unix version, ```pmake``` and ```bmake``` on the BSD Unix variants, there is a cross platform build tool called ```cmake``` and even Microsoft has its own build tool that can be used called ```nmake```.

### Package Managers

This style of software installation put a high barrier to who could practically use Unix/Linux.  Linux distributions took to making software installation and distribution easier by introducing something initially called __Package Managers__.  These were meant to eliminate all of the above process by solving two key problems. First it would solve the re-compilation of code and supporting of make and build tools--you technically wouldn't even need any C compiler or build tools installed.  Second package managers would solve the dependency issues by keeping track of the dependency trail and be smart enough to follow that trail before installation.

#### .deb

 The first package manager was __dpkg__ which was created by Matt Welsh, Carl Streeter and Ian Murdock (founder of Debian) in 1994 as a replacement for an earlier primitive package manager.  The program ```dpkg``` is used to install, remove, and provide information about .deb packages.

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

The most important line being the __Depends__ option which controls dependencies and can prevent installation of these conditions cannot be met.  The second component includes the binary or pre-compiled portion of the code.  Usinb ```dpkg``` is a clear step above using tarballs and compiling the code yourself. There are other tools that build on top of dpkg that are recommended to use.   Let's take a look at an example we have done before in chapter 4 where we downloaded a .deb file for the Vivaldi web browser and installed it via the Ubuntu Software Center.  Now let's perform the same action again using the ```dpkg``` command.

> __Example Usage:__  You can download a .deb file from the Vivaldi website here: [https://vivaldi.com/download/](https://vivaldi.com/download/ "Vivaldi.com") Vivaldi is a new browser from the team that brought us Opera browser.  The packages are not available in the Ubuntu or Gnome Software stores but you can download the .deb. file directly and install through dpkg.  If it is previously installed you might have to use the Ubuntu Software Center to remove it and then complete this exercise.  In the command below we will introduce the install command or the ```-i``` flag, which stands for __install__.
```bash
sudo dpkg -i ./vivaldi-beta_1.0.303.52-5_amd64.deb
```

After executing this command you will receive an error message. What is it telling you and why?  (Hint think 3P's from the previous chapter) You will notice that the dpkg foudn that it had a *dependency*, can you locate that *dependency* on [http://packages.ubuntu.com](http://packages.ubuntu.com "packages")?

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
# x.x.-xx is the version that is not the most recent version as deleting that will
# make your system unbootable.
# uname -a will tell you the current kernel version
sudo dpkg --purge linux-image-x.x.x-xx-generic

# soemetimes there are kernel dependencies and this command will fail
# In those cases you can use the command below to remove the old kernel images
# and free space on your /boot partition.

sudo apt-get remove linux-image-x.x.x-xx-generic
```

#### RPM

 A few years after dpkg became standard on the Debian based distros, the Red Hat company created their own package manager out of necessity in 1998 and called it RPM (Originally Red Hat Package Manager - now known as RPM Package Manager.)  Red Hat created their own package manger that is used across those systems that are Fedora or RHEL derivatives.  RPM is also used on IBM's AIX Unix distribution too.  RPM code and FAQ can be found at [http://rpm.opg](http://rpm.org "RPM.org") [^113].

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

Let's try another rpm.  This one is a software called *denyhosts* this is a brute force banning tool that will lock out IP addresses that attempt to brute force connect to your server.  The rpm is located at [http://pkgs.repoforge.com/denyhosts](http://pkgs.repoforge.com/denyhosts "Denyhosts").  You can download the denyhosts-2.6.5-el6.rf.noarch.rpm.  When you run the rpm based installer what happens?  Why?

#### Installers

   As you can see from above package managers were a great step forward in making Linux usable beyond the ranks of Thompson, Ritchie, and Stallman.  But they still don't handle the dependency issue--they don't understand the context of auto-dependecy retrieval.  Various solutions were created but every Linux distro has pretty much settled on two families of Installers--those that match the major families.  Fedora based distros use Yum and now use DNF (as of Fedora 23) and Debian based distros use APT.  

### APT

Apt (for Advanced Package Tool) is a set of core tools inside Debian. Apt makes it possible to:

   *  Install applications
   *  Remove applications
   *  Keep your applications up to date

The APT installer was released in 1998, the same time that RedHat released its package manager (giving Debian a leg up and a few years head-start).  APT was the out growth of a research project called Diety run by the Debian developers.  It was planned to be a large GUI-like project, but it turns out that the APT CLI was implemented with such finesse and simplicity that all GUI plans were dropped.  APT is mentioned as one of the key user based features for Debian based distros and Debian's founder Ian Murdock considers APT to be one of the best contributions of Linux [^108].  APT stands for the Advanced Packaging Toolkit.  APT will interface with *dpkg* and has many similar commands but extends the functionality of dpkg in a critical way.  

APT, which basically resolves dependency problems and retrieves the requested packages, works with dpkg under the hood. The main commands of APT are as follows:

  * ```apt-get update``` -- used to make sure your system is pointed to the latest repository versions. You should always run this before taking any other actions.
  * ```apt-get install``` -- used to install the application of choice
  * ```apt-get remove``` -- used to remove the application of choice
  * ```apt-cache search [pattern]``` -- used to search all your repositories for an app matching the given pattern
  * ```apt-get upgrade``` -- used to perform an upgrade of all current packages that have updates available (note in Yum this is the command update)
  * ```apt-get dist-upgrade``` -- this performs the same as the upgrade but will also update the kernel version and headers as well
  * ```do-release-upgrade``` -- this will update the entire distribution and move it to the next incremental version (Ubuntu 15.04 to 15.10)

#### Repositories

APT relies on the concept of repositories in order to find software and resolve dependencies. For apt, a repository is a directory containing packages along with an index file. This can be specified as a networked or local based location. The Debian project keeps a central repository of over 25,000 software packages ready for download and installation.  This includes ability to add non-free software repositories as well.    You can add additional repositories via the ```add-apt-repository``` command.  This is used to add community maintained PPA's--which stand for *personal package archive.*  These are for packages maintained outside of Debians's rigorous package checking standards and 1 to 2 year release window. Hence the cartoon at the beginning of the chapter.  

The package system and architecture is on of the reasons for Debian's long standing existence and credibility.  The system just works. Ubuntu is a Debian derivative that utilizes this archive of packages.  Remember that the founder of Ubuntu, Mark Shuttleworth, had been a Debian contributer at one point. Ubuntu builds on top of Debian's 25,000 packages by maintaining additional *downstream* repositories that add additional software and repositories to make up the Ubuntu distribution.  Ubuntu is a little more liberal on including non-free drivers for mainly high-end video cards.  Users can then add additional repositories or PPA's of their own choosing to extend APT functionality and expand that package base.  

Seeing as you may want to access a more recent build of an application that may not be in the standard Debian/Ubuntu distribution or not even submitted to a repository because the version is moving too fast or the maintainer just didn't want to package it up.  For example if you want to install a newer version of the php language on your system, you have to wait for another version of the OS or you can find the maintainer's repository and add their PPA directly.  That way when you can update in real time with them or even install beta software. The example below will add the php5 latest repository for installation.  

You can manually edit the file ```/etc/apt/sources.list``` as well and enter PPAs manually.  Once a new PPA has been added you need to run ```sudo apt-get update``` so APT can see the new repositories and add them to it's cache.

> __Example Usage:__
```
sudo add-apt-repository ppa:ondrej/php5
sudo apt-get update
sudo apt-get install php5
```

The command ```add-apt-repository``` doesn't come standard as part of an Ubuntu distribution  On 12.04 and earlier, install the python-software-properties package: [^109] ```sudo apt-get install python-software-properties```. On 14.04 and later: ```sudo apt-get install software-properties-common```.

> __Example Usage:__ The application [gwibber](http://gwibber.com/ "Gwibber") is a microblogging aggregation application.  It has a PPA where they release daily or nightly builds of their software.  This is good if you are a developer or beta-tester or a user that needs access to cutting edge feature [^110].  If you were so inclined you can add their repository: ```sudo add-apt-repository ppa:gwibber-daily/ppa```

There is also a PPA for Linux-libre.  *"Linux-libre is an operating system kernel and a GNU package that is maintained from modified versions of the Linux kernel. The aim of the project is to remove from the Linux kernel any software that does not include its source code, has its source code obfuscated, or is released under proprietary licenses [^111]. The downside of removing proprietary firmware from the kernel is that it will cause loss of functionality of certain hardware that does not have a free software replacement available. This affects certain sound, video, TV tuner, and network (especially wireless) cards, as well as some other devices. When possible, free software replacement firmware is provided as a substitute, such as the openfwwf for b43, carl9170 and ath9k_htc wireless card drivers."*  

*"The resulting combination of the GNU Operating System and the kernel named Linux is the GNU+Linux operating system, although many (incorrectly) refer to it as "Linux": http://www.gnu.org/gnu/linux-and-gnu.html [^112]"*  

> __Example Usage:__ Let's set our kernel free... The full instructions are at this website:  [https://jxself.org/linux-libre/](https://jxself.org/linux-libre/ "LibreLinux")  Once successful reboot your system and/while holding down shift - you should see the menu in the image below appear. Choose *Advanced Options For Ubuntu* and you will see your GNU/Libre kernels.  Try to boot from one.

These are the short steps:

  * You should also fetch and install the GPG key with which the repository is signed:
    + ```wget https://jxself.org/gpg.inc```
  * Then configure the package manager to trust the key:
     + ```sudo apt-key add gpg.inc```
  * To use this repo edit the ```/etc/apt/sources.list``` file on your system and add the line at the bottom:
     + ```deb http://linux-libre.fsfla.org/pub/linux-libre/freesh/ freesh main```
     + ```sudo apt-get update```
     + ```sudo apt-get install linux-libre64```
     + This will install the latest kernel version 4.3.0, may break Ubuntu...
     + ```sudo apt-get install linux-libre64-3.14```   
     + This will install a kernel version closer to what Ubuntu is currently using 3.19.
\newpage

![*Linux-Libre*](images/Chapter-10/linux-libre/kernel-linux-libre.png "libre.png")

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

### yum  & dnf

  Fedora based Linux is in a bit of a transition. It's enterprise products RHEL and CentOS are still using the YUM installer.  Fedora 22 and 23 still have YUM for backward support but have moved to using DNF to handle the installation of packages and dependency resolution.  YUM is suppoprted in Fedora 22 but now deprecated and DNF is the preferred installter, with YUM to be removed down the line. RPM based distros had used a tool called ```up2date``` prior to 2003.  An opensource tool from a distro called Yellow Dog Linux lead to the creation of YUP (Yellow Dog Updater) which was then improved to become YUM (Yellow Dog Updater Modified) by the year 2003 and by 2005 every distro using RPM had moved to YUM.  Yellow Dog Linux was first released in the spring of 1999 for the Apple Macintosh PowerPC-based computers and continues today as a Linux for high-end POWER7 workstations. A successor to YUM is named DNF which somehow stands for *dandified yum*. It was released in Fedora 18 and is quickly becoming the Fedora package manager of choice.  YUM is still available on RHEL adn CentOS but as companies move to the version 7 platform, this will begin to change too. Yum will be eventually replaced by DNF.  Both YUM and DNF use repositories that are maintained by RedHat or CentOS or even their RHEL repos.

  You can find the installed repositories in ```/etc/yum.repos.d```.  Each file listed will contain information about the URL where it retrieves repos.  There is also an ability to set priorities as to which repo is checked first.  As we did in previous chapters, we added RPM repos.  The most famous package for adding additional software is RPMForge, [http://rpmfusion.org/](http://rpmfusion.org/ "RPMForge").  Taken directly from their website, *"RPMFusion ships packages that Fedora and RedHat don't want to ship standard with their distro."* This includes free software as well as non-free software that cannot be shipped due to the GPL nature of Fedora.  

![*Installed Repositories Fedora 22*](images/Chapter-10/yum/etc-yum.png "YUM")

Frodo is the name of a Commodore 64 emulator - a computer that dominated the home market and the video game market in the years before the IBM PC became cheap enough and the Nintendo popped onto the scene. I still own one and have it in my basement, which I used in real life as a kid.  If we try to install it via ```sudo dnf install frodo``` we get this message, why?  

![*Unable to Find a Match*](images/Chapter-10/yum/unable.png "Unable to find a match")

First we want to check if we have the correct RPM name.  We can search through our repos looking for the name by typing the ```sudo dnf search [fF]rodo*``` command.  This will return two results--the package and a related dependency and watch out, RPM also tends to be case-sensitive.

To enable the download the RPMFusion repos for adding additional software of free and non-free type you can type the following commands:

```sudo dnf install \
http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm```
```sudo dnf install \
http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm```

Note for RHEL/CentOS the installation URL is slightly different:
```sudo yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/el/updates/6/i386/rpmfusion-free-release-6-1.noarch.rpm```
```sudo yum install http://download1.rpmfusion.org/nonfree/el/updates/6/i386/rpmfusion-nonfree-release-6-1.noarch.rpm```

If you are using CentOS or RHEL you need to first install the EL-Repo before the RPMFusion, but not for Fedora.  No it isn't Spanish for *"the repo"*, but stands for Enterprise Linux Repo--located at [http://elrepo.org/tiki/tiki-index.php](http://elrepo.org/tiki/tiki-index.php "El-repo").  The ELRepo Project focuses on hardware related packages to enhance your experience with Enterprise Linux. This includes filesystem drivers, graphics drivers, network drivers, sound drivers, webcam and video drivers.  This book will not focus on the RHEL update and RPM repos but I wanted to make you aware of it.  

Once those RPMFusion repos have been added you can now retry the example above and install, Frodo, Denyhosts, and Links.  Unlike Ubuntu and Debian where we need to update the repositories - DNF and YUM will auto handle that.  Now if we type ```sudo dnf install Frodo``` the package will be found and we will be able to install it to see the [Commadore 64](https://en.wikipedia.org/wiki/Commodore_64 "C64") in all its emulated glory.
\newpage

![*C64*](images/Chapter-10/yum/c64.png "C64")  

> __Example Usage:__ You can install additional packages now that you have the RPMFusion repos added.  Try to install links the webbrowser that failed when we tried to install it.  The command is ```sudo dnf install links```.  The command ```sudo dnf remove links``` will uninstall it.  The command ```sudo dnf upgrade``` will upgrade all packages that have updates pending.  You can now use DNF to [upgrade your system](http://fedoraproject.org/wiki/DNF_system_upgrade "upgrade") as well.   These are the series of commands to install the DNF upgrade plugin and then execute the process.

*  ```sudo dnf update --refresh```
*  ```sudo dnf install dnf-plugin-system-upgrade```
*  ```sudo dnf system-upgrade download --releasever=23```
*  ```sudo dnf system-upgrade reboot```

## Compiling and Installing source code

  In addition to packages you may still want to compile software from source.  This way you can take advantage of the latest compiler optimizations and CPU support.  Or compile older versions that have a feature you need that is no longer supported as a package any more.  

  Let's take a look at this link.  This is the Apache webserver version 2.4.x latest source code and instructions for compiling software. [http://httpd.apache.org/docs/current/install.html](http://httpd.apache.org/docs/current/install.html "Apache").  Follow the link and download the source code, extract it and let's go about compiling the software.   The first step is to run the ```./configure``` command.  This script does what is called a sanity check, and checks to make sure your system has the correct tools to build the software--some configure scripts will also check for dependencies.  You may need to install APR and APR-Util via the package manager or via source as instructed.  

### GNC GCC

   The main tool needed is the GNU C compiler or GCC for short.  This was one of the first items that Richard Stallman created in the GNU project and to this day is needed for building the Linux Kernel and is the standard build tool for Free Software.  There are competing software stacks and compilers, as of version 10 the FreeBSD project deprecated GCC and chose the [Clang](https://en.wikipedia.org/wiki/Clang "Clang") project, originally designed by Apple to support [Xcode](https://en.wikipedia.org/wiki/Xcode "Xcode"), instead. Apple abandoned the GCC compiler because of the restrictions placed on it by GPLv3, which is an interesting side effect of GPLv3. The GCC compiler has grown to include other languages over the years as well.  You can install the GCC compiler and all the addiitonal build tools in Debian/Ubuntu by typing: ```sudo apt-get build-essential```.  In Fedora you would add these two commands; ```sudo yum groupinstall 'Development Tools'``` and ```sudo yum groupinstall 'Development Libraries'```.  You can compile code directly by invoking the gcc or ```g++``` command.    

### GNU Make

  As mentioned prior the GNU make command is used to actually compile the C code and all the directives stated in the build file.  That compiled source is then placed into the proper system directories by the ```make install``` command.  This command needs *superuser* privileges to move files to directories not owned by the user, but the ```make``` command doesn't need sudo--resist the temptation! The ```--prefix=``` is the default location where you want to store the compiled apache binaries, it defaults to ```/usr/local```.

```
./configure --prefix=PREFIX  
make  
sudo make install  
```

### Using Python to Install Python Based Programs

  In addition to compiling software and using package managers the Python language has become common in its application usage and has its own installers for applications.  Looking at the Denyhosts project on their Github account, [https://github.com/denyhosts/denyhosts](https://github.com/denyhosts/denyhosts "Denyhosts") you will see the latest source code version 3.0 available but not in an RPM or DEB package but as a python install package.  We simply need to clone the repository down and enter the directory we just cloned.   We can then install the software, similar to the GCC build tools, by executing just this command: ```sudo python setup.py install```.  Note you may need a dependency depending on what system you are on - the installer will tell you what you need in addition to making this work.

## Chapter Conclusions and Review

  In this chapter we learned about the history of software installation and the tools needed to successfully manage Linux packages.  We learned about the standard package installers and package managers and also learned about alternative methods to compile from source and use python based setup-tools installer.  This enables you as a poweruser or system admin to extend the capabilities of your system.  

### Review Questions

Chapter 10 Review Questions

1) How was software initially distributed in Linux--before package managers?
a. APT
b. tarballs
c. RPM
d. dpkg

2) Who created the initial build system we still use today to build Linux software?
a. Ken Thompson
b. Dennis Ritchie
c. Stuart Feldman
d. Richard Stallman

3) What is the name of the tool that uses makefiles to build software?
a. make
b. make install
c. makefile
d. ./configure

4) What is the name of the package format Debian distribution uses?
a. RPM
b. Alien
c. .deb
d. .rpm

5) What is the name of the package format the Fedora/RedHat based distros use?
a. RPM
b. Alien
c. DNF
d. .deb

6) What is the name of the tool used to install .deb files directly on the command line?
a. debpkg -i *.deb
b. dpkg -i *.deb
c. pkg -i *.deb
d. rpm -ivh *.deb

7) What feature doesn't dpkg handle/support?
a. Dependencies
b. Installing Dependencies
c. Versioning
d. Author Information

8) In 1998 RedHat released it's package manager format - what its name?
a. RPM
b. .deb
c. APT
d. DNF

9) What is the name of the Debian Installer tool that works in conjunction with the dpkg package manager?
a. RPM
b. APT
c. DNF
d. YUM

10) What is the APT command that allows you to install a package named apache2?
a. apt-get apache2
b. apt-install apache2
c. apt get install apache2
d. apt-get install apache2

11) What is the APT command to list all packages currently installed on your Ubuntu 15.04 system?
a. dpkglist
b. dpkg -l
c. dpkg
d. pkg --list

12) What is the APT command to add an additional software repository, named: ppa:linux-libre/ppa, to your APT system?
a. sudo add-repository ppa:linux-libre/ppa
b. sudo add-apt-repository ppa:linux-libre/ppa
c. sudo apt-add-repository ppa:linux-libre/ppa
d. sudo apt-add ppa:linux-libre/ppa

13) What is the command to sync your system with the latest package repositories?
a. sudo apt-get upgrade
b. sudo apt-get dist-upgrade
c. sudo apt-get update
d. sudo apt upgrade

14) What is the command to upgrade your Debian based system packages and to the newest kernel version?
a.  sudo apt-upgrade --system
b.  sudo apt-upgrade
c.  sudo apt-get update
d.  sudo apt-get dist-upgrade

15) What is the RPM command to install a package from the command line?
a. rpm -qa *.rpm
b. rpm install *.rpm
c. rpm -q *.rpm
d. rpm -i *.rpm

16) What is the DNF command used to install addtional software repositories? Use this URL to an RPM: http://download1.rpmfusion.org/nonfree/el/updates/6/i386/rpmfusion-nonfree-release-6-1.noarch.rpm
a. sudo dnf install repo http://download1.rpmfusion.org/nonfree/el/updates/6/i386/rpmfusion-nonfree-release-6-1.noarch.rpm
b. sudo dnf http://download1.rpmfusion.org/nonfree/el/updates/6/i386/rpmfusion-nonfree-release-6-1.noarch.rpm
c. sudo dnf install http://download1.rpmfusion.org/nonfree/el/updates/6/i386/rpmfusion-nonfree-release-6-1.noarch.rpm
d. sudo install http://download1.rpmfusion.org/nonfree/el/updates/6/i386/rpmfusion-nonfree-release-6-1.noarch.rpm

17) What is the name of RPM repository that was mentioned in the textbook?
a. RPMFusion
b. Fusion
c. EL-REPO
d. RPM.org


18) What is the command you run first when compiling code from source to run a "sanity check" on your system before you begin compilation?
a. ./config
b. ./configure
c. ./check
d. sudo reboot

19) What is the name of the C compiler that is standard on all Linux systems?
a. Clang
b. CC
c. GCC
d. C++

20) What other language has a build/install system that is simpler than using C and makefiles?
a. Go
b. Php
c. C++
d. Python

### Podcast Questions

Listen to the FLOSS podcast number 88 with [Linus Torvalds - http://twit.tv/show/floss-weekly/88](http://twit.tv/show/floss-weekly/88 "FLOSS Linus Torvald")

  *  ~6:32 Who is Linus Torvalds?
  *  ~6:54 Where did he create Linux?
  *  ~7:30 What did Unix have that other operating systems didn't at that time?
  *  ~10:02 Within a few months of Linux first release roughly how many people were interested in Linux?
  *  ~10:30 About what month and what year did this happen?
  *  ~10:40-13:30 What was the initial inspiration to create the Linux Kernal as an open source project?
  *  ~13:30-14:00 Why was it licensed under the GPL license?
  *  ~20:48 Why didn't Linus want to work for a Linux company?
  *  ~41:00 More than the technology hurdle what else is needed to get into Linux Kernel Development?
  *  ~46:10 What is the way to become a great programmer?
  *  ~51:17 What is Linus' farewell message to the audience?

### Lab

Chapter 10 Lab

__Objectives:__

* Demonstrate usage of Linux package managers
* Demonstrate the use of Linux installers
* Demonstrate knowledge of how to compile code from source
* Demonstrate knowledge to use a python installers
* Demonstrate the ability to upgrade and update a Linux distribution via the commandline

__Outcomes__
  At the conclusion of this lab you will have gained the mastery of installing Linux software packages from the command line in an array of different fashions and tools.

1) On your Ubuntu 15.04 distribution what is the command you would use to install the package chromium-browser with the APT installer?
1) On Fedora 22 what is the command to install the package ```xeyes```?
1) On Fedora 22 what is the command to add the RPMFusion packages for Free and Non-Free?  Execute those commands and install and run the Frodo C64 emulator.  Located here: [http://download1.rpmfusion.org/nonfree/fedora/releases/22/Everything/x86_64/os/repoview/applications.emulators.group.html](http://download1.rpmfusion.org/nonfree/fedora/releases/22/Everything/x86_64/os/repoview/applications.emulators.group.html)
1) On Fedora 22 what is the command to install via DNF the Dropbox client Located Here: [http://download1.rpmfusion.org/nonfree/fedora/releases/22/Everything/x86_64/os/repoview/user_interface.desktops.group.html](http://download1.rpmfusion.org/nonfree/fedora/releases/22/Everything/x86_64/os/repoview/user_interface.desktops.group.html)
1) On Ubuntu 15.04 what would be the command to upgrade all the packages on the system?
1) On Ubuntu 15.04 what would be the command to upgrade the system to release version 15.10?
1) On Ubuntu 15.04/10 what would be the command to add the Linux-libre repository and then upgrade the Kernel to a Free Linux kernel?
1) On Fedora 22 what would be the series of commands to upgrade Fedora 22 to Fedora 23?
1) On Fedora 22 install the necessary build tools, follow the install instruction here: [http://httpd.apache.org/docs/current/install.html](http://httpd.apache.org/docs/current/install.html) and compile and build Apache 2 server, launch a local web-browser and open up http://localhost - what is the message it prints? Note in the documentation where it says /prefix that means the directory where you want to install this version of Apache2, by default it will go to /usr/local.
1) On Fedora 22 clone the Denyhosts repo from: https://github.com/denyhosts/denyhosts  
execute this command: ```git clone https://github.com/denyhosts/denyhosts.git``` Follow the setup instructions and use python to install denyhosts.  Note - install any dependencies that may be noted or implied.
1) On Ubuntu 15.04 add the current PHP5 repo and then install apache2 and php5.  Once finished create a file named info.php containing this code:

```php
<?php

// Show all information, defaults to INFO_ALL
phpinfo();

?>
```

Locate the file in /var/www/html.  Open a web-browser on the local Ubuntu system and navigate to ```http://localhost/info.php``` what is the PHP version listed?

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
