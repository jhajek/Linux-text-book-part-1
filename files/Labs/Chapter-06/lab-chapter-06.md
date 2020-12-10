# Lab - Chapter 06

The objectives of this lab will be to use the shell and understand meta-characters, pipes, search, and tools. The outcome will be that you will be able to successfully use meta-characters for file creation, location, modification, and manipulation.  You will successfully master the concept of pipes and redirection as well.  Resist the temptation to use the GUI file manager and a web browser.  All actions will be done through the shell. You can use either Ubuntu or Fedora based os.

1. Your PWD is ~. Make a new directory called ```text```.  In that directory Use the ```wget``` command to retrieve a compressed file (zip) of the class textbook from: [https://github.com/jhajek/Linux-text-book-part-1/archive/master.zip](https://github.com/jhajek/Linux-text-book-part-1/archive/master.zip) and extract it.
    i)  Take a screenshot of the above commands used to extract the zip file
1. Now ```cd``` into the directory you just decompressed. Type the command that will create folders named Chapter-16..31 in one command.
    i) Take a screenshot of the above command with output
1. What command will list every file in the textbook directory that has any number of characters and a ```.sh``` two character file extension of any name?
    i) Take a screenshot of the above command with output
1. What command inside the textbook directory will do a long listing of Chapters-02,04,06, and 08 only?
    i) Take a screenshot of the above command with output
1. Write a command that will make a directory named Chapter-00 and copy the file `Chapter-02/chapter-02.md` into the directory `Chapter-00`, and finally use the `move` command (`mv`) to rename the copied file to `chapter-00.md`.  Use the meta-character needed to execute the proceeding commands only if the previous command is true. Place all these commands onto one single line.
    i) Take a screenshot of the above command with output
1. Create a shell variable named UT, assign the contents of the command ```uptime``` to UT and print a string to the screen with its value and with a string stating, "The system has been up for: " and then the value of UT.
    i) Take a screenshot of the above command with output
1. Execute the following commands: ```sudo apt-get -y update 1>/tmp/01.out 2>/tmp/01.err``` ```sudo apt-get -y install nginx 1>/tmp/02.out 2>/tmp/02.err``` ```sudo systemctl start nginx 1>/tmp/03.out 2>/tmp/03.err``` *Note* if you are on Fedora replace apt-get with dnf and skip the first instruction. Display the contents of the \*.out files in one command and pipe its output to the ```less``` command. Display the contents of the \*.err files in one command and pipe its output to the ```less``` command.  
    i) Take a screenshot of the above command with output
1. You are typing the command ```ls -l /topsecret``` and you want to redirect both standard out and standard error to a file named /tmp/out-and-error.txt, how would you do it?
    i) Take a screenshot of the above command with output
1. You will find a file named hosts.deny located in the directory `files` > `Chapter-06` of the download of the textbook. It contains a list of IP addresses - what command would you use to count ONLY the number of lines?
    i) Take a screenshot of the above command with output
1. Using the error.log file located in the directory `files` > `Chapter-06` - what command would you use to count only unique lines and to display their count and only if there is more than 1 occurrence?
    i) Take a screenshot of the above command with output
1. What command would let you display the content of the hosts.deny file, cut out the the second column and sort it?
    i) Take a screenshot of the above command with output
1. What command would let you search the file error.log for the lines that contain the term "robots.txt"?
    i) Take a screenshot of the above command with output
1. What command would let you count the number of lines that have the term "robots.txt" in the file error.log?
    i) Take a screenshot of the above command with output
1. Using the hosts.deny file, what command would you type to display the last 10 lines of the file, cut out the field with the IP address and sort them in ascending order?
    i) Take a screensot of the above command with output
1. Use the `grep` tool to search the file error.log for the line "Invalid method in request" and print to the screen the lines found.
    i) Take a screensot of the above command with output
1. Using tools discussed in this chapter and based on the contents of the file **error.log**, type the commands needed to find the following:  How many unique IPs did the error messages come from?  Home many unique URLs based errors (last column), and list all of the unique type of errors (second to last column).
    i) take a screenshot of each of the above commands and output.
1. Using the ```find``` command and starting from the \~ directory what would be the command to find all files with the name .md?
    i) Take a screenshot of the above command with output
1. Using the find command and starting from the \~ directory what would be the command to find all the files that have been modified in the last hour prior?
    i) Take a screenshot of the above command with output
1. Using the file **sotu -> 2005-sotu.txt** and **sotu -> 2013-sotu.txt** using pipes, display the file of text, determine the 10 most frequently used words, and print out a sorted list of those words along with their frequencies. Use the `tr` command to generate a list of tokenized all lowercased words, start with `cat 2005-sout.txt | tr -cs A-Za-z '\n' | tr A-Z a-z`.
    i) Take a screenshot of the above command with output
1. In the **files > chapter-06 > sample-data** directory, compress the entire directory structure of sample-data as a single `tar` archive called `inputfiles.tar`.
    i) Take a screenshot of the above command with output
1. In the folder, **files > chapter-06 > weather-data**, uncompress the .xz file.  Recompress the original text file using gzip, bzip2, xz, and Brotli.
    i) Take a screenshot of the above commands with output and a long listing showing file size, `ls -lh`
1. Download the Linux kernel archive via wget from: (use the latest version), an example: [https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.14.77.tar.xz](https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.14.77.tar.xz "kernel.org") or any other mainline stable kernel. Extract this `tarball` in one command.  Then type the command to delete the tarball.  Now type the command to re-tar and re-compress it with xzip in one `tar` command.
     i) Take a screenshot of the above command with output -- Note this may be best as a series of screenshots
