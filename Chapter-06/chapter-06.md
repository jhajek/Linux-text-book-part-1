# Shell Variables, Shell Meta-Characters, Search Tools, File Permissions
![*The power of sudo*](images/Chapter-Header/Chapter-06/sandwich.png "Sandwich")

__Chapter 6 Objectives__

   * std in, out, err
   * redirection < > | tee
   * Find and grep
   * {} !,#,$,\,
  *  Understand the nomenclature describing file permissions and security
  *  Understand the sudo command and root user paradigm   

__Outcomes__



Does stdin and std out and std err go here?

## File Permissions and Ownership

  Linux has a simple security model.  There are simply three types of permission that every file has: __read__, __write__, __execute__.  These files give a combination of permissions.  With read you can display the content of a file or copy it, but cannot delete or rename it.  For that you need write permission.  If a file is a shell script or an executable binary it needs the execute permission.  How can you tell what permissions a file has?  Type ```ls -la``` and lets see.  We have seen this output before and now we will explain it. 

The first category is a listing of a files permissions:  See the screenshot below.

Notice that there are 3 groupings of the letters __rwx__ looking like this _rw_r__r__ find a way to escape this.  In addition to inducidualy permissions there are three categories of permission.  These three categories are __owner__,__group__,__other__  Each of these groups has its own read write execute permissions.  

Every file includes an owner and a group.  If you notice the next two columns in the output of ```ls -la``` you will see them listed.  The group name and owner name can be the same, we will talk more about that in Chapter X.

Permissions can be read in a short hand numeric fashion as well.  The read value is worth 4, the write value is worth 2, the execute value is worth 1  so a permission of rw_r__r__ can be read as 644.  The permissions for rwxrwxrwx is 777.  Numberic value for this is rw_______ is 600.
  
### Read, Write, Execute

rwx

### Owner, Group, Other (World)



### Tools 

There are a series of commands that can be used to change or augment the owner, group, or permission of a file.  To execute these commands you will need to have administrator privillege.  User accounts and privilleges will be discussed in more detail in Chapter Y.  But for right now we will use the ```sudo``` command in conjunction with these commands.  The ```sudo``` command allows us to temporarily elevate your user privillege from a user level to an admin level in order to modify the attributes of a file.  Just for experience try to execute one of these commands below without the ```sudo``` command.  You will see a permission denied error (number 2 in the 3P's).

  ```chmod``` 
  Pronounced *"chuh-mod"*
   This command allows you to change the permissions or mode of a file.  You can use numeric values to change the permissions all at once.  Or you can use short cuts to assign or remove single permissions.  
  The outputs look like this:
  Insert picture of chmod 755 and chmod +x 
  
  Why would you change permissions?  PErhaps to allow all users of a system a shell script that backsup the content of your home directory.  Or to make sure that only users of a certain group can have write access (therefore delete access) to the content of a file.
  
  ```chown``` 
  Pronounced *"chuh-own"*
  This command allows you to change the owner of a file.  The syntax would be ```sudo chown root todolist```  There is also a feature that allows you to change the group and the owner at the same time.  ```sudo chown root:root todolist``` the value following the semi-colon will be the new group owner.  Try it 
  
  touch todolist
  
  ls -la todolist - who is the owner of the file?  Who is the group owner?
  
  Change it so that the file is owned by root and the group owner is root
  
  ```chgrp```
  Pronounced *"Chuh-gerp"*  
  This is the change group command.  It works just like ```chown``` but instead only changes the group ownership.

### ACLs

IF you have ever worked on Windows OS you will notice that they have much deeper access control and permission system the the basic read, write, execute and owner, group, other permissions.  These are called ACL's (pronounced ack-els) __Access Control Lists__.  They are not native to the Linux world as they were not part of the original Unix standard.  Modern versions of RHEL implement there own layer of Windows like ACLs on top of the regular permissions.  There are a few other permission features that can help simulate ACLs.   __Sticky Bits__ are one of them.  Here is what sticky bits do...



## The 3 P's Describing 95% of all Linux Problems

Find how to do definitions in markdown
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

 FreeBSD

Listen or watch this podcast: [http://twit.tv/show/floss-weekly/104](http://twit.tv/show/floss-weekly/104 "FreeBSD")

  * What is FreeBSD? ~6:00
  * Why did she switch from Linux to BSD? ~6:30
  * Is FreeBSD Linux or Unix?  ~13:00
  * Is FreeBSD a good option for most people as a desktop? ~14:14
  * Using Mac OSX - what OS do you have under the hood? ~16:10
  * What project did Randi take on that no one else wanted? ~19:10
  * What filesystem does FreeBSD support that convinced Randel to move all his websites to FreeBSD? ~24:25
  * Are there any large companies that sponser FreeBSD?  ~ 31:00
  * How could you get involved in helping the FreeBSD community? ~38:15
  * What is Randi's opinion about "getting more women in open-source?"  ~40:00
  * What is Randi saying that is the wrong focus? ~49:00
  * Linux, Ubuntu and Fedora, have regular release cycles and then long term support, what kind of release cycles doed FreeBSD have?  ~50:25
  * Would you like to try/use FreeBSD or PC-BSD?

### Lab

  Lab goes here 
 
#### Footnotes

