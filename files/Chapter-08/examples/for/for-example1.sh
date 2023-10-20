#!/usr/bin/bash
# Store each line of a file into an Array and loop over the array

NAMESARRAY=( $(cat names.txt))

for NAME in ${NAMESARRAY[@]};
do
  echo "The names in the file: $NAME"
done
