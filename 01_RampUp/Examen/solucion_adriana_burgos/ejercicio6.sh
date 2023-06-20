#!/bin/bash

# 6. Crear tres grupos de usuarios: Desarrollo, Operaciones, Marketing, 
#    crear también 4 usuarios (los nombres los elegís vosotros y a qué grupos asignarlos) 
#    Crear también tres carpetas con archivos: FileDev, FileOps y FileMark, asignar 
#    permisos para cada grupo de tal manera, que:
#       - FileDev, acceso total para Desarrollo y sólo lectura para Operaciones y Marketing
#       - FileOps, lectura y escritura para Operaciones, y solo lectura para Desarrollo y Marketing
#       - FileMark, acceso total para Marketing, y lectura y ejecución para el resto.

# Crear 3 gupos de usuario: Desarrollo, Operaciones, Marketing
sudo groupadd desarrollo
sudo groupadd operaciones
sudo groupadd marketing

# Crear 4 usuarios
sudo useradd -s /bin/bash -d /home/pepe/ -m -G sudo pepe
sudo useradd -s /bin/bash -d /home/maria/ -m -G sudo maria
sudo useradd -s /bin/bash -d /home/juan/ -m -G sudo juan
sudo useradd -s /bin/bash -d /home/manuela/ -m -G sudo manuela

# Asignar los usuarios a los grupos
sudo usermod -a -G desarrollo pepe
sudo usermod -a -G marketing maria
sudo usermod -a -G operaciones juan
sudo usermod -a -G desarrollo manuela

# Crear las carpetas FileDev, FileOps y FileMark
sudo mkdir /FileDev
sudo mkdir /FileOps
sudo mkdir /FileMark

# Para darle permisos a un grupo de usuarios sobre una carpeta,
# deben ser los dueños de dicha carpeta:
sudo chown :desarrollo /FileDev
sudo chown :marketing /FileMark
sudo chown :operaciones /FileOps

# Cambiar permisos de las carpetas a los grupos dueños de dichas carpetas
sudo chmod 770 /FileDev
sudo chmod 760 /FileOps
sudo chmod 770 /FileMark

# No sé muy bien como hacer la parte de dar permisos a grupos que no son
# los dueños de las carpetas. Lo intentaré de nuevo más tarde