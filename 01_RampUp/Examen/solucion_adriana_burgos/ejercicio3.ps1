# 3. Mostrar todos los ficheros .DLL de la carpeta C:\Windows\System32 que sean 
# anteriores a 2022 con un tamaño entre 10 y 50 kbytes.

# Voy a ir guardando todos los datos como variables, que si no es un cacao para ir probándolo
$folder = "C:\Windows\System32"
$include = "*.dll"
$date = Get-Date "01/02/2022"
$minSize = 10KB
$maxSize = 50KB

# En la primera linea listamos todos los .dll de la carpeta, en la segunda los filtramos segun la fecha y tamaño requeridos
# No se si hay que mirar o no en las subcarpetas también, pero eso se haría con la flag -Recurse
# (Resulta que para poner una fecha "anterior a" hay que usar el operador -lt (menor que), the more you know)
Get-ChildItem $folder -Include $include |
    Where-Object -FilterScript {($_.CreationTime -lt $date -and $_.Length -ge $minSize -and $_.Length -le $maxSize)}


# Ejemplo de ejercicio similar sacado del README:

# Busca todos los ejecutables en la carpeta Archivos de programa que se modificaron por última vez 
# después del 1 de octubre de 2005, cuyo tamaño no es inferior a 1 megabyte ni superior a 10 megabytes:

# Get-ChildItem -Path $env:ProgramFiles -Recurse -Include *.exe | Where-Object -FilterScript{($_.LastWriteTime -gt '2005-10-01') -and ($_.Length -ge 1mb) -and ($_.Length -le 10mb)}
