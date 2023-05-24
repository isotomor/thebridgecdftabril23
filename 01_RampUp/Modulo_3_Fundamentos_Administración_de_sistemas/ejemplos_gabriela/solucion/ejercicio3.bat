@echo off
setlocal enabledelayedexpansion


set /p tamano="Ingrese el tamaño: "

for /f "skip=1 tokens=1,2 delims=;" %%a in ( DIR ) do (
    REM  %%~nxa nombre y la extensión del archivo
    REM  %%~za  tamaño del archivo 
    if %%~za GTR %tamano%  ( echo nombre:  %%~nxa , tamaño: %%~za )
    
)