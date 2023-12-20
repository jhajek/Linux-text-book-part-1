# Review Questions - Chapter 06

Shell Meta-Characters, Pipes, Search, and Tools

1.  What is the name for characters that have special meanings in the Linux shell?
    a.  special chars
    b.  marked characters
    c.  shell characters
    d.  shell meta-characters
1.  Assume your pwd is ~.  If you wanted to list every directory that started with the letters "Do" what would be the command?
    a.  ls -l
    b.  ls -la [Dd]o
    c.  ls -l Do
    d.  ls -l Do*
1.  In figure 6.2 in Chapter 06 which of the 3 blue boxes is the step where shell meta-characters are transformed into text?
    a.  Lexical analysis and parse
    b.  Execution
    c.  Builtins
    d.  Expansion
1.  Which meta-character allows you to string commands together regardless of the successful execution of the previous command?
    a.  &&
    b.  ;
    c.  \+
    d.  ||
1.  Which meta-character allows you to string commands together but will exit if the first command fails?
    a.  &&
    b.  ;
    c.  \+
    d.  ||
1.  Which meta-character is the wildcard for 0 or more matches?
    a.  ?
    b.  \*\*
    c.  &
    d.  \*
1.  Which meta-character is the single character wildcard?
    a.  ?
    b.  '
    c.  &
    d.  \*
1.  Square braces [] indicate sets or ______ of characters to be processed
    a.  numbers
    b.  letters
    c.  characters
    d.  ranges
1.  If you wanted to use brace expansion and create a series of nine files named: file1 - file9, all at once--what command would you use?
    a.  touch file[1-9]
    b.  touch file(1-9)
    c.  touch file{1..9}
    d.  touch file[1..9]
1.  If you wanted to assign the value of /etc/alternatives/java to a shell variable named JAVA_HOME--what would be the proper syntax?
    a.  JAVA_HOME = /etc/alternatives/java
    b.  /etc/alternatives/java = JAVA_HOME
    c.  JAVA_HOME=/etc/alternatives/java
    d.  $JAVA_HOME=/etc/alternatives/java
1.  What would be the proper syntax to display the content of a variable named JAVA_HOME in the shell?
    a.  echo JAVA_HOME
    b.  cat JAVA_HOME
    c.  print JAVA_HOME
    d.  echo $JAVA_HOME
1.  There are 3 standard I/O devices in a Linux system, standard in, standard out, and ________
    a.  standard air
    b.  standard io
    c.  standard x
    d.  standard error
1.  Standard In is what device by default?
    a.  mouse
    b.  screen
    c.  tty
    d.  mouse and keyboard
1.  Standard Out is what device by default?
    a.   mouse
    b.   screen
    c.   X
    d.   keyboard
1.  What meta-character can you use to redirect standard out to a file? (Choose all that apply.)
    a.  \>
    b.  \>\>
    c.  \<
    d.  \>\>\>
1.  What meta-character is used to redirect the standard output of one command as the standard input of another command?
    a.  ->
    b.  &&
    c.  ||
    d.  \|
1.  Which command is used to search within files using textual filter patterns?
    a.  find
    b.  locate
    c.  slocate
    d.  grep
1.  Which command can be used to count lines that are in a text file?
    a.  count
    b.  wc
    c.  lines
    d.  uniq
1.  Which command can be used to find unique line occurrences in a text file? 
    a.  sort
    b.  uniq
    c.  wc
    d.  who
1.  Which command can be used to sort the content of a text file>
    a.  sort
    b.  uniq
    c.  wc
    d.  who
1.  Which command would assign the output of the date command to a variable named DT?
    a.  DT = date
    b.  DT=date
    c.  DT=$(date)
    d.  DT = $(date)
1.  What would be the correct command to redirect the standard out and standard error of a command to files?
    a.  `sudo apt install nginx 1>/tmp/02.out 2>/tmp/02.err`
    b.  `sudo apt install nginx 0>/tmp/02.out 1>/tmp/02.err`
    c.  `sudo apt install nginx >/tmp/02.out >/tmp/02.err`
    d.  `sudo apt install nginx &>/tmp/02.out &>/tmp/02.err`
1.  What is the command that will print the last 10 lines of a text file?
    a.  head
    b.  tail
    c.  tac
    d.  cat
1.  What is the command that will print the first 10 lines of a text file?
    a.  head
    b.  tail
    c.  tac
    d.  cat
1.  What is the command to display the content of a text file backwards (last line first)?
    a.  head
    b.  tail
    c.  tac
    d.  cat
