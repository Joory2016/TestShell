#!/bin/bash
# using functions defined in a library file
. ./myfuncs

value1=10
value2=5
res1=$(addem $value1 $value2)
res2=$(multem $value1 $value2)
res3=$(divem $value1 $value2)
echo "The result of adding them is: $res1"
echo "The result of multipling them is: $res2"
echo "The result of dividing them is: $res3"

