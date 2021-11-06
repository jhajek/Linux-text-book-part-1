# Review Questions - Chapter 08

1) True or False The Bash shell scripting language has traditional language constructs like C or Java?

2) What meta-character do you use to access the content of a shell variable?
a.  ```$```
b.  ```#```
c.  ```!```
d.  No character - trick questions

3) When assigning the standard output of a command to a variable which of these are valid methods?
a. DT=``` `date` ```
b. `DT=$(date)`
c. `DT="date"`
d. Not possible, trick questions

4) True or False - You can include shell meta-characters inside of two backticks ``` ` ` ``` - example: ``` `ls -l test[1-5]` ```

5) Which command will list the names of any file that matches these names: file1.txt file2.txt file3.txt file4.txt and send the content of that output to a variable named DIR?
a. `DIR='ls -l ./test[1-4].txt'`
b. DIR = ``` `ls -l ./test[1-4].txt` ```
c. $DIR=``` `ls -l ./test[1-4].txt` ```
d. DIR=``` `ls -l ./test[1-4].txt` ```

6) Which of these are valid commands in the first line of a shell script?  (Choose any - assume any paths are valid paths to executables)
a. ```#!/bin/bash```
b. ```!#/bin/bash```
c. ```#!/usr/local/bin/bash```
d. ```#/bin/bash```
e. ```#!/bin/ksh```

7) If you stored the output of the command hostname into a variable named sys-hostname, what would be the command to print the content to the screen?
a.  ```echo $HOSTNAME```
b.  ```echo $hostname```
c.  ```echo $SYS-HOSTNAME```
d.  ```echo $sys-hostname```

8) What is the name of the command to print out all the predefined system variables?

9) What is the name of the command that allows you to take stdout of a command and insert the lines of output into an array?
a. arrayfile
b. declare
c. for loop
d. mapfile

10) Which of these is a valid command to take the output of this find command and assign the contents to an array?  (Assume the array name has already been declared. Choose one)
a. ```SEARCHARRAY = (find ~ -name mozilla*)```
b. ```SEARCHARRAY < < (find ~ -name mozilla*)```
c. ```SEARCHARRAY=( $(find ~ -name mozilla*))```
d. ```SEARCHARRY < (find ~ -name mozilla*)```

11) Which below is a valid command to find the LENGTH of an array?
a. ```${#SEARCHARRAY[@]}```
b. ```${SEARCHARRAY[@]}```
c. ```${SEARACHARRAY[#]}```
d. ```${@SEARCHARRAY[#]}```

12) Based on this shell script and positional parameters, what would the command be to print out the first positional parameter after the script name? ```./delete-directory.sh ~/Documents/text-book Jeremy```
a.  ```echo $0```
b.  ```echo $1```
c.  ```echo args[1]```
d.  ```echo {$1}```

13) Based on this shell script and positional parameters, what would the command be to print out the entire content of the positional parameter array? ```./delete-directory.sh ~/Documents/text-book Jeremy```
a.  ```echo $#```
b.  ```echo @!```
c.  ```echo $0```
d.  ```echo $@```

14) Based on this shell script and positional parameters, what would the command be to print out the LENGTH of the positional parameter array? ```./delete-directory.sh ~/Documents/text-book Jeremy```
a.  ```echo $#```
b.  ```echo @!```
c.  ```echo $0```
d.  ```echo $@```

15) In a Bash IF statement, what is the name for the pre-made test conditions?
a. Primaries
b. Secondary expressions
c. Expression
d. Primary expressions

16) All values in a Bash IF statement are of what data type by default?
a. INT
b. STRING
c. NULL
d. CHAR

17) Which of these answers will execute a shell script named ~/backup.sh at 2 am every night of the week?
a. ```* * * * * ~/backup.sh```
b. ```2 * * * * ~/backup.sh```
c. ```* 2 * * * ~/backup.sh```
d. ```* * * 2 * ~/backup.sh```

18) Which of these answers will execute a shell script named ~/clean-directory.sh every 15 minutes?
a. ```3/15 * * * * ~/clean-directory.sh```
b. ```*/15 * * * * ~/clean-directory.sh```
c. ```* 3/15 * * * ~/clean-directory.sh```
d. ```* */15 * * * ~/clean-directory.sh```

19) Which of the crontab builtins would you use to execute a cron job 1 time a year on midnight of January 1st?  The name of the script is ~/give-free-cash-to-students.sh
a. ```* * * * 1 ~/give-free-cash-to-students.sh```
b. ```1 * * * * ~/give-free-cash-to-students.sh```
c. ```1 1 1 1 1 ~/give-free-cash-to-students.sh```
d. &#64;```yearly ~/give-free-cash-to-students.sh```

20) What is the name of the control structure that allows you to incrementally through the contents of an array?
a. IF
b. CASE
c. UNTIL
d. FOR
