# Review Questions - Chapter 08

1.  The Bash shell scripting language has traditional language constructs like C or Java.
1.  What meta-character do you use to access the content of a shell variable?
    a.  `$`
    b.  `#`
    c.  `!`
    d.  No character - trick questions
1.  When assigning the standard output of a command to a variable which of these are valid methods?
    a.  DT=``` `date` ```
    b.  `DT=$(date)`
    c.  `DT="date"`
    d.  Not possible, trick questions
1.  What is the name of the program used for manipulating streams of text inside of a file (used for find and replace)?
    a.  awk
    b.   grep
    c.  pgrep
    d.  sed
1.  What would be the correct syntax to find and replace the value 127.0.0.1 with 0.0.0.0 in a the file `50-server.cnf`?
    a.  `sudo sed "s/0.0.0.0/127.0.0.1/g" 50-server.cnf`
    b.   `sudo sed -s "s/0.0.0.0/127.0.0.1/g" 50-server.cnf`
    c.  `sudo sed -i "s/127.0.0.1/0.0.0.0/g" 50-server.cnf`
    d.  `sudo sed -r "s/0.0.0.0/127.0.0.1/g" 50-server.cnf`
1.  Which of these are valid commands in the first line of a shell script?  (Choose any - assume any paths are valid paths to executables.
    a.  `#!/usr/bin/bash`
    b.   `!#/usr/bin/bash`
    c.  `#!/usr/local/usr/bin/bash`
    d.  `#!/bin/bash`
    e. `#!/bin/sh`
1.  If you stored the output of the command `hostname` into a variable named SYSTEMNAME, what would be the command to print the content to the screen?
    a.   `echo $SYSTEMNAME`
    b.    `echo $systemname`
    c.   `echo SYSTEMNAME`
    d.   `echo systemname`
1.  What is the proper syntax to end an `IF` statement -- what is the very last line?
    a.  `}`
    b.   done
    c.  fi
    d.  exit
1.  What is the correct primary syntax for an `IF` statement, to check if a file exists?
    a.  `if [-e filename]`
    b.   `if [ -e filename ]`
    c.  `if (-e filename)`
    d.  `if [ true filename ]`
1.  Which of these is a valid command to redirect the standard out of a `cat` command to standard in of a shell variable?
    a.  `NAMES = (cat roster.txt)`
    b.   `NAMES << (cat roster.txt)`
    c.  `NAMES=$(cat roster.txt)`
    d.  `NAMES < (cat roster.txt)`
1.  Which below is a valid command to find the LENGTH of an array?
    a.  `${#SEARCHARRAY[@]}`
    b.   `${SEARCHARRAY[@]}`
    c.  `${SEARACHARRAY[#]}`
    d.  `${@SEARCHARRAY[#]}`
1.  Based on this shell script and positional parameters, what would the command be to print out the first positional parameter after the script name? `./delete-directory.sh ~/Documents/text-book Jeremy`
    a.   `echo $0`
    b.    `echo $1`
    c.   `echo args[1]`
    d.   `echo {$1}`
1.  Based on this shell script and positional parameters, what would the command be to print out the entire content of the positional parameter array? `./delete-directory.sh ~/Documents/text-book Jeremy`
    a.   `echo $#`
    b.    `echo @!`
    c.   `echo $0`
    d.   `echo $@`
1.  Based on this shell script and positional parameters, what would the command be to print out the LENGTH of the positional parameter array? `./delete-directory.sh ~/Documents/text-book Jeremy`
    a.   `echo $#`
    b.    `echo @!`
    c.   `echo $0`
    d.   `echo $@`
1.  In a Bash IF statement, what is the name for the pre-made test conditions?
    a.  Primaries
    b.   Secondary expressions
    c.  Expression
    d.  Primary expressions
1.  All values in a Bash IF statement are of what data type by default?
    a.  INT
    b.   STRING
    c.  NULL
    d.  CHAR
1.  Which of these answers will execute a shell script named ~/backup.sh at 2 am every day?
    a.  `* * * * * ~/backup.sh`
    b.  `2 * * * * ~/backup.sh`
    c.  `* 2 * * * ~/backup.sh`
    d.  `* * * 2 * ~/backup.sh`
1.  Which of these answers will execute a shell script named ~/clean-directory.sh every 15 minutes?
    a.  `3/15 * * * * ~/clean-directory.sh`
    b.  `*/15 * * * * ~/clean-directory.sh`
    c.  `* 3/15 * * * ~/clean-directory.sh`
    d.  `* */15 * * * ~/clean-directory.sh`
1.  Which of the crontab builtins would you use to execute a cron job 1 time a year on midnight of January 1st?  The name of the script is /home/controller/homework-is-finished.sh
    a. `* * * * 1 /home/controller/homework-is-finished.sh`
    b. `1 * * * * /home/controller/homework-is-finished.sh`
    c. `1 1 1 1 1 /home/controller/homework-is-finished.sh`
    d. &#64;`yearly /home/controller/homework-is-finished.sh`
1.  What is the name of the control structure that allows you to incrementally through the contents of an array?
    a.  IF
    b.  CASE
    c.  UNTIL
    d.  FOR
1.  What is the name of the control structure that allows you to loop through a list until there are no more elements?
    a.  IF
    b.  WHILE
    c.  UNTIL
    d.  FOR
1.  What would be the `sed` command to replace the value bantime = 1h with bantime = 10h in the file `/etc/fail2ban/jail.conf`?
    a.  sudo sed "s/bantime = 1h/bantime = 10h/g" /etc/fail2ban/jail.conf
    b.  sudo sed -i "s/bantime = 10h/bantime = 1h/g" /etc/fail2ban/jail.conf
    c.  sudo grep -r "bantime = 1h" /etc/fail2ban/jail.conf
    d.  sudo sed -i "s/bantime = 1h/bantime = 10h/g" /etc/fail2ban/jail.conf
1.  What would be the `sed` command to replace the value joseph with Joseph in the file `names.txt`?
    a.  sudo sed -i "s/joseph/Joseph/g" names.txt
    b.  sudo sed -i "s/joseph/Joseph/g" names.txt
    c.  sudo sed -i "s/joseph/Joseph/g" names.txt
    d.  sudo sed -i "s/joseph/Joseph/g" names.txt
1.  What would be the `sed` command to replace the value database_name_here with ap-dataabase in the file `/var/www/html/wordpress/wp-config.php`?
    a.  sudo sed -i "s/database_name_here/wp-database/g" /var/www/html/wordpress/wp-config.php
    b.  sudo sed -i "s/wp-database/database_name_here/g" /var/www/html/wordpress/wp-config.php
    c.  sudo sed "s/database_name_here/wp-database/g" /var/www/html/wordpress/wp-config.php 
    d.  sudo sed -i "s/database_name_here/wp-database/g" /var/www/html/wordpress/
