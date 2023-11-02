# ENUNCIADO

# Realizar el ejercicio de las tablas de multiplicar que vimos en la parte de CMD, pero ahora, en un script de bash.


# EJERCICIO

#! /bin/bash

# Pedimos un numero
echo "Introduce un número: "
read num1

# Haremos las tablas de multiplicar con ese numero
echo "Tabla de multiplicar del número $num1:"
for i in {1..10}
do
  echo "$num1 * $i = $(($num1 * $i))"
done

# Por ahora da error en la linea del comando echo, me parece que el signo de multiplicación da problemas
