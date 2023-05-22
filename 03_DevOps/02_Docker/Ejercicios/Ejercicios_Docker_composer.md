![](../../../img/TheBridge_logo.png)

# Ejercicios Docker Composer
***

![img.png](../img/docker_logo.png)

## Ejercicio 1

--- 

Crear un docker-compose.yml que:

- Tenga un solo servicio llamado: miprograma
- Que ese servicio no se pare nunca salvo que lo detengamos nosotros
- Que se construya a partir de un Dockerfile que se llama Dockerfile-miprograma
- El puerto es por defecto 8000

## Ejercicio 2
***

Crear un docker-compose.yml que:

- Tenga dos servicios:
	El primero que se llame: miweb
		- Que se construya a partir de un Dockerfile que está en una carpeta: /data que cuelga del directorio raiz
		- Que exponga el puerto en forma larga, del 5000 al 5005, con el modo host
		- Que esté unido a bd
	El segundo que se llame: bd
		- Que se construya a partir de una imagen de postgreSQL
		- Que exponga por el puerto 5432

## Ejercicio 3

---
Crear un docker-compose.yml que:
- Tenga un solo servicio llamado: runapp
- Que ese servicio no pare nunca
- Que se construya a partir de una imagen de mi docker-hub: el usuario de docker-hub es pepedocker y la imagen es miapli:3.0
- Que tenga un volumen que ha sido creado con docker volume create mivolumen y que está asociado a la carpeta /app/datos del contenedor

## Ejercicio 4 (para nota)
***

Queremos emular con contenedores un sistema de análisis de logs con ElasticSearch. 
Nuestro Docker_compose tiene que tener esto:

Para ello, necesitamos crear tres servicios:
  - Servicio elasticsearch
       Se carga a partir de la imagen de elasticsearch más reciente.        
       
       Necesita unas variables de entorno que son las siguientes:
          "ES_JAVA_OPTS=-Xms1g -Xmx1g"
          "discovery.type=single-node"

       Su puerto por defecto es 9200 y se levanta en ese mismo

       Necesita crear un volumen que se asigna a la ruta:
		/usr/share/elasticsearch/data

  - Servicio kibana
       Se carga a partir de la imagen de kibana más reciente.        

       Su puerto por defecto es 5601 y se levanta en ese mismo


  - Servicio filebeat
       Se carga a partir de la imagen de filebeat más reciente. 
       Hay que decirle que el usuario es root, por lo tanto:
          user: root
       Crea dos volúmenes directamente sobre path:

           El primero en el host de docker: /var/lib/docker
                      en el container: /var/lib/docker
                  Y es de sólo lectura.
           El segundo en el host de docker: /var/run/docker.sock
                      en el container: /var/run/docker.sock
           