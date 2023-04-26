# 3.Crea un cmdlet de PowerShell como el anterior llamado saludo3.ps1 pero en lugar de definir o recoger variables
# como argumentos, debe solicitárselos al usuario con Read

$nombre = Read-Host "Introduce tu nombre"
$apellido = Read-Host "Introduce tu apellido"

$mensaje = 'Tu nombre es {0} y tu apellido es {1}' -f $nombre, $apellido
Write-Output $mensaje