#Crea un cmdlet que solicite al usuario un número, verifique que es positivo y programa un bucle para que muestre
#por consola la palabra FAP tantas veces como indique el número.

Write-Output "Introduce el primer número"
$numero1 = Read-Host
$n = 0
if ($numero1 -gt 0)
{
    while ($numero1 -gt $n)
    {
        Write-Output "Esto es una tonteria"
        $n = $n + 1
    }
}
else
{
    write-ou "El numero introducido es negativo"
}