# System Administration and systemd
![*This generation's 'Who's on First?'*](images/Chapter-Header/Chapter-09/sandwich-2.png  "Permissions")

### Objectives

  * Understand the concept of the ```sudo``` command and the root user security implications
  * Understand the basic admin tools and the Linux concept of logging and the systemd concept of logging with journald
  * Understand how to use basic system tools for system monitoring and reporting
  * Understand using standard tools for user administration
  * Understand the 3Ps method of troubleshooting

### Outcomes

  At the completion of this chapter you will have the ability to administer a Linux system.  You will have an understanding of Linux system logs, their standard locations, and their use.  You will have a knowledge of system monitoring tools and how to understand their output.  You will be able to administer user accounts on a Linux system. Finally you will be able to perform trouble shooting procedures on a Linux system.

## Sudo and the Root User Paradigm

  On every Unix system dating back to Thompson's Unix, there has always been a single *superuser* account on every system.  This account is usually called the __root user__ or __root__.   The __root user__ must be used with the utmost care, as that account has all the system privilege and authority to carry out any operation, even the ```rm -rf /*``` command.  Root is good for getting things done or overriding users, but is *dangerous.* You should log into that account only sparingly.  Every single admin worth their salt will tell you not to use __root__ in almost any case [^90].  

  This concept is *vital* enough that on the Ubuntu distribution there is no __root__ account available. On the BSD distros, Debian, and the RedHat/Fedora family - there is still a __root__ account, partially because of tradition and partially because of the way system administration always worked.  Remember that Unix was developed in the environment of multiple users accessing a large central Unix server.  So you always had to have a __root__ account to override any activities of the users and to enforce system policies, such as disk quotas, changing network configurations, or even system wide profiles. As a reminder when you are signed in as, or acting as "root", the shell prompt displays __#__ as the last character in bash and as seen in the image below.  You can use the ```whoami``` command to find out what user account you are logged in as well.

