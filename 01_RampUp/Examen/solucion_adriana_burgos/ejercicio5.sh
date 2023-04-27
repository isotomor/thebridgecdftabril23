#!/bin/bash

# 5. Escribir un script que calcule el factorial de un número. 
# Por ejemplo, Factorial de 10 = 10*9*8*7*6*5*4*3*2*1

declare -i num
declare -i i
declare -i res
i=1
res=0

# Recibimos el numero del usuario
echo "Dame un numero"
  read num
i=num
res=num

echo "vamos a caulcular el factorial de $num :"
while [ $i -gt 0 ]; do
    res=res*i
    i=i-1
done 
echo "el factorial de $num es $res"