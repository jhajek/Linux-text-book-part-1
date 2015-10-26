# Writing Basic Shell Scripts
![*Bash Escape*](images/Chapter-Header/Chapter-08/escape_artist-2.png "Bash Escape")

__Chapter 8 Objectives__

This portion of the book begins Part II. The first 7 chapters focused more on the *philosophy* and basic tenants of how Unix and Linux were created. The remaining 8 chapters now will focus on the application of what we have learned and focus  on the using the opensource technology of Linux.  The Objectes of this chapter are as follows:

   * Understand how to write and use basic shell scripts
   * if statements
   * for loops
   * System environment variables
   * Passing Variables into scripts
   * Scheduling Shell Scripts With Cron Tab

__Outcomes__

  At the conclusion of this chapter you will have furthered your understanding of the vi editor and be able to demonstrate how to use control structures in shell scripts.  You will also learn about command line variables and how they extend the ability of a shell script to accpet dynamic input.  You will be able to schedule a shell script to run at a scheduled time by using cron service increasing your ability to reduce work by automating repetative tasks.

## Basic Shell Scripts Part II
 
   In the previous chapter we were introduced to the simplist of shell scripts.  In this chapter we are going to increase the depth of our knowledge.

   Add some samples here
   
   Segway to control structures
 
### Bash Shell

   Just like any programming language we cannot have complex logic if we don't have control structures.  The two basic ones we want to cover are if statements and for loops.  There are the other traditional control structures but are used less commonly because of the nature of a shell script is a single execution not as a repeated process or system service.
   
   The BASH shell scripting language resembles a trasitional programming language.  But it is key to remember that it was not designed to be a complete programming language.  As you push shell scripts to their limits you begin to see the end of what they are capable of.  That is where you see languages like Perl or Python coming in to extend and replace BASH.  (Note if you ever find yourself doing serious arithmetic in BASH something is seriously wrong with your design parameters--check again why you are doing this.)
   
   BASH is a tool to help automate the repetition of commands.
   
### Shell Script Variables 
 
   Variables - explain the scope
   
   As we learned previously we can define variables in BASH.  These variables are prefixed with a ```$``` when referenced.   In the previous chapter in the ```.bashrc``` file used to modify the system path, we assigned a new value to the ```PATH``` variable like this: 
   ```bash
   PATH=$PATH:/home/user/Documents/apps
   ```
   
   Note that there is no space allowed in variable assignments.  ```PATH=$PATH``` is valid, ```PATH = $PATH``` will be interpreted in a different way by the shell parser.  
   
   Variables that are predefined by the system can be found by typing: ```printenv``` and you will see a list of system variables.
   
   Put picture of some printenv here:
   
   You can also define your own variables in a shell script--just as you could do on the command line.   Often this is a good idea when you want to assign the output of one command and reuse that value later.  
   
> __Example Usage:__  Create a shell script with this content below.  Save the file, make it executable, and then execute it.
```bash
#!/bin/bash

# This is a comment - usually by convention variables are in all caps - no spaces, ever!
DT=`date`
# This command outputs the date in a format of our specifications
MDY=`date +%m%d%Y` 
echo "****************"
echo "today's date is: $DT"
echo "****************"
echo "Making a folder named MMDDYYYY"
mkdir ~/Documents/$MDY 
echo "Finished"
```

In this example we see how the value of $MDY is interpretted first and then passed to the argument attached to the ```mkdir``` command.  Note that the ```mkdir``` command did not have any backticks around it like the comand to assign the output of ```date``` to the variable ```DT```.  This is because the Shell sees that mkdir is a command and begins to interpret the line as such (followed by options and arguments).  If you want to encapsulate the output of one command into a shell variable then you need to enclose them in backticks ```\`\````.

Any variables that are declared have a scope of this scripts execution.  This means that once the script has finished executing any variables are tossed from memory.  If I wanted a variables name and value to life after the completion of my shell script I can always add the __export__ command.  The __export__ command will take the content of this variable and move it from the memory space of the script's execution and move it into the memory space of the launching shell.  This way the variable will live only as long as that terminal session is open--once the window closes those variables disappear from memory because the process that was holding them in a piece of memory is gone too. 
   
