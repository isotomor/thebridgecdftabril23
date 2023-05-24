#ENUNCIADO

#Mostrar todos los ficheros .DLL de la carpeta C:\Windows\System32 
#que sean anteriores a 2022 con un tamaño entre 10 y 50 kbytes.

#EJERCICIO

# Siguiendo el ejemplo del Readme de Powershell (y comprobando dos cosillas de nada en chatgpt):


Get-ChildItem -Path C:\Windows\System32 -Filter *.dll -Recurse | Where-Object {($_.LastWriteTime -lt "01/01/2022") -and ($_.Length -gt 10kb) -and ($_.Length -lt 50kb)} 


# Nos muestra todos los ficheros solicitados excepto a ciertos archivos donde nos denega el acceso por motivos de permisos