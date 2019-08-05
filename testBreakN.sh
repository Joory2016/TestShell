#!/bin/bash
# breaking out of an out loop

for (( a=1;a<4;a++ ))
do
    echo "Out loop: $a"
    for (( b=1;b<100;b++ ))
    do
        if [ $b -gt 4 ] && [ $a -eq 2 ]
        then 
            break 2
        fi
        echo "  Inner loop: $b"
     done
done

