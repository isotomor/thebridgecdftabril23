![](../../../img/TheBridge_logo.png)

# Ansible
***

![](img/Ansible_logo.png)

## ¿Qué es Ansible?

**Ansible es una plataforma de software libre para configurar y administrar ordenadores.** 

  - Permite instalación multi-nodo
  - Ejecuciones de tareas ad hoc y administración de configuraciones. 
  - También puede ser categorizado como una herramienta de orquestación. 
  - La gestión de nodos la realiza a través de SSH y no requiere ningún software remoto adicional (excepto Python 2.4 o posterior3) para instalarlo. 
  - Dispone de módulos que trabajan sobre JSON y la salida estándar puede ser escrita en cualquier lenguaje.
  - Utiliza YAML para describir configuraciones reutilizables.

Fue creado por Michael DeHaan

Su nombre viene del “sistema de comunicación instantánea más rápida que la luz” de la novela “el juego de Ender”

- Es parte de la distribución de Linux Fedora y también está disponible para Red Hat Enterprise Linux, Ubuntu, CentOS y Scientific Linux a través de los Paquetes Extras para Enterprise Linux (EPEL)

**Fortalezas:**

- Su curva de aprendizaje es muy rápida por su sencillez.  
- Es consistente, seguro y confiable
- No instala agentes en los nodos que configura

Aunque está agrupado en las herramientas de **Gestión de la Configuración**, el conjunto de campos en los cuales se puede utilizar Ansible es el siguiente:

  - Aprovisionamiento
  - Gestión de la configuración
  - Despliegue de aplicaciones
  - Seguridad y Cumplimiento
  - Orquestación


La arquitectura de Ansible se basa en dividir a las máquinas en controladores y nodos.

![](img/Ansible_01_que_es_ansible.png)


### Introducción a su Arquitectura y funcionamiento:

Todo está dirigido por una máquina de control.

Los nodos son manejados utilizando módulos que despliega via SSH

La máquina sabe qué nodos tiene que gestionar a través de un Inventario

No utiliza Agentes como sí hacen Chef o Puppet. Por lo que no se instala nada para comunicarse con la máquina de control. Esto reduce la sobrecarga de red.

## Conceptos

Ansible define una serie de conceptos clave:
### **Nodo de control**

Se considera un ***nodo de control a toda máquina con Ansible instalado***. El único ***requisito*** es que tenga una instalación de ***Python***.

Pueden haber más de un nodo de control.

Ejecuta comandos y PlayBooks.

***No se puede utilizar una máquina Windows como nodo de control.***

### **Nodos administrados**

Son las máquinas que administra Ansible. También llamados hosts

Ansible NO se instala en los nodos administrados

### **Inventario**

Es una lista de nodos administrados que se guarda por defecto en /etc/ansible/hosts

Puede contener nombres de dominio, IPs, se pueden crear grupos para facilitar operaciones, etc

###  **Colecciones**

Es una forma de distribución de contenidos de Ansible. Pueden ser:
  - Playbooks
  - Roles
  - Módulos
  - Complementos
  - Se pueden usar colecciones a través de Ansible Galaxy.

### [Ansible Galaxy](https://galaxy.ansible.com/)
Es un hub para buscar y compartir contenido de Ansible con la comunidad

Proporciona unidades de trabajo pre-empaquetadas llamadas Roles y desde Galaxy 3.2 colecciones.

### **Módulos**

Son las unidades de código que ejecuta Ansible.

Cada módulo sirve para algo en particular.

Se puede invocar un solo módulo con una tarea o invocar varios módulos diferentes en un ***Playbook***

Los módulos se agrupan en colecciones.

### **Tareas**

Son acciones en Ansible.
 
Se pueden ejecutar muchas a través de un ***Playbook*** o ejecutar una a una a través de comandos Ad- hoc

***Las tareas no repiten acciones si ya se han hecho antes***.

### **Playbooks**
Son listas ordenadas de tareas, guardadas para poder ser ejecutadas en cualquier momento y en cualquier número de veces.

### **Handlers**
Se utilizan para realizar acciones en un servicio, como reiniciar o detener un servicio que se está ejecutando activamente en el sistema del nodo administrado.

Su ejecución se produce después de que todas las tareas hayan terminado. Por ejemplo para reiniciar un nodo tras instalar paquetes.

### **Roles**
Son unidades pre-empaquetadas que se pueden colocar en los Playbook y ponerlos a trabajar inmediatamente.

Hay roles para todo: aprovisionamiento, implementación de aplicaciones.

Pueden estar incluidos en Colecciones junto con Playbooks, módulos y complementos.


### [Ansible Tower](https://www.ansible.com/products/controller)

Es un servicio web donde se puede centralizar y controlar cualquier infraestructura IT de forma visual.

Parte de un proyecto llamado AWX Project y que es Open Source: <https://github.com/ansible/awx>

Permite:

  - Control de acceso basado en roles
  - Programación de trabajos
  - Notificaciones integradas
  - Administración gráfica del inventario, etc

Es Propietaria. (Red Hat). Tiene dos versiones Estándar y Premium. Permite prueba de 60 días gratis


![](img/Ansible_01_conceptos.jpeg) 15


## Instalación de Ansible

Para este Bootcamp vamos a utilizar como **Nodo de control** una **MV con Ubuntu**. 

El único prerrequisito de Ansible es que el Nodo de control tenga instalado **Python 2** (versión 2.7) o **Python 3** (versiones 3.5 y superiores)

***No se puede utilizar Ansible desde Windows*** Hay dos productos Ansible: 

- Ansible community
- Ansible-core (más minimalista)

Instalaremos Ansible community

Sobre la MV que se acompaña para el Bootcamp, vamos a crear un clon que utilizaremos como Nodo Administrado. Luego la configuraremos más adelante en otro Hands-On

Después en la MV original, sobre un terminal: 

```bash
sudo -E add-apt-repository ppa:ansible/ansible

sudo apt update

# Solo ejecutar este comando si tenéis buena conexión de internet. 
sudo apt upgrade

sudo apt install ansible
```

Para otros linux

```bash
# Fedora:

sudo dnfinstallansible

# RHEL

sudo yuminstallansible

# CentOS

sudo yuminstallepel-release
sudo yuminstallansible
```

Ahora vamos a dar un nombre a nuestra máquina con Ansible:

```bash
sudo nmcli general hostname control
sudo systemctl restart systemd-hostnamed
reboot
```

También crearíamos una clave SSH con ssh-keygen.
- Nota: Aunque sabemos que meter una **passphrase** es más seguro, en estos ejemplo, para evitar que Ansible nos la pregunte cada vez que lanzamos una tarea, la dejaremos vacía.


Vamos a tomar ahora la máquina que clonamos. Y para hacer más realista la práctica, cambiaremos el nombre de la maquina, y nos preocuparemos de que tenga instalado SSH.
  - Antes de abrir el nodo de control, cambiamos el nombre a la que funcionará como nodo administrado:

```bash
sudo nmcli general hostname nodo1 

sudo systemctl restart systemd-hostnamed
```

Podríamos crear más nodos clonado nodo1 y realizando los cambios pertinentes en las ip de red.

También habría que copiar el fichero **authorized_keys** en cada nodo para que así el nodo de control tenga acceso.

Una vez que tengamos acceso por SSH a los nodos, podemos empezar lanzando los primeros comandos Ad-hoc

## El primer inventario

Ansible ***necesita identificar a quién se va a aplicar las tareas que definamos***, bien con comandos Ad - hoc o con Playbooks.

Para ello necesitamos crear un **Inventario**.

Podemos usar el ***inventario por defecto*** que se encuentra en **/etc/ansible/hosts**

O podemos crear uno, en forma de texto plano, que se utilizará sólo para las tareas que lo indiquen.


Para tener todo almacenado en una carpeta, vamos a crear en el Home la carpeta ansible 

````bash
mkdir ansible
cd ansible
````

- Con cualquier herramienta de edición (vi, vim, gedit, etc) podemos crear el primer inventario llamado **inven.txt**:

- Abrimos el fichero y en él, escribimos:
  - nodo1
  - O bien 192.168.174.102  (o la IP del nodo en cuestión)


Ahora, nuestra primera instrucción de ansible será comprobar que nodos tenemos en el inventario. En un terminal, escribimos:

````bash
ansible all -i inven.txt --list-hosts
````
- **all** significa que la operación --list-hosts se va a aplicar a todos los nodos que aparezcan en el inventario.
- **--list-hosts**  es la orden listar todos los hosts
- **-i inven.txt** indica el nombre del inventario que utilizaremos en la orden
  - Si se omite la opción -i , Ansible buscará hosts en el archivo de inventario /etc/ansible/hosts en su lugar.

La salida será algo así: 
- hosts (1):
  - nodo1


Si tuviéramos más de un nodo y quisiéramos agruparlos en categorías, etc en el ***fichero de inventario*** podríamos escribir algo parecido a esto:
````text
[pruebas] 
    nodo1

[produccion] 
    nodo2
````

Y ahora, si sólo quiero mostrar los hosts que tengo agrupados bajo el grupo producción: 
````bash
ansible produccion -i inven.txt --list-hosts
````

Si añadimos un nuevo nodo fuera de los grupos a nuestro inventario

````text
nodo3
[pruebas]
    nodo1
[produccion]
    nodo2
````

Ese nodo3 estaría dentro de un grupo especial que crea Ansible llamado ***ungrouped***. También existe otro grupo por defecto llamado **all**.
  - **Nota**: *cuidar que el nodo no agrupado esté al principio del fichero, porque si no, lo tomaría como si estuviera en el grupo produccion*
````bash
ansible ungrouped -i inven.txt --list-hosts
````

También se pueden crear grupos cuyo contenido sean otros grupos (children):

````text
[desarrollo] 
  nodo3
[pruebas] 
  nodo1
[produccion] 
  nodo2
[dev:children]
  desarrollo 
  pruebas
[prod:children] 
  produccion
````

La forma de llamarlos es similar a las anteriores: 

````bash
ansible dev -i inven.txt --list-hosts

ansible prod -i inven.txt --list-hosts
````

## Comandos Ad-hoc


