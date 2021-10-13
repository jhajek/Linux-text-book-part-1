# Appendix B - Answers for Review Questions

![*One little thing holding everything up*](images/Chapter-Header/Appendix-B/dependency.png "One little thing holding everything up")

This section contains the questions and answers to the chapter review questions.

## Chapter 01

NA

## Chapter 02

NA

## Chapter 03 - Review Questions

Hardware and Linux Installation

1. What is the term for the industry standard file format that is used to install a Linux distro?
a. ISO

2. What is currently the most common Linux install media type?
c. USB

3. What is the name of the most common tool used to create bootable Linux install media?
c. etcher.io

4. What is the technology that is inserted between ring 1 and ring 0 that enables virtualization?
A: hypervisor

5. The operating system that the hypervisor resides on is called the _________ system?
A: host

6. Hosted or desktop virtualization is called what type of hypervisor?
A: Type II

7. Bare Metal or Native Virtualization is called what type of hypervisor?
A: Type I

8. Each Linux installation distro provides a mechanism to compare what you downloaded with what you expected to download, what is that called?
b. check sum

9. What is the name of the driver package you can install in VirtualBox in order to enable features such as shared clipboard, larger screen resolution, and mouse pointer integration?
d. VirtualBox Guest Additions

10. What is the name for a Linux distribution that runs in memory?
b. Live ISO

11. What feature doesn't dpkg handle/support?
b. Installing dependencies

12. What is the APT command to add an additional software repository in Ubuntu/Debian, named: `ppa:linux-libre/ppa`, to your APT system?
b. `sudo add-apt-repository ppa:linux-libre/ppa`

13. Which distro(s) supports the .deb package?
b. Debian Family

14. Which distro(s) supports the RPM package?
b. RedHat Family

15. We talked about using GCC to compile and install software, what was the other language/package manager discussed in the chapter?
c. Python

16. Describe the purpose of VirtualBox Guest Additions?
The Guest Additions are designed to be installed inside a virtual machine after the guest operating system has been installed. They consist of device drivers and system applications that optimize the guest operating system for better performance and usability.

17. In APT, where are the additional source list fragments stored (file location)?

18. After building software from source and running the ```./configure``` command, what is the next step?
d. Run the ```make``` command

19. What is the name of the new package manager Ubuntu/Canonical has developed?
 snap

20. What is the name of the new package manager RedHat has developed?
 flatpak

## Chapter 04 - Review Questions

Linux Desktop and GUI

