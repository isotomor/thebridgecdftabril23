@echo off
SETLOCAL
set z=[1,2,3]
echo Este es el array %z%
ENDLOCAL
set a=[1, 2, 3]
set a[0]=1
set a[1]=2
set a[2]=Prueba
rem Añadir un elemento al final del array
set a[3]=4
echo Este es el array %a%
echo Este es el array %z%
echo El ultimo elemento del array es %a[2]%
echo El ultimo elemento del array es %a[3]%