![*Root User has the # sign as its shell*](images/Chapter-09/root/root.png "Root User Shell")

  In order to change the user you are logged in as, without logging out, you use the ```su``` command.  Known as *superuser* or *switch user*.  By typing ```su root``` on the command line in Fedora Linux, you will be presented with a password prompt to enter the password you created during the install process for the root account.  You still need to type ```exit``` to logout from the user you switched too.  The sudo command on the other hand, only elevates you for a default period of 15 minutes and then returns you to your standard user account.  It is good habit to type ```sudo``` in front of any command that needs elevated privileges.

### sudo  

  As a great philosopher once said, *"With great power comes great responsibility."*  Seeing as __root__ has unintentionally dangerous uses a temporary system was devised to blunt the power of the __root__ account. The __sudo__ command was created by researchers at SUNY/Buffalo in New York in 1980 to allow users to run specific commands as a different user, in this case as root while not remaining or needing to sign in as root. 

  From 1986 to 1991, development of ```sudo``` moved to CU-Boulder in Colorado and gained the cu-sudo prefix. In 1991, the code was relicensed under the GPLv2.  In 1996 Todd C. Miller (one of the early maintainers) took the project under his wing moving a version of sudo to his own servers, to differentiate from cu-sudo.  By 1999 the code base was moved to the ISC license ( [Internet Systems Consortium](https://www.isc.org/ "ISC") ), the same license the bind-dns server is under, it is the preferred license of the OpenBSD project and is GPL compatible free license.  Todd C. Miller is paid by Dell to maintain ```sudo``` as part of his day job.  The sudo project homepage is located at [http://www.sudo.ws](http://www.sudo.ws). [A brief history of sudo](http://www.sudo.ws/history.html "Brief history of sudo") [^91]. The tool is often mispronounced "*su - doh*".  But actual pronunciation is "*su - doo*".    

#### Ubuntu

  Ubuntu is a bit different from the other Linux and Unix distros in regards to sudo.  They firmly believe not to have a root account as a point of differentiation.  They rely on ```sudo``` hence the cartoon above.  The first user you create (like in Windows and Mac) is automatically added to the __sudo__ usergroup and has sudo privilege.  Then any command you need *superuser* privileges you can simply ellevate to that privilege by typing the word ```sudo``` in front on any command.  Upon successful entry of your own password you will be elevated up to full system authority.  Some refer to this as *god mode* but I think using that term is a bit presumptuous as you do have absolute power over the system but ```sudo``` doesn't let you create the world in seven days.  

  One example is you can assign the permission value of 000 to a file.  Who can access that file now?  According to the permissions, not even the owner can access it.  But the root user can, or a user issuign a ```sudo``` command.    You can find which users on a system have sudo permissions by displaying the /etc/sudoers file: ```cat /etc/sudoers``` (you need sudo privilege).  Here is a sample screen shot where you define which users can be in the sudo group.  You may not want to give admin privilege to every user.  The conf file, under the *user* section, allows you to specifiy root privileges per command. 

![*Ubuntu 15.04 /etc/sudoers*](images/Chapter-09/root/etc-sudoers.png)

Let's look at the contents in more detail.  First to edit the ```/etc/sudoers``` file you do not directly edit the file, but through a special tool called ```visudo```. The ```visudo``` command edits the sudoers file in a safe fashion. visudo locks the sudoers file against multiple simultaneous edits, provides basic sanity checks, and checks for parse errors.  If the sudoers file is currently being edited you will receive a message to try again later [^92]. You can invoke visudo from anywhere on the system.  

The first line is where you set the system path a user receives when they become a sudo user.  
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

The next line allows you to add groupnames to receive sudo access.  Any useraccount that is a member of this group, in Ubuntu's case *sudo* can gain *superuser* permissions

```
# Members of the admin group may gain root privileges
%admin  ALL=(ALL:ALL) ALL
```

This last entry is a catch-all command for backward compatibility.  Ubuntu versions previous to 14.04 used the admin group instead of the sudo group.  

#### sudoers values

  What do the values ```%admin  ALL=(ALL:ALL) ALL```  mean?  This particular command gives every user in the admin group access to execute every command the system.  It essentially turns the root account superuser privileges over temporarily to the user account or group that has that privilege.

The first column is either a user account (no %) or preceded by a % sign meaning a user group.  The second column (or the first ALL) is the hostname of the systems that can allow elevation to *superuser*.  Now if this is your only system the value can be left at ALL.  But if you are preparing enterprise-wide /etc/sudoers configurations then you may want to specify *superuser* access only on particular systems.  The third column (second ALL) is the user that you will turn into when you use the *sudo* command.  By default it is __root__ but you may want it to be another specific user.  The fourth column after the : (third all) is the comma separated list of commands that user can execute. The fifth column (fourth ALL) is optional but it is an access control feature allowing only members of certain groups to sudo.

  Group                    Hosts                    Target User                      Commands
--------------- -----------------------------    ------------------   -----------------------------------------
   %sudo             server-1, db-server              bkupuser               /usr/sbin/postfix /usr/sbin/doveadm
   %admin                ALL                         dbadmin                              ALL
   %cia                  ALL                           ALL                               ALL
--------------- -----------------------------    ------------------   -----------------------------------------

After the useraccount you can add an additional parameter to remove the password requirement.  This is dangerous because it means anyone who has local access to the system can now become a *superuser* account just by switching users.  It is best to leave this task for remote automated users or narrow down the powers to a single specific job.

> __Example Usage:__   The two commands below give the user ```bkupuser``` the ability to become sudo without requiring a password and only the power to execute the copy command.  The second command gives any user who is a member of the admin group the ability to sudo with out any password.
```
bkupuser ALL=(root) NOPASSWD: /usr/bin/mysqldump
%vagrant  ALL=(ALL) NOPASSWD:ALL
%admin  ALL=(ALL) NOPASSWD:ALL
```

#### Fedora and other Linux

   All other Linux distributions have a __root__ account user made at install time. Some minimal distributions or in FreeBSD case may only allow you to create a __root__ user at install time and make additional users your job to create.  In Fedora you can log into an GNOME session using the root account, there might be warnings from the operating system, as it is not expecting you to be logged in as __root__.  The __root__ user has its own home directory located at ```/root```.  Even if you are going to use the __root__ account it is still advised to log in as a regular user and then use the ```sudo``` or ```su``` commands to elevate and then exit those privileges.

   Fedora and other Linux/Unix/Mac use different groups for sudo and *superuser* access.  That group is called *wheel*.  If you look at the ```/etc/sudoers``` output below from Fedora 22 system you see the groups and file content is slightly different.

![*Fedora 22 /etc/sudoers*](images/Chapter-09/root/fedora-22-etc-sudoers.png "Fedora 22 sudoers")

#### sudo usage examples and conclusion

> __Example Usage:__ After installing the apache webserver (httpd) on Fedora - the html files are served out of the default directory ```/var/www/html```.  Now if you cd to that ```/var/www/``` what do you notice about group and other ownership of ```html```?  How would you write a newfile  ```support.html``` file in that directory?

> __Example Usage:__ To install a service: ```sudo dnf install httpd```, then you need to start the service (on Ubuntu they autostart for you, Fedora family they don't autostart), ```sudo systemctl start httpd```.

That is sudo in a nutshell, be careful and happy sudo-ing.  To learn more about the heavy details of sudo you can watch [this presentation http://blather.michaelwlucas.com/archives/2266](http://blather.michaelwlucas.com/archives/2266 "sudo") from Michael Lewis.

## Logging and Monitoring

![*Logging*](images/Chapter-09/logs/640px-PONDEROSA_PINE_LOGS_STACKED_AT_PINE_INDUSTRY_MILL_-_NARA_-_542596.jpg "Logs") [^93]  

  One of the most central functions of an operating system is logging.  Without logging facilites it would be difficult to keep track of what the system is doing.  The technical term for this is __introspection__.  In the course of your Linux career you will find the logging system to be of immense help.  Not only can it be used to debug problems and find errors or security issues, but also to monitor and measure that changes made to the operating system are working to prevent issues.  From here on out when there is an application problem in Linux - your first trouble shooting step should be to go to the logs.  

### /var/log/\*

  The default logging directory on all Linux systems is located in ```/var/log```.  This is the place where the kernel, the operating system, and any default installed services will place its logs. For 30+ years this was the convention and all common knowledge.  But with the recent adoption of systemd on all major Linux platforms, the logging facility that was once simple text, has now been moved into the ```journald``` and into a binary format. Note with the systemd take-over the logging convention has been changed to a binary format and placed under the ```journalctl``` command which we will cover in chapter 11.  But for Fedora 21 and any Ubuntu or Debian distro.

  When you install additional packages, those packages too will add a directory for its own logs.  Note in the picture below there is a log called ```httpd``` that is created when you install the https (apache2 webserver package) to track the webserver error.log and access.log files.  You will notice in these screenshots that there is a log entry for VBoxGuestAdditions--telling you that you are using VirtualBox.

![*Fedora contents of /var/log/\**](images/Chapter-09/logs/var-log.png "var log")

![*Ubuntu contents of /var/log\**](images/Chapter-09/logs/ubuntu-var-log.png "var log")

### syslog

  The operating system needs a convention on how all the logs are transferred and stored.  That method was called syslog.  Until 1980 there were various logging methods and schemes.  The one that caught on was called syslog and was actually part of an email program, Sendmail, initially.  Syslog permits the consolidation of logging data from different types of systems in a central repository.  Syslog logs can also be transmitted remotely and aggregated on a central system.  Originally the protocol used UDP to reduce network traffic, but now mandates the protocol to use TCP and even TLS.  Syslog listens on port 514 and has no authentication mechanism, deferring to the user to allow or block access via the firewall or other network access control. Fedora removed syslog as standard back in Fedora 20 and moved to ```journalctl```.  The system logs that had been stored in: [^94]

\newpage

#### Error Levels

Syslog has adopted default levels to describe the severity of a log that is recorded. Standard syslog error levels [^104].  

Value    Severity        Keyword   		Description     			 	            Examples
----- ---------------- ---------- ---------------------------  ----------------------------------
  0 	  Emergency       emerg      System is unusable  			     This level should not be used
															     by applications.																
  1        Alert         alert     Should be corrected 			     Loss of the primary
								                   immediately 					         ISP connection
  2       Critical       crit      Critical conditions           A failure in the system's
															                                   primary application.
	3        Error         err       Error conditions              An application has exceeded its
																                                 file storage limit and attempts
																                                 to write are failing.
  4       Warning        warning   May indicate that an error    A non-root file system has
								                   will occur if action is       only 2GB remaining.
								                   not taken.  
  5        Notice        notice    Events that are unusual,
								                   but not error conditions.
  6      Informational   info     Normal operational messages    An application has started,
								                  that require no action.  	     paused or ended successfull.
  7        Debug         debug    Information useful to
                  								developers for debugging
							                    the application.   
----- ---------------- ---------- ---------------------------  ----------------------------------

### rsyslog

  By the year 2004 the clear need for a syslog compatible but feature rich replacement was needed.  Rsyslog was developed by [Rainer Gerhards](http://www.gerhards.net/rainer "Rainer Gerhards") and in his words, __"Rsyslog is a GPL-ed, enhanced syslogd. Among others, it offers support for reliable syslog over TCP, writing to MySQL databases and fully configurable output formats (including great timestamps)."__  It was an improvement on syslog.  It made syslog extensible and eventually replaced syslog by default.  Most Linux distributions dropped the original syslog application and replaced it with rsyslog by 2010 [^95].    

### journald and systemd

  Not to be outdone - systemd has preplaced syslog with journald.  And this has happened in every system that has adopted systemd - Debian 8, Fedora 22, Ubuntu 15.04/15.10, Centos 7.  You can read the initial journald announcement and [justification paper here](https://docs.google.com/document/pub?id=1IC9yOXj7j6cdLLxWEBAGRL6wl97tFxgjLUEHIX3MSTs&pli=1 "Justification Paper") [^96].

  In Lennart Poeterring's own words, *"If you are wondering what the journal is, here's an explanation in a few words to get you up to speed: the journal is a component of systemd, that captures Syslog messages, Kernel log messages, initial RAM disk and early boot messages as well as messages written to STDOUT/STDERR of all services, indexes them and makes this available to the user. It can be used in parallel, or in place of a tradditional syslog daemon, such as rsyslog or syslog-ng."* [^97]

  *"One of the impetuses behind the systemd journal is to centralize the management of logs regardless of where the messages are originating. Since much of the boot process and service management is handled by the systemd process, it makes sense to standardize the way that logs are collected and accessed. The journald daemon collects data from all available sources and stores them in a binary format for easy and dynamic manipulation. [^98]"*

  If you are using a version of RHEL 6, Centos 6, Ubuntu 14.04, or Debian 7 and prior you will not find the journald or systemd commands and will find the traditional syslog service.   Syslog can be installed along side of journald and run in the tradditional sense.  Some argue that this is a violation of the Unix principle of small services doing one thing (systemd is not small and does many things).  Some even claim that the journald logging service is no different than the Windows Event Logger and the way in which Windows does logs.  The traditional ways of using syslog had been modified by journald.

  * ```cat /var/log/messages``` will now become ```journalctl```
  * ```tail -f /var/log/messages``` will now become ```journalctl -f```
  * ```grep sshd /var/log/messages``` will now become ```journalctl _COMM=sshd```

  To use the journal daemon (journald) all its elements are accessed through the ```journalctl``` command.  All previously sparse logs are now contained in a single binary append only log format.  The advantage of that is that the output can be programmatically parsed (actually queried like a database) the downside is that some people see an "all your eggs in one basket" problem with a single central binary file.

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

  The concept of logrotation existed under syslog and rsyslog but no longer exist under journald.  Before you could use the ```/etc/logrotate.conf``` file but it is no longer needed.   Also each application may still write to a discrete syslog, but all those logs are then copied up by journald trying to be the single central repository for logs.

  When viewing a older syslog style text log you can use the ```tail -f``` command and it will auto-update if there is new content automatically.  This command can be very helpful if you are watching a log for some particular output - can you find the journald equivilent?  ```journalctl --follow --since=-1day```

  You can find the systemd journald log rotation and collection specifics [here](http://www.freedesktop.org/software/systemd/man/journald.conf.html "journald.conf"): [^101]

  ```/etc/systemd/journald.conf```

  Below are the default settings - even though they are commented out they are set there to give a template for a system admin to modify.

  Entries can be service specific and kept in subdirectories ```/etc/systemd/journald.conf.d/*.conf```  any configurations in these directories take precedence over the main journald.conf file.  

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

  The first step in system administration is monitoring.  Just like viewing logs, also knowing what is currently going on resource wise can be very helpful.  The first command we want to look at to help us understand what is occurring on our system is a command called ```top``.  This stands for *table of processes*. Top produces a list of running processes selected by user-specific criteria [^100].  The traditional Unix version was written by William LeFebvre and originally copyrighted in 1984. Since 1991 there has been a Linux based GPL top command which is part of the [procps-ng suite of tools](https://gitlab.com/procps-ng/procps) [^102].

### top

![*Fedora 22 top screenshot*](images/Chapter-09/monitoring/top/top.png "top")
\newpage

   The top program provides a dynamic real-time view of a running system. It can display system summary information as well as a list of tasks currently being managed by the Linux kernel. When the screen comes up there is a lot of data present and at first it might not be clear what you are looking at.  The main key you need to know is *q* which will quit and exit the top command (just like the less command.) The image below displays the system average loads over longer rolling periods.  1 minute, 5 minutes, and 15 minute rolling average.

![*top avg*](images/Chapter-09/monitoring/top/top-avg.png "Top average")

  This section tells you the number of processes, how much memory and swap is in use and how much is free.  It also tells you the breakdown between users and system on who is using the CPU percentage wise.

![*top usage*](images/Chapter-09/monitoring/top/top-usage.png "Top usage")

   Finally this section shows the name and individual breakdown of the processes and how much resources they are using.  We will cover this in more detail in chapter 11.  

![*top processes*](images/Chapter-09/monitoring/top/top-processes.png "Top process")   

The ```top``` command also has the ability to sort and modify its output while running.  

   Key                  Action in Top
-----------  --------------------------------------------------------------------------------
'd' or 's'     Plus a positive number you can change the reporting cycle.   
   'u'         Plus a user's name will filter only those processes they own
   'k'         Sorts by \%CPU usage.  
   'I'         Sorts by CPU time usage
   'm'         Same as above but more granular
   'n'         Percentage of memory that a task is using.
'w' STATE      D=uninterruptible sleep, R=running, S=sleeping, T=traced or stopped, Z=zombie
-----------  --------------------------------------------------------------------------------

### htop

   The htop command is an extension to the Linux top command.  It is written in C using the ncurses library for text-based GUIs so it has mouse support.  It also has metered output-and uses all the same interactive commands as ```top```.  The homepage for the project can be found at [http://hisham.hm/htop](http://hisham.hm/htop/ "htop").  The ```htop``` command needs to be installed via apt-get or yum/dnf.

![*htop*](images/Chapter-09/monitoring/top/htop.png "htop")
\newpage

### systemd-cgtop

  You were probably wondering if systemd had its own system monitoring tool.  And you would be correct to think so.  It's name is systemd-cgtop and the command is native to any system running systemd.  The usage patterns can be found at [http://www.freedesktop.org/software/systemd/man/systemd-cgtop.html](http://www.freedesktop.org/software/systemd/man/systemd-cgtop.html "systemd-cgtop") The nature of the output is the same as top but the information is being queried from systemd and not from the ```/proc``` filesystem.  You run the command ```systemd-cgtop``` from the commandline with preset flags like top or you run it in interactive mode. In interactive mode you would type ```%``` percent to toggle between CPU time as time or percentage.  You would type p, t, c, m, i to sort by path, number of tasks, CPU load, memory usage, or IO load.  The letter *q* is to quit.  There are other configuration options displayed by typing ```man systemd-cgtop```.

### atop

  There is one other monitoring tool named ```atop```.  The project is located at [http://www.atoptool.nl/](http://www.atoptool.nl/ "atop") The ```atop``` command can be installed via apt-get or yum/dnf.  The ```atop``` command has a series of features compared to other monitoring tools.

![*atop*](images/Chapter-09/monitoring/top/atop.png "atop")   

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

The opposite side of system monitoring is sometime you want to generate a load to see how your system responds.  On modern system that are multi-core with fast memory. There is a tool called ```stress``` you can install it via The Ubuntu and Fedora software stores or form the commandline using apt-get and yum/dnf.  It is also available for the Mac via the Homebrew package manager. The command ```stress --cpu 2 --timeout 60```  will cause two processors to max out for 60 seconds.  You would then be able to see this using an of the above top based commands.  There are some other ways to generate loads in bash as well located here: [http://stackoverflow.com/questions/7908953/how-to-measure-cpu-usage/12993326#12993326](http://stackoverflow.com/questions/7908953/how-to-measure-cpu-usage/12993326#12993326 "Bash load generator ideas")

#### ranwhen

Another interesting project is something called ranwhen.  It shows a visual representation of ```uptime``` on all your previous reboots.  This allows you to see in detail the amount of time your system ran for and also the time between restarts.  This project is written in Python 3 so you need to make sure that Python 3 is installed prior to running it. Simply clone the repo via git (may need to install git as well) via ```git clone https://github.com/p-e-w/ranwhen.git```  Once cloned, cd into the ranwhen directory and type ```python3 ranwhen.py```

#### sar and iostat

In addition to memory, CPU, and process information.  You can other commands to measure system I/O. The ```sar``` command - system activity report -- is something that came from the BSD Unixes and was ported over to Linux. It is used to sample and report various cumulative statistic counters maintained by the operating system.  You can take *n* samples at *t* intervals. Finally the ```iostat``` command, which in Linux is part of the sysstat package--displays kernel I/O statistics on terminal, device and cpu operations. A common word for this is I/O measurement or throughput.  These reports can then be used to change system configurations to better balance the input/output load between physical disks.  

![*iostat*](images/Chapter-09/monitoring/io/iostat.png "iostat")

## User Administration

There are a series of commands that can be used to change or augment the owner, group, or permission of a file.  To execute these commands you will need to have administrator privilege.  The nature of the user commands allow you to do three operations.  The commands are: useradd, userdel, and usermod.   

### useradd

  The useradd command allows you to add a new user to the system.  You can set user defaults by typing the command below.  The -D option will show you what your system ```useradd``` command defaults are.  You can then add a user with these default values by typing:
```bash
useradd name-of-account-to-add
```

![*useradd*](images/Chapter-09/user-administration/default/etc-default.png "etc-default")

You have the option as well to override the default values and set your own values for a new user.

: useradd command options

  Option         Function
-------------   ----------------------------------------------------
```-c```          Add a comment
```-d```          User's home directory
```-e```          Date in which a user account expires
```-g```          Add user to a specific primary group
```-G```          Add user to additional supplementary groups
```-m```          Create user's home directory if it doesn't exist
```-s```          Assign the user's shell
-------------   ----------------------------------------------------

![*adduser*](images/Chapter-09/user-administration/default/adduser.png "adduser")

> __Example Usage:__ What do the options and arguments below do?  Type it in and see what happens.
```bash
sudo useradd -c "This is a user for ITMO-456-01 Fall 2017" -d /home/controller \
-G sudo -s /bin/ksh -m controller
```

In Debian distributions there is an abstraction layer called ```adduser``` and ```addgroup``` which are interfaces to the useradd and groupadd commands.  It is just a perl script that passes the values you enter in the menu to the useradd command.  On all other non-Debian distros ```adduser``` is a symlink to ```useradd``` command.  The ```adduser``` command prompts you for information to fill out all the values and is recommended on Debian based systems, but if writing a shell script this is not portable to a non-Debian based distro.
\newpage

### userdel and usermod

  The same as above, the ```userdel``` command allows you to delete a user.  The ```usermod``` command allows you to modify a setting for a user without having to delete and re-create a user.  The most common scenario is changing the users supplementary groups so that they can be in the sudo, wheel, or admin group.   By default the system creates a usergroup with the same name as the usergroup and marks that as your users primary group. In this command -a means append and -G means append to the groups list.  For example: ```sudo usermod -aG sudo <username>```  is a handy command to remember.  In addition there is a Debian equivilent deluser which asks for a username and then deletes the user and all associated artifacts (home directory, primary group, and passwd file entry), but there is no moduser command.   

### addgroup and groupadd

In the same way as a user is created and there is a Debian based shortcut, there is a similar command to create a new group.  You would want to do this if you needed to create a group that was not in existence.  The syntax is simply ```sudo addgroup name-of-group``` and that is it.  The opposite command exists as well groupdel and delgroup, with the syntax of ```sudo delgroup name-of-group```.

You can list all the groups that exist on your system by executing the ```groups``` command.  If executed without any arguments it will show the current users group membership.  If you follow it up with a username it will return the group memberships of that user.  You can display the list of all the groups that exist on a system by typing ```cat /etc/group``` on the commandline.     

### /etc/passwd

  When a new user is created, the information passed into the ```adduser``` or ```useradd``` command is stored in the ```/etc/passwd``` file (yes it is missing the 'or').  This file originally stored user passwords which had been encrypted, but the file had read access and it was realized that it was a security flaw to allow access in this way.  The actual encrypted passwords were moved to a file called ```/etc/shadow``` and linked via the character *x* in the ```/etc/passwd``` file.  You can see this in the image below.  Also notice from the snippet that there are many many usernames that have been created but only two of them are by your hand.  That is because the system upon install creates many additional users that have single or even legacy purposes that the user will not touch.  At the very end of the screenshot below you see a user named controller, vboxadd, and joe.  Two of those I created, the vboxadd was entered when I installed the VirtualBox Guest Additions.  The syntax is as follows:  Username:password:user-id:group-id:comment-field:home-directory:default-shell.    You can see the encrypted and salted password hash if you have root or sudo privileges by typing ```sudo cat /etc/shadow``` on the command line.   

![*/etc/passwd*](images/Chapter-09/user-administration/default/etc-passwd.png "/etc/passwd")

### chmod

Pronounced *"chuh-mod"*. This command allows you to change the permissions or mode of a file.  You can use numeric values to change the permissions all at once.  Or you can use short cuts to assign or remove single permissions.  The outputs look like this:

 ![*Standard file permissions are 644 - very conservative and secure*](images/Chapter-09/user-administration/standard-permission.png "Standard Permissions")

  Why would you want to change permissions?  Perhaps to allow all users of a system a shell script that backsup the content of your home directory.  Or to make sure that only users of a certain group can have write access (therefore delete access) to the content of a file.  Or to give a shell script execute permission so it can be run by other.

 ![*Same file with write and execute permission enabled*](images/Chapter-09/user-administration/standard-permission-chmod.png "Standard Permissions")

### chown

 Pronounced *"chuh-own"*. This command allows you to change the owner of a file.  The syntax would be ```sudo chown root todolist```  There is also a shorthand feature that allows you to change the group and the owner at the same time.  ```sudo chown root:root todolist``` the value following the semi-colon will be the new group owner.  Resist the temptation to go nuclear--if you are getting a permissions denied on a command figure out why it is being denied--instead of chown-ing everything as this could create subtler problems down the line for system processes expecting a certain pattern of ownership.

> __Exercise:__  based on the previous todo-list.txt created in /tmp, issue an ```ls -l``` command - who is the owner of the file?  Who is the group owner? Change it so that the file is owned by root and the group owner is root (remember to use ```sudo```.)

### chgrp

Pronounced *"Chuh-gerp"*. This is the change group command.  It works just like ```chown``` but instead only changes the group ownership.

#### ACLs

IF you have ever worked on Windows OS you will notice that they have much deeper access control and permission system the the basic read, write, execute and owner, group, other permissions.  These are called ACL's (pronounced "*ack-els*") __Access Control Lists__.  They are not native to the Linux world as they were not part of the original Unix standard.  Modern versions of RHEL implement there own layer of Windows like ACLs on top of the regular permissions.  The difficulties of ACL's in Linux is that they are exclusive to RHEL and not portable to other Linux or Unix systems.
\newpage

### The 3 P's Describing 99% of all Linux Problems

  All my troubleshooting experience in Linux boils down to three things.  I have jokingly named them the 3P's (yes I know that they all don't start with *P*).  If you have an error message or cannot execute a command--run down these three troubleshooting steps:

  * Path
     + If you get an error message telling you that ```file not found``` or ```path does not exist```  double check your path.  It the absolute path correct?  Is it a relative path problem?  Are you on the wrong level?
  * Permission
     +  Every file has permission on what is allowed to be done with it based on a simple access control of read write and execute.  Maybe you don't have permission to write and therefore can't delete a file. Perhaps the file is owned by someone else and they didn't give you permission.  Check permissions via ls -la or see if you need sudo.
  * dePendencies
     +  The last thing is are all the correct software dependencies installed.  Perhaps you are missing a library or have an incompatible version that is preventing a tool from running?  For example in the sample above running runwhen, you need Python3 installed.  If you typed ```python runwhen.py``` you would receive a strange python error which would take you off on a useless googling experience.  The problem is you needed to type ```python3 runwhen.py``` and if you don't have python3 installed you will have a dependency problem.
  * All else fails and you still have a problem, see if it is a full moon outside. =)

## Chapter Conclusions and Review

  Through this chapter we learned about the su, sudo, and root user account paradigms.  We learned when to use them and how they were designed. We learned about the nature of traditional logging (non-systemd) and how they are stored.  We learned about a newer logging format in the journald service from systemd.  Finally we learned about system monitoring tools for visual display of system resources being used.  Finally we learned about the 3Ps of Linux troubleshooting.

### Review Questions

Review Questons Chapter 09

1) What user account has superuser privilege in Linux?
a. ```sudo```
b. ```su```
c. ```superuser```
d. ```root```

2) Which command do you use to temporarily elevate your user's privilege to the superuser (root)?
a. ```su```
b. ```sudo```
c. ```su -```
d. ```root```

3) How can you display the content of a file named topsecret.txt that has permissions 000 and is owned by another user?
a.  You can't do that
b.  ```root cat topsecret.txt```
c.  ```sudo cat topsecret.txt```
d.  ```su cat topsecret.txt```

4) What licesnse is the sudo application under?
a.  GPL
b.  BSD
c.  Public Domain
d.  ISC

5) Which operating system doesn't have an active root account by default?
a. Debian
b. Ubuntu
c. All Debian based distros
d. Fedora

6) What is the name of the file where sudo privilege are kept?
a. /etc/sudo
b. visudo
c. /etc/allow
d. /etc/sudoers