1. What was the original and most popular Unix “Smart Terminal?”
b. VT-100
2. What is the three letter abbreviation still in use today in modern Linux to refer to “terminal 
devices?”
b. TTY
3. Why is the GNOME terminal and Windows cmd.exe terminal emulator screens 80 by 25 by 
default?
c. The developers of these technologies were seeking to emulate the popular VT-100 and 
VT-0220 terminals they used prior.
4. What is the key combo sequence you can hit to switch to a new virtual terminal in Linux?
b. Alt + Ctrl + F1 - F7
5. What is the name of the original Unix based GUI that came out of MIT in ~1984?
b. X
6. True or False – X was originally not opensourced by MIT in 1984
a. True
7. What is the model that the X server uses to render screens?
Client Server
8. What is the name of the successor GUI compositor to X being created by the X.org foundation?
c. Wayland Project
9. What is the name of Ubuntu’s own GUI compositor replacement for X? (Just the name.
a. Mir
10. What are the 3 types of Linux window managers?
Compositing, Stacking, and Tiling
11. There are 4 major Linux desktop environments in use today: which grouping is correct?
d. KDE, GNOME, Xfce, LXDE
12. What is the name of the windowing toolkit that KDE uses? (Two letters)
a. Qt
13. What is the name of the windowing toolkit that GNOME uses? (just 3 letters, no plus sign.
a. GTK+
14. What is the name of the founder of the GNOME project?
a. Miguel de Icaza
15. When the GNOME 3 desktop environment was released in early 2012, many people were unhappy that many changes were made.  There were 3 major projects started to either preserve GNOME 2 or to modify GNOME 3 significantly – what are the names of those projects?
c. Unity, Mate, Cinnamon
16. When released in 2006, what was the main development goal of the LXDE desktop environment?
c. Energy saving and extremely fast
17. Which of these statements are true in regards to Linux desktop environments? (choose all that apply).
a. Desktop environments have a File Manager
b. Desktop Environments have start or action buttons and task and notification bars
c. Desktop environments have a changeable but consistent look-and-feel
d. Desktop environments have system configuration tools and user applications built-in
18. What is the default desktop environment for the latest Fedora desktop? (Name and version)?
a. GNOME 40
19. What is the name of the button on the upper left hand corner of the GNOME 3 desktop that you use to “launch applications?”
a. Activities
20. What is the name of the default Ubuntu desktop environment?
GNOME

## Chapter 05 - Review Questions

The Linux Filesystem, Path, Shell, and File Permissions

1. What is the numeric value of a file with the permissions rwxr--r--?
d. 744

2. What is the numeric value of a file with the permissions rw-----?
c. 600

3. What is the numeric value of a file with the permission rwx-r-xr-x?
b. 755

4. What is the name of the command you use to list the contents of a directory?
d. ls

5. What is the name of the command you use to display the content of a file to the screen?
d. cat

6. What is the name of the command you use to display the content of a file to the screen that 
allows you to page up and down?
b. less

7. Every shell command has three components:
b. Command, options, arguments

8. What does the user use to issue commands to the kernel?
d. Shell

9. What is the name of the GNU shell that is standard across all Linux Distros
d. bash

10. Based on the ls command, what is the option to do a long listing?
d. ls –l

11. What is the command you can use to find out additional usage information about a shell command?
b. man

12. Which of these directories is not part of the LSB LFH?
c. temp

13. The Linux Filesystem is an upside down what?
c. tree

14. What is the character name of the top of the Linux Filesystem tree?
a. ```/```

15. Everything (directories, files, devices. in Unix/Linux is a what?
a. file

16. What is the name of the Unix system standard developed in ~1985 that defines at a minimum what a certified Unix based system must support?
c. POSIX

17. What is the directory where all configuration files are stored in Linux?
c. etc

18. What is the directory where all system binaries are stored?
a. bin

19. What is the absolute path of a user's home directory, assuming the user is named controller?
a. /home/controller

20. True or False - Lennart Poettering supports POSIX
a. False

## Chapter 06 - Review Questions

Shell Meta-Characters, Pipes, Search, and Tools

1. What is the name for characters that have special meanings in the Linux shell?
d. shell meta-characters

2. Assume your pwd is ~. If you wanted to list every directory only that started with the letters "Do" what would be the command?
d. ls -l Do*

3. In figure 6.2 in Chapter 06 which of the 3 blue boxes is the step where shell meta-characters are transformed into text?
d. Expansion

4. Which meta-character allows you to string commands together regardless of the successful execution of the previous command?
b. \;

5. Which meta-character allows you to string commands together but will exit if one of the commands fails?
a. &&

6. Which meta-character is the wildcard (0 or more matches.?
d. \*

7. Which meta-character is the single character wildcard?
a. \?

8. Square braces [] indicate sets or ______ of characters to be processed
d. ranges

9. If you wanted to use brace expansion and create a series of nine files named: file1, file2, file3, etc etc all at once--what command would you use?  (type the full command using touch .
d. touch file{1..9}

10. If you wanted to assign the value of /etc/alternatives/java to a shell variable named JAVA_HOME--what would be the proper syntax?
c. JAVA_HOME=/etc/alternatives/java

11. What would be the proper syntax to display the content of a variable named JAVA_HOME in the shell?
d. echo $JAVA_HOME

12. There are 3 standard I/O devices in a Linux system, standard in, standard out, and ________
d. standard error

13. Standard In is what device by default?
d. keyboard

14. Standard Out is what device be default?
b.  screen

15. What meta-character can you use to redirect standard out to a file? (Choose all that apply.
a. \>
b. \>\>

16. What meta-character is used to redirect the standard output of one command as the standard input of another command?
d. \|

17. Which command is a shortcut to display the kernel's output messages?
d. dmesg

18. Which command is used to search within files using textual filter patterns?
d. grep

19. Which command can be used to count lines that are in a text file?
b. wc

20. Which command can be used to find unique line occurrences in a text file? 
b. uniq

## Chapter 07 - Review Questions

Introduction to Linux Editors, Introduction to Shell Scripts, and User Profiles 

1. What are the two main representatives of stream editors  
d. vi and Emacs

2. Which family of editors came first?
d. Stream Editors

3. Emacs at its core is what?
c. An interpreter for Emacs Lisp

4. Who created the vi editor and in what year?
c. Bill Joy, 1979

5. Which of the following sequences of the history of vi is correct?
b. ed -> em -> ex -> vi -> vim

6. What are the three modes in vi?  (separate each answer via a comma)
a.  command, insert, ex

7. What is the key you use in vi to transition between COMMAND MODE and INSERT mode? (Just three letters)
a. ESC

8. What command sequence (key) in vi will add text to the right of the current cursor position?  (just the letter)
a. a

9. What command sequence (key) in vi will move you to the beginning of the next word? (just the letter)
a. w

10. What command sequence in vi will delete a single line based on the current cursor position? (just the letters)
a. dd

11. What command sequence in vi will delete 10 lines from the current cursor position? (just the numbers and letters)
a. 10dd

12. Which command in ex mode (vi) will save the current file you are working on and exit the vi editor? (include the :)
a. :wq

13. In the log file u_ex150911_.log what would be the ex command to search forward for occurrences of xmlrpc.php? (include the forward slash)
a. /xmlrpc\\.php

14. Assuming your pwd is Linux-text-book-part-I and you have loaded Chapter-02.chapter-02.md into vi, what would be the ex mode command to replace all occurrences of linux with Linux?
a. 1,$s/linux/Linux/g

15. Assuming your pwd is Linux-text-book-part-I and you have loaded Chapter-02.chapter-02.md into vi, what would be the ex mode command to replace all occurrences of Linux with GNU/Linux? (remember to escape the /)
a. 1,$s/Linux/GNU\\/Linux/g

16. Assuming the your pwd is Linux-text-book-part-I and you have loaded Chapter-02.chapter-02.md into vi, what would be the ex mode command to remove all occurrences of the word Windows?
a. 1,$s/Windows//g

17. Assuming a file name topsecret.sh has a permission of 644 - what is the shortcut to give the owner of the file permission to execute the script?
a. chmod u+x topsecret.sh

18. Assuming a file named moretopsecret.sh has a permission of 757 - what is the shortcut to remove all permissions from the the other group?
a. chmod o-rwx moretopsecret.sh

19. What is the correct sequence of profile inheritance?
a. /etc/profile -> ~/.bash_profile or ~/.bash_login or ~/.profile -> ~/.bashrc

20. What is the command to display the contents of the PATH system variable on the command line?
b. echo $PATH

## Chapter 08

1) True or False The Bash shell scripting language has traditional language constructs like C or Java?
True

2) What meta-character do you use to access the content of a shell variable?
a.  ```$```

3) When assigning the standard output of a command to a variable what characters do you encase the command in?
a. \`\`

4) True or False - You can include shell meta-characters inside of two backticks ```\`\```` - example: ```ANS=`ls -l test[1-5]````
True

5) Which command will list the names of any file that matches these names: file1.txt file2.txt file3.txt file4.txt and send the content of that output to a variable named DIR?
d.  ```DIR=\`ls -l ./test[1-4].txt\````

6) Which of these are valid commands in the first line of a shell script?  (Choose any - assume any paths are valid paths to executables) 
a. ```#!/bin/bash```
c. ```#!/usr/local/bin/bash```
e. ```#!/bin/ksh```

7) If you stored the output of the command hostname into a variable named sys-hostname, what would be the command to print the content to the screen?
d.  ```echo $sys-hostname```

