#Realizar el ejercicio de las tablas de multiplicar que vimos en la parte de CMD, pero ahora, en un 
#script de bash.

#imprime en pantalle el mensaje al usuario solicidtando el numero 
echo "Ingrese el numero del que quiera la tabla de multiplicar"
#recojo el numero que ingresò el usuario
read a 

echo "La tabla de multiplicar del numero $a es: "
#hago un bucle del 1 al 10 para que multiplique con el numero ingresado por el usuario
for i in {1..10};

do
#imprimo el resultado en pantalla
    echo  "$a x $i = $((a*i))"
done
