:Ejercicio para ver cuantos pasajeros sobrevivieron de los embarcador en s,c,q.
@echo off

for /f "skip=1 tokens=2,13 delims=," %%a in (titanic.csv) do (
    echo Sobrevivieron %%a del embarque %%b 
        if %%a == 1 {
          SET /A b+=1 
        } 
        else{ 
           SET /A c+=1
        }
        fi
    )

echo  "%b%"
echo "%c%"
