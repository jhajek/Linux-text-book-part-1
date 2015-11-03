# System Administration 
![*This generation's 'Who's on First?'*](images/Chapter-Header/Chapter-09/sandwich-2.png  "Permissions")

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
 
  AS the great philosopher Spiderman once said, "With great power comes great responsibility."  Seeing as __root__ had unintentiaonally dangerous uses potentially.  So a temporary system was devised to blunt the power of the __root__ account as it is neccesary to use it sometimes. Sudo was created by researchers at SUNY/Buffalo in New York in 1980 to allow users to run specific commands as a different user.  Sudo was not designed for file editing. It was more designed for service management. From 1986 to 1991, development of sudo moved to CU-Boulder in Colorado and gained the cu-sudo prefix. In 1991, the code was moved to GPL.  In 1996 Todd C. Miller (one of the early maintainers) took the project under his wing moving a version of sudo to his own servers, to differentiate from cu-sudo.  By 1999 the code base was moved to the ISC license (Internet Systems Consortium), the same license dhcp and dns servers are under, it is the preferred license of the OpenBSD project and is GPL compatiple free license.  Todd C. Miller is paid by Dell to maintain sudo as part of his day job.  The sudo project homepage is located at [http://www.sudo.ws](http://www.sudo.ws). [A brief history of sudo](http://www.sudo.ws/history.html "Brief history of sudo") [^91]. The tool is often mispronounced "*su - doh*".  But actual pronunciation is "*su - do*".  Either one is acceptable.  

#### Ubuntu

  Ubuntu is a bit different from the other Linux and Unix distros in regards to sudo.  They firmly believe not to have a root account as a point of differentiaition.  They rely on ```sudo``` hence the cartoon above.  The first user you create (like in Windows and Mac) is automatically added to the __sudo__ usergroup and has sudo privillege.  Then any command you need *superuser* privilleges you can simply ellevate to that privillege by typing the word ```sudo``` in front on any command.  Upon successful entry of your own password you will be ellevated up to full system authority.  Some refer to this as *god mode* but I think using that term is a bit presumptous as you do have absolute power over the system but ```sudo``` doesn't let you create the world in seven days.  
  
  One example us you can assign the value 000 to a file.  Who can access that file?  According to the permissions not even the owner can access it?  But the ```sudo``` user can.    You can find out on a system which users have sudo permissions by displaying the /etc/sudoers file: ```cat /etc/sudoers``` (you need sudo privillege).  Here is a sample screen shot. Here is where you define which users can be in the sudo group.  You may not want to give admin privillege to every user.  Also under the *user* section below you may want to give a user admin privilleges but only to execute certain commands.  This is where that would be enumerated.   
    
![*Ubuntu 15.04 /etc/sudoers*](images/Chapter-09/root/etc-sudoers.png)

Let's look at the contents in more detail.  First to edit the ```/etc/sudoers``` file you do not directly edit the file, but through a special tool called ```visudo```. The ```visudo``` command edits the sudoers file in a safe fashion. visudo locks the sudoers file against multiple simultaneous edits, provides basic sanity checks, and checks for parse errors.  If the sudoers file is currently being edited you will receive a message to try again later [^92]. You can invoke visudo from anywhere on the system.  

The first line is where you set the system path a user recieves when they become a sudo user.  
 ```Defaults  secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"```  

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
%admin  ALL=(ALL) NOPASSWD:ALL
```

#### Fedora and other Linux

   All other Linux distributions have a __root__ account user made at install time. Some minimal distributions or in FreeBSD case may only allow you to create a __root__ user at install time and make aditional users your job to create.  In Fedora you can log into an GNOME session using the root account, there might be warnings from the operating system, as it is not expecting you to be logged in as __root__.  The __root__ user has its own home directory located at ```/root```.  Even if you are going to use the __root__ account it is still advised to log in as a regular user and then use the ```sudo``` or ```su``` commands to elevate and then exit those privilleges.

   Fedora and other Linux/Unix/Mac use different groups for sudo and *superuser* access.  That group is called *wheel*.  If you look at the ```/etc/sudoers``` output below from Fedora 22 system you see the groups and file content is slightly different.

![*Fedora 22 /etc/sudoers*](images/Chapter-09/root/fedora-22-etc-sudoers.png "Fedora 22 sudoers")

#### sudo usage examples and conclusion

> __Example Usage:__ After installing the apache webserver (httpd) on Fedora 22 - the html files are served out of the default directory ```/var/www/html```.  Now if you cd to that ```/var/www/``` what do you notice about group and other ownership of ```html```?  How would you write a new ```*.html``` file?

> __Example Usage:__ To install a service: ```sudo dnf install httpd```, then you need to start the service (on Ubuntu they autostart for you, Fedora family they don't autostart), ```sudo systemctl start httpd```.

That is sudo in a nutshell, be careful and happy sudo-ing.  To learn more about the heavy details of sudo you can watch [this presentation http://blather.michaelwlucas.com/archives/2266](http://blather.michaelwlucas.com/archives/2266 "sudo") from Michael Lewis. 

## Logging and Monitoring

![*Logging*](images/Chapter-09/logs/640px-PONDEROSA_PINE_LOGS_STACKED_AT_PINE_INDUSTRY_MILL_-_NARA_-_542596.jpg "Logs") [^93]  

  One of the most central functions of an operating system is logging.  Without logging facilites it would be difficult to keep track of what the system is doing.  The tehcnical term for this is __introspection__.  In the course of your Linux career you will find the logging system to be of immense help.  Not only can it be used to debug problems and find errors or security issues, but also to monitor and measure that changes made to the operating system are working to prevent issues.  From here on out when there is an application problem in Linux - your first trouble shooting step should be to go to the logs.  

### /var/log/\*

  The default logging directory on all Linux systems is located in ```/var/log```.  This is the place where the kernel, the operating system, and any default installed services will place its logs. For 30+ years this was the convetion and all common knowledge.  But with the recent adoption of systemd on all major Linux plaftorms, the logging facility that was once simple text, has now been moved into the ```journald``` and into a binary format. Note with the systemd take-over the logging convention has been changed to a binary format and placed under the ```journalctl``` command which we will cover in chapter 11.  But for Fedora 21 and any Ubuntu or Debian distro.
  
  When you install additional packages, those packages too will add a directory for its own logs.  Note in the picture below there is a log called ```httpd``` that is created when you install the https (apache2 webserver package) to track the webserver error.log and access.log files.  You will notice in these screenshots that there is a log entry for VBoxGuestAdditions--telling you that you are using VirtualBox.
  
![*Fedora 22 /var/log/\**](images/Chapter-09/logs/var-log.png "var log")

![*Ubuntu 15.04 /var/log\**](images/Chapter-09/logs/ubuntu-var-log.png "varlog")

### syslog

  The operating system needs a convention on how all the logs are transferred and stored.  That method was called syslog.  Until 1980 there were various logging methods and schemes.  The one that caught on was called syslog and was actually part of an email program, Sendmail, initially.  Syslog permits the consolidation of logging data from different types of systems in a central repository.  Syslog logs can also be transmitted remotely and aggregated on a central system.  Orginally the protocol used UDP to reduce network traffic, but now mandates the protocol to use TCP and even TLS.  Syslog listens on port 514 and has no authentication mechanism, deferring to the user to allow or block access via the firewall or other network access control. Fedora removed syslog as standard back in Fedora 20 and moved to the journalctl.  The system logs that had been stored in: [^94]
  
  * ```cat /var/log/messages``` will now become ```journalctl```
  * ```tail -f /var/log/messages``` will now become ```journalctl -f```
  * ```grep foobar /var/log/messages``` will now become ```journalctl | grep foobar``` 
  
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
```bash
journalctl
```

> With one match specified, all entries with a field matching the expression are shown:
```bash
journalctl _SYSTEMD_UNIT=avahi-daemon.service
```

> If two different fields are matched, only entries matching both expressions at the same time are shown:
```bash
journalctl _SYSTEMD_UNIT=avahi-daemon.service _PID=28097
```

> If two matches refer to the same field, all entries matching either expression are shown:
```bash
journalctl _SYSTEMD_UNIT=avahi-daemon.service _SYSTEMD_UNIT=dbus.service
```

> If the separator "+" is used, two expressions may be combined in a logical OR. The following will show all messages from the Avahi service process with the PID 28097 plus all messages from the D-Bus service (from any of its processes):
```bash
journalctl _SYSTEMD_UNIT=avahi-daemon.service _PID=28097 + _SYSTEMD_UNIT=dbus.service
```

> Show all logs generated by the D-Bus executable:
```bash
journalctl /usr/bin/dbus-daemon
```

> Show all kernel logs from previous boot:
```bash
journalctl -k -b -1
```

> Show a live log display from a system service apache.service:
```bash
journalctl -f -u apache
```

> This will show you only the logs of the current boot, 
```bash
journalctl -b
```

> List all messages of priority levels ERROR and worse, from the current boot:
```bash
journalctl -b -p err
```

> Filtering based on time
```bash
journalctl --since=yesterday
```

> Filter based on time range - note how difficult this would be with using grep, sort, and awk because everything is text. But since journald can be thought of a similar to a SQL database, then these types of queries are possible.
```bash
journalctl --since=2012-10-15 --until="2011-10-16 23:59:59"
```

> See log entries created only by the SSH service
```bash
journalctl _COMM=sshd
```

### Log rotation

  The concept of logrotation existed under syslog and rsyslog but no longer specifically exist under journald.  Before you could use the ```/etc/logrotate.conf``` file but it is no longer needed.   Also each application may still write to a discrete syslog, but all those logs are then copied up by journald trying to be the single central repository for logs.
  
  When viewing a older syslog style text log you can use the ```tail -f``` command and it will auto-update if there is new content automatically.  This command can be very helpful if you are watching a log for some particular output - can you find the journald equivilant?  ```journalctl --follow --since=-1day```
  
  You can find the systemd journald log rotation and collection spefics [here](http://www.freedesktop.org/software/systemd/man/journald.conf.html "journald.conf"): [^101] 
  
  ```/etc/systemd/journald.conf```
  
  Below are the default settings - even though they are commented out they are set there to give a template for a system admin to modify.
  
  Entries can be service specific and kept in subdirectories ```/etc/systemd/journald.conf.d/*.conf```  any configurations in these directories take precedance over the main journald.conf file.  
  
Storage

:     Controls where to store journal data. One of "volatile", "persistent", "auto" and "none". If "volatile", journal log data will be stored only in memory, i.e. below the /run/log/journal hierarchy (which is created if needed). If "persistent", data will be stored preferably on disk, i.e. below the /var/log/journal hierarchy (which is created if needed), with a fallback to /run/log/journal (which is created if needed), during early boot and if the disk is not writable. "auto" is similar to "persistent" but the directory /var/log/journal is not created if needed, so that its existence controls where log data goes. "none" turns off all storage, all log data received will be dropped. Forwarding to other targets, such as the console, the kernel log buffer, or a syslog socket will still work however. Defaults to "auto".

SplitMode

:   Controls whether to split up journal files per user. One of "uid", "login" and "none". If "uid", all users will get each their own journal files regardless of whether they possess a login session or not, however system users will log into the system journal. If "login", actually logged-in users will get each their own journal files, but users without login session and system users will log into the system journal. If "none", journal files are not split up by user and all messages are instead stored in the single system journal. Note that splitting up journal files by user is only available for journals stored persistently. If journals are stored on volatile storage (see above), only a single journal file for all user IDs is kept. Defaults to "uid".

MaxLevelStore, MaxLevelSyslog, MaxLevelKMsg, MaxLevelConsole, MaxLevelWall

:    Controls the maximum log level of messages that are stored on disk, forwarded to syslog, kmsg, the console or wall (if that is enabled, see above). As argument, takes one of "emerg", "alert", "crit", "err", "warning", "notice", "info", "debug", or integer values in the range of 0..7 (corresponding to the same levels). Messages equal or below the log level specified are stored/forwarded, messages above are dropped. Defaults to "debug" for MaxLevelStore= and MaxLevelSyslog=, to ensure that the all messages are written to disk and forwarded to syslog. Defaults to "notice" for MaxLevelKMsg=, "info" for MaxLevelConsole=, and "emerg" for MaxLevelWall=.

SystemMaxFileSize and RuntimeMaxFileSize 

:    Control how large individual journal files may grow at maximum. This influences the granularity in which disk space is made available through rotation, i.e. deletion of historic data. Defaults to one eighth of the values configured with SystemMaxUse= and RuntimeMaxUse=, so that usually seven rotated journal files are kept as history.

    Specify values in bytes or use K, M, G, T, P, E as units for the specified sizes (equal to 1024, 1024²,... bytes). Note that size limits are enforced synchronously when journal files are extended, and no explicit rotation step triggered by time is needed.

SystemMaxFiles and RuntimeMaxFiles 

:    Control how many individual journal files to keep at maximum. Note that only archived files are deleted to reduce the number of files until this limit is reached; active files will stay around. This means that in effect there might still be more journal files around in total than this limit after a vacuuming operation is complete. This setting defaults to 100.

## System Monitoring

  The first step in system administration is monitoring.  Just like viewing logs, also knowing what is currently going on resource wise can be very helpful.  The first command we want to look at to help us understand what is occuring on our system is a command called ```top``.  This stands for *table of processes*. Top produces a list of running processes selected by user-specific criteria [^100].  The traditional Unix version was written by William LeFebvre and originally copyrighted in 1984. Since 1991 there has been a Linux based GPL top command which is part of the [procps-ng suite of tools](https://gitlab.com/procps-ng/procps) [^102].

### top
  
![*Fedora 22 top screenshot*](images/Chapter-09/monitoring/top/top.png "top") 
 
   When the screen comes up there is a lot of data present and at first it might not be clear what you are looking at.  The main key you need to know is *q* which will quit and exit the top command (just like the less command.)

![*top avg*](images/Chapter-09/monitoring/top/top-avg.png "Top average")

  This section displays the system average loads over longer rolling periods.  1 minute, 5 minutes, and 15 minute rolling average.  
 
![*top usage*](images/Chapter-09/monitoring/top/top-usage.png "Top usage") 

  This section tells you the number of proceses, how much memory and swap is in use and how much is free.  It also tells you the breakdown between users and system on who is using the CPU percentage wise.

![*top processes*](images/Chapter-09/monitoring/top/top-processes.png "Top process")   
   
   Finally this section shows the name and induvidual breakdown of the processes and how much resources they are using.  We will cover this in more detail in chapter 11.  
   
The ```top``` command also has the ability to sort and modify its output while running.  

   Key                  Action in Top
-----------  --------------------------------------------------------------------------------
'd' or 's'     Plus a positive nubmer you can change the reporting cycle.   
   'u'         Plus a user's name will filter only those processes they own
   'k'         Sorts by \%CPU usage.  
   'I'         Sorts by CPU time usage
   'm'         Same as above but more granular
   'n'         Percentage of memory that a task is using.
'w' STATE      D=uninterruptable sleep, R=running, S=sleeping, T=traced or stopped, Z=zombie
-----------  --------------------------------------------------------------------------------

### htop 
 
   The htop command is an extesnion to the Linux top command.  It is written in C using the ncurses grpahics library so it has mouse support.  It also has metered output-and uses all the same interactive commands as ```top```.  The homepage for the project can be found at [http://hisham.hm/htop](http://hisham.hm/htop/ "htop")[^103].  The ```htop``` command needs to be installed via apt-get or yum/dnf.
   
![*htop*](images/Chapter-09/monitoring/top/htop.png "htop")

### atop

![*atop*](images/Chapter-09/monitoring/top/atop.png "atop")   

  There is one other monitoring tool named ```atop```.  The project is located at [http://www.atoptool.nl/](http://www.atoptool.nl/ "atop") The ```atop``` command can be installed via apt-get or yum/dnf.  The ```atop``` command has a series of features compared to other monitoring tools.  Here are the highligths.
  
  *  Resource consumption by all processes
  *  Utilization of all relevant resources
  *  Permanent logging of resource utilization
  *  Highlight critical resources
  *  Scalable window width
   
### systemd-cgtop

  You were probably wondering if systemd had its own system monitoring tool.  And you would be correct to think so.  It's name is systemd-cgtop and the command is native to any system running systemd.  The usage patterns can be found at [http://www.freedesktop.org/software/systemd/man/systemd-cgtop.html](http://www.freedesktop.org/software/systemd/man/systemd-cgtop.html "systemd-cgtop") The nature of the output is the same as top but the information is being queried from systemd and not from the ```/proc``` filesystem.
 
### Additional Monitoring Tools

  There are many additional standard Linux tools as well as many GitHub projects being launched all the time to solve specific monitoring problems.  Below is a list of some of the utilities that comes with Linux ```top``` under the procps and procps-ng packages.  

   Command                              Function
--------------  -------------------------------------------------------------
  ```free```       Report the amount of free and used memory in the system
  ```load```         Graphical representation of system load average
  ```top```           Dynamic real-time view of running processes
 ```uptime```         Display how long the system has been running
 ```vmstat```              Report virtual memory statistics
   ```w```            Report logged in users and what they are doing
  ```watch```     Execute a program periodically, showing output fullscreen
--------------  -------------------------------------------------------------

#### Load Generators 

The opposite side of system monitoring is sometime you want to generate a load to see hwo your system responds.  On modern system that are multi-core with fast memory. There is a tool called ```stress``` you can install it via The Ubuntu and Fedora software stores or form the commandline using apt-get and yum/dnf.  It is also available for the Mac via the Homebrew package manager. The command ```stress --cpu 2 --timeout 60```  will cause two processors to max out for 60 seconds.  You would then be able to see this using an of the above top based commands.  There are some other ways to generate loads in bash as well located here: [http://stackoverflow.com/questions/7908953/how-to-measure-cpu-usage/12993326#12993326](http://stackoverflow.com/questions/7908953/how-to-measure-cpu-usage/12993326#12993326 "Bash load generator ideas")

#### ranwhen

Another interesting project is something called ranwhen.  It shows a visual representation of ```uptime``` on all your previous reboots.  This allows you to see in detail the amount of time your system ran for and also the time between restarts.  This project is written in Python 3 so you need to make sure that Python 3 is installed prior to running it. Simply clone the repo via git (may need to install git as well) via ```git clone https://github.com/p-e-w/ranwhen.git```  Once cloned, cd into the ranwhen directory and type ```python3 ranwhen.py```

#### sar and iostat

In addition to memory, CPU, and process information.  You can other commands to measure system I/O. The ```sar``` command - system activity report -- is something that came from the BSD Unixes and was ported over to Linux. It is used to sample and report various cumulative statistic counters maintained by the operating system.  You can take *n* samples at *t* intervals. Finally the ```iostat``` command, which in Linux is part of the sysstat package--displays kernel I/O statistics on terminal, device and cpu operations. A common word for this is I/O measurement or throughput.  These reports can then be used to change system configurations to better balance the input/output load between physical disks.  

![*iostat*](images/Chapter-09/monitoring/io/iostat.png "iostat")

## User Administration 

There are a series of commands that can be used to change or augment the owner, group, or permission of a file.  To execute these commands you will need to have administrator privillege.  The nature of the user commands allow you to do three operations.  The commands are: useradd, userdel, and usermod.   

### useradd

  The useradd command allows you to add a new user to the system.  You can set user defaults by typing the command below.  The -D option reads from the ```/etc/default/useradd``` where you can set the default values a new user created will inherit.
```bash
useradd -D name-of-account-to-add
```

![*useradd*](images/Chapter-09/user-administration/default/etc-default.png "etc-default")

You have the option as well to override the default values and set your own values for a new user.

  Option         Function
-------------   ----------------------------------------------------
```-c```          Add a commment
```-d```          User's home directory
```-e```          Date in which a user account expires
```-g```          Add user to a specific primary group
```-G```          Add user to additional supplimentary groups
```-m```          Create user's home directory if it doesn't exist
```-s```          Assign the user's shell
-------------   ----------------------------------------------------

> __Example Usage:__ What do the options and arguments below do?  Type it in an see what happens.
```bash
sudo useradd -c "This is a user for ITMO-456-02 Fall 2015" -d /home/controller -G sudo -s /bin/ksh -m controller
```
In Debian distributions there is a abstraction layer called ```adduser``` and ```addgroup``` which are interfaces to the useradd and groupadd commands.  It is just a perl script that passes the values you enter in the menu to the useradd command.  On all other non-Debian distros ```adduser``` is a symlink to ```useradd``` command.


### userdel

### usermod

http://askubuntu.com/questions/2214/how-do-i-add-a-user-to-the-sudo-group
sudo usermod -aG sudo <username>

### chmod
 
Pronounced *"chuh-mod"*. This command allows you to change the permissions or mode of a file.  You can use numeric values to change the permissions all at once.  Or you can use short cuts to assign or remove single permissions.  The outputs look like this:
   
 ![*Standard file permissions are 644 - very conservative and secure*](images/Chapter-09/user-administration/standard-permission.png "Standard Permissions")
   
  Why would you want to change permissions?  Perhaps to allow all users of a system a shell script that backsup the content of your home directory.  Or to make sure that only users of a certain group can have write access (therefore delete access) to the content of a file.  Or to give a shell script execute permission so it can be run by other.
  
 ![*Same file with write and execute permission enabled*](images/Chapter-09/user-administration/standard-permission-chmod.png "Standard Permissions")
  
### chown

 Pronounced *"chuh-own"*. This command allows you to change the owner of a file.  The syntax would be ```sudo chown root todolist```  There is also a shorthand feature that allows you to change the group and the owner at the same time.  ```sudo chown root:root todolist``` the value following the semi-colon will be the new group owner. 
  
> __Exercise:__  based on the previous todo-list.txt created in /tmp, issue an ```ls -l``` command - who is the owner of the file?  Who is the group owner? Change it so that the file is owned by root and the group owner is root (remember to use ```sudo```.)
  
### chgrp

Pronounced *"Chuh-gerp"*. This is the change group command.  It works just like ```chown``` but instead only changes the group ownership.


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

[^100]: [https://en.wikipedia.org/wiki/Top_(software)](https://en.wikipedia.org/wiki/Top_\(software\))

[^101]: [http://www.freedesktop.org/software/systemd/man/journald.conf.html](http://www.freedesktop.org/software/systemd/man/journald.conf.html)

[^102]: [http://www.rogerbinns.com/blog/linux-top-origins.html](http://www.rogerbinns.com/blog/linux-top-origins.html)

[^103]: [http://hisham.hm/htop/](http://hisham.hm/htop/)


