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

As we learned previously we can define variables in BASH.  These variables are prefixed with a ```$``` when referenced.   In the previous chapter in the ```.bashrc``` file used to modify the system path, we assigned a new value to the ```PATH``` variable like this: 
```bash
PATH=$PATH:/home/user/Documents/apps

echo $PATH; echo $path; $PATH=PATH??? 

ut=`uptime`

```

```bash
UT=(`ls -l star[1-3]`)
USA="United States of America"
echo $USA
DIR="monthly-reports-winter-quarter-north-america"
ls $DIR
```

Note that there is no space allowed in variable assignments.  ```PATH=$PATH``` is valid, ```PATH = $PATH``` will be interpreted in a different way by the shell parser.  Variables that are predefined by the system can be found by typing: ```printenv``` and you will see a list of system variables.
   
[*Output of printenv command*](images/Chapter-08/bash-shell/printenv.png "printenv")
   
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
   
#### Array Support in Bash
      
  Arrays are a data-type that can be used to associate data in an ordered collection.  Bash arrays function similarly to arrays in C and Java.  Arrays in Bash are untyped (all text).  There is no support for arrayLists, maps, queues, or anything of that nature.  Arrays are used simply to store related data. You can declare an array by simple using the ```declare -a NAMEOFYOURARRAY``` syntax.  The ```-a``` makes your variable an array.  As of Bash 4.x bash gained support for the ```mapfile``` variable. The new mapfile builtin makes it possible to load an array with the contents of a text file without using a loop or command substitution.  Note that Mac as of OSX 10.11 release with Bash 3.2 as the standard.

This example below creates a Bash array and stores the redirected output (note the ```< <```) of an Amazon Webservices cli command to create some virtual instances and store their returned Instnace-Ids back in an array.

```bash
declare -a instanceARR
mapfile -t instanceARR < <(ls -l /etc)
```

How can we access these variables? We can make use of some meta-characters that have new special meanings here.  First is the *at sign* or ```@``` which allows us to access all of the elements in an array without having to create a loop.  The line below will print out the entire content of the array.  The *pound sign* or some people call it a *hash* or *crunch* indicates that we are looking for the length of the array.  Note the dollar sign before the element to tell the shell interpreter that this is a variables to be rendered.  Also note the the array elements are encapsulated in ```{ }```--curly braces to prevent the ```[ ]``` square braces from bein interpretted as shell meta-characters.  As usual elements of an array can be accessed by positional parameters.  ```echo Array[0]; echo Array [1]; echo Array[2]```.  Remember that arrays like in C and Java are __0 indexed__.
```bash
echo ${instanceARR[@]}
LENGTH=${#instanceARR[@]}
echo "ARRAY LENGTH IS $LENGTH"
```

#### Positional Parameters
   
In the case of the command binary ```ls -l /etc``` the command takes options and arguments.  Shell scripts you create have the same ability to accept and parse input from the commandline.  Note that this is different from ```getopts``` which allows you to make a complicated option and argument passing scheme for shell scripts.  This is for simple variable parameters to be passed into a script: For example:
```bash
./delete-directory.sh ~/Documents/text-book Jeremy
```

The content of the shell script is as follows:
```bash
#!/bin/bash

echo "***************************"
echo "The dirctory to be deleted is: $1"
rm -rf $1
echo "***************************"
echo "It was deleted by: $2"
echo $2 > ~/Documents/deletion-log.txt
```

Note that each postional parameter that is passed in to the shell script is simply acceesed by a number prefixed by a ```$```.  What do you think would be the value of ```$0```?  You can similarly access the number of variables that are passed into the command line by using the built-in variable: For example:
```bash
#!/bin/bash
# posparam.sh

echo "This is \$0: $0"
echo "This is the length of the number of items passed in \$# (not counting \$0): $#"
echo "This is the entire array of items passed in \$@: $@"
echo "This is the first parameter: $1"
echo "This is the fourth parameter: $4"
```

Upon giving the shell script above execution permission and then executing the line below, what will the three lines output?

```bash
posparam.sh domo origato Mr. Roboto
```  

### Control Structures

