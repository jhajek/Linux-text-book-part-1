# Review Questions - Chapter 06

Shell Meta-Characters, Pipes, Search, and Tools

1. What is the name for characters that have special meanings in the Linux shell?
a. special chars
b. marked characters
c. shell characters
d. shell meta-characters

2. Assume your pwd is ~. If you wanted to list every directory only that started with the letters "Do" what would be the command?
a. ls -l
b. ls -la [Dd]o
c. ls -l Do
d. ls -l Do*

3. In figure 6.2 in Chapter 06 which of the 3 blue boxes is the step where shell meta-characters are transformed into text?
a. Lexical analysis and parse
b. Execution
c. Builtins
d. Expansion

4. Which meta-character allows you to string commands together regardless of the successful execution of the previous command?
a. &&
b. ;
c. \\+
d. ||

5. Which meta-character allows you to string commands together but will exit if one of the commands fails?
a. &&
b. ;
c. \\+
d. ||

6. Which meta-character is the wildcard (0 or more matches.?
a. ?
b. \*\*
c. &
d. \*

7. Which meta-character is the single character wildcard?
a. ?
b. '
c. &
d. \*

8. Square braces [] indicate sets or ______ of characters to be processed
a. numbers
b. letters
c. characters
d. ranges

9. If you wanted to use brace expansion and create a series of nine files named: file1, file2, file3, etc etc all at once--what command would you use?  (type the full command using touch .
a. touch file{1..9}

10. If you wanted to assign the value of /etc/alternatives/java to a shell variable named JAVA_HOME--what would be the proper syntax?
a. JAVA_HOME = /etc/alternatives/java
b. /etc/alternatives/java = JAVA_HOME
c. JAVA_HOME=/etc/alternatives/java
d. $JAVA_HOME=/etc/alternatives/java

11. What would be the proper syntax to display the content of a variable named JAVA_HOME in the shell?
a. echo JAVA_HOME
b. cat JAVA_HOME
c. print JAVA_HOME
d. echo $JAVA_HOME

12. There are 3 standard I/O devices in a Linux system, standard in, standard out, and ________
a. standard air
b. standard I/O
c. standard x
d. standard error

13. Standard In is what device by default?
a. mouse
b. screen
c. tty
d. keyboard

14. Standard Out is what device by default?
a.  mouse
b.  screen
c.  X
d.  keyboard

15. What meta-character can you use to redirect standard out to a file? (Choose all that apply.
a. \>
b. \>\>
c. \<
d. \>\>\>

16. What meta-character is used to redirect the standard output of one command as the standard input of another command?
a. ->
b. &&
c. ||
d. \|

17. Which command is a shortcut to display the kernel's output messages?
a. kern
b. &kern
c. top
d. dmesg

18. Which command is used to search within files using textual filter patterns?
a. find
b. locate
c. slocate
d. grep

19. When you combine a tar (tape archive) and an additional compression method--what is the name for the resulting file?
a. tar
b. tarx
c. tarall
d. tarball

20. What is the name of the GNU compression tool project released in 1992?
a. xz
b. zip
c. DEFLATE
d. gzip
