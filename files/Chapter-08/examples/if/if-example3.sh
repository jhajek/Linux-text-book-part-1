#!/usr/bin/bash

if [ -a ~/Documents ]
    then
      echo "The documents directory exists"
    else
     # This will silently log the error to a file
     echo "Directory doesn't exist" &> ~/Documents/script.log
fi