7) What is the name of the command used to modify /etc/sudoers to grant a new user sudo privilege?
a. Just use vi to edit it directly
b. Logout and log back in as root and do it
c. visudo
d. sudo visudo

8) Based on this line in /etc/sudoers - ```%meninblack  ALL=(ALL:ALL) ALL``` - what does the first value by the % mean?
a.  Name of a group
b.  Name of a user
c.  Name of the user group
d.  Name of a process

9) In the /etc/sudoers file - what does this line mean: ```RMS ALL=(root) NOPASSWD: ALL```
a.  The user RMS has sudo permissions and access to all commands
b.  The user RMS has sudo permissions
c.  The group RMS has sudo permissions to all commands
d.  The user RMS has sudo permissions and access to all commands, and requires no password to elevate to the sudo user

10)  When using the su command to switch from a regular user account to the root user account, what do you type to return to the standard user account?
a.  quit
b.  exit
c.  stop
d.  sudo reboot

11)  What command would you use to edit the file at this location:  /var/www/html/index.html?
a.  vi /var/www/html/index.html
b.  sudo vim /var/www/html/index.html
c.  vim /var/www/html/index.html
d.  You need to ```chown``` the file and change the owner

12) On a Linux system, which directory are all the traditional system (non-systemd) logs kept in?
a.  /var/run
b.  /logs
c.  /var/adm/log
d.  /var/log

