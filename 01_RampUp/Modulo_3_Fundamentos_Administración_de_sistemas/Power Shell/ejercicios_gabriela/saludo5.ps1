#5.Crea un cmdlet de PowerShell que solicite dos números enteros al usuario. El cmdlet debe  
#decirnos si uno es mayor,menor o igual que el otro.

Write-Host "Introduce 2 numeros enteros para hacer operaciones"

$numero1 = Read-Host "Introduce el primer numero"
$numero2 = Read-Host "Introduce el segundo numero"

if ($numero1 -eq $numero2){
    Write-Host "$numero1 es igual que $numero2"
}elseif ( $numero1 -gt $numero2) {
    Write-Host "$numero1 es mayor que $numero2"
}else{
    Write-Host "$numero1 es menor que $numero2"
}