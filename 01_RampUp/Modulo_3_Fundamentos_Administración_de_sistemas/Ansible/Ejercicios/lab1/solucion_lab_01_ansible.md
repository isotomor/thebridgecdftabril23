# Solución Ejercicio Lab 1 Ansible

Aquí se va a comentar la resolución del ejercicio Lab 1 Ansible. 

1 .Vamos a crear un nuevo nodo administrado que llamaremos nodo2 y con un nuevo usuario que se llame otrou a partir de 
la máquina original. Tiene que ser accesible por ansible como hemos hecho con nodo1. Realizar todos los pasos necesarios

Como se ha visto en el temario, realizaremos un clone del nodo1, cambiando la red para que sea distinta a la 1 y 2. por ejemplo 192.168.0.103. 

2. Se deberá crear un usuario llamado otrou. 

Para ver como crearlo consultar el bloque Usuario dentro de la documentación de ansible.

3. Crear un proyecto nuevo que se llame ansible2
````bash
cd $HOME

mkdir ansible2

````
 
4. Crear un fichero de inventario inven2.txt donde tengamos dos grupos, uno llamado dev que alberga al nodo1 y otro llamado test que alberga al nodo2

````bash
nano invent2.txt
````

````text
[dev]
nodo1

[test]
nodo2 ansible_user=otrou
````

5. Crea un nuevo fichero de configuración ansible.cfg para utilizar escalado de privilegios, que especifique el nuevo usuario que tiene nodo2, que diga cómo se llama el nuevo fichero de inventario y que defina forks como 4. El resto de propiedades pueden ser las mismas.

````bash
nano ansible.cfg
````

````text
[defaults]
inventory = invent2.txt
remote_user = otrou 
interpreter_python = /usr/bin/python3
host_key_checking = False 
deprecation_warnings = False
forks = 4

[privilege_escalation]
become = true
become_method = sudo
become_ask_pass = True
become_user = root
````

5. Escribe el **comando que nos permita instalar nginx en el nodo2**. <https://docs.ansible.com/ansible/2.8/modules/apt_module.html#apt-module>

````bash
ansible nodo2 -m apt -a 'name=nginx state=present update_cache=yes' -b -K
````

Así sería con un ansible-playbook que veremos más adelante. 
````yaml
- name: Instalar en gcp
  hosts: new_instances
  become: yes
  become_method: sudo
  tasks:
  - name: Instalamos nginx
    apt:
      name: nginx
      state: latest
      update_cache: yes
````

