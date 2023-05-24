@echo off
setlocal enabledelayedexpansion

set /p numero=Ingrese el número del que quiere la tabla de multiplicar: 

echo Tabla de multiplicar del %numero%:
for /l %%n in (1,1,10) do (
  set /a multiplicacion=%%n*!numero!
  echo %%n x !numero! = !multiplicacion!
)
