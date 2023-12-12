@echo off
setlocal enabledelayedexpansion

for /l %%i in (1,1,10) do (
  echo Tabla de multiplicar del numero  %%i:
  for /l %%n in (1,1,10) do (
    set /a multiplicacion=%%n*%%i
    echo %%n x %%i = !multiplicacion!
  )
  
)
