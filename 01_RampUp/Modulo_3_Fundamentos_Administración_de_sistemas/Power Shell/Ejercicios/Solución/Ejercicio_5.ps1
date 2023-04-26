#Introducir dos numeros y mostar cual es mayor, menor o si son iguales
Write-Output "Introduce el primer número"
$numero1 = Read-Host
Write-Output "Introduce el segundo número"
$numero2 = Read-Host

if ($numero1 -eq $numero2) {
    Write-Output "los numeros son iguales"
}
if ($numero1 -gt $numero2) {
    Write-Output "El numero: $numero1 es mayor que $numero2"
}
if ($numero1 -lt $numero2) {
    Write-Output "El numero: $numero1 es menor que $numero2"
}