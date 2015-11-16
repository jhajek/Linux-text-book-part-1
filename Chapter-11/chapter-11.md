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
  
  
  
  
  


### SysVinit


### Systemd


## Service related tools


### ps

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
 
 