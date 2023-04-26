# Resolución de ejercicios Power Shell

## Ejercicio 1:

Dentro de la carpeta que acabas de hacer, crea un cmdlet de PowerShell 
llamado saludo1.ps1 que defina dos variables: un $nombre y un $saludo. 
Luego muestra por consola un mensaje en el que se muestre ese saludo y ese nombre.

```powershell
$nombre = "Nacho"
$saludo = "Eyyy!!!"
Write-Output $nombre
Write-Output $saludo
```

## Ejercicio 2:
Crea un cmdlet de PowerShell como el anterior llamado saludo2.ps1, 
pero en lugar de definir dos variables las debe recoger como argumentos de la consola.

```powershell
#Pasarle 2 parametros y mostralos
Write-Output $args[0] "y" $args[1]
```

## Ejercicio 3
Crea un cmdlet de PowerShell como el anterior llamado saludo3.ps1 pero en lugar de definir o recoger variables 
como argumentos, debe solicitárselos al usuario con Read

```powershell
#Introducir nombre y numero y repetir el en nombre x numero
write-output "Introduce un nombre"
$nombre= read-host
Write-Output "Introduce un saludo"
$saludo= Read-Host

Write-Output " El nombre es: " $nombre
Write-Output " El saludo es: " $saludo
```

## Ejercicio 4
Crea un cmdlet de PowerShell que recoja dos variables por consola con Read y lleve a cabo todas las operaciones 
aritméticas entre ellas y las muestre por consola.

```powershell
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
```

##  Ejercicio 5 

Crea un cmdlet de PowerShell que solicite dos números enteros al usuario. El cmdlet debe 
decirnos si uno es mayor, menor o igual que el otro.

```powershell

#Introducir dos numeros y mostar cual es mayor, menor o si son iguales
Write-Output "Introduce el primer número"
$numero1 = Read-Host
Write-Output "Introduce el segundo número"
$numero2 = Read-Host

if($numero1 -eq $numero2){
    Write-Output "los numeros son iguales"
}
if($numero1 -gt $numero2){
    Write-Output "El numero: $numero1 es mayor que $numero2"
}
if($numero1 -lt $numero2){
    Write-Output "El numero: $numero1 es menor que $numero2"
}

```

## Ejercicio 6 

Más humillaciones: crea un cmdlet que solicite al usuario un número, verifique que es positivo y 
programa un bucle para que muestre por consola la palabra FAP tantas veces como indique el número.

```powershell
#Introducir un numero y mostar un mensaje tantas veces como sea el numero introducido.

Write-Output "Introduce el primer número"
$numero1 = Read-Host
$n = 0
if($numero1 -gt 0){
while ($numero1 -gt $n){
  Write-Output "FAP"
  $n = $n + 1
}
} else {
  write-ou "El numero introducido es negativo"
}
```

# Ejercicio 7

Crea un cmdlet que solicite al usuario un número. Mientras lo que introduzca el usuario no esté entre 1 y 100 
se lo tiene que solicitar una y otra vez. Una vez introducido el número correcto el programa debe hacer lo siguiente: 
si ha cometido algún error al introducir un número válido debe hacerse un bucle en el que se increpe al usuario 
tantas veces como errores haya cometido. Si lo hizo bien a la primera saca un mensaje que diga: campeón.

```powershell
#Introducir un numero entre el 1 y el 100, si ha cometido algun error crear un bucle tantas veces como erroes...
  
$salir = 0
$bucle = 0
while ($salir -eq 0){
  Write-Output "Introduce un numero entre el 1 y el 100"
  $numero = Read-Host
  if (($numero -gt 0) -and ($numero -lt 100)) {
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
```