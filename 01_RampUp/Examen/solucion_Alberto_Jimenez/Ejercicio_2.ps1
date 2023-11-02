#ENUNCIADO 

# Crea un array de diez números aleatorios (buscar qué función lo puede hacer y cómo se utiliza), 
# imprímelos y partir de ese array, dale la vuelta. (y lo vuelves a imprimir). Ejemplo:
# - 123 506 712 200 506 203 102 501 602 657
# - 657 602 501 102 203 506 200 712 506 123


#EJERCICIO

# Creamos un array de diez números aleatorios

# Primero definimos el parámetro

$numeroaleatorio = 1..10

# Creamos un bucle con el comando necesario para conseguir los numeros aleatorios

foreach ($numero in $numeroaleatorio)
{
   Get-Random -Minimum 111 -Maximum 999
}

# Revertimos la lista que nos da el bucle

Reverse($numero)

# Aun no he logrado dar con el comando/sintagma exacto para revertir la lista

