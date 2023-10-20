#!/usr/bin/bash
# This is a valid 1 line for loop that prints out a single dot indicator

echo -e "\nFinished launching and sleeping 25 seconds"
for i in {0..25}; do echo -ne '.'; sleep 1;done
echo "\n"