> __Example Usage:__  Create a shell script with this content below.  Save the file, make it executable, and then execute it.  Upon completion of that execution, type ```echo $DT``` what value do you see and why?   
```bash
#!/bin/bash

# This is a comment - usually by convention variables are in all caps - no spaces, ever!
DT=`date`
# This command outputs the date in a format of our specifications
MDY=`date +%m%d%Y` 
echo "****************"
echo "today's date is: $DT"
echo "****************"
echo "Making a folder named MMDDYYYY"
mkdir ~/Documents/$MDY 
export DT
echo "Finished"
```
   
   Arrays in bash +4.0 (macs even 10.11 have 3.2 by default. (Add link to fix it)

mapfile -t 

and declare -a varname
   
   Commandline variables $1 $2...  $# ands $@  what they do.  

./addinput X Y Z

There are other structures for creating full scale shell scripts that parse user input and create menu like functions.  That is beyond the scope of this book.

### Control Structures

   
### IF Statements

The structure of the Bash __IF__ command is as follows: 
```bash
if TEST-COMMANDS; then CONSEQUENT-COMMANDS; fi
```

The __IF__ command starts with a test condition or command.  It is followed by a ```then``` condition which will execute if the test command is *true*. The entire __IF__ command is closed by the letters ```fi```.  Since the scope of BASH is limited compared to a full programming language, __IF__ statements are mostly used to test for conditions or the existance of a condition.  These common __TEST COMMANDS__ are available as built in to BASH in order to accomplish just that. These are called *primaries* and are placed between sqaure braces--space is important [^86].
  
: Primary expressions 

   Primary	            Meaning
------------------ --------------------------------------------------------------
```[ -a FILE ]```	  True if FILE exists.
```[ -b FILE ]```	  True if FILE exists and is a block-special file.
```[ -c FILE ]```   True if FILE exists and is a character-special file.
```[ -d FILE ]```   True if FILE exists and is a directory.
```[ -e FILE ]```   True if FILE exists.
```[ -f FILE ]```   True if FILE exists and is a regular file.
```[ -g FILE ]```   True if FILE exists and its SGID bit is set.
```[ -h FILE ]```   True if FILE exists and is a symbolic link.
```[ -k FILE ]```   True if FILE exists and its sticky bit is set.
```[ -p FILE ]```	  True if FILE exists and is a named pipe (FIFO).
```[ -r FILE ]```	  True if FILE exists and is readable.
```[ -s FILE ]```	  True if FILE exists and has a size greater than zero.
```[ -t FD ]```	    True if file descriptor FD is open and refers to a terminal.
------------------ --------------------------------------------------------------

: Additional Primary expressions

   Primary	         Meaning
------------------ -----------------------------------------------------------------------
```[ -u FILE ]```	  True if FILE exists and its SUID (set user ID) bit is set.
```[ -w FILE ]```	  True if FILE exists and is writable.
```[ -x FILE ]```	  True if FILE exists and is executable.
```[ -O FILE ]```	  True if FILE exists and is owned by the effective user ID.
```[ -G FILE ]```	  True if FILE exists and is owned by the effective group ID.
```[ -L FILE ]```	  True if FILE exists and is a symbolic link.
```[ -N FILE ]```	  True if FILE exists and has been modified since it was last read.
```[ -S FILE ]```	  True if FILE exists and is a socket.
------------------ -----------------------------------------------------------------------

: Primary expressions

   Primary	                            Meaning
---------------------------- ----------------------------------------------------------------------------------------------------
```[ FILE1 -nt FILE2 ]```	    True if FILE1 has been changed more recently than FILE2, or if FILE1 exists and FILE2 does not.
```[ FILE1 -ot FILE2 ]```	    True if FILE1 is older than FILE2, or is FILE2 exists and FILE1 does not.
```[ FILE1 -ef FILE2 ]```     True if FILE1 and FILE2 refer to the same device and inode numbers.
```[ -o OPTIONNAME ]```	      True if shell option "OPTIONNAME" is enabled.
```[ -z STRING ]```	          True of the length if "STRING" is zero.
```[ -n STRING ]```       	  True if the length of "STRING" is non-zero.
```[ STRING1 == STRING2 ]```	True if the strings are equal. "=" may be used instead of "==" for strict POSIX compliance.
```[ STRING1 != STRING2 ]``` 	True if the strings are not equal.
```[ STRING1 < STRING2 ]```	  True if "STRING1" sorts before "STRING2" lexicographically in the current locale.
```[ STRING1 > STRING2 ]```	  True if "STRING1" sorts after "STRING2" lexicographically in the current locale.
```[ ARG1 OP ARG2 ]```	      "OP" is one of -eq, -ne, -lt, -le, -gt or -ge. 
---------------------------- ----------------------------------------------------------------------------------------------------
 
 : Boolean Operators
 
 Boolean               Value
--------------      -------------------------
 ```&&```             Logical AND
 ```||```             Logical OR
 ```-a```             Primary Expression AND
 ```-o```             Primary Expression OR
--------------      -------------------------
 
If statements in BASH have support for nested IFs, IF ELSE constructs, and even [CASE](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_03.html "Case Statements") statements.  Here is an example of a nested IF statement using Else IFs from the TLDP project. We will not cover the scope of CASE statements in this book - see the previous link for a good tutorial.  Note at this level of complexity it might be better to try to engineer a CASE statement of rearchitect what you are trying to do in to smaller steps to reduce complexity.  Completity is the enemy of the programmer.  

```bash
#!/bin/bash
                                                                                                 
# This script lets you present different menus to Tux.  He will only be happy
# when given a fish.  We've also added a dolphin and (presumably) a camel.
                                                                                                 
if [ "$menu" == "fish" ]; then
  if [ "$animal" == "penguin" ]; then
    echo "Hmmmmmm fish... Tux happy!"
  elif [ "$animal" == "dolphin" ]; then
    echo "Pweetpeettreetppeterdepweet!"
  else
    echo "*prrrrrrrt*"
  fi
else
  if [ "$animal" == "penguin" ]; then
    echo "Tux don't like that.  Tux wants fish!"
    exit 1
  elif [ "$animal" == "dolphin" ]; then
    echo "Pweepwishpeeterdepweet!"
    exit 2
  else
    echo "Will you read this sign?!"
    exit 3
  fi
fi  
```

### FOR Loops

  used to loop through contents - files, arrays
   using $@ and $# for length variables and sentinels.

## Scheduling Shell Scripts With Cron Tab

   crontab where it came from and how it was improved - and what it does today.
vixie cron

## Where to find more

http://shop.oreilly.com/product/9780596009656.do   bash book


## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

  Questions go here

### Podcast Questions

 Questions go here

### Lab

 Lab goes here 
 
#### Footnotes

[^86]: [http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html)

