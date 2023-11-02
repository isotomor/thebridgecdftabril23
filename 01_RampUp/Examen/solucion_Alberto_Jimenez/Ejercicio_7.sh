# ENUNCIADO

# Averiguar cómo podríamos hacer backups cada cierto tiempo. (Si se puede, especificar herramientas y comandos a ejecutar).


#EJERCICIO

# Averiguamos que para hacer un backup periódicamente combinamos el comando tar con el comando cron
# Creamos un script con un comando tar que nos haga un backup del directorio mi_directorio (fuente: chatgpt)

#!/bin/bash
tar -czvf backup/mi_directorio_backup_$(date +%Y%m%d_%H%M%S).tar.gz mi_directorio/
# y se agrega el siguiente comando para programar la ejecución del script
crontab -e


# Con esto ya contariamos con la ejecución del backup periódicamente en el momento que le hemos indicado