#! /bin/bash

# Esta función devuelve el factorial del número introducido. Como el factorial de un número natural «n» es el resultado del producto de todos los números desde 1 hasta dicho número «n», debemos utilizar una función recursiva, es decir, una función que se llama a sí misma dentro.

factorial(){
	# Si el número introducio es 0, su factorial será 1, porque su resultado es no multiplicar 
	# ningún número.
	if [[ $1 -eq 0 ]]; then
		echo 1
	else
		# La función factorial se llama recursivamente para calcular el factorial de $((n-1)),
		# y el resultado se almacena en la variable «var»
		local var=$(factorial $(($1-1)))
		echo $(($1 * $var))
	fi
}

echo "Introduce un número para obtener su factorial:"
read num

resultado=$(factorial $num)
echo "El factorial de $num es $resultado"
