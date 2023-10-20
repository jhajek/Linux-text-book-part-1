#!/usr/bin/bash
# You might want a script to exit if a certain condition doesn't exist
# You can do that with an exit command

if [ -a ~/documents ]
    then
      echo "The documents directory exists"
    else
     echo "Directory doesn't exist, exiting program!"
     exit 1
fi
