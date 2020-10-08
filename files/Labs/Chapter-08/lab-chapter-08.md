# Lab - Chapter 08

## Lab Objectives

This lab will allow you to create shell scripts.  Use positional parameters, control structures, and write cron jobs.

## Lab Outcomes

At the completion of this lab you will further your knowledge of shell scripting and enhance your abilities using Bash shell scripts.

In the GitHub repo provided to you please create a folder in your ITMO-556 directory named Chapter-08.  In this directory you will create a file called ReadMe.md and all of the answers, screenshots, and code will be contained in this document.  Submit to Blackboard just your GitHub URL.

1) What would be the command to create an array in Bash named itemARRAY?

1) Write a shell script that declares an array in Bash named `dirarr`. Using the `mapfile` command - redirect the output of the ls -l ~ command into the array previously named and echo out the 3rd and 4th elements of that array.
  
1) Write a WHILE loop that will read the content of the file names.txt, (located in the files > Chapter-08 > lab folder) and create a directory based on the value on the line in the `/tmp` directory (one per users).  Include an if statement to detect if the directory already exists, if it does exist, write the duplicate name out to a text file named: `duplicates.txt` located in the `/tmp` directory.  
  
1) Write the syntax to make a cronjob execute 5 minutes past every hour everyday to execute the shellscript you previously made to store the content of ls -l ~ into an array named dirarr.
  
1) Locate the file `install-java8.sh` located in the **files > Chapter-08 > lab** directory.  Modify the script to include IF statements to check for the existence of the path ```/datapool1``` and to print an error message if the path does not exist.
  
1) Modify `install-java8.sh` again--this time take a positional parameter and put that in place of the directory name ```/datapool1``` (this will allow you to customize the install location of the shell script).  
  
1) Modify the `install-java8.sh` from the previous question to count the number of positional parameters and if less than 1 or more than 1 stop execution of the script (exit).
  
1) Create a directory in ```~``` named ```topsecret```.  In that directory create a file named `xfile.txt`.  Write a shell script to check if that file has executable permission by passing the filename as a positional parameter.  If TRUE print a message.  If FALSE print an error message that the positional parameter name of the file is not executable.
  
1) Write a shell script to check in the `~/topsecret` directory to see if a given file name exists (passed in by postional parameters).  If TRUE print a message else print an error message with the given file name being passed.
  
1) Write a shell script to check if a given PATH is a file or a directory.  If TRUE print a message, else print an error message using the given file name.
  
1) Write a shell script that takes 4 positional parameters.  In the shell script print out $0, $#, and $@ with an explanation of what these variables contain.
  
1) Write a cron job that executes the command, `sudo mysqldump --all-databases` at 11:59 pm on Sunday every week of the month.
  
1) Using awk and other tools, how would you find which ip caused the most HTTP 404 errors? Take a screenshot of the command and the output.  Use these two files in ```files/Chapter-08/logs```: u_ex150721.log, u_ex151002.log.

1) Using awk and other tools, how would you capture the top 5 offending IPs? Take a screenshot of the command and the output. Use these two files in ```files/Chapter-08/logs```: u_ex150721.log, u_ex151002.log.

1) Using sed, type the command to find the line **bind-address** located in the mariadb database server config file (you might need to install mariadb-server).  The file locations are: Fedora ```/etc/my.cnf.d/mariadb-server.cnf``` and Ubuntu ```/etc/mysql/mariadb.conf.d/50-server.cnf```.  Comment out the value, change the IP value to 0.0.0.0, and write the change back to the original file.  Take a screenshot of the output.
