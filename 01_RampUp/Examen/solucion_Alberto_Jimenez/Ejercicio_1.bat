@echo off

:: ENUNCIADO
:: Tomar el fichero titanic.csv y crear un script que nos diga cuántos pasajeros sobrevivieron de los EMBARKED en 
:: S (Southampton), C (Cherbourg), y Q (Queenstown). Asimismo, cuantos no aparece nada en ese campo.


:: EJERCICIO
:: Realizamos un Buble for de análisis de archivos como vimos en el ejemplo de clase para los archivos .csv
:: Vamos a tener en cuenta la columna survived y embarked (columnas 2 y 12)
:: El bucle se basará en un conteo de personas que sobrevivieron y embarcaron en S, C o Q.

for /f "skip=1 tokens=2,12 delims=;" %%a in (titanic.csv) do (
	 
)

:: Fallo a la hora de construir el bucle