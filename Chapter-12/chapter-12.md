# Creating, Partitioning, and Mounting Filesystems
![*Easy as cake...*](images/Chapter-Header/Chapter-12/server_problem-2.png "Server Problem")

__Chapter 12 Objectives__

   * Undedstand how to create and be able to attach virtual disks in VirtualBox, to Linux systems
   * Understand how the fdisk command is used to list, modify, and create filesystem partitions
   * Understand the nature of different Linux filesystems, listing their pros and cons
   * Understand Linux tools relating to filesystems, df, mount/umount, mkfs, and the /etc/fstab directory
   * Understand Logical Volume Management and how its partitioning scheme differs from fdisk.
   
__Outcomes__

  At the conclusion of this chapter you will be able to add additional virtual disks to any Linux verison installed in VirtualBox.  You will be able to format devices and create filesystems on newly formatted devices.  You will understand how to partition a device and install filesystems.  This chapter will give you experience with the tools needed to perform these actions.  We will study the LVM -- Linux Volume Manager and its new concept for dealing with disks.  Finalyl we will learn the concept of mounting and unmounting of disks.

## Disk Management in VirtualBox

  At the time of this writing (11/22/15) a single terrabyte Western Digital Blue harddrive was selling for ~$50.  Storage is cheap.  With that in mind, adding storage or capacity is very easy these days--even common place.  Since we are dealing with virtual storage in this book and examples-we can easily attach and detach storage devices because we don't need to add anything physical to the systems.  For this chapter we will assume that you are using Virtual Box 5.0.x, but all of these concepts translate directly to physical storage or another virtualization platform.

 With you virtual machine powered down, lets add some new disks (virtually) to your Linux system.  The first thing to do is locate the *SETTINGS* button on the main menu.
 
![*Virtual Box settings panel*](images/Chapter-12/virtual-box/settings.png "Settings")
\newpage

The next menu to come up will show the *SETTINGS* options and the name of the virtual machine you are working on.

![*Virtual Box settings menu*](images/Chapter-12/virtual-box/settings-menu.png "Settings Menu")
\newpage

Select the *STORAGE* option from the menu on the left--this is where you can attach, detach, and modify virtual disks in Virtual Box.  In most cases these will be hard drives, but there is the ability to attach ISO images to a virtual cd-rom device as well.  That option is in the top half where you see *Controller: IDE*. Under that you might see the term *EMPTY* or you might see a virtualbox-guest-additions.iso attached.  

![*Storage menu*](images/Chapter-12/virtual-box/storage.png "Storage")
\newpage

