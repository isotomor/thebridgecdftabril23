@echo off

SETLOCAL
call :Display
call :Display_params 5, 10
EXIT /B %ERRORLEVEL%

:Display
SET /A index=2
echo The value of index is %index%
EXIT /B 0

:Display_params
SET /A index=2
echo The value of parameter 1 is %~1
echo The value of parameter 2 is %~2
EXIT /B 0



