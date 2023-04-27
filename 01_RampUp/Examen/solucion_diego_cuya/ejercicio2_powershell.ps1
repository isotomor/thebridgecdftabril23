#Numeros aleatorios
#Usamos la funcion Get-random para que nos de numero aleatorio.
#Primero creamos el array numA para los numeros aleatorios
$numA = @()

for ($i = 0; $i -lt 10; $i++){
    $numA += Get-Random -Minimum 1 -Maximum 100
}

Write-Host "El array original es este: $numA"

for($i = $numA.Count - 1; $i -ge 0; $i--){
    Write-Host  $numA[$i]
}