#pide 2 numeros y muestra las operaciones.

Write-Output "Introduce 2 numeros para hacer operaciones"

Write-Output "el primer numero: "

$uno = Read-Host
Write-Output "el primer numero: "
$dos = Read-Host
$resultado = [int]$uno + $dos
Write-Output "La suma es: "$resultado

$resultado = [int]$uno - $dos
Write-Output "La resta es: "$resultado

$resultado = [int]$uno * $dos
Write-Output "La multiplicacion es: "$resultado

$resultado = [int]$uno / $dos
Write-Output "La división es: "$resultado