8) What is the name of the command to print out all the predefined system variables? printenv

9) What is the name of the command that allows you to take stdout of a command and insert the lines of output into an array?
d. mapfile

10) Which of these is a valid command to take the output of this find command and assign the contents to an array?  (Assume the array name has already been declared. Choose one)
c. ```mapfile -t SEARCHARRAY < <(find ~ -name mozilla*)```

11) Which below is a valid command to find the LENGTH of an array?
a. ```${#SEARCHARRAY[@]}```

12) Based on this shell script and positional parameters, what would the command be to print out the first positional parameter after the script name? ```./delete-directory.sh ~/Documents/text-book Jeremy```
b.  ```echo $1```

13) Based on this shell script and positional parameters, what would the command be to print out the entire content of the positional parameter array? ```./delete-directory.sh ~/Documents/text-book Jeremy```
d.  ```echo $@```

14) Based on this shell script and positional parameters, what would the command be to print out the LENGTH of the positional parameter array? ```./delete-directory.sh ~/Documents/text-book Jeremy```
a.  ```echo $#```

15) In a Bash IF statement, what is the name for the pre-made test conditions?
a. Primaries

16) All values in a Bash IF statement are of what data type by default?
b. STRING

17) Which of these answers will execute a shell script named ~/backup.sh at 2 am every night of the week?
c. ```* 2 * * * ~/backup.sh```

