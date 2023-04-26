#Introducir un numero entre el 1 y el 100, si ha cometido algun error crear un bucle tantas veces como erroes...

$salir = 0
$bucle = 0
while ($salir -eq 0){
  Write-Output "Introduce un numero entre el 1 y el 100"
  $numero = Read-Host
  if ([int]$numero -gt 0 -and [int]$numero -lt 100) {
    $salir=1
  }else{
    $bucle=$bucle+1
  }
}
if ($bucle -eq 0){
    Write-Output "Eres un crack"
}else {
  for ($i=0;$i -lt $bucle; ++$i) {
    Write-Output "Eres un pringao!!!!"
  }
}