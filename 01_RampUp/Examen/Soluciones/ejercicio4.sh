#!/bin/bash
declare -i n
read -p "Introduce un numero: " n
for i in {0..10}
do
 echo "$n x $i=$(($n * $i))"
done