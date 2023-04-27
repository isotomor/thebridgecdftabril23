 #! /bin/bash
#Pedimo un numero al usuario.
echo -n "Dame un numero para darte su factorial:"
read num

#Creamos dos variable, un apara el bucle y otra para el factorial.
contador=1
factorial=1

#Creamos el bucle con un while para que mientras nuestro contador sea menos que el numero, multiplique el contador por factorial y se lo añada a factorial, sumamos 1 al contador para que a la siguiente vuelta se multiplique por el siguiente numero.
#Ya que un factorial en ejemplo seria asi --- factorial de 5= 1 * 2 * 3 * 4 * 5
while [ $contador -le $num ]; do
    factorial=`expr $factorial \* $contador`
    contador=`expr $contador + 1`
done
echo "El factorial de $num es $factorial"
#Es importante poner los dos parentesis ya que sino no te lo reconoce como operacion aritmetica.