#2. Crea un cmdlet de PowerShell como el anterior llamado saludo2.ps1, pero en lugar de definir dos 
#variables las debe recoger como argumentos de la consola.

Write-Output $args[0] 'y' $args[1]