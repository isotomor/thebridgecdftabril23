![](../../../img/TheBridge_logo.png)

# Ejercicios Docker
***

![img.png](../img/docker_logo.png)

## Ejercicio php

--- 
1. En la carpeta _ **01\_ejercicio\_php** _ tenemos un programa (si es que a "eso" se le puede llamar así) llamado index.php
2. Crea una carpeta llamada php-docker. Mete ahí el fichero index.php
3. Crea el Dockerfile necesario para que después podamos construir la imagen y el contenedor.
> **Nota** : Utiliza una imagen base de php 7 que ya tenga apache dentro. (¡Hala!, a buscar en Docker-hub)
4. Abre el navegador y haz una captura del resultado.

## Ejercicio java
***

1. En la carpeta _ **02\_ejercicio\_java** _ tenemos un programa llamado app.java
2. Crea una carpeta llamada java-docker. Mete ahí el fichero app.java
3. Crea el Dockerfile necesario para que después podamos construir la imagen y el contenedor.
> **Nota** : Utiliza una imagen de Java 8

## Ejercicio conversión

---
1. Un amigo nos ha "prestado" a módico precio las instrucciones para crear un contenedor a través de línea de comandos.
2. Pero queremos hacer lo mismo a partir de un Dockerfile. Créalo y después lanza un contenedor con ello.

> **Nota** : El código de mi "Examigo" está en el fichero: _ **codigo.txt** _ que se encuentra en la carpeta _ **03\_ejercicio\_conversion** _

## Ejercicio pescadilla que se muerde la cola

---
1. Crea un Dockerfile que cree un contenedor con Ubuntu 18.04 y que se le instale Docker y Docker-compose dentro.

> **Nota** : Los comandos necesarios para instalar Docker están en el ppt de la sesión 1 y los necesarios para Docker-compose en un fichero de la sesión 2.

2. Sube la imagen a tu cuenta de Docker-hub. Necesitamos la instrucción pull que nos permitiría crear un contenedor a partir de esa imagen.

##  Ejercicio Python 1

--- 
1. En la carpeta _ **05\_ejercicio\_python1** _ tenemos una carpeta app con un pequeño programa en Python que lo que hace es permitir la entrada de datos en un formulario y después almacenarlo en un fichero txt.
2. Crea el Dockerfile necesario para que todo funcione.
   1. En el fichero Dependencias a usar tenemos la versión de Python y los módulos necesarios con sus versiones
3. Realiza la imagen y el contenedor necesario para que a pesar de que creemos distintos contenedores se vaya rellenado en ese fichero txt.

## Ejercicio Python 2

---
1. Una vez que ya tengas el anterior ejercicio. Necesitamos darle el cambiazo al programa sin modificar la imagen, cambiando el fichero txt donde almacena los datos a uno nuevo que está dentro la carpeta _ **06\_ejercicio\_python2** _ llamado alumnos2.txt

## Ejercicio mysql**
1. Crea, **con línea de comandos** , un contenedor mysql 5.6 que tenga un volumen para almacenar la información y recuerda añadirle una MYSQL\_ROOT\_PASSWORD que se te ocurra.
2. Además, queremos una herramienta que nos permita hacer backups, utilizaremos Percona, pero el Debian que tendrá el contenedor es muy básico, así que hay que instalar:
   1. wget
   2. Con ese wget descarga Percona en esta dirección:
      https://repo.percona.com/apt/percona-release\_0.1-3.jessie\_all.deb

   3. Instálalo con estas instrucciones:

````bash
dpkg -i percona-release\_0.1-3.jessie\_all.deb_

apt-get update_

apt-get install percona-xtrabackup-23_
````
   4. Crea el directorio de backup en la ruta: _/backup/xtrabackups_
   
   5. Ahora haz lo mismo, pero en un **Dockerfile** que cumpla a ser posible las normas básicas más importantes a la hora de crear un Dockerfile.

> **Nota** : Para montar el directorio de backup de Percona, se necesita crear otro VOLUME aparte del que sirve a mysql 
> que se definirá en una Run posterior. Añade al final esta instrucción al Dockerfile:

VOLUME ["/backup/xtrabackup"]
