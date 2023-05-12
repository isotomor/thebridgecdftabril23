# Uso de Ansible en máquinas de AWS

### Para este ejemplo, vamos a tener que crear instancias EC2 en AWS

Vamos a crear tres instancias de EC2 en AWS con el sistema operativo Ubuntu 20.04, una será el nodo principal donde 
vamos a instalar [Ansible](https://www.ansible.com/) y las otras dos serán los nodos sobre los que vamos a realizar las 
tareas de configuración y administración.

Una vez creadas las instancias en AWS anotamos las direcciones IP públicas que se le han asignado en AWS, porque más 
adelante serán necesarias para crear el archivo de inventario de [Ansible](https://www.ansible.com/). En mi caso he 
obtenido las siguientes direciones.

| Nodos | IP |
| --- | --- |
| Nodo Principal | 54.173.51.24 |
| Nodo 1 | 18.206.58.248 |
| Nodo 2 | 52.5.11.241 |

## Conexión SSH con las instancias EC2

Para conectarnos a las instancias EC2 necesitaremos una clave SSH que nos habrá proporcionado AWS. La clave SSH debe tener permisos de sólo lectura para el propietario del archivo, por lo que será necesario aplicar el siguiente comando sobre el archivo que contiene la clave.

````bash
chmod 400 aws-ansible.pem
````

Una vez aplicados los permisos adecuados nos conectamos a cualquier instancia utilizando la clave SSH. Por ejemplo para conectarnos al nodo principal utilizaremos el siguiente comando.

````bash
ssh -i aws-ansible.pem ubuntu@54.173.51.24
````

## Instalación de Ansible

La instalación de [Ansible](https://www.ansible.com/) la vamos a realizar únicamente en el  **nodo principal**  y este nodo se conectará al resto de nodos por SSH para realizar las tareas de administración.

En primer lugar deberemos conectarnos al nodo principal SSH como hemos visto en el paso anterior.

Una vez que nos hemos conectado al nodo principal podemos proceder a realizar la instalación de [Ansible](https://www.ansible.com/). El sistema operativo que de nuestra máquina es Ubuntu, por lo tanto la instalación la realizaremos con apt.

````bash
sudo apt update

sudo apt install software-properties-common

sudo apt-add-repository --yes --update ppa:ansible/ansible

sudo apt install ansible
````

## Configuración de Ansible

De momento la única configuración que vamos a realizar en [Ansible](https://www.ansible.com/) será editar el archivo de inventario /etc/ansible/hosts para incluir la lista de hosts sobre los que vamos a realizar tareas con [Ansible](https://www.ansible.com/).

En nuestro caso el contenido del archivo /etc/ansible/hosts será el siguiente:

````text
[aws-hosts]

18.206.58.248

52.5.11.241
````

## Configuración de acceso por SSH

Ahora necesitamos configurar el nodo principal para que pueda conectarse al resto de nodos por SSH.

Ejecutamos el comando ssh-keygen en la máquina principal para crear una clave SSH pública y otra privada.

````bash

ssh-keygen

````

Una vez creada las claves SSH tenemos que copiar la clave pública en cada uno de los nodos que vamos a gestionar con [Ansible](https://www.ansible.com/).

En nuestro caso la clave pública está almacenada en la máquina principal en el directorio: /home/ubuntu/.ssh/id_rsa.pub.

En primer lugar vamos a descargarnos la clave pública de la máquina principal a nuestro equipo local.

````bash
scp -i aws-ansible.pem ubuntu@54.173.51.24:/home/ubuntu/.ssh/id_rsa.pub .

scp -i aws-ansible.pem /home/usuario/.ssh/id_rsa.pub ubuntu@54.173.51.24:/home/ubuntu/.ssh/id_rsa.pub
````

Una vez que tenemos la clave pública vamos a copiarla a cada uno de los nodos.

Copiamos la clave pública al  **nodo 1**.

````bash
cat id_rsa.pub | ssh -i aws-ansible.pem ubuntu@18.206.58.248 "cat - \>\> /home/ubuntu/.ssh/authorized_keys2"
````
Copiamos la clave pública al  **nodo 2**.

````bash
cat id_rsa.pub | ssh -i aws-ansible.pem ubuntu@52.5.11.241 "cat - \>\> /home/ubuntu/.ssh/authorized_keys2"
````

## Lanzamiento de ping

````bash
ansible all -m ping
````

Si sólo queremos hacer ping sobre uno de los nodos en lugar de usar all, indicaremos el nodo sobre el que queremos realiar la operación. Por ejemplo, en este caso realizaríamos un ping únicamente sobre el nodo que tiene la dirección IP 18.206.58.248.

````bash
ansible 18.206.58.248 -m ping
````