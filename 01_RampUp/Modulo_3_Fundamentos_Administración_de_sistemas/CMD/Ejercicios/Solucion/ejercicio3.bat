@echo off
set /p cant="Introduce an amount: "
for %%f in (*) do (
    if %%~zf GTR %cant%
    echo %%f - %%~zf bytes
)

