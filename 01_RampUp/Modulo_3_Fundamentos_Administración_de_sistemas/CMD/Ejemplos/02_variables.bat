@echo off
:comment "Ejemplo para mostrar un valor de tipo string."
SET valor=Esto es un ejemplo
echo %valor%

:comment "Ejemplo para mostrar un valor de tipo int reulizando la variable."
SET /A valor=3
echo %valor%

:comment "Ejemplo suma de variables."
SET /A a=5  
SET /A b=10
SET /A c = %a% + %b%
echo %c%