18) Which of these answers will execute a shell script named ~/clean-directory.sh every 15 minutes?
b. ```*/15 * * * * ~/clean-directory.sh```

19) Which of the crontab builtins would you use to execute a cron job 1 time a year on midnight of January 1st?  The name of the script is ~/give-free-cash-to-students.sh
d. &#64;```yearly ~/give-free-cash-to-students.sh```

20) What is the name of the control structure that allows you to incrementally through the contents of an array?
d. FOR

## Chapter 09

Review Questions Chapter 09

1) What user account has superuser privilege in Linux?
d. ```root```

2) Which command do you use to temporarily elevate your user's privilege to the superuser (root)? 
b. ```sudo```

3) How can I display the content of a file named topsecret.txt that has permissions 000?
c.  ```sudo cat topsecret.txt```

4) What license is the ```sudo``` application under? 
d.  ISC

5) Which operating system doesn't have an active root account by default?
b. Ubuntu

6) What is the name of the file where sudo privilege are kept?
d. /etc/sudoers

7) What is the name of the command used to modify /etc/sudoers to grant a new user sudo privilege?
c. visudo

8) Based on this line in /etc/sudoers - ```%meninblack  ALL=(ALL:ALL) ALL``` - what does the first value by the % mean? 
a.  Name of a group

9) In the /etc/sudoers file - what does this line mean: ```RMS ALL=(root) NOPASSWD: ALL```
d.  The user RMS has sudo permissions and access to all commands, and requires no password to elevate to the sudo user

10) When using the su command to switch from a regular user account to the root user account, what do you type to return to the standard user account?
b.  exit

11) What command would you use to edit the file at this location:  /var/www/html/index.html?
b.  sudo vi /var/www/html/index.html

12) On a Linux system, which directory are all the traditional system (non-systemd) logs kept in?
d.  /var/log

13) Under systemd and journald where are the logs kept?
d.  Trick question - as logs are stored in a binary format and retrieved via journalctl

14) What is the command you use to query the system logs in systemd?
c.  journalctl

15) How would you filter the systemd log based on time?
a.  ```journalctl --since=yesterday```

16) What file would you edit to change the systemd journald.conf?
d. /etc/systemd/journald.conf

17) What command provides a dynamic real-time view of a running system?
a.  top

18) Debian based distros have an additional command to abstract the process to add users to the system - what is it?
c. adduser

19) What command would be used to modify a user account settings and add them to the sudo users group (user is named controller)?
b.  sudo usermod -aG sudo controller

20) Which below are valid useradd commands?  (Choose all that apply)
a. ```sudo useradd -c "User for spring class" -d "/home/export/controller" -G sudo -s /bin/ksh -m controller```
c. ```sudo useradd controller```
d. ```sudo useradd -G sudo -s /bin/ksh -m controller```
e. ```sudo useradd -c "User for spring class" -G sudo -m controller```