Ya hemos visto que Ansible puede realizar tareas directamente desde el terminal. 
  - Tienen todas las posibilidades de Ansible
  - Inconveniente: Cada vez que queremos realizar la tarea, hay que volver a reescribir los comandos.
  - Utiliza flags (-m, -i, etc) para indicar a qué nos estamos refiriendo.

La típica plantilla para lanzar una tarea que ejecuta un módulo en un hosts sería:

* **ansible <<patron_nodos>> -i <<fich_inventario>> -m <<nombre_modulo>> -a "<<opciones_modulo>>"**


Un comando habitual es hacer ping para comprobar la conectividad: 
````bash
ansible nodo1 -i invent.txt -m ping
````

Tras el mensaje anterior de warning, vemos el siguiente texto en verde:

````bash

nodo1 | SUCCESS => {
  "ansible_facts": {
    "discovered_interpreter_python": "/usr/bin/python" 
  },
  "changed": false,
  "ping": "pong"
}
````

Del mismo modo, si quisiéramos lanzar a nodo1 el módulo command con las opciones “uptime” 
```bash
ansible nodo1 -i invent.txt -m command -a "uptime"
```
Nos aparecerá un mensaje de warning sobre la versión de Python que utiliza y al final, en amarillo, lo siguiente:

````bash
nodo1 | CHANGED | rc=0 >>

11:11:03 up 40 min,  2 users,  load average: 0,01, 0,04, 0,03
````

Que es la salida del comando utilizado


También hay que decir que se puede lanzar al propio **localhost** como si fuera un nodo administrado (cuidado porque **all** no lo reconoce dentro de la lista de todos los nodos administrados)

```bash
ansible localhost -m ping
```
- Salida:

````bash
localhost | SUCCESS => {
  "changed": false, "ping": "pong"
}
````

Para poder ver la documentación de un módulo directamente por comando: 

```bash
ansible-doc ping
```

Hay que tener especial cuidado cuando alguna opción venga indicada con un = , porque eso significa que esa opción es obligatoria.

La documentación está en la url: http[s://docs.ansible.com/ansible/latest/index.html](https://docs.ansible.com/ansible/latest/index.html)

La cantidad de módulos disponibles se puede mostrar con la instrucción: 
````bash
ansible-doc -l | wc -l
````

Es importante que ansible use la última versión de python, para revisar que versión está utilizando lo podemos ver con ansible --version
veremos algo así:

````text
ansible [core 2.12.10]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/nacho/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/nacho/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Nov 14 2022, 12:59:47) [GCC 9.4.0]
  jinja version = 2.10.1
  libyaml = True
````

Si la versión de python es la 2 y no la tres podemos obligar al ejecutar que use la 3 con el con  **-e 'ansible_python_interpreter=/usr/bin/python3'**

Si queremos que utilice la tres, a continuación de cualquier comandos ad-hoc añadiremos este flag: 
- **ansible** ......   **-e 'ansible_python_interpreter=/usr/bin/python3'**

Esto es útil por ejemplo para utilizar módulos tan importantes como ‘apt’ en Ubuntu

Un ejemplo de lo anterior:
- Queremos instalar en **nodo1** la aplicación **vim**. Para ello utilizaremos el módulo apt que nos instalará el paquete. 
- En principio podríamos pensar que valdría con algo como esto:

````bash
ansible nodo1 -i invent.txt -m apt -a 'name=vim state=present update_cache=yes' -b -K

# apt -> especificamos que vamos a instalar algo
# name=vim -> Para instalar vim
# State=present -> es que se ejecute con normalidad
# update_cache=yes -> Hace que antes de ejecutar se actualice
# -b -k Obliga a poner la contraseña   
````

- Y como salida nos aparecerán trazas de la instalación de **vim** en el **nodo1** en color amarillo.

Se puede producir el siguiente error:

````bash
nodo1 | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "module_stderr": "Shared connection to nodo1 closed.\r\n",
    "module_stdout": "sudo: se requiere una contraseña\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 1
}
````

Este error es por la versión de python  que hemos comentado antes, añadimos el flag

````bash
ansible nodo1 -i invent.txt -m apt -a 'name=vim state=present update_cache=yes' -b -K -e 'ansible_python_interpreter=/usr/bin/python3'
````

Si tras esto, volviéramos a ejecutar la misma instrucción:

````bash
ansible nodo1 -i invent.txt -m apt -a 'name=vim state=present update_cache=yes' -b -K -e 'ansible_python_interpreter=/usr/bin/python3'
````
****

- Ya no saldrían las trazas amarillas sino esto: 

````bash
nodo1 | SUCCESS => {
  "cache_update_time": 1632057957, 
  "cache_updated": true,
  "changed": false
}
```` 

- Que indica que no se ha vuelto a instalar, porque ya lo tiene instalado. Y es que así funciona Ansible.

Por último decir que, si no se especifica módulo, Ansible toma como módulo por defecto el que lanza comandos de Shell al nodo que especifiquemos:

```bash
ansible localhost -a 'ls /'
```

Que es equivalente a:

````bash 
ansible localhost -m shell -a 'ls /'
````

Respecto a las diferencias entre command, shell y raw, tres comandos ad-hoc que aparentemente hacen lo mismo, lanzar instrucción como si estuviéramos en un terminal, hay ciertas diferencias:

![](img/Ansible_01_comandos_ad_hoc.png)



## Usuarios

Como vemos, las máquinas que estamos utilizando como nodos administrados tienen el mismo usuario:  **usuario**

Pero esto no es normalmente así. ***No podemos ejecutar comandos Ad-hoc ni después Playbooks con el usuario que tenemos en nuestro nodo control.***

Tampoco está recomendado, por seguridad, utilizar el usuario **root** para ejecutar ansible. Por lo que debemos decirle a Ansible que se va a utilizar un usuario remoto, con el flag –u

````bash
ansible nodo1 -i inven.txt -m ping -u otrou
````

Otra forma, sería incluirlo directamente en el inventario:

```bash
nodo1 ansible_hosts=192.168.174.101 ansible_user=otrou 
nodo2 ansible_hosts=192.168.174.102 ansible_user=usuario
```

Y obtendremos el resultado esperado:

```bash
nodo1 | SUCCESS => {
  "ansible_facts": {
    "discovered_interpreter_python": "/usr/bin/python" 
  },
  "changed": false,
  "ping": "pong"
}
```

Recordamos que si queremos cambiar el nombre del usuario de otra máquina, eliminando el anterior, una lista de comandos para ello puede ser esta:

```bash
sudo adduser otrou
```
Se ingresaría la contraseña, etc. Después lo agregaríamos al grupo sudo

````bash
sudo adduser otrou sudo
````

Estableceríamos la contraseña de root y después reiniciaríamos.

````bash
sudo passwd root
````

Iniciaríamos con el nuevo usuario y accederíamos como root

````bash
su root
passwd -l root
````

Reiniciamos de nuevo y volvemos a entrar con el nuevo usuario y eliminamos el anterior

````bash 
sudo deluser usuario
````

Por útlimo borramos el perfil y así se conserva el nuevo nombre asignado

````bash
sudo rm -r /home/usuario
````

## Configurando Ansible

Ansible se puede configurar para que nos facilite operaciones o para que tome ficheros determinados en rutas por defecto.

El fichero que tenemos que modificar se encuentra en **/etc/ansible/ansible.cfg**

De todos modos, si ejecutamos el comando:
````bash
ansible --version
````

````text
ansible [core 2.12.10]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/nacho/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/nacho/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Nov 14 2022, 12:59:47) [GCC 9.4.0]
  jinja version = 2.10.1
  libyaml = True

````

Lo recomendable es dejar “tranquilo” a este fichero /etc/ansible/ansible.cfg de configuración y crearse uno propio

Las secciones más importantes del fichero son: 
- [defaults]
- [privilege_escalation]

Vamos por tanto a crear un fichero **ansible.cfg** pero **en nuestro directorio ansible** con este contenido:

```buildoutcfg
[defaults]
inventory = invent.txt
remote_user = otrou 
host_key_checking = False 
deprecation_warnings = False 
interpreter_python = /usr/bin/python3

[privilege_escalation]
become = true 
become_method = sudo 
become_user = root 
become_ask_pass = True
```

Si ahora volvemos a ejecutar:

- **ansible --version**

El fichero de configuración se encontrará en nuestro directorio

Por lo demás, en el código anterior vemos cómo se hace mención a **remote user** y a los privilegios de escalado.

- **Nota**: *Ya hemos visto que **remote_user** en la línea de comandos se puede llamar con **-u otrou***
- *Asimismo, si queremos usar **become** directamente en la línea de comandos, usaríamos **-b**, con lo cual ya se activaría el escalado de privilegios*

Si ahora intentamos hacer un comando: 
````bash
ansible nodo1 -m shell -a "whoami"
````

Nos aparece esto:
````
nodo1 | FAILED! => {
  "ansible_facts": {
    "discovered_interpreter_python": "/usr/bin/python"
  },
  "changed": false, 
  "module_stderr": "Shared connection to nodo1 closed.\r\n", 
  "module_stdout": "**sudo: se requiere una contraseña**\r\n", 
  "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", 
  "rc": 1
}
````

Es decir, se nos reclama contraseña, porque tenemos la opción **became=true**, por lo que al intentar colocarse como **root** no obtiene la contraseña (y se pone rojo porque no se lo toma muy bien)

Para que nos pida la contraseña, colocaremos el flag -K al final: **ansible nodo1 -m shell -a "whoami" -K**

````bash
BECOME password:
nodo1 | CHANGED | rc=0 >> 
root

````
En todo lo que devuelve ansible aparece el valor **rc=** Esto es el código Error status, siendo **0 cuando todo es correcto** y algún **otro valor dependiendo del error que detecta**.

## Lab 1 Ansible


Para este primer lab vamos a pedir lo siguiente:
- Vamos a **crear un nuevo nodo** administrado que llamaremos **nodo2** y con un nuevo usuario que se llame **otrou** a partir de la máquina original. Tiene que ser accesible por ansible como hemos hecho con nodo1. Realizar todos los pasos necesarios.
- Crear un **proyecto nuevo** que se llame **ansible2**
- Crear un **fichero de inventario inven2.txt** donde tengamos **dos grupos**, uno llamado **dev** que alberga al nodo1 y otro llamado **test** que alberga al nodo2
- Crea un nuevo **fichero de configuración ansible.cfg** para utilizar escalado de privilegios, que especifique el nuevo usuario que tiene nodo2, que diga cómo se llama el nuevo fichero de inventario y que defina forks como 4. El resto de propiedades pueden ser las mismas.
- Escribe el **comando que nos permita instalar nginx en el nodo2**. <https://docs.ansible.com/ansible/2.8/modules/apt_module.html#apt-module>


