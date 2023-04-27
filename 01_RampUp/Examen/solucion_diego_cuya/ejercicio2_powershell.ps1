#Numeros aleatorios
#Usamos la funcion Get-random para que nos de numero aleatorio y gracias a minimun y maximun podemos elegir entre que numeros queremso que salgan, lo probe sin eso y daba numero muy grandes.
#Primero creamos el array numA para los numeros aleatorios
$numA = @()

for ($i = 0; $i -lt 10; $i++){
    $numA += Get-Random -Minimum 1 -Maximum 100
}

Write-Host "El array original es este: $numA"

#Ahora he encontrado que la funcion "$numA".count -1 da a entender que debe empezar por el final del array, con -ge indicamos que si i es menor igual 0 siga, para que valla bajando hasta llegar al primer numero y el -- da a entender q se quite uno osea que se valla una posicion antes al array.
for($i = $numA.Count - 1; $i -ge 0; $i--){
    Write-Host  $numA[$i]
}