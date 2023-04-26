@echo off
setlocal enabledelayedexpansion
cls

::https://learn.microsoft.com/es-es/windows-server/administration/windows-commands/forfiles
set /p Size="Tamaño de los ficheros en bytes= "
forfiles /C "cmd /c if @fsize GTR %Size% echo @file su tamaño es @fsize bytes"