# Ansible - Playbooks

## Introducción a los Playbooks

La línea de comandos no nos permite automatizar al completo Ansible. 

Para entender la diferencia entre comandos Ad-hoc y Playbooks basta con pensar en los comandos ad - hoc de Ansible como comandos de Linux y los libros de jugadas como scripts bash

- Así utilizaremos **comandos ad-hoc** para **tareas no muy frecuentes**: Información sobre el sistema, etc.
- Utilizaremos **los playbooks** cuando queramos **automatizar tareas complejas** como implementación de aplicaciones, configuraciones, administración de usuarios, etc.

Lo que escribimos en un comando Ad-hoc, tiene directa traducción a un Playbook:

![img_2.png](img/Ansible_01_playbooks_01.png)

- Los Playbooks están escritos en YML (YAML). Aquí se muestra un resumen de las sintaxis de los ficheros .yml ó yaml: 

![img.png](img/Ansible_01_playbooks_02.png)

Hay que tener especial cuidado al utilizar las **identaciones**. Lo más recomendado es **usar 2 espacios**. **NUNCA TABULACION.**

**Un Playbook de Ansible siempre comienza con tres guiones**.

A continuación uno o más elementos de una lista (empiezan con guiones) y la clave **name:**  El valor de name sí que puede ser el texto que queremos y a ser posible que explique lo que queremos hacer.

````
---
name: ejemplo playbook
````

Después hay que especificar el grupo o todos o algún nodo de los que tengamos especificados en nuestro fichero de inventario con la palabra clave **hosts**:

A continuación definiremos las tareas con la clave **tasks**:

**Cada tarea empieza con un guión y la clave name:** Y como antes, una palabra o frase que defina qué se va a hacer en esa tarea:

````yaml
---
- name: ejemplo playbook
  hosts: nodo1
  tasks:
    - name: crear un fichero nuevo
````

Debajo del nombre de la tarea se especifica el nombre del módulo a utilizar (shell, apt, file, etc.) seguido de el símbolo **:**

Identado más adentro tendremos que especificar las variables específicas a rellenar de cada módulo con los valores que necesitemos. Ver la documentación de cada módulo.


````yaml
---
- name: ejemplo playbook
  hosts: nodo2
  tasks: 
    - name: crear un fichero nuevo
      file:
        path: /tmp/ejemplo.txt
        mode: 664
        owner: otrou
        state: touch
````

- La estructura podría ser la siguiente:

![](img/Ansible_01_playbooks_03.png)

Una vez creado el playbook. Recordamos con extensión .yml o .yaml, la forma de ejecutarlo sería:

````bash
ansible-playbook ejemplo.yml -K
````

Obtendremos algo como esto:

````
BECOME password: 
PLAY [ejemplo playbook ] **************************************************************

TASK [Gathering Facts ] ************************************************************** 
ok: [nodo1]

TASK [crear un fichero nuevo] 
**changed: [nodo1]**

PLAY RECAP **************************************************************
nodo1: **ok=2 changed=1**    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  65
````

Podríamos verificar tanto manualmente, como a través de un nuevo comando ad-hoc de ansible: 

````bash
ansible nodo2 -m command -a "ls -l /tmp/ejemplo.mio" -K
````

Obtendremos algo como esto:

````bash
BECOME password:** 

**nodo1 | CHANGED | rc=0 >>**
**-rw-rw-rw- 1 otrou root 0 sep 19 16:06 /tmp/ejemplo.txt
````

Este ejemplo.yml, como es muy sencillo, también podríamos haberlo escrito con este comando: 

````bash
ansible nodo2 -m file -a "path=/tmp/ejemplo.mio mode=0666 owner=otrou state=touch" -K
````

Cuando los playbooks sean muy largos, es recomendable chequear la sintaxis introducida para evitar que algunas tareas se realicen y otras se queden a medias, etc.

Para verificar la sintaxis de un playbook utilizamos **--syntax-check** a la hora de utilizar ansible-playbook 

````bash
ansible-playbook --syntax-check ejemplo.yml
````

Si todo es correcto mostrará el nombre del propio yml.

También podemos hacer un simulacro de lo que realizará el yml con **--check**
````bash
ansible-playbook --check ejemplo.yml -K
````

## Más sobre Playbooks

Un playbook puede contener múltiples jugadas y cada jugada, a su vez, puede contener múltiples tareas.

“Cada jugada” es equivalente a “cada reproducción”

Se acompaña un fichero llamado 01_multiple.yml

````bash
ansible-playbook --check 01_multiple.yml -K
````

Volvemos a tener problemas con Python2.  Podemos solucionarlo colocando como antes en la instrucción añadiendo al final:

````bash
-e 'ansible_python_interpreter=/usr/bin/python3'
````

Otras opciones son:
  - Colocarlo directamente en el inventario como una variable:

````yaml
vars:
  ansible_python_interpreter:/usr/bin/python3
````
Colocarlo en la parte **[defaults]** del fichero **ansible.cfg** para que siempre utilice python3:

````
[defaults]
...
interpreter_python = /usr/bin/python3 ...
````

Si queremos **saber qué nodos** son afectados por un yml múltiple podemos utilizar **-- list-hosts** 

````bash
ansible-playbook --list-hosts 01_multiple.yml
````

Obtenemos algo como esto:

````
playbook: 01_multiple.yml

play#1 (all): primera jugada     TAGS: []
  pattern: [u'all']
  hosts (2):
    nodo2
    nodo1
play#2 (nodo2): segunda jugada   TAGS: []
  pattern: [u'nodo2']
  hosts (1):
    nodo2
````

Podemos enumerar **las tareas** ejecutadas por un yml múltiple **--list-tasks** 
````bash
ansible-playbook --list-tasks 01_multiple.yml
````

Obtenemos algo como esto:

````
playbook: 01_multiple.yml
  play#1 (all): primera jugada   TAGS: []
    tasks:
      instala tmux               TAGS: []
      crea un fichero            TAGS: []
      
play#2 (nodo2): segunda jugada   TAGS: []
  tasks:
    instala git                  TAGS: []
````

## Reutilizando Playbooks

Los Playbooks de Ansible tendrían poco recorrido si no se pudiesen reutilizar como partes de otros playbooks´.

Así, si tenemos el caso en que varios playbooks comparten una lista común de tareas, podemos crear un archivo yml que contenga esa lista tareas comunes y luego reutilizarlas en otros playbooks

Se acompaña un fichero llamado **02_grupos.yml** y otro **03_importando.yml**

En esos ejemplos se utiliza **import_task** para indicar de dónde se van a sacar las tareas a utilizar.

También se puede usar import_playbook o include para reutilizar un playbook completo. Se acompañan ejemplos de estos. 

Sólo hay un inconveniente: *Qué SOLO se puede usar un nivel de anidamiento.*

La única diferencia es que las declaraciones de **importación** se **procesan previamente** en el momento en que se analizan los libros de jugadas. Por otro lado, las declaraciones de inclusión se procesan a medida que se encuentran durante la ejecución del libro de jugadas. 

En resumen, la importación es estática mientras que la inclusión es dinámica.

Otra forma de reutilización es el uso de **etiquetas** (**Tags**)
- Con éstas. *se puede optar por no ejecutar un playbook completo* y, en su lugar, *se puede ejecutar tareas o jugadas específicas.*
- Basta con añadir las claves “tags” que se precisen, con el valor que necesitemos. Esto “marca” las tareas, para que después con el flag --tags al ejecutar ansible-playbook se ejecute solo la tarea marcada:

````bash
ansible-playbook 06_multiple_tags.yml --tags git
````

Sólo se ejecutará la tarea de la segunda reproducción •


## Lab 2 Ansible

Para este segundo lab vamos a pedir lo siguiente:

- Queremos instalar utilizando ansible en nodo1 y nodo2: •
  - **apache2**
  - **Php 7.4 y toda la pila de lamp**

- Como ayuda, se adjuntan las instrucciones que habría que ejecutar en Ubuntu 18.04 si lo hiciéramos paso a paso desde el terminal.

- El fichero se llama PasosPHP.txt