We will be working with attaching virtual hard drives so we are interested in the bottom portion of the menu which is identified by *Controller: SATA* which is your [Serial ATA](https://en.wikipedia.org/wiki/Serial_ATA "Serial ATA") hard drive bus connection.  As a refresher, Serial ATA is the protocol and databus in which the operating system communicates and recieves data with your hard drive. Go ahead and highlight the SATA Controller entry.  

In order to add a new hard drive to your virtual machine, click the blue HDD icon with a __+__ sign at the bottom of the menu. 

![*Add Storage Icon*](images/Chapter-12/virtual-box/add-storage-icon.png "Storage Icon")

Upon completion of that step a new menu will pop out of the HDD icon and give you and option to *Add Hard Disk*.

![*Add Storage*](images/Chapter-12/virtual-box/add-storage.png "Add Storage")
\newpage

Once you have selected *Add Hard Disk* a familiar set of screens come up, these are the same screens you walked through in chapter 2, and the same set of screens you walk through when setting up a new virtual machine.  You are presented first with an option to create a new disk or attach an existing one.  Usually you want to create a new disk.  

![*Create New Disk*](images/Chapter-12/virtual-box/create-new.png "Create New")

Once that is selected you will be presented with the virtual disk type screen.  Since we will be working with Virtual Box, the default setting of VDI (VirtualBox Disk Image) will be the best selection.  But if you know this VM will be moving to antother platform--you may want to choose accordingly. 

![*VDI step-through*](images/Chapter-12/virtual-box/vdi.png "VDI")
\newpage

The next page allows you to choose either a dynamic or staticly allocated hard drive.  Dynamic is usually the best when you are working on a laptop or other development system, as you will be creating and destroying virtual machine rapidly, and static allocations of multiple gigabytes can become an issue after some time due to your disk filling up.

![*Dynamic Filesystem*](images/Chapter-12/virtual-box/dynamic.png "Dynamic")
\newpage

This next screen allows you to change the location of where the virtual hard disk will be stored, as well as adjust the size of this new partition.  
![*Hard drive size*](images/Chapter-12/virtual-box/size.png "Size")
\newpage

Once you see the screen below - it means you have succesfully created a new virtual hard drive and have attached it to your virtual machine.  You can reverse the above operations by highlighing the virtual disk drive of choice and selecting the HDD icon with the minus sign and that will delete the hard drive.  But I recommend against that as your operating system won't know what happened and that could cause system instability.  Always best to unmount a partition from inside the operating system first before deleting the virtual hard drive. By highlighting the new disk or existing one, you can see the meta-data about the disk.

![*Succesfully added new disk*](images/Chapter-12/virtual-box/new-disk.png "New")

![*Disk Information*](images/Chapter-12/virtual-box/information.png "Information")

Adding a virtual disk is only the first step, there are three more steps before we can use this disk.  We need to partition the disk, create a filesystem, and then mount the disk so that it can be used by your operating system. 

## Disk Partitioning and Formatting

  According to the ```fdisk``` man page, ```fdisk``` is a dialog-driven program for the creation and manipulation of patition tables.  The term __parition__ in relation to a hard drive is an important concept.   You can think of a brand new hard drive as a large plot of land, multiple acres of land.  The land itself in that form is not very useful, just as a new hard drive added into your system is not very useful.  Just as that land needs to be partitioned up into different uses and functions, a hard drive needs to know where it'
  s partitions are.    Each disk can have multiple partitions.  
  
  Linux inherited a way to name each device and reference certain partitions attached to a system.  Windows simply uses the letter C, D, E, and so forth.  Linux and Unix use a device/partition nomeclature.  You can see this currently by typing the ```lsblk``` command, which will print out currently all the block devices, their device name and their partitions in a nice tree based format. 
  
![*lsblk output from a virtual machine with 2 additional drives attached*](images/Chapter-12/fdisk/lsblk.png "lsblk")

Here you will note that the drives are references by the prefix __sdx__ with the __x__ being the alphabet letter in incremental order.  Meaning that the first disk drive that your system detects in labeled __sda__, the next one would be __sdb__, and can you guess what the third and fourth system would be?  In the image above you notice that __sda__ has 3 partitions, sda1, sda2, and sda5.  These three partitions were created at installation time by the default Linux installer.  The first partition you can see has the character ```/``` in the far right column.  That is where the __root__ partition is mounted (meaning your entire filesystem). The second partition is where the ```/boot``` partition is mounted, and the final partition says __SWAP__ in the far right meaning this is a Linux SWAP partition--used by the operating system for moving data in and out of RAM in chunks at a time or called *pages*.

You can create partitions on a new disk for a fresh OS installation or just create a single partition to contain data.  The program mentioned above to create partitions is a program called ```fdisk```.  The ```fdisk``` command is considered an essential and standard Linux tool and is part of the [util-linux](https://en.wikipedia.org/wiki/Util-linux "Util Linux") package.  The best command to get started with when dealing with new disks and creating partitions is ```sudo fdisk -l```.  This commmand will list the current existing disks and any partitions they may have.  It will also report the undetermined state of any newly attached disks.  See the image below for a sample output.  If you are using Fedora 22/23 you will see a bit of a different output, you will see partitions labeled __LVM__ which will be explained at the end of the chapter.  Ubuntu has the option to use ```fdisk``` traditional partitioning by default.

![*sudo fdisk -l*](images/Chapter-12/fdisk/valid-parition.png "fdisk")  

![*sudo fdisk -l*](images/Chapter-12/fdisk/not-valid-parition.png "fdisk")    

The history of the Linux ```fdisk``` command goes way back.  Stemming from the early 1990's Hard drives at that time using the standard BIOS of the day were only allowed 4 __primary partitions__ on the operating system.  At those times, hard drives were small, and devices were expensive, and things we take for granted now, like optical drives, didn't really exist, so 4 primary partitions was thought to be more than anyone would ever need.  A primary partition could be broken up into an __extended partition__. Then each __extended partition__ could be further sub-divided into as many __logical partitions__ that fit on the drive.  At that time only one __primary partition__ could be active (or bootable and seeable) at a time, all other primary partitions would be hidden from the currently active operating system.  In this world ```fidsk``` was built, hence its concern with partitioning.  There has been an improvement since 2000 called LVM, which is covered and thankfully used almost exclusively now by default.

To work/modify a device that has no exsiting partitions (say ```sdb``` in the image above). From the TLDP documentation regarding how to use ```fdisk```: [^122]  

*"fdisk is started by typing (as root) fdisk device at the command prompt. Device might be something like /dev/hda or /dev/sda (see Section 2.1.1). The basic fdisk commands you need are:"* 

  * p print the partition table 
  * n create a new partition 
  * d delete a partition 
  * q quit without saving changes 
  * w write the new partition table and exit 

To succesfully create a partition on a new drive, let's select ```sdb``` in the example above.  The command ```sudo fdisk /dev/sdb``` will enter into ```fdisk``` and operate on this device.  Remember all *devices* are accessed through file handles in the ```/dev``` directory. Upon executing this command you are greeted with a status message reporting that the partition type cannot be detected or is not valid.  The error message seems a bit dated because you notice that it mentions DOS, SUN, SGI, and OSF--all outdated or unused partition types.  Similar to different languages or dialects, a partition also has to speak to an Operating system, and each operating system does it a bit different because of how particiualr filesystems are architected.  Fortunately this is a simple choice for us as we only need a Linux and a Linux SWAP partition for our uses--the rest are just artifacts of the past.

![*sudo fdisk /dev/sdb*](images/Chapter-12/fdisk/fdisk.png "fdisk")
  
  Always type __m__ for menu because the single letter commands are not intuitive.  
  
![*m for menu*](images/Chapter-12/fdisk/m-for-menu.png "Menu")
  
  If you type the letter __l__ you will see the entire list of possible partitions, we are onyl interested in the value hex 82 and 83.  The next command to type is __p__ for printing out the current partition table--which will be blank.

![*p for print*](images/Chapter-12/fdisk/p-for-print.png "Print")

The next step is to type the __n__ command to create a new partition.  You will be presented with two choices for your new partition.  In this case you can select __primary partition__.  In most cases in creating data drives you can select primary partitions without concern.  If you find yourself creating many data drives or creating triple and quad bootable systems (multiple operating systems)  then you will want to conserve those primary partitions and use __exteneded/logical__ partitioning.  

![*n is for new partition*](images/Chapter-12/fdisk/n-for-new.png "New")

You are then presented with a series of options to choose a partition number, the beginning sector of your partition (usually best to choose the default) and the finishing sector (how big do you want your disk).  You can specify in a known quantity of K=kilobytes, M=megabytes, G=Gigabytes and prefacing that value with a __+__.  Selecting the default for the option of last sector will automatically fill up your disk with 1 single large partition.

![*New Partition Options*](images/Chapter-12/fdisk/n-options.png "Options") 
  
Let's see if our partition was created succesfully.  You can type __m__ to display the menu again or type the __p__ directly to print out the current partition table.  You will notice that it has been modified.

![*Succesful Partition Creation*](images/Chapter-12/fdisk/p-finished.png "Finished")

Everything looks good, but DON'T QUIT YET!  If you type __q__ now your changes will not be saved, and no partition information will be written.   Now you need to type __w__ to write the new partition data to the disk you are working on. The __w__ command will write and quit out automatically for you. After writing this partition data, you will see if show up in the ```sudo fdisk -l``` command.  After you see your new partition in ```fdisk``` of ```lsblk``` you are ready to move on to the next step of formating a partition with a filesystem.

![*Write the Partition table data to disk*](images/Chapter-12/fdisk/w-for-write.png "Write")

## Filesystems

  To extend our analogy of a disk drive being like land, and a partition being like different lots of land sold off to different people, then a filesystem would be the actual building that is built on the property to make use of the land, be it farm land, nature preserve, solar plant, or factory.  A __fielsystem__ is the way that an operating system addresses, stores, and retrieves data stored on a disk.  It is an in-between layer so the operating system can have an addressing scheme for data, without having to know the exact mapping of the particular disk drive in question.    

  If you have used Windows before you are familiar with Fat32 and NTFS filesystems. Since Windows is created and currated by Microsoft, there has only been two different filesystems in the history of Windows.  Linux on the otherhand supports multiple different filesystems that serve many different purposes.  

### ext/ext2

  The ext filesystem was the first Linux based filesystem released in 1991.  It was borrowed conceptually from the Minix operating system that Andrew Tanenbaum had created for research purposes.  It had severe limitations since ext was engineered to be *ultra* backwards compatible--hence had 16 bit offsets and had a maxmimum partition size of 64 megabytes.  By 1992 and Linux 0.96c a new filesystem replacement called __ext__ was created and brought into Linux as the native filesytem.   By January of 1993, __ext2__ has been created and additional features added, including future proofing the system by adding unused options that could later on be tested and added as need arose.  Like most operating systems, data is broken up into __blocks__, which is the smallest sized piece of data that can be read or written.  
  
: Limits of ext2 [^123]

----------------------  ------- ------- ------- -------   
Block size:              1 KiB   2 KiB   4 KiB   8 KiB 
max. file size:          16 GiB 256 GiB  2 TiB   2 TiB 
max. filesystem size:    4 TiB  8 TiB    16 TiB  32 TiB 
----------------------  ------- ------- ------- -------   

### ext3/ext4

  As filesystems became larger and the amount of data being written increased, the chances for data corruption or writes to fail became more evidant and critical.  Also the speed of processors and hard drives became fast enough to be able to introduce __journaling__ technology to the file system to prevent types of write failures that corrupts data.  Not to be confused with journald from systemd, __ext3__ introduced a journaling feature.  Ext3 was introduced to the Linux kernel in 2001.  Being an extension basically of ext2, adding this new feature and support for larger drives helped with backward compatibility, but began extending the ext filesystem which was now over a decade old.  
  
 *"A journaling file system is a file system that keeps track of changes not yet committed to the file system's main part by recording the intentions of such changes in a data structure known as a "journal", which is usually a circular log. In the event of a system crash or power failure, such file systems can be brought back online quicker with lower likelihood of becoming corrupted. [^124]"*
  
: Limits of ext3 [^125]

Block size   Max file size   Max file system size
----------- --------------- ----------------------
  1 KiB         16 GiB             4 TiB 
  2 KiB         256 GiB            8 TiB 
  4 KiB         2 TiB             16 TiB 
----------- --------------- ----------------------  
  
By 2008 it became appearant that ext3 has reached the end of its development, and [Theodore Ts'o](https://en.wikipedia.org/wiki/Theodore_Ts%27o "Ts'o") announced that __ext4__ would extend the __Ext__ filesystem a bit longer, but the growth of ext had hit the end, and a newer fielsystem path needed to be developed to handle the larger sets of data and the massively improved hardware that existed from 1992, when ext was developed.

Ext4 saw the capacity extension of ext3 and introduction to __extents__. The ext4 filesystem can support volumes with sizes up to 1 exbibyte (EiB) and files with sizes up to 16 tebibytes (TiB). However, Red Hat recommends using XFS instead of ext4 for volumes larger than 100 TB. 

In ext4, __extents__ replaced the traditional block mapping scheme used by ext2 and ext3. An extent is a range of contiguous physical blocks, improving large file performance and reducing fragmentation. A single extent in ext4 can map up to 128 MiB of contiguous space with a 4 KiB block size [^126].  

Theodore Ts'o is a respected developer in the open source community, who currently is the maintainer of ext4 and is employed by Google to develop filesystems.  Ext4 is the current default file system for most Linux.  It is well tested and a well known quantity and is currently used by Google in Android devices as well.  

There are three competing filesystems that fill the void between ext4 and current existing technology.

### XFS
 
  XFS is a robust and highly-scalable single host 64-bit journaling file system. It is entirely extent-based, so it supports very large file and file system sizes. The maximum supported file system size is 100 TB. The number of files an XFS system can hold is limited only by the space available in the file system [^127].   
  
  XFS was originally created by SGI (Silicon Graphics Inc) back in 1993 to be a high-end Unix work station filesystem.  SGI was the company that made computers in the 1990's for high end move special effects and graphical simualtion.  They had their own version of Unix called IRIX, and needed a filesystem capable of handling large files at that time, and places like NASA which had large amounts of data to store and access.  SGI created XFS to suit that need.  XFS excels in the execution of parallel input/output (I/O) operations due to its design, which is based on allocation groups (a type of subdivision of the physical volumes in which XFS is used- also shortened to AGs). Because of this, XFS enables extreme scalability of I/O threads, file system bandwidth, and size of files and of the file system itself when spanning multiple physical storage devices [^127].
  
  XFS was ported to Linux in 2001, as SGI and IRIX went out of business and the filesystem languished.  It was opensourced and GPL'd in 2002.  RedHat began to see this filesystem as an alternative to ext4 and more mature than btrfs or other replacements since it had over 10 years of development from the start to handle large scale files.  RedHat also hired many of the SGi engineers and developers who created this filesystem and brought back into production quality.  Recently RedHat began in RHEL 7.x to deprecate ext4 as the default filesystem and implment XFS as their standard filesystem--which will trickle down to CentOS 7.  XFS is notoriously bad at being used by an everyday computer usage pattern that reads and writes many small files, so it is not suitable for Fedora or Ubuntu, but works perfect on a system storing large database files or archiving large images or x-ray data.

### Btrfs
  
  Theodore Ts'o has recommended moving to Btrfs (pronounced *butter fs*) as a replacement for ext4 moving forward, but development on btrfs is still in beta and not quite stable for production.   Btrfs uses copy-on-write, which is a strategy where as multiple processes using the same piece of data, don't make copies of it each, but use pointers to the initial data, thereby speeding up the system, reducing the number of writes needed. The project was initially created by Oracle, for use on their own storage products, but was GPL'd and now many companies contribute to the codebase. The project is marked stable and included in the Linux kernel since July of 2013.  
  
   *"Chris Mason, the principal Btrfs author, has stated that its goal was "to let Linux scale for the storage that will be available. Scaling is not just about addressing the storage but also means being able to administer and to manage it with a clean interface that lets people see what's being used and makes it more reliable. [^128]"*
  
  
  
  
  
  
  
  A third alternative is a filesystem originally developed by Sun, called ZFS.  ZFS is an ellegantly designed filesystem.   
 
   
### Disk related tools

  df and dh  
  
## Mounting and Unmounting of disks

  mount, umount, /etc/fstab    

## Logical Volume Manager

  repeat the previous sections with LVM commands
  
  LVM created in 1998
   
## Chapter Conclusions and Review

   In this chapter we learned and mastered the tools and concepts needed to manage, create, and format disks in Linux.  We learned how to inspect and how to mount and umount these drives from our system.
 
### Review Questions

  Questions go here

### Podcast Questions

 Questions go here

### Lab

 Lab goes here 
 
#### Footnotes
 
[^122]: [http://tldp.org/HOWTO/Partition/fdisk_partitioning.html](http://tldp.org/HOWTO/Partition/fdisk_partitioning.html)

[^123]: [https://en.wikipedia.org/wiki/Ext2](https://en.wikipedia.org/wiki/Ext2)
 
[^124]: [https://en.wikipedia.org/wiki/Journaling_file_system](https://en.wikipedia.org/wiki/Journaling_file_system) 
 
[^125]: [https://en.wikipedia.org/wiki/Ext3](https://en.wikipedia.org/wiki/Ext3) 
 
[^126]: [https://en.wikipedia.org/wiki/Ext4](https://en.wikipedia.org/wiki/Ext4) 
 
[^127]: [https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Performance_Tuning_Guide/s-storage-xfs.html](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Performance_Tuning_Guide/s-storage-xfs.html) 
 
[^128]: [https://en.wikipedia.org/wiki/Btrfs](https://en.wikipedia.org/wiki/Btrfs)
 