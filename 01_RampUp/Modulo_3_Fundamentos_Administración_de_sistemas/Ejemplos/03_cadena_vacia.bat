:: Ejemplo cadena vacía
@echo off  
SET a=
SET b=Hello
if [%a%]==[] echo "Cadena A vacia"  
if [%b%]==[] echo "Cadena B vacia"

:: Ejemplo concatenación de cadenas. 
@echo off  
SET a=Hello
SET b=World
SET /A d=50
SET c=%a% and %b% %d% 
echo %c%

:: Otro Ejemplo
@echo off
set var=13145
set /A var=%var% + 5  
echo %var%
echo 

:: Eliminar parte de una cadena
@echo off
set str=Este es un ejemplo
echo %str%
set str=%str:un= %
echo %str%

:: Eliminar caracteres
@echo off
set str=Helloworld
echo %str%
:: izquierda
set str_iz=%str:~0,5%
echo %str_iz%
:: derecha
set str_de=%str:~-4%
echo %str_de%
:: medio
set str_medio=%str:~5,10%
echo %str_medio%

