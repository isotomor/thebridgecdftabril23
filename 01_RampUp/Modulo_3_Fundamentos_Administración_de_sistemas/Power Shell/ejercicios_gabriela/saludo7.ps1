#7. Crea un cmdlet que solicite al usuario un número. Mientras lo que introduzca el usuario no esté entre 1 y 100
# se lo tiene que solicitar una y otra vez. Una vez introducido el número correcto el programa debe hacer lo 
#siguiente:
#si ha cometido algún error al introducir un número válido debe hacerse un bucle en el que se increpe al usuario
#tantas veces como errores haya cometido. Si lo hizo bien a la primera saca un mensaje que diga: campeón.

$numero = 0
$error = 0

while($numero -eq 0 -or [int]$numero -lt 1 -or [int]$numero -gt 100){
    $numero = Read-Host "Introduce un numero entre 1 y 100"
    if ([int]$numero -lt 1 -or [int]$numero -gt 100){
        Write-Host "Error, el numero debe estar entre 1 y 100. Ingresa otro nùmero."
        $error+=1
    }
}

if ($error -eq 0){
    Write-Host "Eres un campeòn"
} else {
    for($i=1; $i -lt $error; $i++){
        Write-Output "Error número $i"
    }
}
