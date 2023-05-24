#4.Crea un cmdlet de PowerShell que recoja dos variables por consola con Read y lleve a cabo todas
# las operaciones aritméticas entre ellas y las muestre por consola.

Write-Output "Introduce 2 numeros para hacer operaciones"

$numero1 = Read-Host "Introduce el primer numero"
$numero2 = Read-Host "Introduce el segundo numero"

$suma =[int]$numero1 + [int]$numero2
Write-Output "La suma es: $suma"

$resta =[int]$numero1 - [int]$numero2
Write-Output "La resta es: $resta"

$multiplicacion =[int]$numero1 * [int]$numero2
Write-Output "La multiplicacion es: $multiplicacion"

if ($numero2 -ne 0 ){
    $division =[int]$numero1 / [int]$numero2
    Write-Output "La division es: $division"
} else{
    Write-Output "La division entre 0 no es vàlida"
}