- Convertir a un playbook de varias tareas. Ayuda:
  - [https://docs.ansible.com/ansible/latest/collections/ansible/builtin/index.html#plugins-in- ansible-builtin](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/index.html#plugins-in-ansible-builtin)
  
- ¿Podrías colocar la parte de apache2 como una import_task?


# Variables en Ansible

- Los sistemas administrados varían demasiado. Es tal vez esto lo que determina el trabajar con variables en Ansible.
- Este uso de variables nos permitirá incluso dar más uso a distintos playbook, ya que a veces podremos utilizar el mismo con distintas aplicaciones.
- Se pueden usar variables dentro del playbook que las utiliza o como fichero aparte.


### Definición de variables

Para definir una variable utilizamos **vars** como en este ejemplo:

````yaml
---

- name: Ejemplo variables 
  hosts: all
    vars:
      color:
        ubuntu: Amarillo
        centos: Rojo
````


### Usar variables

Para usar variables, Ansible, tal vez influenciado por Python, utiliza el sistema de plantillas Jinja2. Por lo que para obtener el valor de la variable anterior, sólo tendremos que rodearlo de {{  y }} en el lugar que corresponda:

- **Esto es un {{ color }}**

Si la variable es el único elemento o es el primer elemento, se debe escribir entre comillas: 
- **“{{ color }}”**


Un ejemplo en un playbook podría ser este:

````yaml
---
- name: ejemplo variables
  hosts: nodo1
  vars:
    color: amarillo
  tasks:
  - name: Mostrar el color favorito
    debug:
      msg: Mi color favorito es el {{ color }}.
````

La salida incluirá esto:

````
TASK [Mostrar el color favorito] ************************************************* 
ok: [nodo1] => {
  "msg": “Mi color favorito es el amarillo."
}
````

### Crear listas y diccionarios

#### Listas
- En Ansible se pueden utilizar listas (arrays) y diccionarios (pares clave:valor) para definir variables de varios valores. Por ejemplo, si queremos definir una serie de números de puerto:

```yaml
vars:
  port_nums: [21,22,23,25,80,443]
```

Por influencia de Python, los arrays se enmarcan entre [ ]

- Otra forma sería en forma lista según YAML:

````yaml
vars:

port_nums:
  - 21
  - 22
  - 23
  - 25
  - 80
  - 443
````

Otras formas de lanzar o ver elemento en Ansible 

- Muestra el último elemento
```yaml
port_nums[-1]
```
- Mostrar desde el tercero hasta el último:
```yaml
port_nums[2:]
```  

- Mostrar desde el tercero hasta el penúltimo: •
````yaml
port_nums[2:-1]
````  

Otra forma sería en forma lista según YAML:

````yaml
vars:
  port_nums:
    - 21
    - 22
    - 23
    - 25
    - 80
    - 443
````

Para imprimir todos los valores de **port_nums**: 

- **{{ port_nums }}**

Si queremos un elemento específico de la lista: 
- **{{ port_nums[0] }}**

Con el número 0 entre corchetes queremos indicar que hacemos referencia al primer elemento de la lista. (Igual que se hace en Python)

#### Diccionarios

Respecto a los diccionarios, aquí se muestra un ejemplo de definición del diccionario **usuarios**:

- {‘clave1’: valor, ‘clave2’: valor}

````yaml
vars:
  usuarios:
    juan:
      username: juan 
      uid: 1122
      shell: /bin/bash
    ana:
      username: ana 
      uid: 2233
      shell: /bin/sh
````

Sin embargo, para los diccionarios hay dos formas de acceder a sus elementos:

````yaml
usuarios['juan']['shell']
# -> /bin/bash

#ó

{{usuarios.juan.shell}}
````

### Incluir variables externas

Al igual que se puede importar (o incluir) tareas en un libro de jugadas. También se puede hacer lo mismo con las variables. Es decir, en un playbook, se puede incluir variables definidas en un archivo externo: **variables.yml**

Ahora, para incluirlo en un playbook, sólo hay que utilizar la palabra clave **vars_files** y colocar el nombre del fichero como valor:

```yaml
---
- name: variables externas
  hosts: nodo1
  # Aquí incluimos variables externas
  vars_files: variables.yml
  tasks:
    - name: Mostrar el segundo elemento de port_nums 
      debug:
        msg: El puerto SSH es {{port_nums[1] }}
    - name: Mostrar el uid de Juan
      debug:  
        msg: El UIDde Juan es {{usuarios.juan.uid }}
```

**vars_files** preprocesa y carga las variables al comienzo del playbook. Si lo que queremos es que se carguen a medida que van realizándose tareas (modo dinámico) utilizaremos **include_vars** así

```yaml
\---
- name: variables externas 
  hosts: nodo1 
  tasks:
  - name: Mostrar el segundo elemento de port_nums 
    debug:
      msg: El puerto SSH es cualquiera
  - name: Carga de las variables 
      include_vars: variables.yml
  - name: Mostrar el uid de Juan
    debug:
      msg: El UIDde Juan es {{usuarios.juan.uid }}
```

### Obtener información del usuario. 
Ansible permite solicitar información en tiempo de ejecución al usuario.
Se utiliza vars_prompt y espera a que el usuario introduzca la información y pulse ENTER:

````yaml
---
- name: saludo
  hosts: nodo1
  vars_prompt:
    - name: nombre
      prompt: ¿Cuál es su nombre?
      private: no
  tasks:
    - name: saludamos al usuario
      debug:
        msg: Hola {{nombre }}
````

El determinar **private: no**, es necesario si queremos ver qué estamos escribiendo, porque de lo contrario, private es yes y pasará como con las contraseñas.

### Configuración de variables de grupo de host. 
Se pueden establecer variables específicas para los nodos administrados.
Para ejemplificarlo vamos a cambiar el inventario inven.txt a este:

```
[proxy] 
nodo1 
[webserver] 
nodo2
```

El siguiente paso es crear un directorio host_vars en cada uno de los nodos administrados y, dentro del directorio, crear archivos de variables con nombres de archivo que sean iguales que los nombres de los nodos:

Configuración de variables de grupo y de host

- (en el nodo1)
````bash
mkdir host_vars

echo "mensaje: Soy un servidor proxy" >> host_vars/nodo1.yml
````

- (en el nodo2)
````bash
mkdir host_vars

echo "mensaje: Soy un web server" >> host_vars/nodo2.yml
````

Y ahora el playbook podría ser este:

```yaml
---
- name: configurar el mensaje del dia de todos los nodos 
  hosts: all
  tasks:
    - name: configurar
        motd = valor de la variable mensaje 
      copy:
      content: "mensaje"
      dest: /etc/motd
```

Como se ha visto, las variables de Ansible se pueden establecer en diferentes ámbitos (o niveles).

Pero si la misma variable se establece en diferentes niveles; el nivel más específico tiene prioridad. Es decir:
- Una variable que se define en un playbook tiene prioridad sobre la misma definida por host_vars
- Una variable que se define en la línea de comandos con

  - --extra-vars (-e) tiene la prioridad más alta.

Lanzamos el fichero **precedencia.yml** que se acompaña pero con esta línea de comando: 
- **ansible-playbook precedencia.yml -e "distribucion=CentOS"**


Al ejecutar un comando ad-hoc como este: 
- **ansible all -m command -a "cat /etc/motd"**

Aparecerá algo como esto:
````
node1 | CHANGED| rc=0 >> 
Soy un servidor proxy 
node2 | CHANGED| rc=0 >> 
Soy un web server
````

## Lab Ansible (group_vars)

Configuración de variables de grupo y de host

- Lo mismo se podría hacer con **group_vars** y a partir de ahí incluir todas las variables relacionadas con el grupo en un nombre


# Hechos en Ansible

## Recopilación de hechos

Se puede recuperar o descubrir variables que contienen información sobre los nodos administrados. Estas variables se denominan **Hechos** y Ansible utiliza el módulo **setup** para recopilarlos.

Un hecho por tanto puede ser la dirección IP del nodo1.

- **ansible nodo1 -m setup -K**

El resultado puede ser como el que se muestra en el fichero **hechos_nodo1.txt**

De forma predeterminada, Ansible llama automáticamente al módulo setup para realizar el descubrimiento de hechos. Aunque si no queremos que lo haga, basta con poner:

- gather_facts: false

Al inicio de la definición de un Playbook

Es posible que deseemos crear nuestros propios hechos personalizados. Para hacer esto, se puede usar el módulo **set_fact** para agregar hechos temporalmente o el directorio **/etc/ansible/facts.d** para agregar hechos permanentes en los nodos administrados.

Necesitamos tres pasos para realizar esto:

### 1. Crear el archivo de hechos personalizado en el nodo de control. 

En un fichero **hechos.fact** escribimos:

````fact
[tonterias]
manzana=fruta 
matrix=pelicula 
pulpo='animal de compañia’
````

Para los otros dos pasos, podemos utilizar un playbook como el que se acompaña **hechos_pers.yml**

Y lo ejecutamos con:

- **ansible-playbook hechos_pers.yml -K**

Para comprobar que nuestras “tonterías” se han añadido a los hechos del nodo1, ejecutaremos: 
- **ansible nodo1 -m setup -a "filter=ansible_local"**

Y para utilizar cualquier dato de esas tonterías en cualquier lugar, por ejemplo la clave pulpo: 

- Un pulpo es {{ansible_local.hechos.tonterias.pulpo }}

La clave **hechos** viene del nombre del fichero **hechos.fact** que hemos creado

En Ansible, hay tareas que no muestran resultados al ejecutarse. Los módulos **command**, **shell** y **raw**, no muestran nada cuando se ejecutan en un playbook

Pero podemos crear nuestras propias “trazas” usando un registro para capturar la salida de una tarea y guardarlo en una variable.

Esto permite hacer uso de la salida de una tarea en otra parte de un playbook simplemente dirigiéndose a la variable registrada.

En el fichero **registros.yml** se muestra un ejemplo, en el que creamos una variable **mi_uptime** que mostramos completa o una parte de ella

# Bucles (Legacy) en Ansible

Ansible está en continuo cambio.

Y donde más se está notando es en los bucles. Porque se está agrupando todas las variantes de with, por una sintaxis más homogénea con loop.

A continuación vamos a ver los cambios en una serie de ficheros.
  - [with_list](Ejemplos/bucles/with/with_list.yml)
  - [with_together](Ejemplos/bucles/with/with_random_choice.yml)
  - [with_dict](Ejemplos/bucles/with/with_random_choice.yml)
  - [with_sequence](Ejemplos/bucles/with/with_random_choice.yml)
  - [with_nested](Ejemplos/bucles/with/with_random_choice.yml)
  - [with_random_choice](Ejemplos/bucles/with/with_random_choice.yml)

En ocasiones, es posible que deseemos repetir una tarea varias veces. Por ejemplo, es posible que tengamos que crear varios usuarios, iniciar o detener varios servicios o cambiar la propiedad de varios archivos en sus hosts administrados.

La forma es usar los bucles de Ansible para repetir una tarea varias veces sin tener que volver a escribir toda la tarea una y otra vez.

Ansible utiliza las palabras clave **loop** y **until** y mantiene aún la cláusula **with_<elemento>**


- Sin embargo, hay que recordar que algunos módulos como **yum** o **apt**, es mejor introducir directamente la lista en nombre en vez de usar bucles.

## Bucles sobre Listas

Los bucles sobre listas son los más sencillos de entender:

### loop

El conjunto del bucle consiste en la parte de iteración, y la parte donde relaciona la variable:

![](img/Ansible_02_Bucles_sobre_listas.jpeg)

Podemos también colocar listas definidas en variables directamente en el bucle:

````yaml
---
- name: print list
  hosts: nodo1
  vars:
    prime: [2,3,5,7,11]
  tasks:
    - name: Muestra los primero numeros
      debug:
        msg : "{{ item }}"
      loop: "{{ prime }}"
````

Otro ejemplo:

````yaml
---
- name: Crea un usuario en el gropo root pero no en wheel porque no existe el grupo
  hosts: nodo1
  tasks:
    - name: Añade varios usuarios 
      ansible.builtin.user:
          name: "{{ item.name }}"
          state: present
          groups: "{{ item.groups }}"
      loop:
        - { name: 'testuser1', groups: 'wheel' }
        - { name: 'testuser2', groups: 'root' }
````

Como sólo se puede usar bucles con listas, cuando tenemos diccionarios como variables, la forma de iterar por esos valores es usar **dict2items**, que nos separará las claves de los valores:

```yaml
---
- name: Itera sobre un diccionario. 
  hosts: nodo1
  tasks:
    - name: Sobre diccionarios
      debug:
        msg: "{{ item.key }}- {{ item.value }}" 
      loop: "{{ tag_data | dict2items }}" 
      vars:
        tag_data:
          Environment: dev
          Application: payment
```

La forma es utilizar range(numero) y con un filtro de listas para que se pueda establecer la iteración:
Al igual que ocurre en Python, si sólo tomamos un número, range crea una serie de valores desde 0 hasta ese número -1


````yaml
---
- name: Uso del bucle range 
  hosts: nodo1
  tasks:
  - name: Bucle sobre rango 
    debug:
      msg : "{{ item }}"
    loop: '{{ range(10) | list  }}'
````

Si no queremos empezar por cero, podemos colocar dos números. En este caso va de 5 a 14:

````yaml
---
- name: Uso del bucle range
  hosts: nodo1
  tasks:
    - name: Bucle sobre rango
      debug:
        msg : "{{item }}"
      loop: "{{ range(5,15) | list }}" # [5,15]
````

Y también podemos establecer un Paso:

````yaml
---
- name: Uso del bucle range
  hosts: nodo1
  tasks: 
    - name: Impresion de ips
      debug:
        msg: 192.168.1.{{ item }}
      loop: "{{ range(0,256,2) | list }}"
    # loop: "{{ range(255,0,-2) | list }}"
````

### Recorrer inventarios.

Para recorrer un Inventario, podemos utilizar una variable especial de Ansible, llamada **groups**
Por ejemplo, si queremos iterar por todos los hosts de un inventario escribiríamos

````yaml
# ...
loop: "{{ groups['all'] }}"
````

Y también podemos iterar por un grupo de hosts: ……….

````yaml
# ...
loop: "{{ groups['test'] }}"
````


### Pausas en los bucles.

A veces podemos necesitamos pausar un cierto número de segundos entre cada iteración de los bucles. Para esto se utiliza la directiva **pause** a través de la palabra clave **loop_control**

También existe index_var

En el fichero **cuentaatras.yml** se muestra un ejemplo que pausa 1 segundo en cada iteración.

### Until

Pero si los bucles loop son necesarios, el bucle until es más aún, porque determina la iteración a partir de una condición.

Si la condición se cumple, separa el bucle.
El bucle Until utiliza tres palabras clave:
- **until:** <condición> La condición que ha de cumplirse para que el bucle se detenga.
- **retry**: <numero de intentos> Cuantas veces queremos ejecutar antes de que Ansible se de por vencido. Podríamos decir que es el número de intentos máximos si no se cumple la condición.
- **delay**: <segundos> Segundos de espera entre reintentos.

El siguiente ejemplo, la tarea seguirá enviando la solicitud GET a la URL especificada hasta que la clave de "estado" en respuesta sea igual a “READY".
Le pedimos a Ansible que haga 10 intentos en total con un retraso de 1 segundo entre cada intento. Si después del último intento, la condición until aún no se ha cumplido, la tarea se marca como fallida.

````yaml
# Ejemplo 
- name: Esperar hasta que el servidor esté disponible
  hosts: nodo1
  tasks:
    - name: Retry a task until a certain condition is met
      ansible.builtin.shell: /usr/bin/foo
      register: result
      until: result.stdout.find("all systems go") != -1
      retries: 5
      delay: 10
````

Esta tarea se ejecuta hasta 5 veces con un retraso de 10 segundos entre cada intento. Si el resultado de cualquier intento tiene "todos los sistemas funcionan" en su salida estándar, la tarea tiene éxito. El valor predeterminado para "reintentos" es 3 y "retraso" es 5.

Cuando ejecuta una tarea untily registra el resultado como una variable, la variable registrada incluirá una clave llamada "intentos", que registra el número de reintentos para la tarea.


# Tomas de decisiones en Ansible

## Condicionales con When.

Se puede utilizar el condicional **When** para determinar que una **Tarea** sólo se ejecutará cuando se cumpla una condición.

**When** se une al final de la tarea para condicionarla. 

Las variables no se tienen que rodear con llaves cuando se utilizan en condicionales when

````yaml
---
- name: condicional when
  hosts: all
  tasks:
    - name: Detecta si es un servidor ubuntu
      debug:
        msg: "Es un servidor Ubuntu"
      when: ansible_facts["distribution"] == "Ubuntu"
````

Otro ejemplo es utilizar when con registros que capturan la salida de alguna operación.

En este, se captura lo que salga de la operación cat en un registro llamado **os_release**

Luego busca en la cadena, la palabra CentOS

````yaml
---
- name: when con registros
  hosts: all
  tasks:
    - name: Guarda el contenido de /etc/os-release 
      command: cat /etc/os-release
      register: os_release
    - name: Detecta los servidores CentOS
      debug:
        msg: "Running CentOS ..."
      when: os_release.stdout.find('CentOS') != -1
````

Podemos combinar varias condiciones con when, utilizando los operadores and, or, etc.

El siguiente Playbook reinicia los servidores Ubuntu o CentOS

````yaml
---
- name: reiniciar ubuntus o centos
  hosts: all
  tasks:
    - name: Reinicia los servidores Ubuntu o CentOS
      reboot:
        msg: "Servidor reiniciándose ..."
      when: ansible_facts['distribution'] == "Ubuntu" or ansible_facts['distribution'] == "CentOS"
````

- **Los and se hacen antes que los or**


Se puede combinar When con Loop. El resultado es que todos los elementos que itere el bucle se filtrarán bajo la condición de when.

El siguiente ejemplo solo imprime los impares

````yaml
---
- name: Imprime pares
  hosts: nodo1
  tasks:
    - name: Imprime numeros pares 
      debug:
        msg: El número {{ item }}es par. 
      loop: "{{ range(1,11) | list }}" 
      when: item % 2 == 0
````

## Excepciones con Block.

En principio, el uso de Block es la agrupación de tareas bajo un nombre.

Sin embargo, uno de sus usos más importantes es utilizarlo para aislar posibles errores y actuar en consecuencia.

Por ejemplo, supongamos que tenemos una serie de tareas que son susceptibles de generar un error. La solución es agrupar esas tareas en un **block** y después añadir un bloque **rescue** que ejecutará una tarea en caso de fallo.

````yaml
---
- name: Imprime pares
  hosts: nodo1
  tasks:
    - name: Manejando errores
      block:
        - name: Lanza un comando que existe 
          command: uptime
        - name: Lanza un comando que no existe 
          command: dubidubidu
        - name: Esta otra tarea nunca se hace
          debug:
            msg: "¡¡Nunca me dan una oportunidad."
      rescue:
        - name: Tarea a ejecutar si el bloque falla 
          debug:
            msg: "El bloque falló, estamos reparándolo…."
````

Sin embargo, si a ese código, en la tarea que da error, añadimos **ignore_errors: yes** resultará que a pesar del error, Ansible seguirá con el resto de tareas.

````yaml
---
- name: Imprime pares
  hosts: nodo1
  tasks:
    - name: Manejando errores
      block:
        - name: Lanza un comando que existe
          command: uptime
        - name: Lanza un comando que no existe
          command: dubidubidu
          ignore_errors: yes  
        - name: Esta otra tarea nunca ya se hace
          debug:
            msg: “¡¡Por fin tengo mi oportunidad."
      rescue:
        - name: Tarea que no se va a ejecutar
          debug:
            msg: “El bloque falló, estamos reparándolo…."
````

Además de **ignore_errors: yes**, también tenemos **ignore_unreachable: yes** que ignora a todos esos nodos que no tenemos acceso

Por último, tenemos el bloque always, que se ejecutará haya o no errores.

El fichero **errores.yml** tiene el código completo

## Handlers

Un **handler** se utiliza para desencadenar tareas si ha habido algún cambio en los nodos administrados.

Por ejemplo, es posible que se desee reiniciar un servicio si una tarea actualiza la configuración de ese servicio, pero no si la configuración no ha cambiado.

Ansible utiliza controladores para abordar este caso de uso.

Los **Handlers** son tareas que solo se ejecutan cuando se las notifica. Por lo que un **Handler** siempre viene acompañado de uno o más **notify**, que llaman al nombre del handler

El ejemplo **verificacion.yml** muestra un ejemplo.

Un mismo **notify** puede avisar a más de un handler:

````yaml
- name: Verifica una instalacion de Apache
  hosts: nodo1
  tasks:
    - name: Archivo de configuracion 
      template:
        src: template.j2
        dest: /etc/foo.conf
      notify:
        - Reinicia memcached
        - Reinicia apache
      handlers:
        - name: Reinicia memcached
          service:
            name: memcached
            state: restarted
        - name: Reinicia apache
          service:
            name: apache
            state: restarted
````

De forma predeterminada, los handlers se ejecutan después de que se hayan completado todas las tareas de una jugada.

Este enfoque es muy eficaz, porque el controlador solo se ejecuta una vez, independientemente de cuántas tareas lo notifiquen

Sin embargo hay dos cuestiones:
- ¿Se puede llamar a un handler en la mitad de las tareas de una jugada?
- ¿Se puede evitar que se llame a un handler a pesar de la existencia de un notify si no ha cambiado nada en el nodo?

- ¿Se puede llamar a un handler en la mitad de las tareas de una jugada?
  - Sí, utilizando **meta: flush_handlers**

````yaml
tasks:
  - name: Some tasks go here 
    ansible.builtin.shell: ...
  
  - name: Flush handlers 
    meta: flush_handlers
    
  - name: Some other tasks
    ansible.builtin.shell: ...
````

**meta** activa los **handlers** que ya han sido notificados hasta ese momento


¿Se puede evitar que se llame a un handler a pesar de la existencia de un notify si no ha cambiado nada en el nodo?
- Si, existe un condicional llamado **changed_when** que puede definir alguna condición que marque cuando una tarea ha cambiado algo.
- Esto nos da libertad de que a pesar de que exista un **notify**, si la condición de ese **changed_when** no se cumple, pasará el aviso al **handler**

Los handlers son especialmente útiles cuando está editando configuraciones de servicios con Ansible. Eso es porque solo se quiere reiniciar un servicio cuando hay un cambio en la configuración del servicio.

El ejemplo [ssh.yml](Ejemplos/Handlers/ssh.yml) muestra cómo sólo se llama al handler cuando se ha producido un cambio en la configuración.
- Nota: **blockinfile** sirve para insertar filas en un fichero


# Ansible Vault 

## ¿Qué es Ansible Vault?

Ansible Vault es una característica dentro de Ansible que le **permite mantener todas las contraseñas y datos 
confidenciales en archivos cifrados**, en lugar de tenerlos en texto sin formato dentro de los playbooks o en vars.

Ansible Vault puede apuntar a la ubicación de un archivo de contraseña o puede hacer que Ansible solicite la contraseña cada vez que ejecute un playbook.

**ansible-vault** es parte del núcleo de Ansible por lo que no hay que instalar nada

- Los pasos para configurar una bóveda Ansible son
  - Crear un archivo de bóveda usando cifrado ansible-vault
  - Especificar la contraseña de la bóveda
  - Ver archivo cifrado usando la vista ansible-vault

### 1. Crear un archivo de bóveda usando cifrado ansible-vault

Para empezar con ansible-vault lo primero es cifrar un archivo, ya sea nuevo o uno que ya exista. 
- **ansible-vault create mitesoro.yml**

Nos pedirá una contraseña y su confirmación.

Si ahora intentamos hacer un cat sobre el fichero:
- **cat mitesoro.yml**

Aparece algo como esto:

````text
$ANSIBLE_VAULT;1.1;AES256
30386536393230386530636436396265386332356263623363323638323266376461313966383061
6665626333333536633033356132613063366166656337610a653335393761613666646665336337
36623466323239396238363365393865323265396537636233376666383437636234653663343335
6233396461303462640a373730326465383361343439393464613064623330663230616537353234
35393730653762383139666265633164333630333331376232663530363761396434
````

Para volver a ver el original:
- **ansible-vault view mitesoro.yml**

Pedirá una contraseña y después se puede volver a ver el archivo.

Si ya existiese el fichero, no habría que usar **create** sino **encrypt**: 
> Creamos el fichero si no existe. 
- **ansible-vault encrypt ./group_vars/all.yml**

Nos pedirá la contraseña y la confirmación

Encrypt puede cifrar varios ficheros a la vez

También podemos editar un archivo cifrado 
- **ansible-vault edit mitesoro.yml**

### 2. Usar Ansible Vault en un playbook

Si tenemos un playbook que necesite acceder a algún fichero cifrado con Ansible Vault, al ejecutarlo: 
- **ansible-playbook ejemplovault.yml**

Dará el error:
- **ERROR!Attempting to decrypt but no vault secrets found**

La razón del error es que el archivo está encriptado y necesita una contraseña para acceder a los datos, sin embargo, no le dijimos a Ansible cómo obtener la contraseña.

Podemos por tanto:
  - Solicitar la contraseña durante la ejecución del playbook
  - Especificar la ubicación del archivo de contraseña durante la ejecución del playbook
  - Especificar la ubicación en el fichero **ansible.cfg**

#### Solicitar la contraseña durante la ejecución del playbook:
- Basta con escribir **--ask-vault-pass** tras la ejecución del playbook

````bash
ansible-playbook mitesoro.yml --ask-vault-pass
````

#### Usar Ansible Vault con un archivo de contraseña:
- Este archivo de contraseña debe protegerse mediante los permisos de la máquina y mantenerlo fuera de repositorios de Git y del alcance de indeseables. El fichero solo necesita tener la contraseña
- Tras estas medidas se puede especificar así:

````bash
ansible-playbook mitesoro.yml --vault-password-file vault-pass.txt
````

#### Especificar la ubicación en el fichero ansible.cfg
- Se puede especificar la ubicación de este archivo de contraseña en el fichero de configuración ansible.cfg
```bash
vault_password_file = vault-pass.txt 
```

### 3. Cambiar la contraseña de archivos ya cifrados

Si ya no se desea que el archivo esté cifrado (que no es lo mismo de querer comprobar el contenido con view), se puede desencriptar con:

```bash
ansible-vault decrypt mitesoro.yml
```
- Preguntará por la contraseña utilizada originalmente y el fichero será desencriptado.

Si lo que queremos es cambiar la contraseña, utilizaremos **rekey**:
````bash
ansible-vault rekey mitesoro.yml
````

Y nos pedirá la contraseña original y la nueva

### 4. Cómo ocultar la salida de un playbook que utiliza secretos.

Ansible Vault SOLO protege los 'datos en reposo’.

Una vez que el contenido está descifrado ('datos en uso'), los autores de playbooks y complementos son responsables de evitar cualquier divulgación secreta.

Una de las acciones más sencillas pero eficaces es no mostrar salida en las operaciones que impliquen secretos. Para ello, en las tareas utilizamos **no_log : true**

También podemos usar **no_log** en una jugada al completo.

Ejemplo de no_log en tareas

````yaml
--- 
- name: Prueba ejecucion encriptada
  hosts: nodo1
  no_log: True
  vars:
    secret_value: abcd1234
  tasks:
    - name: secret task
      shell: /usr/bin/do_something --value={{ secret_value }} 
      no_log: True
      register: salidavacia
    - name: mostrar
      debug: 
        msg: "{{ salidavacia }}"
# La ejecución devolverá erroy porque los datos están censurados. 
````

Podemos ejecutarlo encriptando el fichero

````bash
ansible-vault encrypt prueba.yml # Ponemos la contraseña deseada. 
````

Para ejecutar un fichero encriptado, recordamos: 
````bash
ansible-playbook prueba.yml --ask-vault-pass
````

## Otros problemas con ficheros de contraseñas

La problemática de los ficheros de contraseñas.

A pesar de que los datos están cifrados, y seguros, sabemos que las contraseñas que utilizamos son el problema.

Para hacer una buena gestión de estos ficheros, primero debemos elegir entre 1 sólo fichero para todas las contraseñas o varios ficheros según las necesidades.
- En sistemas pequeños conviene la primera opción
- En sistemas grandes conviene tener varios ficheros, ya sea para diferentes niveles de acceso, diferentes usuarios, diferentes entornos (dev y prod), etc.

Si se usan varias contraseñas de bóveda, se pueden diferenciar con un ID de bóveda.

Este ID se puede usar de dos maneras:
- Pasándolo con **--vault-id** cuando se utiliza el comando **ansible-vault** al crear el contenido encriptado.
- Pasarlo directamente al playbook con **--vault-id** al ejecutarlo.

Un Id debe tener un formato:
````yaml
--vault-id label@source
````

Por ejemplo:

````bash
# DEBEMOS CREAR UN FICHERO LLAMADO password_file CON LA CONTRASEÑA QUE QUERAMOS. 

# Esto nos crea una variable que se llama mi secreto y codifica el rultado. 
ansible-vault encrypt_string --vault-id password_file 'abcd1234' --name 'mi_secreto'

# Si el fichero está por ejemplo dentro de una carpeta llamada dev lo llamaríamos así:
ansible-vault encrypt_string --vault-id dev/password_file 'abcd1234' --name 'mi_secreto'
````

En este ejemplo se ha cifrado la cadena abcd1234 con la contraseña de bóveda “dev” almacenada en fichcontra y a la variable cifrada se la llama 'mi_secreto'

Otro ejemplo:

````bash
ansible-vault encrypt_string --vault-id dev@password_file --stdin-name 'mi_secreto'
````

En este ejemplo **se pedirá una cadena a cifrar** que se cifrará con la contraseña de bóveda “dev” almacenada en fichcontra y a la variable cifrada se la llama ‘mi_secreto’

Lo único a tener en cuenta es que no se pulse ENTER para acabar, sino ctrl-d

Ejemplo de --vault-id al crear un archivo de datos cifrado:

````bash
ansible-vault create --vault-id dev@password_file fichero.yml

# Para ver el fichero usar ansible-vault view
````

Esto lanzará el editor por defecto para introducir las variables a cifrar. Cuando cierra la sesión del editor, el archivo se guarda con datos cifrados. El encabezado del archivo reflejará el ID de la bóveda que se usó para crearlo.


También podríamos usar --vault-password-file para encriptar el fichero. Donde password_file es el nombre del fichero a encriptar.
````bash
ansible-vault encrypt_string --vault-password-file password_file 'foobar' --name 'the_secret'

# foobar es el contenido del fichero
# the_secret es el valor de la variable 
# La contraseña está en el ficheor password_file. 
````

En los ejemplos anteriores hemos visto como podemos encriptar una variable, ahora vamos a ver como usarla. 

Por ejemplo en el siguiente playbook mostramos el contenido de una variable my_secret:

````yaml
---
- name: secure a variable demostrate
  hosts: nodo1
  vars:
    my_secret: P@ssword123
 
  tasks:
    - name: Print a secure variable
      debug:
        var: my_secret
````

Si lo que queremos es encriptar la variable ejecutaríamos el siguiente comando:

````bash
ansible-vault encrypt_string --vault-id password_file "P@ssword123" --name "my_secret"
````

El resultado será algo así:

````txt
my_secret: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          39653932303765613963373330393365383262393963616364346462313538373439393961376534
          6330356136356330326337636664643835646630316331330a383033353561363863326337643933
          38666436656136633031663135353631386366356461326636363463356564373132633562636365
          6434313434303466360a363236303965636632643035656232383963366438663062363565353962
          6630
Encryption successful
````

Ahora tendremos que copiar este resultado en el playbook:

````yaml
---
- name: secure a variable demostrate
  hosts: nodo1
  vars:
    my_secret: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          39653932303765613963373330393365383262393963616364346462313538373439393961376534
          6330356136356330326337636664643835646630316331330a383033353561363863326337643933
          38666436656136633031663135353631386366356461326636363463356564373132633562636365
          6434313434303466360a363236303965636632643035656232383963366438663062363565353962
          6630
 
  tasks:
    - name: Print a secure variable
      debug:
        var: my_secret
````

Para ejecutar el playbook usaríamos el siguiente comando:

````bash
# ejemplo.yml es el nombre del playbook, aquí podríais vuestro nombre usado
ansible-playbook ejemplo.yml --ask-vault-pass
````

# Pre y Post Task 

## Pre-Task
 
Las **Pre-Task** son bloques de ejecución condicional que se ejecuta **antes** de ejecutar la Jugada. Puede ser una 

tarea con algunos requisitos previos de verificación (o) validación.
- Por ejemplo instalar dependencias antes de ejecutar aplicaciones.
- Validación de si un entorno cumple con lo requisitos antes de instalar un software.
- Configurar claves SSH antes de iniciar sesiones
- Aprovisionamiento de creación un usuario, grupo, etc.

Un ejemplo:

````yaml
---
- hosts: all
  become: true
  pre_tasks:
    - name : instala dependencias antes de comentar
      register: aptinstall
      apt:
        name:
          - nodejs
          - npm
          - git
        state: latest
        update_cache: yes
    - name : validar la instalacion de nodejs
      debug: msg="Instalación correcta"
      when: aptinstall is changed
````

## Post-Task

Las **Post-Task** son bloques de ejecución condicional que se ejecuta **después** de ejecutar la Jugada.
  - Validación de instalaciones
  - Notificaciones por correo o por Slack
  - Iniciar aplicaciones tras su instalaciones y configuraciones.

````yaml
---
- hosts: all
  become: true
  post_tasks:
    - name: notificar via Slack que se ha actualizado el server
      tags: slack
      community.general.slack:
        token: T026******PF/B02U*****N/WOa7r**********Ao0jnWn # Tendríamos que añadir el token de acceso de slack
        msg: |
          ### StatusUpdate ###
          --------------------------------------
          ``
          `Server : {{ansible_host}}
          `Status : NodeJS Sample Application installed successfully
          --------------------------------------
        channel: '#ansible'
        color: good
        username: 'Ansible on {{inventory_hostname }}'
        link_names: 0
        parse: 'none'
      delegate_to: localhost
````

````yaml
# Notificar via email. 
post_tasks:
  - name: notificar via email
    mail:
      host: smtp.gmail.com
      port: 587
      username: mail@example.com
      password: “{{ passsecret }}”
      from: SYSTEM
      to: example <mail@example.com>
      subject: Ansible-Report Apache Web Server restarted 
      body: |-
        Apache Web Server restarted in:
        {% for item in ansible_play_hosts_all %}
        - Server: {{item }}
        {% endfor %}
      delegate_to: localhost
      run_once: true
````

# Git con Ansible

Ansible funciona sin problemas con Git, pero sí que hay que tener en cuenta temas de seguridad

![](img/Ansible_03_Git.png)


El módulo git de Ansible se usa para extraer un código fuente de un repositorio para su posterior implementación en el servidor.
  - Extraer, descargar el código del repositorio de Git.
  - Crear un archivo de Git desde el repositorio
  - Obtener todas las Pull Requests
  - Clonar un repositorio. 

Tras descargar el código del repositorio, y teniendo instalado git se pueden usar los comandos regulares de del propio git.


Pero si tenemos que descargar de un repositorio privado, necesitaremos alguna forma de iniciar sesión en el repositorio (ya sea Github, Gitlab, etc) desde la CLI de Git.

## 1. Configurar el inicio de sesión de Git

Hay varias formas de iniciar sesión. De la más recomendable a menos:
  - Uso de clave SSH. Previa configuración de una clave SSH para nuestro repositorio: [https://docs.github.com/en/enterprise/2.15/user/articles/adding-a-new-ssh-key-to-your- github-account](https://docs.github.com/en/enterprise/2.15/user/articles/adding-a-new-ssh-key-to-your-github-account)
  - Uso de nombre de usuario y token en la URL <https://user:token@github.com/path>

En el siguiente ejemplo haremos un clone del nodo1 ene ste repositorio. . Para ejecutarlo hay que seguir los siguientes pasos:

Generación del fichero yaml:

````yaml
---
- name: Clone de un repositorio GIT vía SSH
  hosts: nodo1
  tasks:
      - name: Clone del repositorio GIT
        git:
            repo: git@github.com:isotomor/thebridgecdptenero23.git # Aquí deberéis poner el repo que estamos usando
            dest: /home/otrou/repos/thebridgecdptenero23
            accept_hostkey: true
````

- **accept_hostkey**  - Es necesario ya que acepta automáticamente la clave SSH del host remoto.  

Antes de la ejecución es importante tener en cuenta una cosa. La primera es que si en el fichero ansible.cfg tenemos
puesto la conexión con become, nos puede dar errores porque intentará descargar el repo en modo sudo. 

Para esta ejecución es recomendable comentarlo pero en la ejecución del fichero deberemos poner -K para que nos pida 
la contraseña del usuario en curso.

Ejecución del playbook

````bash
ansible-playbook ejemplo_git.yml -K
````

Otra forma sería ponerlo en el ansible.cfg, solo la solicitud de la contraseña:

````buildoutcfg
[privilege_escalation]
become_ask_pass = True
````

Si aun así nos falla es posible que tengamos que agregar la ruta del id_rsa al almacen en el agente SSH. 
Para ello ejecutanmos en el nodo1 el siguiente comando.

````yml
ssh-add /ruta/a/tu/clave/ssh
````

Para coger estos cambios se debe añadir también en el invent.txt el siguiente comando: 

````buildoutcfg
[ssh_connection]
ssh_args=-o ForwardAgent=yes
````

Para utilizar SSH con git, este artículo: 
- ***https://mahmudasif.com/atomic/***

### Lab
Es hora de probar por tu cuenta. Realiza esta conexión SSH y a hacer un clone del repositorio con la opción del token.

# Roles en Ansible

Los roles permiten crear un playbook con la mínima configuración y definir toda la complejidad y lógica de las acciones a más bajo nivel.

Un rol carga automáticamente vars, archivos, tareas, handlers y otros artefactos de Ansible relacionados en función de una estructura de archivo conocida.

Agrupar todo así ayuda a la reutilización y a compartir contenido.

Para garantizar la reutilización tienen una estructura muy determinada que permite a Ansible estandarizar el concepto Rol.

Los roles sólo se ejecutan una vez en un playbook.

Existe dos formas de crear la estructura de carpetas y subcarpetas.
- De forma manual
- Utilizando Ansible-Galaxy

## 1. Estructura de un Rol:

Una carpeta de rol, tiene como mucho 8 directorios diferentes, aunque como mínimo debe tener 1.

Cada directorio albergará un archivo relevante en un fichero main.yml, main.yaml o simplemente main que Ansible buscará.

Las carpetas son:
- **tasks, handlers, library, files, templates, vars, defaults y meta**

**tasks/mail.yml**
  - Es la lista principal de tareas que ejecuta el rol.

**handlers/main.yml**
  - Haldlers que se puedan utilizar en este rol.

**library/mi_modulo.py**
  - Módulos Python que puedan ser necesarios para la correcta ejecución de este Rol. Este punto es el menos añadido a los roles.

**defaults/mail.yml**
  - Variables globales predeterminadas para el rol. Son las de más baja precedencia, por lo que pueden ser modificadas en el propio código del playbook

**vars/main.yml**
  - Tiene la misma función que defaults y se usa para almacenar variables. Las que se definen en vars tienen más prioridad que las definidas en defaults.

**files/main.yml**
  - Archivos que despliega el rol. Estos ficheros no se pueden modificar y serán copiados tal cual a los hosts remotos. (código fuente, un .rpm, etc)

**templates/mail.yml**
  - Aunque se parecen a los files, éstos sí que admiten modificaciones. Podemos pasar variables de configuración al template para que este lo aplique a los hosts, utilizando la notación jinja2.

**meta/main.yml**
  - Metadatos para el rol, incluidas las dependencias del rol. Describen el entorno (Sistema Operativo, versión, autor, licencia, etc)

El hecho de que hayamos visto sólo main.yml en la mayoría de las carpetas, no quiere decir que sólo pueda existir ese main. Ya que se pueden agregar ficheros de tareas que se importarán con **import_task** o ficheros de playbooks que se ejecutarán con **import_playbook**

Por defecto Ansible busca roles en una carpeta **roles/** que cuelgue del directorio de trabajo que estemos utilizando

O bien, en **/etc/ansible/roles** (no recomendado)

Si fuera necesario ubicar los roles en otro lugar, habría que modificar la propiedad **roles_path** en el fichero de configuración.

Por último, podemos llamar a un rol con una ruta absoluta en el propio playbook: ---
````yaml
- name: ejemplo playbook con roles
  hosts: webservers
  roles:
    - role: '/home/usuario/ansible2/roles/mirol'
````

Si queremos crear un role mediante ansible-Galaxy, tendremos que ejecutar el siguiente comando en nuestra carpeta roles de nuestro directorio de trabajo
````bash
ansible-galaxy init webservers
````

Esto crea la estructura de carpetas y ficheros que ya hemos visto.

## 2. Usar roles

Se pueden utilizar **a nivel de jugada**, con la opción roles, como hemos visto anteriormente.

Es la forma original y clásica de hacerlo.

Como ya hemos visto, cuando Ansible se encuentra una carpeta rol, se añaden a la jugada las tareas, los handlers las vars, y las dependencias existentes.

Ansible los trata como importaciones estáticas y los procesa en el análisis del playbook.

Se pueden utilizar **a nivel de tareas, de forma dinámica**. Incluso a partir de una condicional

En este caso se utiliza include_role:

````yaml
---
- hosts: webservers
  tasks:
    - name: Imprime un mensaje 
      ansible.builtin.debug:
        msg: “Esta tarea se ejecuta antes del rol"
        
    - name: Incluye el rol 
      include_role:
        name: ejemplo
    - name: Imprime el mensaje 
      ansible.builtin.debug: 
        msg: “Esta tarea se ejecuta después del rol"
````

La última forma es utilizar roles con reutilización estática.

Se puede utilizar cualquier parte de la sección tasks utilizando import_role.

````yaml
---
- hosts: webservers
  tasks:
    - name: Escribe un mensaje 
      ansible.builtin.debug:
        msg: “Antes de lanzar el rol"
        
    - name: Importa el rol 
      import_role:
        name: example
    
    - name: Escribe un mensaje 
      ansible.builtin.debug: 
        msg: “Después de lanzar el rol"
````


## 3. Roles en Ansible

A pesar de que podemos definir nuestros propios roles, el hecho de que exista una gran comunidad llamada Ansible Galaxy ha hecho que el uso de roles se haya extendido bastante.

En el siguiente ejemplo vamos a realizar la búsqueda del Rol de MySql y vamos a ver qué fácil lo pone la comunidad para poder .

Lo primero es irnos a la página de Ansible galaxy

![](img/Ansible_03_Module_galaxy_01.png)

Escogemos Databases y nos muestra

![](img/Ansible_03_Module_galaxy_02.png)

Buscamos mysql y escogemos una. A ser posible la que tenga una documentación mejor elaborada

![](img/Ansible_03_Module_galaxy_03.png)

Ahora, el proceso de instalación y uso es casi siempre similar:

Instalamos el rol:

```bash
ansible-galaxy install geerlingguy.mysql
```

El rol se guarda en la carpeta: **.ansible/role** que nos habrá creado en nuestro directorio home.

Ahí podríamos ver y estudiar qué es lo que plantea el rol.

Los siguiente es crear el playbook que va a ejecutar el rol y crear lo necesario para establecer algunas variables necesarias (todo según la documentación que nos aporte el rol)

Creamos el playbook:

````yaml
- name: Instalar mysql
  hosts: nodo1
  become: yes
  vars_files:
    - defaults/main.yml
  roles:
    - {role: geerlingguy.mysql }
````

En este caso, vamos a utilizar un fichero en una carpeta vars como datos para nuestra instalación.

Creamos la carpeta vars en nuestro directorio de trabajo:

````bash
mkdir defaults

cd defaults
````

Y ahora escribimos el main.yml que va a consistir en la contraseña de root: 
````bash
nano main.yml
````

mysql_root_password: “abcd1234"

Volvemos a nuestro directorio de trabajo

````bash
cd ..
````

Y lanzamos el playbook **mysql.yml**:

````bash
ansible-playbook mysql.yml -K
````

El resultado será que se habrá instalado mysql en el nodo1 sin más.

Podríamos añadir al fichero defaults/main.yml, algunas bases de datos y usuarios:

````yaml
mysql_root_password: "abcd1234"
mysql_databases:
  - name: myshop
    encoding: latin1
    collation: latin1_general_ci
  - name: sysbench
    encoding: latin1
    collation: latin1_general_ci
mysql_users:
  - name: myshop_user
    host: "%"
    password: mySh0pPassw0rd
    priv: "myshop.*:ALL"
  
  - name: sysbench_user
    host: "192.168.174.%"
    password: sysBenchPassw0rd 
    priv: "sysbench.*:ALL"
````

Guardaríamos y ejecutaríamos de nuevo el playbook para que los cambios a vars/main.yml surtan efecto:

````bash
ansible-playbook mysql.yml -K
````

Y ahora comprobaríamos:

```bash
ssh nodo1

sudo mysql -u root -p -e 'SHOW DATABASES'
```

Por último, indicar que a veces no se instala directamente con el nombre del rol: (ansible-Galaxy collection install <<usuario>>.<<rol>>

Sino que se utiliza esta estructura:

````bash
ansible-galaxy collection install -r requirements.yml
````

Donde el fichero requirements.yml tiene este aspecto:

````yaml
---
collections:
  - name: community.grafana
    version: 1.2.0
````

Esto nos permitiría instalar varios roles a la vez

# Lab 01 -Instalar Chocolatey

Vamos a instalar el rol de **Chocolatey** o de **nginx**

Para ello hay que buscarlo en el Ansible-Galaxy y seguir las indicaciones para ello.

Está en la sección **Packages**

**Nginx** en la sección

# Ansible Tower

[Ansible Tower](https://www.ansible.com/) es una herramienta Ansible a nivel empresarial.

Está basada en web para administrar una organización con una interfaz de usuario muy fácil que proporciona un tablero con resúmenes de estado de todos los hosts.

Permite implementaciones rápidas y monitorea todas las configuraciones.

**Tower** también permite compartir credenciales SSH sin exponerlas, registrar todos los trabajos, administrar inventarios gráficamente y sincronizarlos con una amplia variedad de proveedores de cloud.

Al ser propietaria, y de **Red Hat**, la herramienta ha ido perdiendo compatibilidad con las versiones Ubuntu de Linux para centrarse en las versiones de Red Hat Linux ( Red Had Enterprise Linux, CentOS, etc)

También se necesita mínimo arquitectura 64 bits, 4GB de RAM,la última versión de Ansible y una cuenta en Red Hat.

**Características**

![](img/Ansible_03_Características.png)

Panel de Ansible:
  - Muestra todo lo que sucede en su entorno de Ansible, como hosts, estado del inventario, actividad laboral reciente, etc. 

Actualizaciones en tiempo real:
  - Se pueden ver todas las actualizaciones que va realizando Ansible en tiempo real, playbooks, tareas desglosadas por máquina.
  - Muestra tanto las que han tenido éxito como las que han fallado.
  - También muestra que falta por realizar en la cola de trabajos.

Flujos de trabajo:
  - Se pueden encadenar la ejecución de cualquier número de playbooks, independientemente del uso de diferentes inventarios, utilizar varias credenciales o ejecutar diferentes usuarios.

Escalado:
  - Se pueden conectar varios nodos de Ansible Tower en un clúster de Ansible Tower.
  - Los clústeres agregan redundancia y capacidad, lo que le permite escalar la automatización de Ansible en toda la empresa. 

Administración de inventario:
  - Ansible Tower ayuda a administrar toda la infraestructura permitiéndo extraer fácilmente el inventario de proveedores de nube pública como Amazon Web Services, Microsoft Azure, etc.

API REST:
  - Todas las funciones de Ansible Tower están disponibles a través de una API REST que proporciona la API ideal para una infraestructura de gestión de sistemas.
  - La herramienta CLI de Ansible Tower está disponible para iniciar trabajos desde sistemas CI como Jenkins, o cuando necesite integrarse con otras herramientas de línea de comandos.

Ejecución remota
  - Como Ansible que es, permite toda la funcionalidad que permite Ansible..

## Instalación

Actualmente Ansible Tower ha modificado su nombre a Red Hat Ansible Automation, preparada para su instalación en Red Hat Enterprise Linux, o CentOS y con acceso a los servicios de Red Hat Ansible Automation Platform

Aparte de tener instalada la última versión de Ansible es necesario tener instalado PostgreSQL.
  - Nota: Esto ya no es tanto así, porque las ultimas versiones de Tower ya presintalan PostgreSQL

El proceso es muy sencillo, se descarga el fichero, se descomprime y se lanza un playbook que trae el propio ansible tower.
  - Nota: No se puede instalar Tower salvo en CentOS superiores a 7.9 y RHEL de Red Hat, En Ubuntu, hasta la 16.04

![](img/Ansible_03_Ansible_Tower_01.png)

### Creación de un usuario:

Pulsamos en Settings, Users y Create User.

Una vez en la pestaña de Usuario, Pulsamos Add para crear un nuevo usuario. Introducimos los datos y pulsamos Guardar:

![](img/Ansible_03_Ansible_Tower_02.png)

### Creación de un inventario:

Ahora en Inventories, pulsamos Add.

![](img/Ansible_03_Ansible_Tower_03.png)

Introducimos los detalles como el nombre, descripción, organización, y pulsamos Guardar.

![](img/Ansible_03_Ansible_Tower_04.png)

### Creación de un hosts a un inventario:

Para añadir un host, en la pestaña Inventarios se elige el inventario al que se desea agregar hosts.

Tras esto se elige la pestaña Hosts y se hace clic en Add Hosts.

Una vez que se rellenan los campos, pulsamos Guardar .

![](img/Ansible_03_Ansible_Tower_05.png)

Tras crear el host, se va a añadir una credencial.

Para ello, vamos a Settings, Credentials, y pulsamos Add. Rellenamos lo necesario y pulsamos Guardar

![](img/Ansible_03_Ansible_Tower_06.png)

### Acceso a un playbook:

Hay dos formas de acceder a un playbook sencillo. De manera manual o especificando un enlace desde un repositorio de GitHub.

En este caso lo vamos a realizar de manera manual:
- Primero hay que crear un playbook y luego configurar el proyecto.
- Por defecto, el directorio base del proyecto está en /var/lib/awx. En él podemos crear una carpeta y dentro el playbook.

En este caso lo vamos a realizar de manera manual:
  - Para configurar el proyecto, vamos a pinchar en Projects y dentro pulsamos en Add

![](img/Ansible_03_Ansible_Tower_07.png)

En este caso lo vamos a realizar de manera manual:
  - Una vez que se haya pinchado en Add, nos dirige a una página donde deberá completar detalles como el Nombre y la Descripción del Proyecto. Luego, configuramos el tipo de SCMen Manual, y para el Directorio de Playbook, seleccionamos un valor que corresponda al subdirectorio que creó, luego hacemos clic en Guardar .

En este caso lo vamos a realizar de manera manual:

![](img/Ansible_03_Ansible_Tower_08.png)

En este caso lo vamos a realizar de manera manual:

Y ya por último, vamos a pulsar en Templates, para añadir una con el botón Add, que nos volverá a dirigir a una página donde se completarán el Nombre, el inventario, el proyecto, los playbooks y las credenciales.

Una vez rellenado todo, al volver a la pantalla de Templates, si queremos lanzar el proyecto, pulsamos en el icono del cohete.

![](img/Ansible_03_Ansible_Tower_09.png)

![](img/Ansible_03_Ansible_Tower_10.png)

Ya podríamos lanzar cualquier playbook a cualquier nodo administrado