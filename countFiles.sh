#!/bin/bash
#itetate throught all the files in a directory

files=0
dires=0

for file in /bin/*
do
    if [ -d "$file" ]
    then 
        echo "$file is a directory"
        (( dires++ ))
    elif [ -f "$file" ]
    then 
        echo "$file is a file"
        (( files++ ))
    fi
done

echo "the number of files is $files"

echo "the number of directory is $dires"

