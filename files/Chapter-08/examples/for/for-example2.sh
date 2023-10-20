#!/usr/bin/bash
# This is a traditional C based for loop

declare -a planetARRAY
planetARRAY=( mars earth mercury )
LENGTH=${#planetARRAY[@]}
echo "ARRAY LENGTH IS $LENGTH"

for (( i=0; i<${LENGTH}; i++));
do
  echo ${planetARRAY[$i]}
  sleep 1
done
