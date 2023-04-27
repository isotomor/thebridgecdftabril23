#Mostrar todos los ficheros .DLL de la carpeta C:\Windows\System32 que sean anteriores 
#a 2022 con un tamaño entre 10 y 50 kbytes.

#Para mostar los archivos de la carpeta C:\Windows\System32 utilizo el siguiente comando:

#Con -include *.DLL lo que hacemos es filtrar los archivos DLL y utilizamos | para concatenar los comandos.
#Usamos LaswriteTimeyear junto con -le(menos o igual) 2021 para buscar los archivos anteriores al 22.

#Delante de los 1000bytes he usado -ge para que sean mayor o igual que la cantidad y delante de 5000 -le para 
#que sea menor o igual.

#10kbytes = 1000bytes
#50kbytes = 5000bytes.

Get-ChildItem -Path "C:\Windows\System32" -Recurse -Include *.DLL |  Where-Object -FilterScript{
    ($_.LastWriteTime.Year -le 2021) -and ($_.Length -ge 1000) -and ($_.Length -le 5000)}

    #Pienso que esta bien, pero al ejecutar el script me lanza un error de "Acceso denegado".