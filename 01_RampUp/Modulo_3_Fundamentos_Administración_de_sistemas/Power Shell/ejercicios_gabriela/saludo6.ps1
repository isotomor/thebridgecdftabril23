#6. Crea un cmdlet que solicite al usuario un número, verifique que es positivo y programa un bucle 
#para que muestre por consola la palabra FAP tantas veces como indique el número.


do {
    $numero1 = Read-Host "Introduce un número positivo"
} until ($numero1 -gt 0)

for ($i=1; $i -le $numero1; $i++){
    Write-Host "FAP"
}