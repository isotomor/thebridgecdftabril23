@echo off

set a=21
set b=32

:: SET /a nos servir  para realizar operaciones

:: los operadores aritm‚ticos son iguales a los de cualquier otro leng. de programaci¢n

set /a suma=%a%+%b%
set /a resta=%a%-%b%
set /a producto=%a%*%b%
set /a division=%a%/%b%

:: Mostramos los resultados

echo Suma: %suma%
echo Resta: %resta%
echo Producto: %producto%
echo Division: %division%