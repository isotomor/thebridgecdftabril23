#!/bin/bash

# 7. Averiguar cómo podríamos hacer backups cada cierto tiempo. 
# (Si se puede, especificar herramientas y comandos a ejecutar).

# Investigando veo dos maneras principales: o hacemos un script que use el comando rsync, 
# o creamos un script use el comando tar. En ambos casos después 
# lo añadimos a nuestro crontab para automatizar el proceso

# Con rsync, el script sería algo similar a:
origen="/home/test/Documents/Dir1"
destino="/media/hdd2/rsync_backup"

rsync -av $origen $destino
# -a es el "modo archivo", para asegurarnos de que nuestros archivos se copian idénticos a los originales (permisos, fechas, etc)
# -v para verbose, que nos de más info

# Echo para saber que ha terminado.
echo "Backup terminado"

# Si usaramos un script con tar para hacer las copias, sería algo como:
origen="/home/test/Documents/Dir1"
destino="/media/hdd2/rsync_backup"

# Tendriamos que crear un nombre para nuestros archivos copiados.
dia=$(date +%A)
hostname=$(hostname -s)
archivo="$hostname-$day.tgz"

# Echo para saber qué estamos haciendo.
echo "Haciendo backup de $origen a $dest/$archivo"

# Comprimimos con tar en la carpeta $destino con el nombre $archivo.
tar -czf $destino/$archivo $origen

# Echo para saber que ha terminado.
echo "Backup terminado"

# Ambos scripts copiarian los archivos cada vez que los ejecutaramos. Para ejecutarlo cada cierto tiempo
# y automatizar el proceso, podríamos añadirlo a nuestro crontab