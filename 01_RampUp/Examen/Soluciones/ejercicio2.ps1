$lista= [System.Collections.ArrayList]::new()
# También se puede crear la lista como
$lista = 0,0,0,0,0,0,0,0,0,0

Write-Host "Lista Aleatoria: $lista"

foreach($i in (1..10)) {

 $numero=Get-Random -Minimum 1 -Maximum 1000
 $lista.Add($numero)

}

Write-Host "Lista : $lista"

$lista.Reverse()

Write-Host "Lista invertida: $lista"
