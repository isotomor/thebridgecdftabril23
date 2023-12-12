#3.Mostrar todos los ficheros .DLL de la carpeta C:\Windows\System32 que sean anteriores a 2022 con un tamaño entre 10 y 50 kbytes.

#  con Get-ChildItem obtengo los acrhivos que tiene la extension .dll en el directorio system32
#  LastWriteTime fecha ultima vez que se escribiò
#  Name, Length, LastWriteTime nombre tamaño y ultima fecha en la que se escribio

Get-ChildItem -Path "C:\Windows\System32" -Filter "*.dll" | Where-Object {$_.LastWriteTime -lt "01/01/2022" -and $_.Length -gt 10000 -and $_.Length -lt 50000} | Select-Object Name, Length, LastWriteTime