## Chapter 10

Chapter 10 Review Questions

1) What is the name of *beep* sound heard in the initial boot of a PC (assume you are using BIOS not UEFI)?
b) POST

2) What is the name of the GNU software that is the first software program that runs when a computer with Linux installed starts?
c) GRUB

3) In what Linux directory is the kernel and initrd image stored?
c) /boot

4) What is the name of the pre-kernel gzip file located in /boot that helps the kernel load?
b) initrd

5) Where is the file location where the GNU Grub configuration is stored that a user would edit?
b) /etc/default/grub

6) In the /etc/default/grub file, which of these options below would I edit to dispaly the *splash* screen on boot so kernel messages are displayed?
a) GRUB_CMDLINE_LINUX_DEDFAULT

7) What is the command to make changes to /etc/default/grub permanent?
c) sudo update-grub

8) Under SysVinit - what is the ancestor process that launches first and everyother process is started by it?
c)  init

9) Under SysVinit - what runlevel is considered multi-user command-line only?
c) 3

10) Under SysVinit - what runlevel is considered multi-user GUI only?
d) 5

11) Which company created the Upstart init system as an improvement of SysVinit?
d) Ubuntu

12) What is the name of the init system that has replaced SysVinit in every single major Linux distribution (Not including Devuan and Gentoo Linux)?
b)  systemd

13) What is the name of the command you use in systemd to inspect, start, stop, and modify process states?
d) systemctl

14) What would be the command to disable (make the service not start at boot time) the httpd service on Fedora using systemd?
d) sudo systemctl disable httpd.service

15) What is the Linux command to inspect processes (not part of systemd)?
b) ps

16) SysVinit used the concept of PIDs and PPIDs--what did systemd replace these with?
c) cgroups

17) What is the signal name for a kill -2 command?
b) SIGINT

18) The /proc filesystem provides you what?  (choose all that apply)
a) Provides you a file based interface to the processes that are running on your system
b) It can be regarded as a control and information centre for the kernel

19) What command can be used to list all the pci devices attached to your system?
d) lspci

20) What is the runlevel target that has a single user only as root, using no password: commonly called single-user mode?
d) runlevel1.target

## Chapter 11

Chapter 11 Review Questions

1) What is the `fdisk` program?
a) a dialog-driven program for the creation and manipulation of partition tables.

2) What is the default VirtualBox disk type?
a) VDI

3) After attaching a new virtual disk, what is the next step?
a) partitioning

4) Which command will print out currently all the block devices, their device name, and their partitions in a nice tree based format.
b) lsblk

5) `fdisk` is part of what package?
c) utils-linux

6) What would be the name of the second SATA disk attached to your system?
b) sdb

7) What is the name of the first native Linux filesystem released in 1992?
d) ext

8) What is the name of the current default Linux Filesystem?
d) ext4

9) Ext4 breaks up data into __________, which is the smallest sized piece of data that can be read or written?
c) blocks

10) If you use the ext2 filesystem and choose a 4 KiB block, what is the maximum filesystem size?
b) 16 TiB

11) What is the name of the maintainer of the ext4 filesystem?
b) Theodore Ts'o

12) What is the name of the filesystem that the ext4 maintainer, Theodore Ts'o, is recommending to replace ext4?
b) Btrfs

13) What is the name of the filesystem that RedHat adopted on their RHEL 7 platform to replace ext4 and support better performance on large filesystems?
b) XFS

14) Which is the correct command needed to install on Ubuntu to be able to create XFS filesystems?
a) `sudo apt-get install xfsprogs`

15) What is the name of the combined filesystem and logical volume manager designed by Sun Microsystems?
c) ZFS

16) Which is the correct command for making an ext4 filesystem on a partition /dev/sdb1?
b) `sudo mkfs.ext4 /dev/sdb1`

17) Which is the correct command to mount an ext4 filesystem, /dev/sdb1 on a mount point /mnt/data-drive-2?
c) `sudo mount -t ext4 /dev/sdb1 /mnt/data-drive-2`

18) Which file contains the mountpoints that will be mounted automatically at boot?
c) /etc/fstab

