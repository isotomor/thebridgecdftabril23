#3.Crea un cmdlet de PowerShell como el anterior llamado saludo3.ps1 pero en lugar de definir
# o recoger variables como argumentos, debe solicitárselos al usuario con Read

$nombre = Read-Host "Ingrese un nombre"
$apellido = Read-Host "Ingrese un apellido"

Write-Host "Hola $nombre $apellido"
