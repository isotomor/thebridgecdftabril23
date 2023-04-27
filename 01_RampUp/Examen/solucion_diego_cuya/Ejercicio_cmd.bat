:Ejercicio para ver cuantos pasajeros sobrevivieron de los embarcador en s,c,q.
@echo off
SET /A c=0  
SET /A b=0
for /f "skip=1 tokens=2,13 delims=," %%a in (titanic.csv) do (
    echo Sobrevivieron %%a del embarque %%b 
        if %%a EQU 1 {
          %b%+=1 
        }
        else {
            %c%+=1
        }
        fi
    )

echo %b%
echo %c%