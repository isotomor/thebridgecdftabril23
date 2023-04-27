#Crea un array de diez números aleatorios (buscar qué función lo puede hacer y cómo se utiliza), imprímelos y partir de ese array, 
#dale la vuelta. (y lo vuelves a imprimir).

#Primero he creado una variable llamada aleatorio que saque números entre el 1 al 50 y lo
#he concatenado con la función Get-Random. -Count 10 es para que solo muestre 10 numeros.

$aleatorio = 1..50 | Get-Random -count 10

Write-Output $aleatorio #Imprimo por pantalla los 10 números aleatorios.


[array]::reverse($aleatorio) #Entre corchetes marco el tipo, array en este caso y con ::reverse le doy la vuelta

Write-Output $aleatorio 
#Por ultimo, imprime nuevamente los 10 números pero dados la vuelta en mi caso salieron los siguientes:
1
3
36
6
25
44
33
17
30
34

34
30
17
33
44
25
6
36
3
1



