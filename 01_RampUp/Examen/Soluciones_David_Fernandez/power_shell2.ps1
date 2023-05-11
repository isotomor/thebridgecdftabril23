# Creamos un array de diez números aleatorios entre 1 y 999
$nums = 1..10 | ForEach-Object {Get-Random -Minimum 1 -Maximum 999}

# Imprimimos el array original
Write-Host "Array original:" $nums

# Invertimos el array original
$array_inv = [array]::Reverse($nums)

# Imprimimos el array invertido
Write-Host "Array invertido:" $nums
