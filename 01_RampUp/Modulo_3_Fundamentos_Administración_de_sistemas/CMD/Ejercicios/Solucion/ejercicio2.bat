@echo off
:: Ejercicio2
SETLOCAL enabledelayedexpansion
for /l %%t in (1,1,10) do (

    for /l %%n in (1,1,10) do (
        set /a valor= %%t * %%n
        echo %%t * %%n = !valor!
    )
    echo =============
)
