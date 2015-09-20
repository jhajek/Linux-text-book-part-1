# System Administration 
![*Permissions are all messed up...*](images/Chapter-Header/Chapter-11/authorization-2.png  "Permissions")

__Chapter 11 Objectives__

  *  logging  /var/log  
    + syslog 
    + rsyslog
    + dmesg
    + dtrace/strace
  * top, atop, htop
  * adduser, userdel, usermod
    + chown, chgrp, chmod 
  * watchdogs, tail -f
  * logrotation
  *  systemd 
    + binary logs
    + other systemd tools
  * sudo
    + visudoers
  * 3P's 

__Outcomes__


  
  ### The 3 P's Describing 99% of all Linux Problems

  * Path 
     + If you get an error message telling you that ```file not found``` or ```path does not exist```  double check your path.  It the absolute path correct?  Is it a relative path problem?  Are you on the wrong level?
  * Permission
     +  This is discussed below, every file has permission on what is allowed to be done with it based on a simple access control of read write and execute.  Maybe you don't have permission to write and therefore can't delete a file. Perhaps the file is owned by someone else and they didn't give you permission.  Check permissions via ls -la
  * dePendencies
     +  The last thing is are all the correct software dependecies installed.  Perhaps you are missing a library or have an incompatible version that is preventing a tool from running?
  
  
  ### Tools 

There are a series of commands that can be used to change or augment the owner, group, or permission of a file.  To execute these commands you will need to have administrator privillege.  User accounts and privilleges will be discussed in more detail in Chapter X.  But for right now we will use the ```sudo``` command in conjunction with these commands.  The ```sudo``` command allows us to temporarily elevate your user privillege from a user level to an admin level in order to modify the attributes of a file.  Just for experience try to execute one of these commands below without the ```sudo``` command.  You will see a permission denied error (number 2 in the 3P's). This command will be covered in depth in chapter 6.

#### chmod
 
Pronounced *"chuh-mod"*. This command allows you to change the permissions or mode of a file.  You can use numeric values to change the permissions all at once.  Or you can use short cuts to assign or remove single permissions.  The outputs look like this:
   
 ![*Standard file permissions are 644 - very conservative and secure*](images/Chapter-05/permissions/standard-permission.png "Standard Permissions")
   
  Why would you want to change permissions?  Perhaps to allow all users of a system a shell script that backsup the content of your home directory.  Or to make sure that only users of a certain group can have write access (therefore delete access) to the content of a file.  Or to give a shell script execute permission so it can be run by other.
  
 ![*Same file with write and execute permission enabled*](images/Chapter-05/permissions/standard-permission-chmod.png "Standard Permissions")
  
#### chown

 Pronounced *"chuh-own"*. This command allows you to change the owner of a file.  The syntax would be ```sudo chown root todolist```  There is also a shorthand feature that allows you to change the group and the owner at the same time.  ```sudo chown root:root todolist``` the value following the semi-colon will be the new group owner. 
  
> __Exercise:__  based on the previous todo-list.txt created in /tmp, issue an ```ls -l``` command - who is the owner of the file?  Who is the group owner? Change it so that the file is owned by root and the group owner is root (remember to use ```sudo```.)
  
#### chgrp

Pronounced *"Chuh-gerp"*. This is the change group command.  It works just like ```chown``` but instead only changes the group ownership.

### ACLs

IF you have ever worked on Windows OS you will notice that they have much deeper access control and permission system the the basic read, write, execute and owner, group, other permissions.  These are called ACL's (pronounced ack-els) __Access Control Lists__.  They are not native to the Linux world as they were not part of the original Unix standard.  Modern versions of RHEL implement there own layer of Windows like ACLs on top of the regular permissions.  There are a few other permission features that can help simulate ACLs.   __Sticky Bits__ are one of them and will be covered in Chapter X.

## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

  * Questions go here

### Podcast Questions

 * Questions go here

### Lab

 * Lab goes here 
 
 