There are other structures for creating full scale shell scripts that parse user input and create menu like functions.  That is beyond the scope of this book.
   
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
------------------------------ ---------------------------------------------------------------------
```[ FILE1 -nt FILE2 ]```	      Newer than or if FILE1 exists and FILE2 does not.
```[ FILE1 -ot FILE2 ]```	      Older than FILE2, or is FILE2 exists and FILE1 does not.
```[ FILE1 -ef FILE2 ]```       True if FILE1 and FILE2 refer to the same device and inode numbers.
```[ -o OPTIONNAME ]```	        True if shell option "OPTIONNAME" is enabled.
```[ -z STRING ]```	            True of the length if "STRING" is zero.
```[ -n STRING ]```       	    True if the length of "STRING" is non-zero.
```[ STRING1 == STRING2 ]```	  True if the strings are equal. 
```[ STRING1 != STRING2 ]``` 	  True if the strings are not equal.
```[ STRING1 < STRING2 ]```	    True if "STRING1" sorts before "STRING2" 
```[ STRING1 > STRING2 ]```	    True if "STRING1" sorts after "STRING2" 
```[ ARG1 OP ARG2 ]```	        "OP" is one of ```-eq, -ne, -lt, -le, -gt or -ge```. 
------------------------------ ---------------------------------------------------------------------
 
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

  A FOR loop is used to loop incrementily through a list until the end is met.  In Bash the only data structure that you will use loop through are arrays and lists.  Lists are not a datatype like in C and Java but simply a space delimeted list of items.  The syntax of a FOR loop is:
```bash
for arg in [LIST]
do 
 # code here
done
```

If the ```do``` portion of the for loop is on the same line as the for loop a single ```;``` is needed between them.

```bash
#!/bin/bash
# Listing the planets.

for planet in Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto
do
  echo $planet  # Each planet on a separate line.
done
```
```bash
LENGTH=${#cleanupLBARR[@]}
echo "ARRAY LENGTH IS $LENGTH"

for (( i=0; i<${LENGTH}; i++));
  do
  aws elb delete-load-balancer --load-balancer-name ${cleanupLBARR[i]} --output text
  sleep 1
done
```

This is also a valid 1 line for loop that prints out a single dot to indicate a meter.

```bash
echo -e "\nFinished launching and sleeping 25 seconds"
for i in {0..25}; do echo -ne '.'; sleep 1;done
echo "\n"
```

## Scheduling Shell Scripts With Cron Tab

Now that we have sufficiently complex shell scripts the idea of automating their execution come into play. The concept of the __cron__ command and the __crontab__ files frist came into use in Unix System V release ~1983.  Each user can set their own scheduled tasks by editing the __crontab__ file by typting ```crontab -e```.  The contents of the crontab file are initially blank.  The language of the crontab is that of 5 columns and then a command to be executed. Multiple commands can be executed using ```; or &&``` And multiple different times can be listed in the crontab.  The five (and sometimes a sixth fields) are as follows:

Time Unit              Values
-------------  -----------------------
minute           0 - 59
hour             0 - 23
day of month     1 - 31
month            1 - 12
day of week      0 - 6 (0 is Sunday)
-------------  -----------------------

The cron service scans for your combination of jobs and if a pattern matches the current time then that job executes.  For example:
```bash
* 20 * * * /home/jeremy/backup.sh
```

In this case the script above would execute every night of the week at the 20th hour [^87]. The values of cron can be combined to get specific times and dates.  There is also syntax for executing on every 15 minutes.
```bash 
*/15 * * * * ~/Documents/script.sh
```

```bash
0,15,30,45 * * * *  ~/Documents/script.sh
```
Something unique like this will start at 3 minutes after and then execute every 10 minutes (13,23,33,43,53 minutes)

```bash
3/10 * * * * ~/Documents/script.sh
```

Any command that is executed obeys general shell meta-characters and variables as if you were typing that command directly on the command line.  This also allows for redirection of standard out and standard error as well.

Entry                                Description                          Equivalent to
-------------------- ------------------------------------------------- -----------------------
@yearly               Run once a year at midnight of January 1st           ```0 0 1 1 *``` 
@monthly              Run once a month, midnight 1st day of the month      ```0 0 1 * *``` 
@weekly               Run once a week at midnight on Sunday morning        ```0 0 * * 0``` 
@daily                Run once a day at midnight                           ```0 0 * * *``` 
@hourly               Run once an hour at the beginning of the hour        ```0 * * * *``` 
@reboot               Run at startup                                        @reboot 
-------------------- ------------------------------------------------- -----------------------

## Where to find more

[http://shop.oreilly.com/product/9780596009656.do](http://shop.oreilly.com/product/9780596009656.do "Bash Book")


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

[^87]: [https://en.wikipedia.org/wiki/Cron#Examples](https://en.wikipedia.org/wiki/Cron#Examples)

[^88]: [https://en.wikipedia.org/wiki/Cron#Nonstandard_predefined_scheduling_definitions](https://en.wikipedia.org/wiki/Cron#Nonstandard_predefined_scheduling_definitions)

