# Solicitamos al usuario que introduzca un número que guardamos en la variable num
echo "Introduce un número: "
read num

# Informamos al usuario del número introducido
echo "El número introducio es el $num."

# Recorremos una lista de valores del 1 al 10 y lo multiplicamos por el número introducido por el usuario.
# Guardamos la multiplicación en la variable resutado y le mostramos el recorrido del bucle al usuario
echo "La tabla de multiplicar del $num es la siguiente: "

for i in {0..10}
do
        resultado=$((num*i))
        echo "$num x $i = $resultado"
done
