#!/bin/bash

# 4. Realizar el ejercicio de las tablas de multiplicar 
# que vimos en la parte de CMD, 
# pero ahora, en un script de bash.

declare -i num
declare -i i
declare -i res
i=1
res=0

# Recibimos el numero del usuario
echo "Dame un numero"
  read num
echo "vamos a imprimir la tabla del $num :"

# Por cada número del 1 al 10, lo multiplicamos por num
# y lo mostramos por pantalla.
while [ $i -le 10 ]; do
    res=num*i
    echo "$num * $i = $res"
    i+=1
done
echo "Hecho!"
exit 0