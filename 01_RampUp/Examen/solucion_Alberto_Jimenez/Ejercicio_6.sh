# ENUNCIADO

# Crear tres grupos de usuarios: Desarrollo, Operaciones, Marketing, crear también 4 usuarios (los nombres los elegís 
# vosotros y a qué grupos asignarlos) Crear también tres carpetas con archivos: FileDev, FileOps y FileMark, asignar 
# permisos para cada grupo de tal manera, que:
# - FileDev, acceso total para Desarrollo y sólo lectura para Operaciones y Marketing
# - FileOps, lectura y escritura para Operaciones, y solo lectura para Desarrollo y Marketing
# - FileMark, acceso total para Marketing, y lectura y ejecución para el resto.


# EJERCICIO

# Creamos tres grupos

addgroup dev
addgroup ops
addgroup mkt

# Creamos 4 usuarios

sudo useradd -s /bin/bash -d /home/alex/-m -G sudo alex
sudo useradd -s /bin/bash -d /home/bea/-m -G sudo bea
sudo useradd -s /bin/bash -d /home/alex/-m -G sudo carlos
sudo useradd -s /bin/bash -d /home/alex/-m -G sudo dani


# Asignamos equipo a los grupos

sudo adduser alex dev
sudo adduser bea ops
sudo adduser carlos mkt
sudo adduser dani mkt

# Creamos carpetas con archivos: FileDev, FileOps y FileMkt

sudo mkdir /var/FileDev
sudo mkdir /var/FileOps
sudo mkdir /var/FileMkt

# Vamos a asignar cada carpeta a un grupo 

sudo chown :dev /var/FileDev 
sudo chown :ops /var/FileOps
sudo chown :mkt/var/FileMkt

# Y asignamos permisos 

# FileDev, acceso total para Desarrollo y sólo lectura para Operaciones y Marketing
sudo chmod g+w+x+r /var/FileDev
sudo chmod o+r /var/FileDev

# FileOps, lectura y escritura para Operaciones, y solo lectura para Desarrollo y Marketing
sudo chmod g+w+r /var/FileOps
sudo chmod o+r /var/FileOps

# FileMark, acceso total para Marketing, y lectura y ejecución para el resto.
sudo chmod g+w+x+r /var/FileMkt
sudo chmod o+r+x /var/File Mkt

# Comprobamos permisos con ls -l