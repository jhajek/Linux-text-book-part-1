#!/usr/bin/bash

#How would you print out all lines of a file that do not contain a # as the first character?
awk '$0!~/^#/' hosts.deny | head
