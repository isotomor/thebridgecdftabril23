#! /bin/bash

# Este script muestra todas las tablas de multiplicar del 1 al 10.
# Recorremos los números del 1 al 10 con un primer bucle para multiplicar cada iteración por los números iterados dentro de un segundo bucle for también con números del 1 al 10

for i in {1..10}
do
  #Mostramos por pantalla en qué tabla de multiplicar estamos
  echo "Tabla de multiplicar del $i:"
  for j in {1..10}
  do
    # Guardamos en una variable el resultadmo de la multipliación del ítem del primer bucle con los ítems del
    # segundo bucle y los mostramos por pantalla
    resultado=$((i*j))
    echo "$i x $j = $resultado"
  done
  echo ""
done
