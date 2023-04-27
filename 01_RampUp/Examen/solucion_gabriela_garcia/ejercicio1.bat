@echo off

set sobrevivio_s=0
set sobrevivio_c=0
set sobrevivio_q=0

for /f "skip=1 tokens=2,12 delims=," %%a in (titanic.csv) do (
    if "%%b"=="S" (
        if "%%a"=="1" (
            set /a sobrevivio_s+=1)
    ) else if "%%b"=="C" (
        if "%%a"=="1" (
            set /a sobrevivio_c+=1)
    ) else if 
)