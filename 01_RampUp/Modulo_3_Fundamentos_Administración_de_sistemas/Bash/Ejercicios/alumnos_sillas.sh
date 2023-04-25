#! /bin/bash

#declare -a usuarios=([0]=num1 [1]=num2 [2]=num3 [3]=num4)
#!/bin/bash

# Pedimos al usuario que introduzca los parámetros separados por espacios
echo "Introduce el numero de alumnos que hay hoy:"
read cantidad_alumn

echo "Introduce el numero de sillas que hay hoy en clase:"
read cantidad_sillas

if (( $cantidad_alumn > $cantidad_sillas )); then

     echo  "No hay sufientes sillas para los alumnos"
else
        alumnos=()
        sillas=()
#En este caso el i=1 marca el inicio del bucle luego la condicion y luego q se valla sumando 1

         for ((i=1; i<=$cantidad_alumn; i++)) 
         do
 
#Pido el nombre del alumno 

             echo "Dame el nombre del alumno $i:"
             read nombre_alumn

             echo "Dame el numero de la silla de $nombre_alumn:"
             read numero_silla
  
#Aqui con el alumnos+ lo que hacemos es tomar la variable leida y añadirla a alumnos
          alumnos+=($nombre_alumn)
          sillas+=($numero_silla)
        done
 
# Asociar aleatoriamente los nombres de los alumnos con los números de silla

reparto=$(paste <(printf "%s\n" "${alumnos[@]}") <(printf "%s\n" "${sillas[@]}" | shuf))

# Mostrar la asociación aleatoria
  echo "A continuacion os diremos donde se sienta al final cada uno:"
  echo "$reparto"
fi
