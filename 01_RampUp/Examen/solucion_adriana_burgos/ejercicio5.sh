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

# Nuestro contador i se inicializa a num - 1 ya que el factorial 
# se va multiplicando siempre por si mismo - 1. El resultado se inicializa a 1
i=num-1
res=num

echo "vamos a caulcular el factorial de $num :"

# Mientras nuestro contador i sea mayor que 0, multiplicamos el resultado
# por i y le restamos 1 a i para seguir iterando. 
# Tambien se podría hacer le bucle con al lógica inversa: mientras i sea menor que num, 
# i+=1 para iterar.
while [ $i -gt 0 ]; do
    res=res*i
    i=i-1
done
echo "el factorial de $num es $res"