19) What is the command used to create a LVM physical volume?
a) pvcreate

20) What is the command used to create a LVM volume group?
a) vgcreate

## Chapter 12

1. Using the ip2 suite of tools, which command would show your IP address?
  c.  ip address show
  d.  ip a sh
1. Using the ip2 suite of tools, which command would show your routing table?
  b.  `ip route`
1. What tool could you use to establish if a server is responding to requests?
  b.  `ping`
1. What is the purpose of a NETMASK?
1. What is the purpose of DNS?
1. What is a valid class C address?
  c.  192.168.1.0
1. If you had a network with a CIDR block of /23 how many IP addresses would you have control of?
  c. 512
1. If you had a CIDR block of /24 and a network address of 192.168.1.0, how many IP addresses would you have?
  d.  256
1. How does CIDR block addressing differ from Class based networking (A-D)?
1. What tool is used to release a dhcp address from the command line?
  c.  `dhclient -r`
1. using the ip2 suite, What tool can be used to monitor and examine all current local ports and TCP/IP connections?
  a.  `ss`
1. Where are your network card settings located on Ubuntu while using network manager?
`/etc/network/interfaces`

1. Where are your network card settings located on CentOS/Fedora using network manager?
`/etc/sysconfig/network-scripts/`

1. Where are your network card settings located on Ubuntu 18.04 using netplan?
`/etc/netplan/config.yaml`

1. What are the two major opensource webservers?
  a. Apache, Nginx
1. What are two related and major opensource relational databases?
  b. MariaDB and MySQL
1. Name one major No-SQL database mentioned in this chapter?
Mongodb
1. What is the file location that the system uses as a *local DNS* for resolving IPs?
  b. `/etc/hosts`
1. What is the name of the file that you would place in your home directory, that allows you not to have to type your login password for a MySQL database?
  d. `~/.my.cnf`
1. Before systemd, NIC interface naming schemes depended on a driver based enumeration process: they switched to a predictable network interface names process that depends on what for the interface names?
  b. interface names depend on physical location of hardware (bus enumeration)

## Chapter 13

1. What is a common title given to IT workers who are responsible for the ongoing operations of applications and their environments?
d) ops

2. What would describe Mitchell Hashimoto's design goals in created Vagrant?
a) Automation

3. What is the name of the tool originally built as an abstraction layer on top of VirtualBox to deploy virtual machines?
d) Vagrant

4. What is the name of the tool originally built as a way to automate the installation of any operating system into an artifact?
a) Packer

5. What year approximately was Vagrant introduced?
c) 2010

6. Fill in the blank.  Think of Vagrant as _______________ between you and VirtualBox, Hyper-V, Docker, or even VMware desktop
an abstraction layer

7. What is the name of the file type Vagrant uses that contains an `vmdk` and and `ovf`?
c) `*.box`

8. Name the file that contains the configuration file for each Vagrant box file.

9. What is the correct command to add the Vagrant Box `centos/7`?
b) `vagrant box add centos/7`

10. What is the command used to list all Vagrant Boxes being managed by Vagrant?
c) `vagrant box list`

11. What is the correct command to initialize a Vagrant file for Vagrant Box named `centos/7` that has already been added to the system?
b) `vagrant init centos/7`

12. What is the Vagrant command to start or turn on a Vagrant Box?
vagrant up

13. What is the Vagrant command to restart a Vagrant Box?
vagrant reload

14. What is the Vagrant command to shutdown or poweroff a Vagrant Box?
vagrant halt

15. For Packer.io, what is the descriptive name of the json file used for building artifacts?
c) build template

16. What is the name of the stage that runs after the builder portion of a build template?
b) provisioner

17. What is the name of the stage that runs after building and provisioning of Packer artifacts is complete?
d) post-processor

18. If there is an error in any part of the Packer build command what will happen?
c) the command will terminate and any artifacts will be deleted

19. What is the generic name of the file that is provided to Packer to help it complete the manual question part of the install?
b) answer file

20. What are the respective names of the RedHat and Debian based answer files?
c) kickstart and preseed

## Chapter 14

TBA
