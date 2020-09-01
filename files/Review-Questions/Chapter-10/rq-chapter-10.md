# Review Questions - Chapter 10

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
a) Red Hat
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

14) What would be the command to disable (make the service not start at boot time) the httpd service on Fedora using systemd?
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