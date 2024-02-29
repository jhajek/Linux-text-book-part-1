# Review Questions - Chapter 07

1.  What are the two main representatives of stream editors?
    a.  gedit and kate
    b.  Nano and Joe
    c.  vi and Nano
    d.  vi and Emacs
1.  Which family of editors came first?
    a.  Screen editors
    b.  Butterfly editors
    c.  GUI editors
    d.  Stream Editors
1.  What type of editor is GNU Nano?
    a.  stream
    b.  text
    c.  free
    d.  file
1.  Who created the vi editor?
    a.  Richard Stallman, 1984
    b.  Brian Fox, 1989
    c.  Bill Joy, 1979
    d.  Bill Joy, 1983
    e. Brian Fox, 1979
1.  Which of the following sequences of the history of vi is correct?
    a.  Emacs -> ed -> ex -> vi
    b.  ed -> em -> ex -> vi -> vim
    c.  em -> ex -> vi
    d.  em -> ed -> vi -> vim
1.  What are the three modes in vi?
    a.  command, insert, output
    b.  command, output, ex
    c.  command, insert, ex
    d.  command, insert, vi
1.  What is the key you use in vi to transition between COMMAND MODE and INSERT mode?
    a.  delete
    b.  alt
    c.  escape
    d.  F1
1.  What command sequence (key) in vi will add text to the right of the current cursor position?
    a.  a
    b.  i
    c.  o
    d.  w
1.  What command sequence (key) in vi will move you to the beginning of the next word?
    a.  w
    b.  b
    c.  i
    d.  o
1.  What command sequence in vi will delete a single line based on the current cursor position?
    a.  ddd
    b.  d
    c.  dd
    d.  del
1.  What command sequence in vi will delete 10 lines from the current cursor position?
    a.  10d
    b.  10dd
    c.  dd10
    d.  d10
1.  Which command in ex mode (vi) will save the current file you are working on and exit the vi editor?
    a.  `:sq`
    b.  `:q`
    c.  `:w`
    d.  `:wq`
1.  In `vim` what would be the `ex` command to search forward for occurrences of `GoogleBot`?
    a.  `/GoogleBot`
    b.  `GoogleBot`
    c.  `?GoogleBot`
    d.  `GoogleBot/`
1.  In `vim` what would be the command in `ex` mode to replace all occurrences of `linux` with `Linux` in a document?
    a.  `:1,$s/linux/Linux/g`
    b.  `:s/linux/Linux/g`
    c.  `:s/linux/Linux/`
    d.  `:1,$s/Linux/linux/g`
1.  In `vim` what would be the command in `ex` mode to replace all occurrences of `Linux` with `GNU/Linux`?
    a.  `:1,$s/linux/GNU/Linux/g`
    b.  `:1,$s/linux/GNU\/Linux/g`
    c.  `:s/linux/GNU/Linux/g`
    d.  `:s/linux/GNU\/Linux/g`
1.  In `vim` what would be the command in `ex` mode to replace all occurrences of the word Windows?
    a.  `:1,$s/Windows//g`
    b.  `:1,$s//Windows/`
    c.  `:1,$s/Windows//`
    d.  `:s/Windows//g`
1.  Assuming a file name `topsecret.sh` has a permission of 644 - what is the shortcut to give just the **owner** of the file additional permissions to execute the script?
    a.  `chmod +x topsecret.sh`
    b.  `chmod o+x topsecret.sh`
    c.  `chmod g+x topsecret.sh`
    d.  `chmod u+x topsecret.sh`
1.  Assuming a file named `moretopsecret.sh` has a permission of 755 - what is the command to change the permission to have only read and write permission for the owner?
    a.  `chmod 700 moretopsecret.sh`
    b.  `chmod 600 moretopsecret.sh`
    c.  `chmod 744 moretopsecret.sh`
    d.  `chmod 755 moretopsecret.sh`
1.  What is the correct command sequence to save or write out a file in GNU Nano?
    a.  `^6`
    b.  `^X`
    c.  `^O`
    d.  `:wq`
1.  What is the command to display the contents of the PATH system variable on the command line?
    a.  echo PATH
    b.  echo $PATH
    c.  echo path
    d.  $PATH
1.  Using `vim` what is the `ex` mode command to move your curser to line 25 of a text file?
    a.  `:m25`
    b.  `25`
    c.  `^25:`
    d.  `:25`
1.  Using `vim` what is the `ex` mode command to move your curser to the last line of a text file?
    a.  `$`
    b.  `G`
    c.  `:$`
    d.  `ESC G`
1.  Using `vim` what is the `ex` more command to find and replace the word `Ubuntu` with `Fedora` only the first occurance on a line
    a.  `:s/ubuntu/fedora`
    b.  `:s/Ubuntu/Fedora`
    c.  `:1,$s/Ubuntu/Fedora`
    d.  `:s/Ubuntu/Fedora/g`
1.  In every bash shell script what are the required first two characters?
    a.  `#`
    b.  `!!`
    c.  `#!`
    d.  `!#`
1.  In a Bash script what is the default path of the bash executable?
    a.  /bin/bash
    b.  /bin/sh
    c.  /bin/ash
    d.  /sbin/bash
1.  If you execute the command `./list-ip.sh` and you recieved the error message **Permission denied**. What is the solution to the problem?
    a.  You need to give the owner of the file read permission
    b.  You need to give the owner of the file write permission
    c.  You need to give the owner of the file open permission
    d.  You need to give the owner of the file execute permission
1.  Upon opening a new terminal which file is processed, in your home directory, to extend a user's environment variables?
    a.  `.profile`
    b.  `.bash-logout`
    c.  `.bashrc`
    d.  `bashrtc`
