#!/bin/bash

declare -i num
declare -i i
declare -i res
i=1
res=0
echo "Dame un numero"
  read num
echo "vamos a imprimir la tabla del $num :"
while [ $i -le 10 ]; do
    res=num*i
    echo "$num * $i = $res"
    i+=1
done
echo "Hecho!"
exit 0
