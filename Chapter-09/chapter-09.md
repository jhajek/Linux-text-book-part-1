# System Administration 
![*This generation's 'Who's in First?'*](images/Chapter-Header/Chapter-09/sandwich-2.png  "Permissions")

__Chapter 09 Objectives__

  * Understanding basic admin tools and the Linux concept of logging
  * Understand how to use basic system tools for system reporting
  * Understand using standard tools for user administration
  * Discuss standard trouble shooting procedures for system admins.
  * Understand the 3Ps method of troubleshooting

__Outcomes__

  At the completion of this chapter you will have the ability to administer a Linux system.  You will have an understanding of Linux system logs, their standard locations, and their use.  You will have a knowledge of some basic reporting tools and how to understand their output.  You will be able to administer user accounts on a Linux system. Finally you will be able to enter trouble shooting procedures.

## Sudo and the Root user paradigm

  On every Unix system dating back to Thompson's Unix, there has always been a single *superuser* account on every system.  This system is usually called the __root user__.   The __root user__ must be used with the utmost care, as that account has all the system privillege and authority to carry out any operation, even the ```rm -rf /*``` command.  Root is good for getting things done or overriding users, but is *dangerous* you should log into that account only sparingly.  Every single admin worth their salt will tell you not to use __root__ in almost any case [^90].  

  This concept is *vital* enough that on the Ubuntu distribution their is no __root__ account availalbe. On the BSD distros, Debian, and the RedHat/Fedora family - there is still a __root__ account, partially because of tradition and partially because of the way system administration always worked.  Remember that Unix was developed in the environemnt of mulitple users accessing a large central Unix server.  So you always had to have a __root__ account to overrride any activities of the users and to enforce system policies, such as disk quotas, changing network configurations, or even system wide profiles. As a reminder when you are signed in as, or acting as "root", the shell prompt displays __#__ as the last character in bash and as seen in the image below.  You can use the ```whoami``` command to find out what user account you are logged in as well.
 
