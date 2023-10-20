#!/usr/bin/bash
# Complex decision logic using AND with positional parameters

if [ -a $1 ] && [ -x $1 ]
    then
      echo "File exists and is executable"
else
  echo "File does not exist and/or is not executable"
fi
