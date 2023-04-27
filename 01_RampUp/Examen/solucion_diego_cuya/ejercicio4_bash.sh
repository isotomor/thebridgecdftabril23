 #! /bin/bash
#Ejercicio de tablas de multiplicar
#Primero pedimos un numero.
echo "Dame un numero para darte su tabla de multiplicar:"
read num
#Ahora realizamos un bucle for para que pueda para que en base al numero recibido, me realice la multipliccion por 1 hasta el 10.

for  i in {0..10..1} 
do 
    resultado=$(($num * $i))

    echo "$num * $i = $resultado"
done