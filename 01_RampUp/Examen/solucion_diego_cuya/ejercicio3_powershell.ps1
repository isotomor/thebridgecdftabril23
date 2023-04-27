#Mostrar todos los ficheros .DLL de la carpeta C:\Windows\System32 que sean anteriores a 2022 con un tamaño entre 10 y 50 kbytes.

#Primero usamos el Get-ChildItem para poder obterner los archivos con extension .dll de la carpeta de windows\system32\ , expecificando con -Path la ruta que queremos tomar.

#Luego utilizamos el comando Where-Object  para especificar los que queremos que se cumpla de los ficheros que queremos .

# Por ultimo gracias a $_.LastWriteTime.Year : -lt significa menor que, por tanto antes de 2022
# $_.Length  -ge significa mayor que 10000 bytes, ya que el enunciado pide mas de 10 kbytes; y hacemos los mismo para antes de 50 kbytes, en este caso usamos -le que significa menor igual a. 

Get-ChildItem -Path C:\Windows\System32 -Filter *.dll | Where-Object {$_.LastWriteTime.Year -lt 2022 -and $_.Length -ge 10000 -and $_.Length -le 50000} 
