#Crea un array de diez números aleatorios (buscar qué función lo puede hacer y cómo se utiliza),
# imprímelos y partir de ese array, dale la vuelta. (y lo vuelves a imprimir).

$array = @()


#Con un bucle for que itere 10 veces obtendre los numeros y para que sean aleatorios
#con la funcion get-random y limito que sean numeros de 2 cifras

for ($i=0; $i -lt 10 ; $i++){

    $array += Get-Random -Minimum 10 -Maximum 99


}
# imprimo el mensaje mas el array generado

Write-Host "Array generado: $($array)"


#ahora para numeros invertidos creo un array que va a alamcenar los elementos del for 

$array_invertido = @()


for ($i=9; $i -ge 0 ; $i--){

    $array_invertido += $array[$i]
}
Write-Host " Array invertido: $($array_invertido )"