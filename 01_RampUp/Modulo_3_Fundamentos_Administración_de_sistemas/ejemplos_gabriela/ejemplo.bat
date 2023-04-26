@echo off
for /f "skip=1 tokens=1,2,3 delims=;" %%a in (fichero.csv) do (
    echo Mi nombre es %%a mi apellido %%b y mi correo %%c
)