#!/usr/bin/bash

# What is the difference between 
cat hosts.deny 
awk '{print;}' hosts.deny

# How would you print out all lines of a file that contain a # as the first character?
awk '$0~/^#/' hosts.deny

#How would you print out all lines of a file that do not contain a # as the first character?
awk '$0!~/^#/' hosts.deny
