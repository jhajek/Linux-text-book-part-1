#!/usr/bin/bash
# Checking the number of parameters and exiting is postional parameter quantity is wrong

if [ $# -gt 1 ]
    then
      echo "You need to type only 1 positional parameter - you entered more!"
      exit 1
else
   echo "Good job you typed in 1 parameters"
fi
