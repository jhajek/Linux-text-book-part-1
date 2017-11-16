# Creating, Partitioning, and Mounting Filesystems
![*Easy as cake...*](images/Chapter-Header/Chapter-12/server_problem-2.png "Server Problem")

### Objectives

   * Understand how to create and be able to attach virtual disks in VirtualBox, to Linux systems
   * Understand how the fdisk command is used to list, modify, and create filesystem partitions
   * Understand the nature of different Linux filesystems, listing their pros and cons
   * Understand Linux tools relating to filesystems, df, mount/umount, mkfs, and the /etc/fstab directory
   * Understand Logical Volume Management and how its partitioning scheme differs from fdisk.

### Outcomes

  At the conclusion of this chapter you will be able to add additional virtual disks to any Linux version installed in Virtual Box.  You will be able to format devices and create filesystems on newly formatted devices.  You will understand how to partition a device and install filesystems.  This chapter will give you experience with the tools needed to perform these actions.  We will study the LVM -- Linux Volume Manager and its new concept for dealing with disks.  Finally we will learn the concept of mounting and unmounting of disks.

## Disk Management in VirtualBox

  At the time of this writing (11/22/15) a single terabyte Western Digital Blue hard drive was selling for ~$50.  Storage is cheap.  With that in mind, adding storage or capacity is very easy these days--even common place.  Since we are dealing with virtual storage in this book and examples-we can easily attach and detach storage devices because we don't need to add anything physical to the systems.  For this chapter we will assume that you are using Virtual Box 5.0.x, but all of these concepts translate directly to physical storage or another virtualization platform.

 With you virtual machine powered down, lets add some new disks (virtually) to your Linux system.  The first thing to do is locate the *SETTINGS* button on the main menu.

![*Virtual Box settings panel*](images/Chapter-12/virtual-box/settings.png "Settings")
\newpage

The next menu to come up will show the *SETTINGS* options and the name of the virtual machine you are working on.

![*Virtual Box settings menu*](images/Chapter-12/virtual-box/settings-menu.png "Settings Menu")
\newpage

Select the *STORAGE* option from the menu on the left--this is where you can attach, detach, and modify virtual disks in Virtual Box.  In most cases these will be hard drives, but there is the ability to attach ISO images to a virtual cd-rom device as well.  That option is in the top half where you see *Controller: IDE*. Under that you might see the term *EMPTY* or you might see a virtualbox-guest-additions.iso attached.  

![*Storage menu*](images/Chapter-12/virtual-box/storage.png "Storage")
\newpage