![*Root User has the # sign as its shell*](images/Chapter-09/root/root.png "Root User Shell") 
  
  In order to change the user you are logged in as, without logging out, you use the ```su``` command.  Known as *superuser* or sometimes *switch user*.  By typing ```su root``` on the command line in Fedora Linux, you will be presented with a password prompt to enter the password you created during the install process for the root account.  Sudo ellevates you for a default period of 15 minutes, but it is good habit to type ```sudo``` in front of any command that needs ellevated privilleges.

### sudo  
 
  AS the great philosopher Spiderman once said, "With great power comes great responsibility."  Seeing as __root__ had unintentiaonally dangerous uses potentially.  So a temporary system was devised to blunt the power of the __root__ account as it is neccesary to use it sometimes. Sudo was created by researchers at SUNY/Buffalo in New York in 1980 to allow users to run specific commands as a different user.  Sudo was not designed for file editing. It was more designed for service management. From 1986 to 1991, development of sudo moved to CU-Boulder in Colorado and gained the cu-sudo prefix. In 1991, the code was moved to GPL.  In 1996 Todd C. Miller (one of the early maintainers) took the project under his wing moving a version of sudo to his own servers, to differentiate from cu-sudo.  By 1999 the code base was moved to the ISC license (Internet Systems Consortium), the same license dhcp and dns servers are under, it is the preferred license of the OpenBSD project and is GPL compatiple free license.  Todd C. Miller is paid by Dell to maintain sudo as part of his day job.  The sudo project homepage is located at [http://www.sudo.ws](http://www.sudo.ws). [A brief history of sudo](http://www.sudo.ws/history.html "Brief history of sudo") [^91].
  
  The tool is often mispronounced "*su - doh*".  But actual pronunciation is "*su - do*".  Either one is acceptable.  

#### Ubuntu

  Ubuntu is a bit different from the other Linux and Unix distros in regards to sudo.  They firmly believe not to have a root account as a point of differentiaition.  They rely on ```sudo``` hence the cartoon above.  The first user you create (like in Windows and Mac) is automatically added to the __sudo__ usergroup and has sudo privillege.  Then any command you need *superuser* privilleges you can simply ellevate to that privillege by typing the word ```sudo``` in front on any command.  Upon successful entry of your own password you will be ellevated up to full system authority.  Some refer to this as *god mode* but I think using that term is a bit presumptous as you do have absolute power over the system but ```sudo``` doesn't let you create the world in seven days.  
  
  One example us you can assign the value 000 to a file.  Who can access that file?  According to the permissions not even the owner can access it?  But the ```sudo``` user can.    You can find out on a system which users have sudo permissions by displaying the /etc/sudoers file: ```cat /etc/sudoers``` (you need sudo privillege).  Here is a sample screen shot. Here is where you define which users can be in the sudo group.  You may not want to give admin privillege to every user.  Also under the *user* section below you may want to give a user admin privilleges but only to execute certain commands.  This is where that would be enumerated.   
    
![*Ubuntu 15.04 /etc/sudoers*](images/Chapter-09/root/etc-sudoers.png)

Let's look at the contents in more detail.  First to edit the ```/etc/sudoers``` file you do not directly edit the file, but through a special tool called ```visudo```. The ```visudo``` command edits the sudoers file in a safe fashion. visudo locks the sudoers file against multiple simultaneous edits, provides basic sanity checks, and checks for parse errors.  If the sudoers file is currently being edited you will receive a message to try again later [^92]. You can invoke visudo from anywhere on the system.  

The first line of significance is: 
```Defaults  secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"```  
This is where you set the system path a user recieves when they become a sudo user.  

> __Example Usage:__  Using either Fedora 22 or Ubuntu 15.04: as your user account from the commandline type ```echo $PATH``` now type ```sudo sh``` and then ```echo $PATH``` notice what happens to the prompt?  Are the paths different?  Why?  Type ```exit``` to exit back to the normal user. 

The next line of interest is: 
```
# User privilege specification
root    ALL=(ALL:ALL) ALL
```

This line allows you to add specific users and then list specific commands that they have *superuser* access too.

```
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL
```

The next line allows you to add groupnames to recieve sudo access.  Any useraccount that is a memeber of this group, in Ubuntu's case *sudo* can gain *superuser* permissions

```
# Members of the admin group may gain root privileges
%admin  ALL=(ALL:ALL) ALL
```

This last entry is a catch-all command for backward compatability.  Ubuntu versions previous to 14.04 used the admin group instead of the sudo group.  

#### sudoers values

  What do the values ```%admin  ALL=(ALL:ALL) ALL```  mean?  This particular command gives every command on any system root access.  It essentially turns the root account superuser privilleges over temporarily to the user account that has that privillege.

The first column is either a user account (no %) or preceded by a % sign mean a user group name.  The second column (or the first ALL) is the hostname of the systems that can allow ellevation to *superuser*.  Now if this is your only system the value can be left at ALL.  But if you are preparing enterprise-wide /etc/sudoers configurations then you may want to specify *superuser* access only on particular systems.  The third column (second ALL) is the user that you will turn into when you use the *sudo* command.  By default it is __root__ but you may want it to be another specific user.  The fourth column after the : (fourth all) is the comma separated list of commands that user can execute. The fifth column (fourth ALL) is optional but it is an access control feature allowing only memebers of certain groups to sudo 

  Group                    Hosts                    Target User                      Commands
--------------- -----------------------------    ------------------   -----------------------------------------
   %sudo             server-1, db-server              root               /usr/sbin/postfix /usr/sbin/doveadm
   %admin                ALL                          root                               ALL
   %meninblack           ALL                           ALL                               ALL
--------------- -----------------------------    ------------------   -----------------------------------------

After the useraccount you can add an additional parameter to remove the password requirement.  This is dangerous because it means anyone who has local access to the system can now become a *superuser* account just by switching users.  It is best to leave this task for remote automated users or narrow down the powers to a single specific job.

> __Example Usage:__   The two commands below give the user ```nobody``` the ability to become sudo without requiring a password and only the power to execute the copy command.  The second command gives any user who is a memeber of the admin group the ability to sudo with out any password.
```
nobody ALL=(root) NOPASSWD: /bin/cp 
```
```
%admin  ALL=(ALL) NOPASSWD:ALL
```

#### Fedora and other Linux

   All other Linux distributions have a __root__ account user made at install time. Some minimal distributions or in FreeBSD case may only allow you to create a __root__ user at install time and make aditional users your job to create.  In Fedora you can log into an GNOME session using the root account, there might be warnings from the operating system, as it is not expecting you to be logged in as __root__.  The __root__ user has its own home directory located at ```/root```.  Even if you are going to use the __root__ account it is still advised to log in as a regular user and then use the ```sudo``` or ```su``` commands to elevate and then exit those privilleges.

   Fedora and other Linux/Unix/Mac use different groups for sudo and *superuser* access.  That group is called *wheel*.  If you look at the ```/etc/sudoers``` output below from Fedora 22 system you see the groups and file content is slightly different.

![*Fedora 22 /etc/sudoers*](images/Chapter-09/root/fedora-22-etc-sudoers/png "Fedora 22 sudoers")

#### sudo usage examples and conclusion

> __Example Usage:__ After installing the apache webserver (httpd) on Fedora 22 - the html files are served out of the default directory ```/var/www/html```.  Now if you cd to that ```/var/www/``` what do you notice about group and other ownership of ```html```?  How would you write a new ```*.html``` file?

> __Example Usage:__ To install a service: ```sudo dnf install httpd```, then you need to start the service (on Ubuntu they autostart for you, Fedora family they don't autostart), ```sudo systemctl start httpd```.

That is sudo in a nutshell, be careful and happy sudo-ing.  To learn more about the heavy details of sudo you can watch [this presentation http://blather.michaelwlucas.com/archives/2266](http://blather.michaelwlucas.com/archives/2266 "sudo") from Michael Lewis. 

## Logging and monitoring

![*Logging*](images/Chapter-09/logs/640px-PONDEROSA_PINE_LOGS_STACKED_AT_PINE_INDUSTRY_MILL_-_NARA_-_542596.jpg "Logs") [^93]  

  One of the most central functions of an operating system is logging.  Without logging facilites it would be difficult to keep track of what the system is doing.  The tehcnical term for this is __introspection__.  In the course of your Linux career you will find the logging system to be of immense help.  Not only can it be used to debug problems and find errors or security issues, but also to monitor and measure that changes made to the operating system are working to prevent issues.  From here on out when there is an application problem in Linux - your first trouble shooting step should be to go to the logs.  

### /var/log/\*

  The default logging directory on all Linux systems is located in ```/var/log```.  This is the place where the kernel, the operating system, and any default installed services will place its logs. For 30+ years this was the convetion and all common knowledge.  But with the recent adoption of systemd on all major Linux plaftorms, the logging facility that was once simple text, has now been moved into the ```journald``` and into a binary format. Note with the systemd take-over the logging convention has been changed to a binary format and placed under the ```journalctl``` command which we will cover in chapter 11.  But for Fedora 21 and any Ubuntu or Debian distro.
  
  When you install additional packages, those packages too will add a directory for its own logs.  Note in the picture below there is a log called ```httpd``` that is created when you install the https (apache2 webserver package) to track the webserver error.log and access.log files.  You will notice in these screenshots that there is a log entry for VBoxGuestAdditions--telling you that you are using VirtualBox.
  
![*Fedora 22 /var/log/\**](images/Chapter-09/logs/var-log.png "var log")

![*Ubuntu 15.04 /var/log\**](images/Chapter-09/logs/ubuntu-var-log.png "varlog")

### syslog

  The operating system needs a convention on how all the logs are transferred and stored.  That method was called syslog.  Until 1980 there were various logging methods and schemes.  The one that caught on was called syslog and was actually part of an email program, Sendmail, initially.  Syslog permits the consolidation of logging data from different types of systems in a central repository.  Syslog logs can also be transmitted remotely and aggregated on a central system.  Orginally the protocol used UDP to reduce network traffic, but now mandates the protocol to use TCP and even TLS.  Syslog listens on port 514 and has no authentication mechanism, deferring to the user to allow or block access via the firewall or other network access control. Fedora removed syslog as standard back in Fedora 20 and moved to the journalctl.  The system logs that had been stored in: [^94]
  
  * "cat /var/log/messages" will now become "journalctl".
  * "tail -f /var/log/messages" will now become "journalctl -f".
  * "grep foobar /var/log/messages" will now become "journalctl | grep foobar". 
  
  If you are using a version of RHEL 6, Centos 6, Ubuntu 14.04 and prior you will not find the journald commands and will find the traditional syslog service.   Syslog can be installed along side of journald and run in the traditional sense.  Some argue that this is a violation of the Unix priniciple of small services doing one thing (systemd is not small and does everything).  Some even claim that the journald logging service is no different than the Windows Event Logger and the way in which Windows does logs--perhaps positioning Fedora to be in a Windows style dominance over Linux?

### rsyslog

  By the year 2004 the clear need for a syslog compatible but feature rich replacement was needed.  Rsyslog was developed by [Rainer Gerhards](http://www.gerhards.net/rainer "Rainer Gerhards") and in his words, __"Rsyslog is a GPL-ed, enhanced syslogd. Among others, it offers support for reliable syslog over TCP, writing to MySQL databases and fully configurable output formats (including great timestamps)."__  It was an improvement on syslog.  It made syslog extensible and eventually replaced syslog by default.  Most Linux distributions dropped the original syslog application and replaced it with rsyslog by 2010 [^95].  

### journald and systemd

  Not to be outdone - systemd in its attempt to take over everything, has preplaced syslog with jounrald.  And this has happened in every system that has adopted systemd - Debian 8, Fedora 22, Ubuntu 15.04/15.10, Centos 7.  You can read the initial journald announcement and [justification paper here](https://docs.google.com/document/pub?id=1IC9yOXj7j6cdLLxWEBAGRL6wl97tFxgjLUEHIX3MSTs&pli=1 "Justification Paper") [^96]. 

  In Lennart Poeterrings own words, *"If you are wondering what the journal is, here's an explanation in a few words to get you up to speed: the journal is a component of systemd, that captures Syslog messages, Kernel log messages, initial RAM disk and early boot messages as well as messages written to STDOUT/STDERR of all services, indexes them and makes this available to the user. It can be used in parallel, or in place of a traditional syslog daemon, such as rsyslog or syslog-ng."* [^97]

  "One of the impetuses behind the systemd journal is to centralize the management of logs regardless of where the messages are originating. Since much of the boot process and service management is handled by the systemd process, it makes sense to standardize the way that logs are collected and accessed. The journald daemon collects data from all available sources and stores them in a binary format for easy and dynamic manipulation." [^98]
  
  To use the journal daemon (journald) all its elements are accessed through the ```journalctl``` command.  All previously sparse logs are now contained in a single binary append only log format.  The advantage of that is that the output can be programatically parsed (actually queried like a database) the downside is that some people see a "all your eggs in one basket" problem with a single central binary file.

> __Example Usage:__ These examples have been taken from the [systemd website](http://www.freedesktop.org/software/systemd/man/journalctl.html "jounralctl examples"): [^99]

> Without arguments, all collected logs are shown unfiltered:
```journalctl```

> With one match specified, all entries with a field matching the expression are shown:
```journalctl _SYSTEMD_UNIT=avahi-daemon.service```

> If two different fields are matched, only entries matching both expressions at the same time are shown:
```journalctl _SYSTEMD_UNIT=avahi-daemon.service _PID=28097```

> If two matches refer to the same field, all entries matching either expression are shown:
```journalctl _SYSTEMD_UNIT=avahi-daemon.service _SYSTEMD_UNIT=dbus.service```

> If the separator "+" is used, two expressions may be combined in a logical OR. The following will show all messages from the Avahi service process with the PID 28097 plus all messages from the D-Bus service (from any of its processes):
```journalctl _SYSTEMD_UNIT=avahi-daemon.service _PID=28097 + _SYSTEMD_UNIT=dbus.service```

> Show all logs generated by the D-Bus executable:
```journalctl /usr/bin/dbus-daemon```

> Show all kernel logs from previous boot:
```journalctl -k -b -1```

> Show a live log display from a system service apache.service:
```journalctl -f -u apache```

> This will show you only the logs of the current boot, 
```journalctl -b```

> List all messages of priority levels ERROR and worse, from the current boot:
```journalctl -b -p err```

> Filtering based on time
```journalctl --since=yesterday```

> Filter based on time range - note how difficult this would be with using grep, sort, and awk because everything is text. But since journald can be thought of a similar to a SQL database, then these types of queries are possible.
```journalctl --since=2012-10-15 --until="2011-10-16 23:59:59"```

### Log rotation

  The concept of logrotation existed under syslog and rsyslog but no longer specifically exist under journald.  Before you could use the ```/etc/logrotate.conf``` file but it is no longer needed.   Also each application may still write to a discrete syslog, but all those logs are then copied up by journald trying to be the single central repository for logs.
  
  When viewing a older syslog style text log you can use the ```tail -f``` command and it will auto-update if there is new content automatically.  Very helpful if you are watching a log for some particular output.

## System Administration 

### top

 * top
 * htop 
 * atop
 * https://github.com/p-e-w/ranwhen
 
### dmesg systat memfree 

  * sar
  * http://stackoverflow.com/questions/7908953/how-to-measure-cpu-usage/12993326#12993326
  * vmstat
  * memfree
  * cpufree
  * sysstat - iostate

## User Administration 

There are a series of commands that can be used to change or augment the owner, group, or permission of a file.  To execute these commands you will need to have administrator privillege.  User accounts and privilleges will be discussed in more detail in Chapter X.  But for right now we will use the ```sudo``` command in conjunction with these commands.  The ```sudo``` command allows us to temporarily elevate your user privillege from a user level to an admin level in order to modify the attributes of a file.  Just for experience try to execute one of these commands below without the ```sudo``` command.  You will see a permission denied error (number 2 in the 3P's). This command will be covered in depth in chapter 6.

### chmod
 
Pronounced *"chuh-mod"*. This command allows you to change the permissions or mode of a file.  You can use numeric values to change the permissions all at once.  Or you can use short cuts to assign or remove single permissions.  The outputs look like this:
   
 ![*Standard file permissions are 644 - very conservative and secure*](images/Chapter-05/permissions/standard-permission.png "Standard Permissions")
   
  Why would you want to change permissions?  Perhaps to allow all users of a system a shell script that backsup the content of your home directory.  Or to make sure that only users of a certain group can have write access (therefore delete access) to the content of a file.  Or to give a shell script execute permission so it can be run by other.
  
 ![*Same file with write and execute permission enabled*](images/Chapter-05/permissions/standard-permission-chmod.png "Standard Permissions")
  
### chown

 Pronounced *"chuh-own"*. This command allows you to change the owner of a file.  The syntax would be ```sudo chown root todolist```  There is also a shorthand feature that allows you to change the group and the owner at the same time.  ```sudo chown root:root todolist``` the value following the semi-colon will be the new group owner. 
  
> __Exercise:__  based on the previous todo-list.txt created in /tmp, issue an ```ls -l``` command - who is the owner of the file?  Who is the group owner? Change it so that the file is owned by root and the group owner is root (remember to use ```sudo```.)
  
### chgrp

Pronounced *"Chuh-gerp"*. This is the change group command.  It works just like ```chown``` but instead only changes the group ownership.

### adduser 

### userdel

### usermod

http://askubuntu.com/questions/2214/how-do-i-add-a-user-to-the-sudo-group
sudo usermod -aG sudo <username>

#### ACLs

IF you have ever worked on Windows OS you will notice that they have much deeper access control and permission system the the basic read, write, execute and owner, group, other permissions.  These are called ACL's (pronounced ack-els) __Access Control Lists__.  They are not native to the Linux world as they were not part of the original Unix standard.  Modern versions of RHEL implement there own layer of Windows like ACLs on top of the regular permissions.  There are a few other permission features that can help simulate ACLs.   __Sticky Bits__ are one of them and will be covered in Chapter X.
 
### The 3 P's Describing 99% of all Linux Problems

  * Path 
     + If you get an error message telling you that ```file not found``` or ```path does not exist```  double check your path.  It the absolute path correct?  Is it a relative path problem?  Are you on the wrong level?
  * Permission
     +  This is discussed below, every file has permission on what is allowed to be done with it based on a simple access control of read write and execute.  Maybe you don't have permission to write and therefore can't delete a file. Perhaps the file is owned by someone else and they didn't give you permission.  Check permissions via ls -la
  * dePendencies
     +  The last thing is are all the correct software dependecies installed.  Perhaps you are missing a library or have an incompatible version that is preventing a tool from running?

## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

  Questions go here

### Podcast Questions

 Questions go here

### Lab

 Lab goes here 
 
#### Footnotes
 
[^90]: [http://www.tldp.org/LDP/lame/LAME/linux-admin-made-easy/root-account.html]( http://www.tldp.org/LDP/lame/LAME/linux-admin-made-easy/root-account.html "tldp root")
 
[^91]: [http://www.sudo.ws/history.html](http://www.sudo.ws/history.html "sudo") 
 
[^92]: [http://manpages.ubuntu.com/manpages/dapper/man8/visudo.8.html](http://manpages.ubuntu.com/manpages/dapper/man8/visudo.8.html "visudo") 
 
[^93]: "<a href="https://commons.wikimedia.org/wiki/File:PONDEROSA_PINE_LOGS_STACKED_AT_PINE_INDUSTRY_MILL_-_NARA_-_542596.jpg#/media/File:PONDEROSA_PINE_LOGS_STACKED_AT_PINE_INDUSTRY_MILL_-_NARA_-_542596.jpg">PONDEROSA PINE LOGS STACKED AT PINE INDUSTRY MILL - NARA - 542596</a>" by <span class="fn value"> Daniels, Gene, photographer, Photographer (<a class="external text" href="//research.archives.gov/person/8463941" rel="nofollow">NARA record: 8463941</a>) </span> - <a title="en:U.S. National Archives and Records Administration" class="extiw" href="//en.wikipedia.org/wiki/U.S._National_Archives_and_Records_Administration">U.S. National Archives and Records Administration</a>. Licensed under Public Domain via <a href="//commons.wikimedia.org/wiki/">Wikimedia Commons</a>.

[^94]: [https://fedoraproject.org/wiki/Changes/NoDefaultSyslog](https://fedoraproject.org/wiki/Changes/NoDefaultSyslog)

[^95]: [http://www.rsyslog.com/doc/history.html](http://www.rsyslog.com/doc/history.html)

[^96]: [https://docs.google.com/document/pub?id=1IC9yOXj7j6cdLLxWEBAGRL6wl97tFxgjLUEHIX3MSTs&pli=1](https://docs.google.com/document/pub?id=1IC9yOXj7j6cdLLxWEBAGRL6wl97tFxgjLUEHIX3MSTs&pli=1)

[^97]: [http://0pointer.de/blog/projects/journalctl.html](http://0pointer.de/blog/projects/journalctl.html)

[^98]: [https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs](https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs)

[^99]: [http://www.freedesktop.org/software/systemd/man/journalctl.html](http://www.freedesktop.org/software/systemd/man/journalctl.html)

