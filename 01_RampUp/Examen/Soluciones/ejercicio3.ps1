Get-ChildItem -Path "C:\Windows\System32" -Filter "*.dll" |
Where-Object {($_.LastWriteTime -lt "01/01/2022") -and ($_.Length -ge 10kb) -and ($_.Length -le 50kb)}
Select-Object Name, Length, LastWriteTime