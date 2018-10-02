# Init Services, Daemons, and Processes
![*You never know what is enabled...*](images/Chapter-Header/Chapter-10/security_holes-2.png "Security Holes")

### Objectives

  * Understand the traditional SysVinit system and its relationship to starting system processes
  * Understand the new systemd init system
  * Understand the nature of starting, stopping, and service reporting
  * Understand how to use system tools to examine processes
  * Understand the nature of the /proc virtual-filesystem

### Outcomes

  At the outcome of this chapter you will have an understanding of how the traditional init system and the new systemd init system comparatively work.  You will understand how to examine, start, and stop services in both arenas.  You will learn about the ```/proc``` virtual-filesystem and how it represents running processes as files.  Finally you will be able to use system tools like ```ps``` and ```kill``` to examine and manage system processes.

## Init Systems and Services

  When you hit the power button, after a short pause, your system begins to whir to life.  Fans spinning and a short POST *beep* sound tells you are on your way.  The next thing you see is some messages flash across the screen, a logo perhaps, some spinning icons, and then the login screen comes to life.  Collectively this is called the *boot* process.  We are interested in the last part--when the operating system is loaded from disk into memory and the init process begins to start launching the components of our operating system.  Before we dive into that part, let's review what goes on before hand.

  This boot order will assume that you are booting a [BIOS](https://en.wikipedia.org/wiki/BIOS "BIOS") based system and not a [UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface#Platforms_using_EFI.2FUEFI "UEFI") system, but the overarching principles are still the same.  When the BIOS boots and successfully receives a positive result from the POST test, which will be a short *beep* there are hard coded basic I/O device drivers that are loaded into memory to allow the computer to complete basic I/O functions, display information, and read from a hard disk.  Immediately the system loads the MBR-Master Boot Record, which is the first sector of the first identified bootable device.  This is usually your hard drive but could be a flash drive, SD Card, or even a good old fashioned CD-ROM.  The Master Boot Record points to the VBR or Volume Boot Record.  

  In modern Linux the VBR is controlled by [GNU GRUB](https://www.gnu.org/software/grub/ "GNU GRUB").  *"Briefly, a boot loader is the first software program that runs when a computer starts. It is responsible for loading and transferring control to the operating system kernel software (such as the Hurd or Linux). The kernel, in turn, initializes the rest of the operating system (e.g. GNU)."* [^114]   

  GNU GRUB superseded what is now called legacy GRUB (version 0.9x) and begins with version 2 to separate the different tools--though they are both called GRUB.  We will only talk here about GRUB 2 or GNU GRUB when referring to GRUB. GRUB itself has 3 stages in order to get you to stage two which is the loading of your Linux Kernel from disk into memory.  Stage 1 detects and finds the locations of and discovers various file systems on disk for loading at a later time.  Once this is accomplished GRUB loads stage 1.5 and passes control to it.  GRUB 1.5 will load file system drivers that are separate from the Operating System so the file ```/boot/grub/grub.cfg``` can be read, Fedora stores its grub configuration at ```/boot/grub2/grub.cfg```.  This file contains details about the path to various kernels for loading and various system configurations.  Once complete stage 2 is loaded and control is passed.  This is where you get the nice TUI (Terminal User Interface screen) allowing you to choose which kernel and any features you want to enable/disable per this boot.

![*Terminal User Interface*](images/Chapter-10/GRUB/tui-large.png "TUI")

  By default this User Interface will pop up if you have more than one operating system or kernel version installed in the case of Fedora.  If you have a single operating system this screen will be skipped by default, you can hold down the SHIFT key at boot and force this screen to come up.  In the case of Ubuntu you can select ADVANCED to see different kernel versions you can load.

  Once we select a kernel version, GRUB knows where to go to find that file, read it into memory, decompress it. All kernel images are located in ```/boot``` and your GRUB 2 configuration file knows this.  
\newpage

![*Terminal User Interface Advanced*](images/Chapter-10/GRUB/tui-advanced.png "TUI Advanced")  

![*Contents of /boot*](images/Chapter-10/GRUB/slash-boot.png "/boot")

You will notice that there is a vmlinuz kernel image per each instance that corresponds to the TUI entries in the previous image.   The file that is loaded first is actually the ```initrd.img-X.XX.X-XX``` file.  This is the pre-kernel which contains all the drivers necessary for the kernel to use before the root filesystem has been mounted.  The *initrd* file is gzip compressed and is decompressed on each boot.  Once the *initrd* temporary filesystem is loaded, with its own /etc and own /bin, the *vmlinuz* file which is the actual kernel is now loaded into memory and begins to un-mount and remove the *initrd* from memory as it is no longer needed.  

### GRUB

 The GRUB 2 or GNU GRUB bootloader exists in the file ```/boot/grub/grub.cfg``` but this file is auto generated so to edit the settings you would modify the ```/etc/default/grub``` file.  
 The ```/etc/default/grub``` file contains various key, value pairs defining default kernel parameters to be passed to GRUB.

 GRUB_DEFAULT=N  -- this value is which entry in your GRUB list is the default operating system to boot.  If you have a single OS installed, this value will be 0.  

 GRUB_TIMEOUT -- this is the setting that tells the system to boot the default command N seconds after the GRUB menu has appeared.  It functions as a countdown.  

 GRUB_TIMEOUT_STYLE -- this will let the count down appear or silently countdown.  

 GRUB_CMDLINE_LINUX_DEFAULT -- this value adds additional key value pairs to the kernel boot parameters.  A common setting here is to change the setting of *splash quiet* which hides and boot time kernel message behind the Ubuntu logo and instead displays them on the screen.  

 GRUB_DISABLE_LINUX_RECOVERY -- this hides the single user/recovery mode from the GRUB menu per kernel entry

 GRUB_GFXMODE=640x480 -- this setting is commented out by default, but you can enable this to hard code a certain boot resolution.

 GRUB_BACKGROUND -- this option lets you *theme* your GRUB menu by adding a background image.

To make these changes permanent you need to execute the ```sudo update-grub``` command after saving the file so the ```/boot/grub/grub.cfg``` will be regenerated and used on the next boot.

### SysVinit

I am going to describe the Unix System V init process - that was the basis of all Unix and Linux knowledge since the early 1980s.  This is referred to as SysVinit--note that only the Unix based derivatives of BSD use this--Debian recently dropped it, with Fedora and Ubuntu abandoning circa 2015.  This is not in use anymore in Linux as we learned in Chapter 2 but we shall go over it for completeness sake.

Now that the kernel has complete control of the hardware, it begins to execute the "guts" of the operating system--by setting up the system processes.  The first task it executes is ```/sbin/init```.  This is referred to as the init process.  It's job is only to be the ancestor of all other processes and start each succeeding service--starting from the X server, to the login server, to any GUI, to a webserver or database.  The ```/sbin/init/``` looks at the value stored in ```/etc/inittab``` to find the system __run level__.  The **run level** tells us which mode to start in and which associated services are needed.  These levels are general and each Linux distro modifies them as needed.  The default run level for a GUI based distro is **5**. The default run level for a server based OS is **3**.

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

Once the run level is determined, there is a directory called ```/etc/rc.d``` which contains what are called __run level specific__ programs to be executed.  Files preceded by an *S* mean to start the service, and files preceded by a *K* mean to kill that service. Each K or S file is followed by a number which also indicated priority order--lowest is first. The good thing is that each K or S file is nothing more than a bash script to start or kill a service and do a bit of environment preparation.  As you can see this system has some flaws.  There is no way to start services in parallel, its all sequential, which is a waste on today's modern multi-core CPUs.  Also there is no way for services that start later that depend on a previous service to be started to understand its own state.  The service will happily start itself without its dependencies and go right off a cliff [^115].
\newpage

![*Classic SysVinit RC files on Ubuntu 14.04*](images/Chapter-10/sysvinit/rc-d.png "rc.d")

### Upstart

In 2006 the Ubuntu distro realized the short comings of SysVinit and created a compatible replacement called ```upstart```.  Upstart moved all the traditional runlevels and start up scripts to ```/etc/init``` directory and placed the scripts in configuration files. While leaving the ```/etc/rc.d``` structure in place for any backward compatible needing scripts. Here is an example of a *myservice.conf* upstart file stored in ```/etc/init/myservice.conf```:  Note the use of the __run level__ concept from SysVinit.  Compare this to (on an Ubuntu system) the contents of any script in ```/etc/rc3.d``` (run level 3).  Upstart exhibits a bit more process control but still being a shell script when you boil it down.

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

Ubuntu adopted Upstart in 2006, Fedora adopted it as a SysVinit supplemental replacement in Fedora 9 - until version 18 when systemd was ready.  RHEL and CentOS used Upstart as well until RHEL 7, and ChromeOS still does (OS for Chromebooks).  Debian considered using Upstart when Debian 8 was being developed but instead decided to jump entirely to systemd instead. When Debian made the jump, this forced Ubuntu, which is a Debian derived distribution, to abandon work on Upstart and switch to systemd as their init system--though they fought until the bitter end.  Upstart was seen as the compromise between SysVinit and its failings but in the end systemd won out.  MacOS uses their own version called [launchd](https://en.wikipedia.org/wiki/Launchd "launchd") and Sun/Oracle Solaris and Illumos/SmartOS use [SMF](https://en.wikipedia.org/wiki/Service_Management_Facility "SMF") which are similar to Upstart in concept but have OS specific extensions.

### Systemd and Systemctl

![*The architecture of systemd as it is used by Tizen. Several components, including telephony, bootmode, dlog and tizen service, are from Tizen and are not components of systemd.*](images/Chapter-10/systemd/systemd.png "systemd")

Systemd was the alternative decision to SysVinit/Upstart that had been developed by Lennart Poettering while at RedHat. It's main goal is to unify basic Linux configurations and service behaviors across all distributions.  Systemd is licensed under the LGPL 2.1 or later, [GNU Lesser General Public License](https://en.wikipedia.org/wiki/GNU_Lesser_General_Public_License "LGPL").  

From Lennart's own website, *"systemd is a suite of basic building blocks for a Linux system. It provides a system and service manager that runs as PID 1 and starts the rest of the system. [^117]"*   Unlike the SysVinit/Upstart method which has an ancestor process in PID 1 (process ID 1), now systemd becomes the PID 1. The init process *IS* the system and the process manager, if PID 1 dies, then your system dies too. Systemd includes many other items, 69 different binaries all rolled into PID 1.    

> *"As an integrated software suite, systemd replaces the startup sequences and runlevels controlled by the traditional init daemon, along with the shell scripts executed under its control. systemd also integrates many other services that are common on Linux systems by handling user logins, the system console, device hotplugging (see udev), scheduled execution (replacing cron), logging, hostnames and locales. [^121]"*

> *One goal of systemd is to unify the dispersed Linux landscape a bit. We try to get rid of many of the more pointless differences of the various distributions in various areas of the core OS. As part of that we sometimes adopt schemes that were previously used by only one of the distributions and push it to a level where it's the default of systemd, trying to gently push everybody towards the same set of basic configuration. This is never exclusive though, distributions can continue to deviate from that if they wish, however, if they end-up using the well-supported default their work becomes much easier and they might gain a feature or two. Now, as it turns out, more frequently than not we actually adopted schemes that where Debianisms, rather than Fedoraisms/Redhatisms as best supported scheme by systemd. For example, systems running systemd now generally store their hostname in /etc/hostname, something that used to be specific to Debian and now is used across distributions. [^116]*

One of the main differences between traditional Upstart/SysVinit based Linux is that systemd doesn't have __run levels__.  The command ```init 3``` was always start at the commandline, and ```init 5``` was GUI.  Systemd introduces __targets__ in their place.  Targets are supposed to be more flexible in what they can load and how they are loaded as opposed to the values of the ```/etc/inittab``` [^118].

   Run Level              systemd target               Function
---------------- ------------------------------------- -------------------------
     0            runlevel0.target, poweroff.target     Shuts down the system
     1            runlevel1.target, rescue.target       singleuser rescue mode
     2,3,4        runlevelX.target, multi-user.target   multi-user text-mode
     5            runlevel5.target, graphical.target    multi-user GUI mode
     6            runlevel6.target, reboot.target       reboots
                  emergency.target                      Emergency shell
---------------- ------------------------------------- -------------------------  

You can use the command  ```systemctl``` to list all running services and to issue them commands.  If you wanted to change to a graphical mode directly from your GUI mode you would issue ```systemctl isolate graphical.target``` effectively changing run levels or targets.  You can change the default target by issuing this command: ```systemctl set-default <name of target>.target```  ```systemctl get-default``` will print out your current default target.

> **Exercise:**  Run the ```systemctl get-default``` command, what is the output?

## Processes and Services

Whenever you start a program in Linux, whether that is a service, or something as simple as run a command in the terminal or open a new web-browser tab, that creates a system process.  Each process gets an ID so that it can be accessed or referenced and is assigned memory space and CPU affinity (priority).  In addition to a process--which can be short lived or long lived, there are services--which can be helper items such as the login and authentication service or something focused such as an apache2 web-server. Each process in turn has a PPID--Parent Process ID, which tells you which other process launched that process.  In traditional SysVinit ```/sbin/init``` launches each additional service.  In systemd, instead of having PPIDs and PIDs, you have the concept of cgroups and processes grouped together.

### Working With Services in SysVinit/Upstart  

Under the Upstart methodology you can simply start services and stop them with the ```service``` command.  The syntax is ```sudo service <service-name> start | stop | restart | status```.  This would act upon the appropriate shell script to perform the appropriate action.  Why would you need to restart a user run service?  Remember that everything in Linux is configured with text files.  At initial load the text files information is parsed and placed in memory.  If you change a value, you need to reload that configuration file into memory, and restarting a service does just that for instance.  The ```service``` commands are still in place but since Ubuntu 15.04 and Fedora 20 they are just symlinks to the systemd command and control ```systemctl```.

> __Example Usage:__  On an Ubuntu system to restart your apache2 webserver your would type: ```sudo service apache2 restart``` (assuming you had apache2 already installed).

> __Example Usage:__ On SysVinit systems (pre-Ubuntu 6.10) you would type the absolute path to the directory where the init script was located.  In this case perhaps ```/etc/init.d/apache2 restart```

### Working With Services in systemctl

> __Example Usage:__ On a systemd based system, service control is done with ```systemctl <command> <name>.service```.  In the case of Apache2 webserver the command to restart it would look like this:  ```sudo systemctl restart httpd.service```  The ```.service``` can be left off and the system will assume the exetension. 

> __Example Usage:__ The ```systemctl``` command has additional abilities.  It absorbed the ```chkconfig``` command, which was/is used to set services to autostart at boot time.  In Fedora installed services do not automatically start at boot time, you must explicitly add them.  You can check the status of the httpd service by issuing: ```sudo systemctl is-enabled httpd.service```.  Issue that command and what does it report?

> __Example Usage:__ To disable a service at boot type: ```sudo systemctl disable httpd.service``` and *enable* does the opposite.  The *status* option will tell you what is the current status, start or stopped.  

Systemd has the capability for targets to show what they "Require" to run, and what they "Want" to be running before they start.  Systemd command ```systemctl show``` will show all details relating to a target or a service.  Let us look at a service definition.  Type this command, ```cd /lib/systemd/system; ls http*; file http*```  what do you see? Type this command to see the contents of the httpd.serivce file, ```cat httpd.service``` what do you see contained inside?

Compared to the make up of a SysVinit service, systemd has a simple design for each of its *service* files.  They are located in ```/lib/systemd/system```.  Upon entering this directory you can launch an ```ls``` command and see the actual service files that you start/stop and enable/disable with ```systemctl```.

![*httpd.service*](images/Chapter-10/systemd/httpd-service.png "service")

You can see the dependencies the httpd service needs and will only start if the targets listed in \[Unit\] under *After* have started--which makes sense. The command ```sudo systemctl show --property "Wants" httpd.service``` will show only the property from the unit file that you identify with __--property__. The *ExecStart* and *ExecReload* are called when you start and restart the service--which point to the absolute path to the Apache2 binary.  The final value is when the service is installed it has a dependency of being in a mutil-user target--it obviously be used on a single user system.

#### hostnamectl and timedatectl
 
One of the components of systemd is hostnamectl which is designed to give you an easy interface into controlling the information relating to your systems hostname. Running the command ```man hostnamectl``` shows you what can be done here [hostnamectl](https://www.freedesktop.org/software/systemd/man/hostnamectl "hostnamectl")

> **Exercise:** Use the hostnamectl command to change your systems hostname to itmo-556 (or your class name).  Now close your shell and reopen it--what do you see?

The ```timedatectl``` is used for setting timezone and to activate ntp (network time protocol) synchronization.  This part of systemd superceeds previous commands that ran to handle the clock. [timedatectl](https://www.freedesktop.org/software/systemd/man/timedatectl "timedatectl").  

> **Exercise:** Using the man command for timedatectl can you enable ntp synchronization?  Can you change the timezone to ETC?

#### systemd-analyze

Systemd was designed to bring modern OS principles to desktop and server Linux.  That includes a tool called ```systemd-analyze``` which breaks down the time it took for all services, modules, and parts of the kernel to finish loading.  To further debug these numbers use, ```systemd-analyze blame```.  This will print out individually which services/targets/units/mounts are taking the most time to load and allow you to investigate or disable those elements.  You can even use the builtin *plotting* feature of systemd-analyze, by typing, ``` systemd-analyze plot > plot.svg``` and then typing ```eog plot.svg``` to create a visual time based graph of your plot.  There are additional commands under systemd-analyze, ```critical-chain``` will print specific load time for dependent services of the service you provide, ```systemd-analyze critical-chain httpd.service```.   These tools and options available in the man page, are used to determine system boot-up performance statistics.

### ps

The ```ps``` command displays information about a selection of the active processes. This is different from the ```top``` command as the information is not updated but just displayed.  The ```ps``` command by itself shows very little useful information.  Overtime three versions of ```ps`` have joined together so there are three sets of options, BSD, Unix, and GNU.  The BSD options have no "-" prefix, UNIX options have a single "-" and GNU options have a double dash "--".   

![*ps command*](images/Chapter-10/processes/ps.png "ps")

These additional commands will share more information:

  * ```ps -e```  <-- select all processes (similar to -A)
  * ```ps -ef```  <-- this is one of the more helpful and verbose sets of options with full-formatting
  * ```ps -eF``` <-- Extra full-formatting
  * ```ps -ely```  <-- Long formatting
  * ```ps -eo pif,tid,class,ni,pri,psr...```  <-- the ```o``` option allows you to customize the column arraingment and output.
  * ```ps -C syslogd -o pid=```  <-- this is the same as doing ```ps -ef | grep firefox``` or ```pidof firefox```
  * ```ps xawf -eo pid,user,cgroup,args``` [^119]  Shows cgroup ownership details.
  *  systemd version of ```ps``` is called ```systemd-cgls``` which shows a nice hierarchy of process ownership.
    + cgroups (control groups) were a feature added to the Linux kernel that allow for processes to be grouped together and control commands can be executed on entire groups (permission limiting, start/stop, priority changes, etc, etc.)  Systemd makes big use of [cgroups](https://en.wikipedia.org/wiki/Cgroups "cgroups").

\newpage    

### kill

In the SysVinit/Upstart world to terminate a process you would use the ```kill``` command.  There are various levels of ```kill```.  

 Level       Name            Function
-------- ------------ -----------------------------------------------------------------------
  1        SIGHUP       Used to make a process re-read a config file
  2        SIGINT       Effectively hitting CTRL+C
  9        SIGKILL      Kills a process ungracefully--could damage files, use as last resort
  15       SIGTERM      Like a kill 9, but with class, gracefully kills a process
-------- ------------ -----------------------------------------------------------------------

All programs can choose to *trap* these kill commands and ignore them or take different expected behaviors.  All except ```kill -9``` every process has to obey.  You can use the ```killall``` command to kill the process and any associated processes that it had launched all in one fell swoop.  You and use the ```ptkill``` command to kill a process by name instead of PID.

### Killing Processes with systemd

Systemd on the other hand has a mechanism for dealing with services directly, ```systemd kill httpd.service``` will kill the Apache2 webserver service.  You can also issue the same kill commands above within systemd not only to individual services but also to control groups of processes as well.

#### cgroups

Systemd uses cgroups as a way to hierarchically group and label processes, and (B) a way to then apply resource limits to these groups.  cgroups allow you to *police* the resource usage of processes and related subprocesses--which gives finer grained control over other tools.  

By typing the command, ```systemd-cgls``` you can see a ordered hierarchy of which processes are part of which cgroup.  You don't have to search for process IDs anymore, you simply kill the entire cgroup.

> __Example Usage:__ To terminate the Apache2 web-server service, (assuming it has been enabled and started) first let's see the processes in its cgroup by typing ```systemd-cgls```.  You can see the httpd.service cgroup.  You can issue a kill command in the same way you can kill traditional processes by typing, ```systemctl kill httpd.service```.  You can also issue a kill level command through the ```-s``` flag, ```systemctl kill -s SIGHUP httpd.service``` will issue a ```kill -1``` command to all the members of the https.service cgroup.

### nice

The ```nice``` command is a *suggestion* tool to the operating system scheduler on how to adjust resource allocation to a process.  Giving nice the value or -20 means that this is a really high priority or more favorable process, all the way up to 19 which means that it is a really low priority process.  A good example of this would be on a large print job that will take a long time to print but you are not in a time rush--so you can nice the print job to a low priority and it will print when the system is less busy.  You can find the usage at ```man nice```.

> __Example Usage:__  This example will increase favorability of this process to the scheduler by 10 on a scale of -20 to 19--default is 0.
```bash
nice -n 10 my-loop
```

## /proc

> *"/proc is very special in that it is also a virtual filesystem. It's sometimes referred to as a process information pseudo-file system. It doesn't contain 'real' files but runtime system information (e.g. system memory, devices mounted, hardware configuration, etc). For this reason it can be regarded as a control and information centre for the kernel. In fact, quite a lot of system utilities are simply calls to files in this directory. [^120]"*

The ```/proc``` virtual filesystem provides you a file based interface to the processes that are running on your system.  When you type ```ls /proc``` what do you see?  You see a series of numerical directories.  These numbers correspond to process IDs.  Inside of each directory there are a series of files that represent the state of the process at the moment of introspection.   This can be handy in debugging an application or fine tuning a system in regards to memory usage.   Try to launch a Firefox or any other browser window.  Use the ```ps -C``` command from above to find its process ID.  Then find that process directory in ```/proc```.  What do you see? Some of the highlights are ```/proc/PID/cmdline```, which will tell you what command line options were used in launching that particular process, ```/proc/PID/status``` links to the process status in human readable form, and ```/proc/PID/mem``` describes the memory held by this process.  The command ```procinfo``` will give you summary of all system and resource states, the package may need to be installed.  For an exhaustive list of all the contents and meanings you can find a chart at the Linux Documentation Project, [http://www.tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html](http://www.tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html "TLDP PROC").

 In addition ```/proc``` has convieniant information about the state of your system.  To display information about your processor you would type, ```cat /proc/cpuinfo``` this prints out the processor family, the feature flags, and the number of processors (physical and logical).  The same can be done with memory by typing, ```cat /proc/meminfo```.  

 The Linux kernel also has a concept of loadable kernel modules.  These are pieces of code that can be added into or removed from the kernel--statically at boot, or dynamically as needed, so as to extend the capabilities of your kernel, without forcing uneeded code. For example--needing drivers for a floppy disk would be a waste to include that in the kernel when it could be added and removed via a loadable module if you happened to need it for testing.   To list all the module currently loaded you would type, ```lsmod```.   This command is actually just formatting the content of ```/proc/modules```.  There are other shortcut commands as well to inspect system devices.

--------------   ---------------------------------------------------------------------------
  lsmod           Lists all currently loaded kernel modules
  lspci           Lists all the currently detected PCI devices              
  lsusb           Lists all the currently detected USB connections
  lsblk           Lists all block devices attached to the system (useful for hard-drives)
--------------   ---------------------------------------------------------------------------

#### Loading Modules

You can list, load, and remove kernel modules form a running kernel.  This is desirable because it allows you to change functionality on a permanent basis or temporary basis without having to recompile the core Linux kernel each time you make a change - hence loadable kernel modules.  One of the best instances is [KVM](http://www.linux-kvm.org/page/Main_Page "KVM") KVM stands for *Kernel-based Virtual Machine* and though present in the Linux Kernel the module is not loaded until you install the KVM software libraries that call for that module to be loaded on boot.  If you had the KVM/Qemu virtualization applications installed (```sudo dnf install qemu-kvm libvirtd```) then you would type ```lsmod | grep kvm*```) to see the modules loaded.

> __Example Usage:__ You will notice for instance if you type ```lsmod | grep vbox*``` you will see VirtualBox kernel modules loaded - you wouldn't see these if you were on a natively installed Linux system.   

> __Example Usage:__ The ```modprobe``` command is a more intelligent way to add kernel modules than ```insmod```.  The command ```lsmod``` will list activated kernel modules and ```rmmod``` will unload a kernel module.

## Single User Mode

If you have a system with an issue--or damage that needs to be repaired.  Perhaps you need to reset the root password?  You can drop your system into what was once known as single-user mode or runlevel1.target by issuing a command: ```sudo systemctl isolate runlevel1.target```  this command should be used sparingly because what it does is drop you to a commandline prompt with a single user logged in (root) with no password.  This can be used to change or modify lost system passwords, or even reset database passwords or other troubleshooting issues like filesystem checks, which we will talk more about in the next chapter.

## Chapter Conclusions and Review

Through this chapter we learned about init systems, the traditional SysVinit and the new systemd init commands.  You learned about how to manage processes in both systems and the basics of how processes are handled.  You learned about the systemctl command for managing processes.  You learned about the ps command for managing processes under SysVinit.  Finally we learned about the ```/proc``` virtual filesystem and how it presents process information in file format dynamically on boot and during a system's use.

### Review Questions

Chapter 11 Review Questions

1) What is the name of *beep* sound heard in the initial boot of a PC (assume you are using BIOS not UEFI)?
a) PERC
b) POST
c) GRUB
d) BIOS

2) What is the name of the GNU software that is the first software program that runs when a computer with Linux installed starts?
a) BIOS
b) LILO
c) GRUB
d) GLOADER

3) In what Linux directory is the kernel and initrd image stored?
a) /root
b) /root/kernel
c) /boot
d) /boot/vmlinux

4) What is the name of the pre-kernel gzip file located in /boot that helps the kernel load?
a) vmlinuz
b) initrd
c) initram
d) init

5) Where is the file location where the GNU Grub configuration is stored that a user would edit?
a) /boot/grub/grub.cfg
b) /etc/default/grub
c) /etc/grub/grub.cfg
d) /boot/kernel/conf

6) In the /etc/default/grub file, which of these options below would I edit to dispaly the *splash* screen on boot so kernel messages are displayed?
a) GRUB_CMDLINE_LINUX_DEDFAULT
b) GRUB_BACKGROUND
c) GRUB_GFXMODE
d) GRUB_TIMEOUT

7) What is the command to make changes to /etc/default/grub permanent?
a) No special command just edit and save /etc/default/grub
b) sudo apt-get update
c) sudo update-grub
d) sudo updatedb

8) Under SysVinit - what is the ancestor process that launches first and everyother process is started by it?
a)  root
b)  sbin
c)  init
d)  systemd

9) Under SysVinit - what runlevel is considered multi-user command-line only?
a) 1
b) m
c) 3
d) 5

10) Under SysVinit - what runlevel is considered multi-user GUI only?
a) 1
b) 0
c) 3
d) 5

11) Which company created the Upstart init system as an improvement of SysVinit?
a) RedHat
b) Debian
c) Oracle
d) Ubuntu

12) What is the name of the init system that has replaced SysVinit in every single major Linux distribution (Not including Devuan and Gentoo Linux)?
a)  systemX
b)  systemd
c)  systemV
d)  initrd

13) What is the name of the command you use in systemd to inspect, start, stop, and modify process states?
a) systemd
b)  systemd-init
c)  service
d) systemctl

14) What would be the command to disable (make the service not start at boot time) the httpd service on Fedora 22 using systemd?
a)  sudo service apache2 stop
b)  sudo systemctl disable apache2.service
c)  sudo systemctl stop apache2.service
d)  sudo systemctl disable httpd.service

15) What is the Linux command to inspect processes (not part of systemd)?
a) p
b) ps
c) proc
d) meminfo

16) SysVinit used the concept of PIDs and PPIDs--what did systemd replace these with?
a) proc-groups
b) sys-groups
c) cgroups
d) xgroups

17) What is the signal name for a kill -2 command?
a) SIGHUP
b) SIGINT
c) SIGKILL
d) SIGTERM

18) The /proc filesystem provides you what?  (choose all that apply)
a) Provides you a file based interface to the processes that are running on your system
b) It can be regarded as a control and information centre for the kernel
c) Shows up to the second process usage--updated in real time
d) Is a replacement for the top command

19) What command can be used to list all the pci devices attached to your system?
a) ls --pci
b) ls -p
c) lsusb
d) lspci

20) What is the runlevel target that has a single user only as root, using no password: commonly called single-user mode?
a) runlevel3.target
b) runlevel5.target
c) runlevel0.target
d) runlevel1.target

### Podcast Questions

Systemd Podcast?

### Lab

__Objectives:__

  * Modify GRUB settings
  * Use ```systemctl``` to start, stop, and examine processes in systemd
  * Use systemd-analyze to understand what services are loading during system boot
  * Change systemd.targets
  * Use the nice command to modify a processes priority
  * List kernel modules currently loaded on your Linux system

__Outcomes:__

At the conclusion of this lab you will be able to manage, edit, and list system processes in systemd--helping you to master the concepts of systemd.  

__Instructions:__ Make a folder in your Github repo named Week-13, create a file called ReadMe.md.  In this file you will make a header H2 (## in markdown) for each question and will post a screenshot of the commmand and output that each question requires.
 
1) Change the default grub settings in Ubuntu add a background image (preferably dark) and remove or disable the ```quiet splash``` option) make sure to execute  ```update-grub``` before rebooting or changes won't be written.
1) Use the ```systemd-analyze``` tools to print out the most recent boot time for your system
1) Install MariaDB server, ```sudo dnf install mariadb```.
    a) Use the command ```systemctl status <servicename>``` after MaraiDB is installed to display its current status, then enable the service via ```systemctl```, and then start the service. Now reboot your system.
1) With MariaDB enabled, use the ```systemd-analyze``` tools to print out the most recent boot time for your system again and compare if adding this service increased boot times.  
1) Use ```systemd-analyze blame``` to collect start times of each element after installing and enabling the MariaDB service 
1) Use systemctl to enable and start the httpd.service (Fedora)
1) Use systemctl to SIGHUP the httpd.service (Fedora)
1) Change the ```systemd``` target to the systemd commandline only level, display the ```systemd``` default target level - then change back to the GUI target (or runlevel5).
1) Using systemctl and the ```--show option```, display the "After" and "Wants" of the sshd.service  
1) nice a command - create/compile a C infinite loop program and nice it to lowest priority and then highest priority.  Open a second terminal tab/window and use htop (install it if needed) to display that process' system usage
1) Launch multiple tabs in Firefox using these:  ```firefox -new-tab -url https://www.krebsonsecurity.com -new-tab -url http://twit.tv/floss/```. Find the process IDs via ```ps -ef``` and kill those tabs/processes with a ```kill -2``` command
1) Using ```lsmod``` and ```grep``` list all of the kernel modules loaded on your system that contain VirtualBox (search for ```vb*```).   
1) Run the command that will list all the PCI devices attached to your system
1) Type the command to display info about your CPU and use ```grep flags``` to filter the response to show only the processor flags.  
1) Using ```systemctl``` find the cgroup for the apache2 webserver (known as httpd on Fedora) and issue a SIGHUP to the entire cgroup.
1) Using ```systemd-cgls``` list and filter (grep) and show the sub-process IDs for the httpd.service
1) Install and execute the ```procinfo``` command and display the system overview.
1) Use the ```timedatectl``` command to change the clock of your system to UTC.
1) Use the ```hostnamectl``` command to:
    a) set-hostname to itmo-556-xyz (xyz is your initials)
    b) set-location to Chicago
    c) set-chassis to VM

#### Footnotes

[^114]: [https://www.gnu.org/software/grub/](https://www.gnu.org/software/grub/)

[^115]: [http://www.slashroot.in/linux-booting-process-step-step-tutorial-understanding-linux-boot-sequence](http://www.slashroot.in/linux-booting-process-step-step-tutorial-understanding-linux-boot-sequence)

[^116]: [http://0pointer.de/blog/projects/the-biggest-myths](http://0pointer.de/blog/projects/the-biggest-myths)

[^117]: [http://www.freedesktop.org/wiki/Software/systemd/](http://www.freedesktop.org/wiki/Software/systemd/)

[^118]: [http://fedoraproject.org/wiki/Systemd](http://fedoraproject.org/wiki/Systemd)

[^119]: [http://0pointer.de/blog/projects/systemd-for-admins-2.html](http://0pointer.de/blog/projects/systemd-for-admins-2.html)

[^120]: [http://www.tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html](http://www.tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html)

[^121]: [https://en.wikipedia.org/wiki/Systemd](https://en.wikipedia.org/wiki/Systemd)
