#5.Escribir un script que calcule el factorial de un número. Por ejemplo, Factorial de 10 = 1098765432*1
#mensaje para el usuario que ingrese el numero
echo "ingrese el numero: "

#recojo el numero
read a

#voy a hacerlo con un bucle for, el factorial es la multiplicacion de los numeros desde el 1 hasta el
#numero que ha elegido el usurio

factorial=1

#bucle for para iterar desde 1 hasta el número ingresado
for (( i=1; i<=$a; i++ )) 
do
  #multiplicar el valor actual de la variable fact por el valor actual de i y almacenar el resultado en la variable fact
  factorial=$((factorial*i))
done

#imprimir el resultado en pantalla
echo "El factorial es: $factorial"