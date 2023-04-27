#!/bin/bash

# Estos son los comandos que he usado para la creación de los usuarios, 
# el primero para la creación y el segundo para asignarle contraseña.

sudo useradd -s /bin/bash -d /home/nombreusuario/ -m -G sudo nombreusuario
sudo passwd pepe

cd/ home ls -lrt #uso este comando para verificar que los usuarios se han creado.
#Para verificar que puedo trabajar con ellos ejecuto: su nombreusuario

#Comando usado para la creación de los grupos.
sudo groupadd Desarrollo 
sudo groupadd Operaciones
sudo groupadd Marketing

#Verifico que los grupos han sido creados
less /etc/group 

#Añado los usuarios a los grupos
sudo usermod -a -G nombre grupo nombre usuario

#Verifico que los usuarios se han añadido al grupo.
id nombre usuario

#Comando usado para crear las carpetas
sudo mkdir nombrecarpeta

#Dentro de la carpeta creamos los archivos indicados con:
nano nombrearchivo.txt

#Le doy a Desarrollo acceso total al archivo FileDev
sudo chmod u+rwx FileDev

#Permisos solo lectura para marketing y operaciones
sudo chmod g+r FileDev

#Permisos lectura y escritura para Operaciones archivo FileOps.
sudo chmod g+rw FileOps

#Solo lectura para desarrollo y marketing, archivo FileOps.
sudo chmod g+r FileOps

#FileMark, acceso total para Marketing,
sudo chmod g+rwx FileMark