13) Under systemd and journald where are the logs kept?
a.  /var/log
b.  /var/log/error
c.  /var/log/journald
d.  Trick question - as logs are stored in a binary format and retrieved via journalctl

14) What is the command you use to query the system logs in systemd?
a.  systemctl
b.  journald
c.  journalctl
d.  showlogs

15) How would you filter the systemd log based on time? (Which is valid syntax?)
a.  ```journalctl --since=yesterday```
b.  ```journalctl --since=tomorrow```
c.  ```journalctl --yesterday```
d.  ```journalctl --filter=yesterday```

16) Where is the journald.conf file located?
a. /etc/logrotate.conf
b. /etc/systemd/journalctl.conf
c. /etc/systemd.conf
d. /etc/systemd/journald.conf

17) What command provides a dynamic real-time view of a running system?
a.  top
b.  iostat
c.  ranwhen
d.  journalctl

18) Debian based distros have an additional command to abstract the process to add users to the system - what is it?
a.  useradd
b.  usermod
c.  adduser
d.  add

19) What command would be used to modify a user account settings and add them to the sudo users group (user is named controller)?
a.  ```sudo useradd -aG sudo controller```
b.  ```sudo usermod -aG sudo controller```
c.  ```sudo usermod -G sudo controller```
d.  ```sudo userdel controller```

