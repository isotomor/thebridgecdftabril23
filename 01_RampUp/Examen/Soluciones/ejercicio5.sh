#!/bin/bash
declare -i n
read -p "Introduce un numero: " n
for ((total=1,i=$n; $i > 1; i--))
do
 total=$(($total * $i))
done
echo "$n!=$total"