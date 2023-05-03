@echo off

set s_survived=0
set c_survived=0
set q_survived=0
set other_survived=0


for /f "skip=1 tokens=2,13 delims=," %%a in (titanic.csv) do (
    if "%%b"=="S" (
        if %%a==1 set /a s_survived+=1
    ) else if "%%b"=="C" (
        if %%a==1 set /a c_survived+=1
    ) else if "%%b"=="Q" (
        if %%a==1 set /a q_survived+=1
    ) else (
        set /a other_survived+=1
    )
)

echo Sobrevivieron %s_survived% pasajeros que embarcaron en Southampton
echo Sobrevivieron %c_survived% pasajeros que embarcaron en Cherbourg
echo Sobrevivieron %q_survived% pasajeros que embarcaron en Queenstown
echo %other_survived% pasajeros sobrevivieron, pero no tienen puerto de embarque registrado
