# ENUNCIADO

# Escribir un script que calcule el factorial de un número. Por ejemplo, Factorial de 10 = 10*9*8*7*6*5*4*3*2*1


# EJERCICIO

#! /bin/bash

# Pedimos un numero 

echo "Introduce un numero: "
read num

# Introducimos parámetro y bucle

FACT=1

for i in $(seq 1 10 $num)
do
	FACT=$((FACT*i))
done

# Comenta el resultado

echo "El factorial es $FACT"

exit 0

