@echo off
SETLOCAL enabledelayedexpansion

set /a S = 0
set /a C = 0
set /a Q = 0
set /a N = 0

for /f "tokens=2,13 delims=," %%a in (titanic.csv) do (
    if "%%a" == "1" (
        if "%%b" == "S" (
            set /a S += 1
        ) else (
            if "%%b"=="C" (
                set /a C+=1
            ) else (
                if "%%b"=="Q" (
                    set /a Q+=1
                ) else (
                    set /a N+=1
                )
            )
        )
    )
)
echo Sobrevivieron %C% de Cherbourg
echo Sobrevivieron %Q% de Queenstown
echo Sobrevivieron %S% de Southampton
echo Hay %N% personas que sobrevivieron pero no sabemos donde embarcaron