# Con este código obtenemos una tabla con todos los archivos con extensión .dll dentro del directorio
# C:\Windows\System32 y en sus subdirectorios (comando -Recurse) anteriores al 01/01/2022, cuyo tamaño
# este entre 10 y 50 kbytes.


# Como el tamaño de los archivos está en bytes y buscamos aquellos archivos entre 10 y 50 kbytes,
# realizamos la conversión y le pasamos el tamaño en bytes. 

Get-ChildItem -Path C:\Windows\System32 -Filter *.dll -Recurse | Where-Object { $_.LastWriteTime -lt "01/01/2022" -and $_.Length -ge 10000 -and $_.Length -le 50000 } | Select-Object Name, Length, LastWriteTime
