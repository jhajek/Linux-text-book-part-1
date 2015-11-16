# Init Services, Daemons, and Processes
![*You never know what is enabled...*](images/Chapter-Header/Chapter-11/security_holes-2.png "Security Holes")

__Chapter 11 Objectives__

  * Undertand the traditional SysVinit system
  * Understand the new systemd init system
  * Understand the nature of starting, stopping, and service reporting
  * Understand how to use system tools to examine processes
  * Understand the nature of the /proc virtual-filesystem
  * Understand process tracing

__Outcomes__

  At the outcome of this chapter you will have an understanding of how the traditional init system and the new systemd init system comparatively work.  You will understand how to examine, start, and stop services in both arenas.  You will learn about the /proc virtual-filestystem and how it represents running processes as files.  Finally you will be able to use system tools like ```ps``` and ```kill``` to examine and manage system processes.

## Init Systems and Services

  When you hit the power button, after a short pause, your system begins to whir to life.  Fans spinning and a short POST *beep* sound tells you are on your way.  The next thing you see is some messages flash accross the screen, a logo perhaps, some spinning icons, and then the login screen comes to life.  Collectively this is called the *boot* process.  We are interested in the last part--when the operating system is loaded from disk into memory and the init process begins to start launching the components of our operating system.  Before we dive into that part, let's review what goes on before hand.
  
  This boot order will assume that you are booting a [BIOS](https://en.wikipedia.org/wiki/BIOS "BIOS") based system and not a [UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface#Platforms_using_EFI.2FUEFI "UEFI") system, but the overarching priciples are still the same.  When the BIOS boots and succesfully receives a postive result from the POST test, which will be a short *beep* there are hardcoded basic I/O device drivers that are loaded into memory to allow the computer to complete basic I/O functions, display information, and read from a hard disk.  Immediately the system loads the MBR-Master Boot Record, which is the first sector of the first identified bootable device.  This is usually your hard drivem, but could be a flash drive, SD Card, or even a good old fashioned CD-ROM.  The Master Boot Record points to the the VBR or Volume Boot Record.  
  
  In modern Linux the VBR is controlled by [GNU GRUB](https://www.gnu.org/software/grub/ "GNU GRUB").  *"Briefly, a boot loader is the first software program that runs when a computer starts. It is responsible for loading and transferring control to the operating system kernel software (such as the Hurd or Linux). The kernel, in turn, initializes the rest of the operating system (e.g. GNU)."* [^114]   

  GNU GRUB superceded what is now called legacy GRUB (version 0.9x) and begins with version 2 to separate the different tools--though they are both called GRUB.  We will only talk here about GRUB 2 or GNU GRUB when referring to GRUB.   GRUB itself has 3 stages in order to get you to stage two which is the loading of your Linux Kernel from disk into memory.  Stage 1 detects and finds the locations of and discovers various file systems on disk for loading at a later time.  Once this is accomplished GRUB loads stage 1.5 and passes control to it.  GRUB 1.5 will load file system drivers that are seperate from the Operating System so the file ```/boot/grub/grub.conf``` can be read.  This file contains details about the path to various kernels for loading and various system configurations.  Once complete stage 2 is loaded and control is passed.  This is where you get the nice TUI (Terminal User Interface screen) allowing you to choose which kernel and any features you want to enable/disable per this boot.
  
![*Terminal User Interface*](images/Chapter-11/GRUB/tui-large.png "TUI")
  
  By default this User Interface will pop up if you have more than one operating system or kernel version installed in the case of Fedora.  If you have a single operating system this screen will be skipped by default, you can hold down the SHIFT key at boot and force this screen to come up.  In the case of Ubuntu you can select ADVANCED to see different kernel versions you can load.
  
![*Terminal User Interface Advanced*](images/Chapter-11/GRUB/tui-advanced.png "TUI Advanced")
  
  Once we select a kernel version, GRUB knows where to go to find that file, read it into memory, decompress it. All kernel images are located in ```/boot``` and your GRUB 2 configuration file knows this.  
  
![*Contents of /boot*](images/Chapter-11/GRUB/slash-boot.png "/boot")

You will notice that there is a vmlinuz kernel image per each instance that corresponds to the TUI entries in the previous image.   The file that is loaded first is actually the ```initrd.img-X.XX.X-XX``` file.  This is the pre-kernel which contains all the drivers neccesary for the kernel to use before the root filesystem has been mounted.  The initrd file is gzip compressed and is decompressed on each boot.  Once the initrd temporary filesystem is loaded, with its own /etc and own /bin, the vmlinuz.* file which is the actual kernel is now loaded into memory and begins to unmount and remove the initrd from memory as it is no longer needed.  

### SysVinit

  Here is where the boot process begins to splinter.  I am going to describe the Unix System V init process - that was the basis of all Unix and Linux knowledge since the early 1980s.  This is referred to as sysvinit--note that only the Unix based derivaties of BSD use this--Debian recently dropped it, with Fedora and Ubuntu abandoning it in the middle of last decade.
  
  Now that the kernel has complete control of the hardware, it begins to execute the "guts" of the operating system--by setting up the system processes.  The first task it executes is ```/sbin/init```.  This is referred to as the init process.  It's job is only to be the ancestor of all other processes and start each succeeding service--starting from the X server, to the login server, to any GUI, to a webserver or database.  The ```/sbin/init/``` looks at the value stored in ```/etc/inittab``` to find the system __run level__.  Run level tells us which mode to start in and which associated services are needed.  These levels are general and each Linux distro modified them as needed, but in general are consistent.
  
: Traditional Run Levels

   Level                Operation
-----------  ------------------------------------
   0             System Halt/Shut Down 
   1              Single User Mode 
   2         Multiuser Mode Without Networking 
   3              Full Multiuser Mode 
   4                    Unused 
   5                    GUI/X11 
   6                    Reboot 
-----------  ------------------------------------

  Once the run level is determined, there is a directory called ```/etc/rc.d``` which contains what are called __run level specific__ programs to be executed.  Files preceeded by an *S* mean to start the service, and files preceeded by a *K* mean to kill that service. Each K or S file is followed by a number which also indicated priority order--lowest is first. The good thing is that each K or S file is nothing more than a bash script to start or kill a service and do a bit of environment prepartation.  As you can see this system has some flaws.  There is no way to start services in parallel, its all sequential, which is a waste on today's modern multi-core CPUs.  Also there is no way for services that start later that depend on a previous service to be started to understand its own state.  The service will happily start itself without its dependencies and go right off a cliff [^115].
  
![*Classic sysvinit RC files on Ubuntu 14.04*](images/Chapter-11/sysvinit/rc-d.png "rc.d")
  
### Upstart

  In 2006 the Ubuntu distro realized the short comings of sysvinit and created a compatible replacement called ```upstart```.  Upstart moved all the traditional runlevels and start up scripts to ```/etc/init``` directory and placed the scripts in configuration files. Here is an example myservice.conf file stored in ```/etc/init/myservice.conf```:  Note the use of the __run level__ concept from sysvinti.
  
```bash
 myservice - myservice job file

description "my service description"
author "Me <myself@i.com>"

# Stanzas
#
# Stanzas control when and how a process is started and stopped
# See a list of stanzas here: http://upstart.ubuntu.com/wiki/Stanzas#respawn

# When to start the service
start on runlevel [2345]

# When to stop the service
stop on runlevel [016]

# Automatically restart process if crashed
respawn

# Essentially lets upstart know the process will detach itself to the background
expect fork

# Run before process
pre-start script
    [ -d /var/run/myservice ] || mkdir -p /var/run/myservice
    echo "Put bash code here"
end script

# Start the process
exec myprocess
```

  Ubuntu adopted Upstart in 2006, Fedora adopted it as a sysvinit supplimental replacement in Fedora 9 - unitl version 18 when systemd was ready.  RHEL and CentOS use Upstart as well as Chrome OS.  Debian considered using Upstart when Debian 8 was being developed but instead decided to jump entirely to systemd instead. When Debian made the jump, this forced Ubuntu, which is a Debian derived distribution, to abandon work on Upstart and switch to systemd as their init system--though they fought until the bitter end.  Upstart was seen as the compromise between sysvinit and its failings but in the end systemd won out.  Mac OSX uses their own version called [launchd](https://en.wikipedia.org/wiki/Launchd "launchd") and Sun/Oracle Solaris uses [SMF](https://en.wikipedia.org/wiki/Service_Management_Facility "SMF") which are similar to Upstart in concept but have OS specific extensions.

### Systemd

  Systemd was the alternative decision to sysvinit and Upstart that had been developed by Lennart Poettering while at RedHat.  From his own website, *"systemd is a suite of basic building blocks for a Linux system. It provides a system and service manager that runs as PID 1 and starts the rest of the system. [^117]"*   Unlike the sysvinit/Upstart method which has an ancestor be PID 1 (process ID 1), systemd become the PID 1.  Systemd includes many other items, 69 different binaries all roled into PID 1.  The init process *IS* the system and the process manager, if PID 1 dies, then your system dies too.
 
![*systemd service chart*](images/Chapter-11/systemd/systemd.png "systemd") 
 
> *One goal of systemd is to unify the dispersed Linux landscape a bit. We try to get rid of many of the more pointless differences of the various distributions in various areas of the core OS. As part of that we sometimes adopt schemes that were previously used by only one of the distributions and push it to a level where it's the default of systemd, trying to gently push everybody towards the same set of basic configuration. This is never exclusive though, distributions can continue to deviate from that if they wish, however, if they end-up using the well-supported default their work becomes much easier and they might gain a feature or two. Now, as it turns out, more frequently than not we actually adopted schemes that where Debianisms, rather than Fedoraisms/Redhatisms as best supported scheme by systemd. For example, systems running systemd now generally store their hostname in /etc/hostname, something that used to be specific to Debian and now is used across distributions. [^116]*

  One of the main differences between traditional Upstart/sysvinit based Linux is that systemd doesn't have __run levels__.  The command ```init 3``` was always start at the commandline, and ```init 5``` was GUI.  Systemd introduces __targets__ in their place.  Target's are supposed to be more flexible in what they can load and how they are loaded as opposed to the values of the ```/etc/inittab``` [^118]. 
  
SysVinit level                 systemd target               Function
---------------- ------------------------------------- -------------------------
     0            runlevel0.target, poweroff.target     Shuts down the system
     1            runlevel1.target, rescue.target       singleuser rescue mode
     2,3,4        runlevelX.target, multi-user.target   multi-user text-mode
     5            runlevel5.target, graphical.target    multi-user GUI mode
     6            runlevel6.target, reboot.target       reboots
                  emergency.target                      Emergency shell
---------------- ------------------------------------- -------------------------  

You can use the command  ```systemctl``` to list all running services and to issue them commands.  If you wanted to change to a graphical mode directly from your GUI mode you would issue ```systemctl isolate graphical.target``` effectively changing run levels or targets.  You can change the default target by issuing this command: ```systemctl set-default <name of target>.target```  ```systemctl get-default``` will print out your current default target. 

## Processes and Services

  Whenever you start a process in Linux, whether that is a service, or something as simple as run a command in terminal or open a new web-browser tab, that creates a system process.  Each process gets an ID so that it can be accessed or referenced.  Each process in turn has a PPID--Parent Process ID, which tells you which other process launched that process.  In traditional sysvinit ```/sbin/init``` launches each additional service.  In systemd it is not quite that clear. In addition to a process--which can be short lived or long lived, there are services--which can be helper items such as the login and authtication service or something focus such as an apache2 web-server.   
  
### Working With Services  
  
    Under the Upstart methodology you can simply start services and stop them with the ```service``` command.  The syntax is ```sudo service <service-name> start | stop | restart | status```.  This would act upon the apporpriate shell script to perform the appropraite action.  Why would you need to restart a user run service?  Remember that everything in Linux is configured with text files.  At initial load the textfiles information is parsed and placed in memeory.  If you change a value, you need to reload that configuration file into memory, and restarting a service does just that for instance.  The ```service``` commands are still in place but since Ubuntu 15.04 and Fedora 20 they are just symlinks to the systemd command and control ```systemctl```. 
    
> __Example Usage:__  On an Ubuntu system to restart your apache2 webserver your would type: ```sudo service apache2 restart``` (assuming you had apache2 already installed).

> __Example Usage:__ On sysvinit systems (pre-Ubuntu 6.10) you would type the absolute path to the directory where the init script was located.  In this case perhaps ```/etc/init.d/apache2 restart```

> __Example Usage:__ On a systemd based system, service control is done with ```systemctl <command> <name>.service```.  In the case of Apache2 webserver the command to restart it would look like this:  ```sudo systemctl restart httpd.service```

> __Example Usage:__ The ```systemctl``` command has additional abilities.  It absorbed the ```chkconfig``` command, which was/is used to set services to autostart at boot time.  In Fedora installed services do not automatically start at boot time, you must explicitly add them.  You can check the status of the httpd service by issuing: ```sudo systemctl is-enabled httpd.service```.  Issue that command and what does it report?

> __Example Usage:__ To disable a service at boot type: ```sudo systemctl disable httpd.service``` and *enable* does the opposite.  The *status* option will tell you what is the current status, start or stopped.

### ps

  The ```ps``` command displays information about a selection of the active processes. This is different from the ```top``` command as the information is not updated but just displayed.  The ```ps``` command by itself shows very little useful information.  
  

### kill

### nice

    
## proc

  Get from tldp   and screen shot from Linux
  
 * lspci 
 * lsmod

## strace/dtrace

## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

 Questions go here

### Podcast Questions

 Questions go here

### Lab

 Lab goes here 
 
#### Footnotes

[^114]: [https://www.gnu.org/software/grub/](https://www.gnu.org/software/grub/) 
 
[^115]: [http://www.slashroot.in/linux-booting-process-step-step-tutorial-understanding-linux-boot-sequence](http://www.slashroot.in/linux-booting-process-step-step-tutorial-understanding-linux-boot-sequence) 
 
[^116]: [http://0pointer.de/blog/projects/the-biggest-myths](http://0pointer.de/blog/projects/the-biggest-myths) 
 
[^117]: [http://www.freedesktop.org/wiki/Software/systemd/](http://www.freedesktop.org/wiki/Software/systemd/)

[^118]: [http://fedoraproject.org/wiki/Systemd](http://fedoraproject.org/wiki/Systemd)