20) Which below are valid useradd commands?  (Choose all that apply)
a. ```sudo useradd -c "User for spring class" -d "/home/export/controller" -G sudo -s /bin/ksh -m controller```
b. ```sudo useradd -D controller```
c. ```sudo useradd controller```
d. ```sudo useradd -G sudo -s /bin/ksh -m controller```
e. ```sudo useradd -c "User for spring class" -G sudo -m controller```

### Podcast Questions

NodeJS - [https://twit.tv/shows/floss-weekly/episodes/387](https://twit.tv/shows/floss-weekly/episodes/387 "NodeJS")

Node.js Update

* ~4:20 Where does Aaron (guy wearing black) say he is starting to see Node JS more and more?
* ~7:22 What is Node.js?
* ~8:50 Accroding to Mikael, what are we seeing an explosion of?
* ~9:15 What language(s) is NodeJS similar to?
* ~9:35 What is Event Driven Programming?
* ~10:45 what is NodeJS package manager/ecosystem?
* ~12:05 what kind of things would use Node?
* ~17:20 What are the two popular desktop apps built in NodeJS that Mikael mentioned?
* ~ 19:30 What are some of the ways to learn NodeJS?
* ~ 21:30 What did Microsoft do with NodeJS and where did it get Node?
* ~ 22:30, Mikael mentions multiple languages: TypeScript, CoffeeScript, Electron, and Dart -- what are they and hwo do they relate to the NodeJS project? (Need to do some side research)
* ~25:27 What company started the NodeJS and eventually the NodeJS foundation? (Currently owned by Samsung)
* ~ 26:43 What does the NodeJS foundation do (what is its role?)
* ~ 34:00 Who is the guest and what is his job?
* ~ 38:48 How much did Mikael reduce his code when he switched from Python to NodeJS?
* ~41:54 is is possible to run NodeJS for command line scripting?
* ~45:00 Where is pretty much every NPM module hosted?
* ~47:40 What is the Go language good at and what is it not?
* ~50:55 Is there any relationship between NodeJS and Docker?


### Lab

Chapter 09 Lab

Objectives

  The objective of this lab are as follows:

  * Understand when and how to use the sudo command
  * Understand how to edit the /etc/sudoers file
  * Understand how to use the journald and journalctl logging mechanism in systemd
  * Understand how to add and manage user accounts
  * Understand the structure and use of the cron service

Outcomes

   At the outcome of this lab you will be able to successfully understand how to apply the sudo/root user paradigm.  You will understand the binary logging mechanism of journald.  You will be able to add, delete, and modify user accounts.  Finally you will be able to schedule shell scripts to execute at repeated intervals.

   __Note__ you will need to submit a screenshot of the correct command(s) in action.
   __Note__ if a command asks you to work on a user that doesn't exist it is assumed that you have to create it.
   __Note__ The ```mysqldump``` application requires the ```mysql-client``` package to be installed. [http://superuser.com/questions/165582/installation-mysqldump](http://superuser.com/questions/165582/installation-mysqldump)

   1)  What would be the command to add a user named "controller" to your system - using the system default values?  

   1)  What would be the command to modify the user's group to add them to a *superuser* group (sudo on Ubuntu or wheel on Fedora based)?

   1)  What would be the command to delete a user account named nsa-spy?  (Note you also have to include the steps to add this user... unless the NSA is already in your system =)

   1)  What would be the command to edit the ```/etc/sudoers``` file and give the user "mysql-backup" sudo privilege? (Show the /etc/sudoers being edited and enter the relevant line that you add to that file)

   1)  What would be the command to edit the ```/etc/sudoers``` file and give the group "mysql-admins" sudo privilege? (Show the ```/etc/sudoers``` being edited and enter the relevant line that you add to that file)

   1)  What would be the command to edit the /etc/sudoers file to give the user "mysql-admin" sudo privilege to only use the mysql database backup command "mysqldump" ? (Show the ```/etc/sudoers``` being edited and enter the relevant line that you add to that file)

   1)  What would be the command to edit the /etc/sudoers file to give the user "mysql-admin" sudo privilege to only execute the "mysql" command and not require a password?

   1)  When you execute the command tail journalctl - you receive an error?  Show the error in a screenshot and explain why the error comes?

   1) What would be the command to execute to find all the occurences of logs generated by SSHD in journalctl?  P.168 in the text book -- you may need to install ```openssh-server``` package if the command returns no results

   1)  What would be the command to execute to find all the logs generated by _PID=1 (systemd itself) and since yesterday?

   1)  What would be the command to execute to see the logs of the current boot only using journalctl?

   1)  Which file and what value would I modify to change the journals settings to make the logs be stored in memory (volatile)?

   1)  The journald values SystemMaxUse= and RuntimeMaxUse= default to 10% and 15% of the system disk respectively.  How would you modify that value to be 20% and 30% respectively?  (Note you can't add percentages you have to use your system and do some scratch math - you can execute a df -H command to see the size of your root partition)

   1)  What would be the command to edit the cron service and run this command "mysqldump --xml -u root world City" (Assume you have mysql installed) at 2 am every Sunday?

   1) What would be the command to edit the cron service and run this command "mysqldump --xml -u root world City" (Assume you have mysql installed) at the 1st day of every month?

   1) What would be the command to edit the cron service and run this command "mysqldump --xml -u root world City" (Assume you have mysql installed) every 45 minutes?

   1) What would be the command to edit the cron service and run this command "mysqldump --xml -u root world City" (Assume you have mysql installed) on every 45 past the hour on Sundays?  

   1) What would be the command to edit the cron service and run this command "mysqldump --xml -u root world City" (Assume you have mysql installed) at 2:45am on Tuesday?

   1) What command would you use to change the group ownership of the file todo-list.txt to be owned by the "accounting" group?  (If that group doesn't exist then create it on your system)

   1) What command would you use to change the group ownership and file ownership (on one command) of the file todo-list.txt to be root:root?

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

[^104]: [https://en.wikipedia.org/wiki/Syslog](https://en.wikipedia.org/wiki/Syslog)
