#!/usr/bin/bash
# Assume the names.txt file exists from previous examples

while read LINE
  do echo $LINE; mkdir -v /tmp/$LINE
done < names.txt