We will be working with attaching virtual hard drives so we are interested in the bottom portion of the menu which is identified by *Controller: SATA* which is your [Serial ATA](https://en.wikipedia.org/wiki/Serial_ATA "Serial ATA") hard drive bus connection.  As a refresher, Serial ATA is the protocol and data-bus in which the operating system communicates and receives data with your hard drive. Go ahead and highlight the SATA Controller entry.  

In order to add a new hard drive to your virtual machine, click the blue HDD icon with a __+__ sign at the bottom of the menu.

![*Add Storage Icon*](images/Chapter-12/virtual-box/add-storage-icon.png "Storage Icon")

Upon completion of that step a new menu will pop out of the HDD icon and give you and option to *Add Hard Disk*.

![*Add Storage*](images/Chapter-12/virtual-box/add-storage.png "Add Storage")
\newpage

Once you have selected *Add Hard Disk* a familiar set of screens come up, these are the same screens you walked through in chapter 2, and the same set of screens you walk through when setting up a new virtual machine.  You are presented first with an option to create a new disk or attach an existing one.  Usually you want to create a new disk.  

![*Create New Disk*](images/Chapter-12/virtual-box/create-new.png "Create New")

Once that is selected you will be presented with the virtual disk type screen.  Since we will be working with Virtual Box, the default setting of VDI (VirtualBox Disk Image) will be the best selection.  But if you know this VM will be moving to another platform--you may want to choose accordingly.

![*VDI step-through*](images/Chapter-12/virtual-box/vdi.png "VDI")
\newpage

The next page allows you to choose either a dynamic or static allocated hard drive.  Dynamic is usually the best when you are working on a laptop or other development system, as you will be creating and destroying virtual machine rapidly, and static allocations of multiple gigabytes can become an issue after some time due to your disk filling up.

![*Dynamic Filesystem*](images/Chapter-12/virtual-box/dynamic.png "Dynamic")
\newpage

This next screen allows you to change the location of where the virtual hard disk will be stored, as well as adjust the size of this new partition.  
![*Hard Drive Size*](images/Chapter-12/virtual-box/size.png "Size")
\newpage

Once you see the screen below - it means you have successfully created a new virtual hard drive and have attached it to your virtual machine.  You can reverse the above operations by highlighting the virtual disk drive of choice and selecting the HDD icon with the minus sign and that will delete the hard drive.  But I recommend against that as your operating system won't know what happened and that could cause system instability.  Always best to unmount a partition from inside the operating system first before deleting the virtual hard drive. By highlighting the new disk or existing one, you can see the meta-data about the disk.

![*Succesfully Added New disk*](images/Chapter-12/virtual-box/new-disk.png "New")

![*Disk Information*](images/Chapter-12/virtual-box/information.png "Information")

Adding a virtual disk is only the first step, there are three more steps before we can use this disk.  We need to partition the disk, create a filesystem, and then mount the disk so that it can be used by your operating system.

## Disk Partitioning and Formatting

  According to the ```fdisk``` man page, ```fdisk``` is a dialog-driven program for the creation and manipulation of partition tables.  The term __partition__ in relation to a hard drive is an important concept.   You can think of a brand new hard drive as a large plot of land, multiple acres of land.  The land itself in that form is not very useful, just as a new hard drive added into your system is not very useful.  Just as that land needs to be partitioned up into different uses and functions, a hard drive needs to know where it'
  s partitions are.    Each disk can have multiple partitions.  

  Linux inherited a way to name each device and reference certain partitions attached to a system.  Windows simply uses the letter C, D, E, and so forth.  Linux and Unix use a device/partition nomenclature.  You can see this currently by typing the ```lsblk``` command, which will print out currently all the block devices, their device name and their partitions in a nice tree based format.

![*lsblk output from a virtual machine with 2 additional drives attached*](images/Chapter-12/fdisk/lsblk.png "lsblk")

Here you will note that the drives are references by the prefix __sdx__ with the __x__ being the alphabet letter in incremental order.  Meaning that the first disk drive that your system detects in labeled __sda__, the next one would be __sdb__, and can you guess what the third and fourth system would be?  In the image above you notice that __sda__ has 3 partitions, sda1, sda2, and sda5.  These three partitions were created at installation time by the default Linux installer.  The first partition you can see has the character ```/``` in the far right column.  That is where the __root__ partition is mounted (meaning your entire filesystem). The second partition is where the ```/boot``` partition is mounted, and the final partition says __SWAP__ in the far right meaning this is a Linux SWAP partition--used by the operating system for moving data in and out of RAM in chunks at a time or called *pages*.

You can create partitions on a new disk for a fresh OS installation or just create a single partition to contain data.  The program mentioned above to create partitions is a program called ```fdisk```.  The ```fdisk``` command is considered an essential and standard Linux tool and is part of the [util-linux](https://en.wikipedia.org/wiki/Util-linux "Util Linux") package.  The best command to get started with when dealing with new disks and creating partitions is ```sudo fdisk -l```.  This command will list the current existing disks and any partitions they may have.  It will also report the undetermined state of any newly attached disks.  See the image below for a sample output.  If you are using Fedora 22/23 you will see a bit of a different output, you will see partitions labeled __LVM__ which will be explained at the end of the chapter.  Ubuntu has the option to use ```fdisk``` traditional partitioning by default.
\newpage

![*sudo fdisk -l*](images/Chapter-12/fdisk/valid-partition.png "fdisk")  

![*sudo fdisk -l*](images/Chapter-12/fdisk/not-valid-partition.png "fdisk")    

The history of the Linux ```fdisk``` command goes way back.  Stemming from the early 1990's Hard drives at that time using the standard BIOS of the day were only allowed 4 __primary partitions__ on the operating system.  At those times, hard drives were small, and devices were expensive, and things we take for granted now, like optical drives, didn't really exist, so 4 primary partitions was thought to be more than anyone would ever need.  A primary partition could be broken up into an __extended partition__. Then each __extended partition__ could be further sub-divided into as many __logical partitions__ that fit on the drive.  At that time only one __primary partition__ could be active (or bootable and seeable) at a time, all other primary partitions would be hidden from the currently active operating system.  In this world ```fidsk``` was built, hence its concern with partitioning.  There has been an improvement since 2000 called LVM, which is covered and thankfully used almost exclusively now by default.

To work/modify a device that has no existing partitions (say ```sdb``` in the image above). From the TLDP documentation regarding how to use ```fdisk```: [^122]  

*"fdisk is started by typing (as root) fdisk device at the command prompt. Device might be something like /dev/hda or /dev/sda (see Section 2.1.1). The basic fdisk commands you need are:"*

  * p print the partition table
  * n create a new partition
  * d delete a partition
  * q quit without saving changes
  * w write the new partition table and exit

To successfully create a partition on a new drive, let's select ```sdb``` in the example above.  The command ```sudo fdisk /dev/sdb``` will enter into ```fdisk``` and operate on this device.  Remember all *devices* are accessed through file handles in the ```/dev``` directory. Upon executing this command you are greeted with a status message reporting that the partition type cannot be detected or is not valid.  The error message seems a bit dated because you notice that it mentions DOS, SUN, SGI, and OSF--all outdated or unused partition types.  Similar to different languages or dialects, a partition also has to speak to an Operating system, and each operating system does it a bit different because of how particular filesystems are architected.  Fortunately this is a simple choice for us as we only need a Linux and a Linux SWAP partition for our uses--the rest are just artifacts of the past.

![*sudo fdisk /dev/sdb*](images/Chapter-12/fdisk/fdisk.png "fdisk")

  Always type __m__ for menu because the single letter commands are not intuitive.  

![*m for menu*](images/Chapter-12/fdisk/m-for-menu.png "Menu")

  If you type the letter __l__ you will see the entire list of possible partitions, we are only interested in the value hex 82 and 83.  The next command to type is __p__ for printing out the current partition table--which will be blank.

\newpage

![*p for print*](images/Chapter-12/fdisk/p-for-print.png "Print")

The next step is to type the __n__ command to create a new partition.  You will be presented with two choices for your new partition.  In this case you can select __primary partition__.  In most cases in creating data drives you can select primary partitions without concern.  If you find yourself creating many data drives or creating triple and quad bootable systems (multiple operating systems)  then you will want to conserve those primary partitions and use __extended/logical__ partitioning.  

![*n is for new partition*](images/Chapter-12/fdisk/n-for-new.png "New")

You are then presented with a series of options to choose a partition number, the beginning sector of your partition (usually best to choose the default) and the finishing sector (how big do you want your disk).  You can specify in a known quantity of K=kilobytes, M=megabytes, G=Gigabytes and prefacing that value with a __+__.  Selecting the default for the option of last sector will automatically fill up your disk with 1 single large partition.

![*New Partition Options*](images/Chapter-12/fdisk/n-options.png "Options")

Let's see if our partition was created successfully.  You can type __m__ to display the menu again or type the __p__ directly to print out the current partition table.  You will notice that it has been modified.

![*Successful Partition Creation*](images/Chapter-12/fdisk/p-finished.png "Finished")

\newpage

Everything looks good, but DON'T QUIT YET!  If you type __q__ now your changes will not be saved, and no partition information will be written.   Now you need to type __w__ to write the new partition data to the disk you are working on. The __w__ command will write and quit out automatically for you. After writing this partition data, you will see if show up in the ```sudo fdisk -l``` command.  After you see your new partition in ```fdisk``` of ```lsblk``` you are ready to move on to the next step of formatting a partition with a filesystem.

![*Write the Partition table data to disk*](images/Chapter-12/fdisk/w-for-write.png "Write")

## Filesystems

  To extend our analogy of a disk drive being like land, and a partition being like different lots of land sold off to different people, then a filesystem would be the actual building that is built on the property to make use of the land, be it farm land, nature preserve, solar plant, or factory.  A __filesystem__ is the way that an operating system addresses, stores, and retrieves data stored on a disk.  It is an in-between layer so the operating system can have an addressing scheme for data, without having to know the exact mapping of the particular disk drive in question.    

  If you have used Windows before you are familiar with Fat32 and NTFS filesystems. Since Windows is created and curated by Microsoft, there has only been two different filesystems in the history of Windows.  Linux on the other-hand supports multiple different filesystems that serve many different purposes.  

### ext/ext2

  The ext filesystem was the first Linux based filesystem released in 1991.  It was borrowed conceptually from the Minix operating system that Andrew Tanenbaum had created for research purposes.  It had severe limitations since ext was engineered to be *ultra* backwards compatible--hence had 16 bit offsets and had a maximum partition size of 64 megabytes.  By 1992 and Linux 0.96c a new filesystem replacement called __ext__ was created and brought into Linux as the native filesytem.   By January of 1993, __ext2__ has been created and additional features added, including future proofing the system by adding unused options that could later on be tested and added as need arose.  Like most operating systems, data is broken up into __blocks__, which is the smallest sized piece of data that can be read or written [^123].  

: Limits of ext2

----------------------  ------- ------- ------- -------   
Block size:              1 KiB   2 KiB   4 KiB   8 KiB
max. file size:          16 GiB 256 GiB  2 TiB   2 TiB
max. filesystem size:    4 TiB  8 TiB    16 TiB  32 TiB
----------------------  ------- ------- ------- -------   

  Traditionally your ```/boot``` partition is formatted as __ext2__ because it is only used for a short time to load your *initrd* and *kernel image* into memory, so the overhead of ext4 is not needed.  You can use the built in ```sudo mkfs /dev/sdb1`` command to format a partition with __ext2__.

### ext3/ext4

  As filesystems became larger and the amount of data being written increased, the chances for data corruption or writes to fail became more evident and critical.  Also the speed of processors and hard drives became fast enough to be able to introduce __journaling__ technology to the file system to prevent types of write failures that corrupts data.  Not to be confused with journald from systemd, __ext3__ introduced a journaling feature.  Ext3 was introduced to the Linux kernel in 2001.  Being an extension basically of ext2, adding this new feature and support for larger drives helped with backward compatibility, but began extending the ext filesystem which was now over a decade old.  

 *"A journaling file system is a file system that keeps track of changes not yet committed to the file system's main part by recording the intentions of such changes in a data structure known as a "journal", which is usually a circular log. In the event of a system crash or power failure, such file systems can be brought back online quicker with lower likelihood of becoming corrupted. [^124][^125]"*

: Limits of ext3

Block size   Max file size   Max file system size
----------- --------------- ----------------------
  1 KiB         16 GiB             4 TiB
  2 KiB         256 GiB            8 TiB
  4 KiB         2 TiB             16 TiB
----------- --------------- ----------------------  

By 2008 it became appearant that ext3 has reached the end of its development, and [Theodore Ts'o](https://en.wikipedia.org/wiki/Theodore_Ts%27o "Ts'o") announced that __ext4__ would extend the __Ext__ filesystem a bit longer, but the growth of ext had hit the end, and a newer filesystem path needed to be developed to handle the larger sets of data and the massively improved hardware that existed from 1992, when ext was developed.

Ext4 saw the capacity extension of ext3 and introduction to __extents__. The ext4 filesystem can support volumes with sizes up to 1 exibyte (EiB) and files with sizes up to 16 tebibytes (TiB). However, Red Hat recommends using XFS instead of ext4 for volumes larger than 100 TB.

In ext4, __extents__ replaced the traditional block mapping scheme used by ext2 and ext3. An extent is a range of contiguous physical blocks, improving large file performance and reducing fragmentation. A single extent in ext4 can map up to 128 MiB of contiguous space with a 4 KiB block size [^126].  

Theodore Ts'o is a respected developer in the open source community, who currently is the maintainer of ext4 and is employed by Google to develop filesystems.  Ext4 is the current default file system for most Linux.  It is well tested and a well known quantity and is currently used by Google in Android devices as well.  To format a partition using the __ext4__ filesystem you would simply type ```mkfs.etx4 /dev/sdX1```  and the partition will be formatted. You normally don't format entire devices, just partitions, which can take up entire disks. There are three additional competing filesystems that fill the void between ext4 and current existing technology.

### XFS

  XFS is a robust and highly-scalable single host 64-bit journaling file system. It is entirely extent-based, so it supports very large file and file system sizes. The maximum supported file system size is 100 TB. The number of files an XFS system can hold is limited only by the space available in the file system [^127].   

  XFS was originally created by SGI (Silicon Graphics Inc) back in 1993 to be a high-end Unix work station filesystem.  SGI was the company that made computers in the 1990's for high end move special effects and graphical simulation.  They had their own version of Unix called IRIX, and needed a filesystem capable of handling large files at that time, and places like NASA which had large amounts of data to store and access.  SGI created XFS to suit that need.  XFS excels in the execution of parallel input/output (I/O) operations due to its design, which is based on allocation groups (a type of subdivision of the physical volumes in which XFS is used- also shortened to AGs). Because of this, XFS enables extreme scalability of I/O threads, file system bandwidth, and size of files and of the file system itself when spanning multiple physical storage devices [^127].

  XFS was ported to Linux in 2001, as SGI and IRIX went out of business and the filesystem languished.  It was opensourced and GPL'd in 2002.  RedHat began to see this filesystem as an alternative to ext4 and more mature than btrfs or other replacements since it had over 10 years of development from the start to handle large scale files.  RedHat also hired many of the SGI engineers and developers who created this filesystem and brought back into production quality.  Recently RedHat began in RHEL 7.x to deprecate ext4 as the default filesystem and implement XFS as their standard filesystem--which will trickle down to CentOS 7.  XFS is notoriously bad at being used by an everyday computer usage pattern that reads and writes many small files, so it is not suitable for Fedora or Ubuntu, but works perfect on a system storing large database files or archiving large images or x-ray data.  You can install the tools needed to make a partion of the XFS format by typing:

  * XFS tools are already installed on Fedora
  * sudo apt-get install xfsprogs

### Btrfs

  Theodore Ts'o has recommended moving to Btrfs (pronounced *butter fs*) as a replacement for ext4 moving forward, but development on btrfs is still in beta and not quite stable for production.   Btrfs uses copy-on-write, which is a strategy where as multiple processes using the same piece of data, don't make copies of it each, but use pointers to the initial data, thereby speeding up the system, reducing the number of writes needed. The project was initially created by Oracle, for use on their own storage products, but was GPL'd and now many companies contribute to the codebase. The project is marked stable and included in the Linux kernel since July of 2013.  

   Chris Mason, the principal Btrfs author, has stated that its goal was, *"to let Linux scale for the storage that will be available. Scaling is not just about addressing the storage but also means being able to administer and to manage it with a clean interface that lets people see what's being used and makes it more reliable. [^128]"*

  Btrfs adds support for resource pooling and using extents to make logical drives across physical devices. It also includes snapshoting of files--for point in time restore and in place cloning, and checksuming.  In order to format a system using Btrfs you need to install ```btrfs-tools``` on Ubuntu and ```btrfs-progs``` on Fedora.

  * ```sudo dnf install btrfs-progs -y``` or ```sudo yum install btrfs-progs -y``` 		
  * ```sudo apt-get install btrfs-tools -y```	 

### ZFS

   A third alternative is a filesystem originally developed by Sun, called ZFS.  ZFS is an elegantly designed filesystem.   *"ZFS is a combined file system and logical volume manager designed by Sun Microsystems. The features of ZFS include protection against data corruption, support for high storage capacities, efficient data compression, integration of the concepts of filesystem and volume management, snapshots and copy-on-write clones, continuous integrity checking and automatic repair, Software based RAID,(RAID-Z) [^129]"*   

   ZFS was developed by Sun and inherited by Oracle.  It is not licensed under the GPL but under a Sun/Oracle license called CDDL, which is similar to GPL, but allowed Sun and Oracle to license proprietary parts of the filesystem, as not free. This prevented ZFS from being adopted natively into the Linux kernel because of the GPL.  But the FreeBSD kernel didn't have this restriction under the BSD license and they have had native kernel based support for ZFS since version 8 of FreeBSD.  

   Recently Linux added an additional repository that you can manually add to your system to include the CDDL licensed ZFS code on Linux as a loadable kernel module--which is close to being native.  You can load the module, you just can install your operating system on ZFS natively while installing because the module isn't included in the Linux kernel.  Here is an example to install the ZFS PPA, load the module and then format and create a zpool logical mirror (RAID1) in 5 steps,  tutorial comes from here: [ http://serverascode.com/2014/07/01/zfs-ubuntu-trusty.html]( http://serverascode.com/2014/07/01/zfs-ubuntu-trusty.html "ZFS Tutorial")

```bash
 sudo add-apt-repository ppa:zfs-native/stable
 sudo apt-get update
 sudo apt-get install -y ubuntu-zfs

# Now check to see if the zfs module is loaded
 modprobe zfs
 lsmod | grep zfs
# change the value of sdX and sdZ to the actual device names (your entire unformated devices)
# the name "tank" is used in the tutorial -- I replaced it with mydatapool.
 sudo zpool create mydatapool mirror /dev/sdX /dev/sdZ
 lsblk
 zfs list
 df -h | grep tank
```  

## Mounting and Unmounting of disks

   Once a disk is partitioned, and formatted with a filesystem, it now needs to be mounted.   The concept of mounting came from the UNIX days of carrying a large reel of magnetic tape, and physically mounting it on a tape reader.  You can see all the mount points currently attached to your system by typing ```/etc/mtab```.  A filesystem needs to be mounted to a directory location.  Technically your root filesystem is mounted to the ```/``` partition.  

   In the previous examples we we have created partitions and filesystem, now let us mount them.  The first step we need to do is provide a mount point.  Traditionally that is done in the ```/mnt``` directory.  You should create your __mountpoints__ here.   Let's type ```sudo mkdir -p /mnt/data-drive```.  The name *data-drive* is an arbitrary name I have given my newly created __mountpoint__.  The ```-p``` flag will auto-create any subdirectory under ```/mnt``` that doesn't already exist.  Why did I type ```sudo```?  Who owns the ```/mnt``` directory?  

   Once this directory is created, you can use the ```mount``` command like this: ```sudo mount -t ext4 /dev/sdb /mnt/data-drive```.  The ```-t``` flag tells this mount that the filesystem is of type __ext4__ and the operating system needs to know so that it can interface correctly with the filesystem.  Once this is done, the directory will still be owned by root, you probably need to change the ownership of the directory so that you own and can write to it. How would you do that based on last chapter?  You could type ```sudo chown jeremy:jeremy /mnt/data-drive```, assuming your username is *jeremy*.

   The partition can be unmounted by typing the ```umount``` command--yes it is missing the __n__.  Be careful you don't try to unmount the device while your pwd is in a directory on that mount--otherwise you will get a *device is busy error.*    

### /etc/fstab  

   The ```/etc/fstab``` file controls the automatic mounting of your filesystems at boot.  Every time your system boots, technically each partition is remounted every time too.  If you create your own filesystem and want it mounted automatically on boot, then you would need to add an entry here. The ```/etc/fstab``` file has 6 columns containing values listed here: ```<device> <mount point> <fs type> <options> <dump> <pass>```.

   An example entry could contain these values: ```/dev/sdb1 /mnt/data-drive  ext4  defaults  0   0```.  Devices now are typically listed by their UUID, which can be found by typing ```ls -l /dev/disk/by-uuid```.  That is the actual command not a place holder. This is where the long strings you see in the ```/etc/fstab``` file in place of the device name.  There are many options that can be set in the place of ```defaults``` as well, such as:

1. sync/async - All I/O to the file system should be done (a)synchronously.
2. auto - The filesystem can be mounted automatically (at bootup, or when mount is passed the -a option). This is really unnecessary as this is the default action of mount -a anyway.
3. noauto - The filesystem will NOT be automatically mounted at startup, or when mount passed -a. You must explicitly mount the filesystem.
4. dev/nodev - Interpret/Do not interpret character or block special devices on the file system.
5. exec / noexec - Permit/Prevent the execution of binaries from the filesystem.
6. suid/nosuid - Permit/Block the operation of suid, and sgid bits.
7. ro - Mount read-only.
8. rw - Mount read-write.
9. user - Permit any user to mount the filesystem. This automatically implies noexec, nosuid,nodev unless overridden.
10. nouser - Only permit root to mount the filesystem. This is also a default setting.
11. defaults - Use default settings. Equivalent to rw, suid, dev, exec, auto, nouser, async.
12. netdev - this is a network device, mount it after bringing up the network. Only valid with fstype nfs.    

### Disk related tools

  There are two useful commands to use in regards to understanding the disk resource use in regards to the filesystem.  The ```df``` command will list the disk usage.   There is an optional ```-H``` and ```-h``` which presents the file-system usage in Gigabytes (-H is metric: giga, -h is binary, gibi).  When you use ```df``` without any directories, it will list all file-systems.  The command below lists the file-system that contains the user's home directory: ```/home/controller```.

![*df -H /home/controller*](images/Chapter-12/du/df-h.png "df")  

 The ```du``` command is disk usage.  This is a helpful command to show the exact *byte-count* that each file is actually using.  When using ls -l Linux reports only 4096 kb for a directories size, this does not actually reflect the size of the content inside the directory.  The ```du``` command will do that for you.  

\newpage

![*du -H --exlude=".\*" /home/controller*](images/Chapter-12/du/du-h.png "du")  

## Logical Volume Manager

   In order to enhance processing you may in your partitioning decisions want to place certain portions of the file-system on different disks.  For instance you may want to place the ```/var``` directory on a different disk so that system log writing doesn't slow down data stored int he users home directories.  You may be installing a MySQL database and want to move the default storage to a second disk you just mounted to reduce write ware on your hard disks.  These are good strategies to employ, but what happens as the hard disks in those examples begin to fill up?  How do you migrate or add larger disks?

   The question is under standard partitioning you don't. You simply backup, reinstall, and reformat the entire drive.  This is very time consuming and a risky operation that is usually not taken lightly.  What to do?  A solution to this problem, called LVM, [Logical Volume Management](http://tldp.org/HOWTO/LVM-HOWTO/ "LVM"), was created in 1998.  LVM version 2 is the current full featured version baked in to the Linux kernel since version 2.6.

   LVM is a different way to look at partitions and file-systems.  Instead of the standard way of partitioning up disks, instead we are dealing with multiple large disks.  As technology progressed, we took our single large disk that we had split into partitions with __fdisk__ and now we supplemented it with multiple disks in place of those partitions.  The Linux kernel needed a new way to manage those multiple disks, especially in regards to a single file system.  *"Logical volume management provides a higher-level view of the disk storage on a computer system than the traditional view of disks and partitions. This gives the system administrator much more flexibility in allocating storage to applications and users. [^130]"*
\newpage

![*LVM diagram*](images/Chapter-12/LVM/LVM.png "LVM")

This diagram creates three concepts to know when dealing with LVM:

*  Volume Group (VG) - The Volume Group is the highest level abstraction used within the LVM. It gathers together a collection of Logical Volumes and Physical Volumes into one administrative unit [^131].
*  Physical Volume (PV) - A physical volume is typically a hard disk, though it may well just be a device that 'looks' like a hard disk (eg. a software raid device) [^132].
*  Logical Volume (LV) -  The equivalent of a disk partition in a non-LVM system. The LV is visible as a standard block device; as such the LV can contain a file system (eg. /home) [^133].
    + Physical Extent (PE) - This is the unit of storage (blocks) that a PV is split into
    + Logical Extent (LE) - This matches the PE and is used when multiple PVs are added to an LG, to make the *logical disk*.  The LVM counts how many extents are possible and makes this its *disk* so to speak.

### Physical Volumes

The first thing to do in creating an LVM partition is to figure out what kind of disks you have and what kind of partition scheme you want to use.  Note that you can choose to use the entire disk ```/dev/sdb``` for instance or you can create a partition on the disk for use with LVM; if you do make sure to create the partition of type __0x8E__ LVM and not a standard Linux partition. In order to use entire disks you need to use the ```pvcreate``` command to *create* physical volumes, same case with the partition.

### Volume Groups

Once you have added the disks/partitions to the PV, now you need to create a Volume Group (VG) to add those PVs to.  The command to add PVs to an LG is: ```vgcreate VOLUME-GROUP-NAME /dev/sdx /dev/sdy```. You can extend this volume group by simply adding another ```pvcreate /dev/sdx1``` command for example and then using the ```vgextend VOLUME-GROUP-NAME /dev/sdz```.  There is also a ```vgreduce``` command that will remove a PV from a Volume Group.  The volume group allows for a single logical management unit for multiple disk/partitions.  This is useful as well for adding additional storage and removing storage devices that may have failed or are not performing at required parameters.  

### Logical Volumes

From within our Volume Group (VG) we can now carve out smaller LV (Logical Volumes).  The nice part here is that the Logical Volumes don't have to match any partition or disk size--since they are logically based on the combined size of the Volume Group which has extents mapped across those disks.  Use the command ```lvcreate -n LOGICAL-VOLUME-NAME --size 250G VOLUME-GROUP-TO-ATTACH-TO```. The ```vgdisplay``` command will show what had been created and what is attached to where. There are options to make the LV striped extents as opposed to Linear, but that is an application based decision.  Since LVs are logical they can also be extended and reduced on the fly--that alone is a better replacement for standard partitioning.  The command ```lvextend -L 50G /dev/VOLUME-GROUP-NAME/LOGICAL-VOLUME-NAME``` will extend the LV to become 50 GB in size.  Using ```-L+50G``` will add 50 additional gigabytes to an existing LV's size.

Once you have successfully created an LV, now it needs a file-system installed.  Here you can add XFS, Btrfs, ZFS, Ext4, Ext2, or any other file-system.   You would use the ```mkfs``` proper tool for your filesystem.  Once you have the file-system created then you need a mount point just as with traditional partitions and mounting.  Each file-system type (XFS, Btrfs, Ext4, etc etc) has tools that allow you to extend the file-system automatically without the need to reformat the entire system, if the underlying LV or traditional partition is modified.  Not all file-systems have the built in ability to shrink an existing partition.   

One definite feature not included in traditional partitioning is the concept of ```snapshots```.  Now ```snapshots``` exist at the file-system level too in (Btrfs and ZFS, but not XFS or ext4 they are too old).  The command ```sudo lvcreate -s -n NAME-OF-SNAPSHOT -L 5g VOLUME-GROUP-NAME``` creates a LV volume that is a snapshot or COW, Copy-on-Write partition.  It often can be smaller, because this new LV is only going to copy the changes, or deltas, from the original LV, not duplicating data but sharing it between the two LVs.   This delta can be merged back in, returning you to a point in time state, via the ```sudo lvconvert --merge``` command.  Also snapshot can be *promoted* to be a full LV that can be copied and mounted itself as a full LV.

LVM is used mostly during partitioning during installation and new file-systems like Btrfs and ZFS seek to replicate its abilities at a file-system level.  LVM has many more detailed and powerful commands worth exploring.

## Chapter Conclusions and Review

   In this chapter we learned and mastered the tools and concepts needed to manage, create, and format disks in Linux.  We learned how to inspect and how to mount and umount these drives from our system.  We learned about the standard Linux file-systems and new advanced file-systems.  Finally we learned about file-system tools and the use of Logical Volume Management.  Finally we learned about the concept of volume management snapshotting.  You have been prepared to with the basics of how to manage and understand the file-system on your Linux distro.

### Review Questions

Chapter 12 Review Questions

1) What is the fdisk program?
a) a dialog-driven program for the creation and manipulation of partition tables.
b) a filesystem creation tool
c) a tool for formatting floppy disks
d) a tool for removing disks from a system

2) What is the default Virtual Box disk type?
a) VDI
b) HDD
c) COW
d) VDD

3) After attaching a new virtual disk what is the next step?
a) partitioning
b) make a filesystem
c) mount a filesystem
d)

4) Which command will print out currently all the block devices, their device name, and their partitions in a nice tree based format.
a) lspci
b) lsblk
c) lsusb
d) lstree

5) fdisk is part of what package?
a) utils
b) GNU
c) utils-linux
d) utils-unix

6) What would be the name of the second sata disk attached to your system?
a) sda
b) sdb
c) sdc
d) sdd

7) What is the name of the first native Linux filesystem released in 1992?
a) ext2
b) minix
c) ext4
d) ext

8) What is the name of the current default Linux Filesystem?
a) ext
b) btrfs
c) ext3
d) ext4

9) Ext4 breaks up data into __________, which is the smallest sized piece of data that can be read or written?
a) sectors
b) tracks
c) blocks
d) clusters

10) If you use the ext2 filesystem and choose a 4 KiB block, what is the maximum filesystem size?
a) 2 TiB
b) 16 TiB
c) 4 TiB
d) 4 GiB

11) What is the name of the maintainer of the ext4 filesystem?
a) Brian Kernighan
b) Theodore Ts'o
c) Andrew Tanenbaum
d) Google

12) What is the name of the filesystem that the ext4 maintainer, Theodore Ts'o, is recommending to replace ext4?
a) XFS
b) Btrfs
c) ZFS
d) HAMMER

13) What is the name of the filesystem that RedHat adopted on their RHEL 7 platform to replace ext4 and support better performance on large filesystems?
a) ZFS
b) XFS
c) Btrfs
d) HAMMER

14) What is the name of the package needed to install on Ubuntu to be able to create XFS filesystems?
a) sudo apt-get install xfsprogrs
b) sudo apt-get install zprogs
c) sudo apt-get install file-progs
d) sudo apt-get install zfsprogs

15) What is the name of the combined filesystem and logical volume manager designed by Sun Microsystems?
a) XFS
b) SunFS
c) ZFS
d) Btrfs

16) Which command is valid for making an ext4 filesystem on a partition /dev/sdb1
a) sudo mkfs.ext4 /dev/sdb
b) sudo mkfs.ext4 /dev/sdb1
c) sudo mkfs /dev/sdb1
d) sudo makefs

17) What is the command to mount an ext4 filesystem, /dev/sdb1 on a mount point /mnt/data-drive-2?
a) sudo mnt /dev/sdb1 /mnt/data-drive-2
b) sudo mnt -t ext4 /dev/sdb1 /mnt/data-drive-2
c) sudo mount -t ext4 /dev/sdb1 /mnt/data-drive-2
d) sudo mount /dev/sdb1 /mnt/data-drive-2

18) What is the command used to list the current mountpoints, that will be mounted automatically at boot?
a) /etc/mtab
b) /etc/default/grub.conf
c) /etc/fstab
d) /etc/tab

19) What is the command used to create a LVM physical volume?
a) pvcreate
b) pvck
c) pvadd
d) pvscan

20) What is the command used to create a LVM volume group?
a) vgcreate
b) vgck
c) vgdisplay
d) vgmknodes

### Podcast Questions

TBD

### Lab

Chapter 12 Lab

Objectives

  * Creating virtual disks in Virtual Box
  * Creating new partitions in fdisk
  * Creating new filesystems with mkfs
  * Creating new filesystems in ZFS
  * Mounting new filesystems
  * Editing /etc/fstab to make our mounts permanent

Outcomes

  At the conclusion of this lab you will have successfully created a new virtual disk in Virtual Box, created new partitions using fdisk, formatted those partitions using mkfs, XFS, and ZFS, and mounted all those partitions manually and automatically using the /etc/fstab.

__Instructions:__ Create a folder called Week-14 in your Github repo.  Also note to self show the systemd disk mounting writing of service files and compare to ZFS and the automounting

1) Create two virtual disk in Virtual Box (attach them to either Fedora or Ubuntu) of 4 GB size each. Submit a screenshot of the Virtual Box settings screen showing two new virtual drives attached.  In your screenshot highlight one of the newly created disks to display its properties on the right hand side of the screen-capture this in the screenshot.

2) Use the fdisk command to create two entire disk partitions (one on each of the newly created virtual disks) after going through the steps to create the full disk partitions, take a screenshot of the entire output of sudo fdisk -l showing that they have been formatted

3) Find the command that is used to display the devices and their partitions in a nice tree form--submit of screenshot of the output of that command.

4) Use the mkfs command to create an ext2 filesystem on the partition you just created on /dev/sdb. Submit a screenshot of the command and its results

5) Use the mkfs command to create an ext4 filesystem on the partition you just created on /dev/sdc. Submit a screenshot of the command and its results

6) Use the mkdir command to create a mountpoint named data-drive in /mnt, change ownership and group to your user. Show the output of an ls -l on /mnt. Take a screenshot of the output of these commands.

7) Use the mount command to mount the partition of /dev/sdb to /mnt/data-drive

8) Use the mkdir command to create a mountpoint named backup-drive in /mnt, change ownership and group to your user. Show the output of an ls -l on /mnt. Take a screenshot of the output of these commands.

9) Use the mount command to mount the partition of /dev/sdc to /mnt/backup-drive

10) Show the output of the df -H command displaying the two new successful mountpoints

11) Edit the /etc/fstab file to make these two mountpoints automount at boot

12) Follow the example in the book under the ZFS header to create a ZFS mirror pool. To complete this add two additional Virtual hard drives.  Follow the steps outlined in the script, present a screen shot containing the output of lsblk, zfs list, and df -H | grep tank

13) From the BTRFS tutorial: [https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices](https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices "BTRFS")  -- Take a screenshot of each ```df -H``` command
a) You will have to install the btrfs tools relevant to your operating system (either Ubuntu or Fedora)
b) Create 3 additional virtual disks of 2 GB size and 1 of 4 GB size
c) use ```lsblk``` to list these partitions   
d) use mkfs.btrfs -d raid0  to create a 3 disk stripe (leave the 4GB disk out of this stripe)
e) use any device as your mountpoint for btrfs
f) open a terminal window and execute ```df -H```  

14) Continuing the previous question:
a) Add the fourth device (4 GB size) to the btrfs stripe
b) Then balance the metadata according to the tutorial
c) open a terminal window and execute ```df -H```

15) Continuing the previous question:
a) Remove one of the devices
b) open a terminal window and execute ```df -H```

16) Add a line in your /etc/fstab to mount this btrfs stripe at boot, reboot and see if it works by typing df -H

17) Using an entirely newly created virtual disk, create an XFS based filesystem and mount-point, show the command to mount the XFS partition.  
a) You need to install the XFS filesystem tools relevant to your operating system (either Ubuntu or Fedora)

18) Show the entry in /etc/fstab to mount the XFS partition.  

19) Use the ```du``` command to find and list the size of the Denyhosts directory you cloned in the previous chapter.

20) Create 3 additional virtual disks each of 4 GB in size (delete and previous partitions if need be)
a) Add all three volumes (entire disk) as LVM PVs (Physical Volumes)
b) Create a Volume group named vg-456
c) Create 4 logical volumes of 3 GB size each within that Volume Group
d) Create an ext4 and xfs partitions on the first 2 LVs and on the 3rd and 4th create a Btrfs Mirror (RAID1)
e) Create mountpoints under ```/mnt``` and mount them and list them all with a ```df -H``` commmand

#### Footnotes

[^122]: [http://tldp.org/HOWTO/Partition/fdisk_partitioning.html](http://tldp.org/HOWTO/Partition/fdisk_partitioning.html)

[^123]: [https://en.wikipedia.org/wiki/Ext2](https://en.wikipedia.org/wiki/Ext2)

[^124]: [https://en.wikipedia.org/wiki/Journaling_file_system](https://en.wikipedia.org/wiki/Journaling_file_system)

[^125]: [https://en.wikipedia.org/wiki/Ext3](https://en.wikipedia.org/wiki/Ext3)

[^126]: [https://en.wikipedia.org/wiki/Ext4](https://en.wikipedia.org/wiki/Ext4)

[^127]: [https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Performance_Tuning_Guide/s-storage-xfs.html](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Performance_Tuning_Guide/s-storage-xfs.html)

[^128]: [https://en.wikipedia.org/wiki/Btrfs](https://en.wikipedia.org/wiki/Btrfs)

[^129]: [https://en.wikipedia.org/wiki/ZFS](https://en.wikipedia.org/wiki/ZFS)

[^130]: [http://tldp.org/HOWTO/LVM-HOWTO/whatisvolman.html](http://tldp.org/HOWTO/LVM-HOWTO/whatisvolman.html)

[^131]: [http://tldp.org/HOWTO/LVM-HOWTO/vg.html](http://tldp.org/HOWTO/LVM-HOWTO/vg.html)

[^132]: [http://tldp.org/HOWTO/LVM-HOWTO/pv.html](http://tldp.org/HOWTO/LVM-HOWTO/pv.html)

[^133]: [http://tldp.org/HOWTO/LVM-HOWTO/lv.html](http://tldp.org/HOWTO/LVM-HOWTO/lv.html)
