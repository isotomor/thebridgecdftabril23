@echo off
:: Ejercicio2
SETLOCAL enabledelayedexpansion
set /p tabladel="Dime de que numero quieres la tabla: "

for /l %%n in (1,1,10) do (
    set /a valor= %tabladel% * %%n
    echo %tabladel% * %%n = !valor!
)
