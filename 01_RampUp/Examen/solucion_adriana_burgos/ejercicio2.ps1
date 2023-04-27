#  2. Crea un array de diez números aleatorios (buscar qué función lo puede hacer y cómo se utiliza), 
#     imprímelos y partir de ese array, dale la vuelta. (y lo vuelves a imprimir). Ejemplo:
#   - 123 506 712 200 506 203 102 501 602 657
#   - 657 602 501 102 203 506 200 712 506 123

# Creo un array vacio
$array=@()
$reverse=@()

# Hago un bucle for para añadir 10 numero aleatorios al array.
# Todos los números de ejemplo son de 3 cifras, 
# así que añado los parámetros -Minimum y -Maximum para ajustar el numero aleatorio a eso
for ($i=0; $i -lt 10; $i++) {
    $array+=Get-Random -Minimum 100 -Maximum 999
}
Write-Host "Elementos del array: $array"

# Para imprimir los elementos de un array del final al principio podriamos 
# usar un bucle for e imprimir cada uno de los elementos del array empezando por el final.
# Sin embargo, Powershell cuenta con un método propio que sirve para revertir el orden de los
# elementos en un array, así que usemos eso:

# NOTA: por algún motivo la sintaxis de $array = $array.Reverse() me daba el siguiente error:
# "Error en la invocación del método porque [System.Int32] no contiene ningún método llamado 'Reverse'." 
# así que estoy usando un metodo alternativo:

# Clonamos el array y después usamos el método Reverse para invertirlo
$reverse = $array.clone()
[array]::reverse($reverse)

# Imprimir el array invertido
Write-Host "Array invertido:     $reverse"
