![](../../img/TheBridge_logo.png)

# Terrafrom 
***

![](img/Terraform_logo.png)

# Índice 
***

- [Pre-requisitos](#pre-requisitos)
- [¿Qué es Terraform?](#que-es-terraform)
  - [Conceptos Iniciales](#conceptos-iniciales)
- [Infraestructura con Terraform](#instraestructura-con-terraform)
  - [Crear un servidor en EC2](#crear-un-servidor-en-ec2)
  - [Terraform provider vs Terraform Resource](#terraform-provider-vs-terraform-resource)
  - [Terraform State](#terraform-state)
  - [Otros Ficheros](#otros-ficheros)
  - [Terraform Outputs](#terraform-outputs)
  - [Load Balancer](#load-balancer)
- [Infraestructura Reutilizable](#infraestructura-reutilizable)
  - [Variables Terraform](#variables-de-terraform)
  - [Tipado dinamico variables](#tipado-dinamico-variables)
  - [Variables: Mapas y validaciones](#variables-mapas-y-validaciones)
  - [Bucles y Meta-Argumentos](#bucles-y-meta-argumentos)
  - [Count](#count)
  - [For-each](#for-each)
  - [Cuando usar Count o For-each](#cuando-usar-count-o-for-each)
  - [Expresiones for](#expresiones-for)
  - [Expresiones splat](#expresiones-splat)
  - [Variables local](#variables-local)
  - [Refactorizar Load-Balancer](#refactorizar-load-balancer)
  - [Modulos](#modulos)
  - [Entornos](#creacion-de-dos-entornos-desarrollo-y-produccion)
- [Terraform State](#terraform-state)
  - [¿Qué es Terraform State?](#que-es-terraform-state)
  - [Almacenar el estado en Git](#almacenar-el-estado-en-git)
  - [Terraform backend](#terraform-backend)
  - [Backend en S3](#backend-en-s3)
  - [Terraform Cloud](#terraform-cloud)
  - [Terraform Workspaces](#terraform-workspaces)
  - [Terraform Graph](#terraform-graph)
  - [Importar Infraestructura](#importar-infraestructura)
  - [Renombrar servidor](#renombrar-un-servidor)

# Pre-requisitos
***

### Instalación de Terraform

Tendremos que instalar Terraform según nuestro sistema operativo, para ello pinche [aquí](https://developer.hashicorp.com/terraform/downloads)

### Instalar un IDE (Visual Studio Code)

Para este módulo usaremos el IDE de Visual Studio Code, aunque se puede usar el IDE con el que trabajemos más cómodos.

También tendremos que tener instalado la extención para terraform, usaremos ```HashiCorp Terraform```

![img.png](img/extension_terraform_vsc.png)

### Crear cuenta de Amazon AWS

Llegados a este punto tendríamos que tener una cuenta de AWS creada, aunque de no ser así puede crearla 
siguiendo la siguiente guía [Creación de cuenta AWS](https://repost.aws/es/knowledge-center/create-and-activate-aws-account)

### Configurar AWS CLI

Tendremos que tener instalado AWS CLI, si no lo lo tienes sigue esta guía [Instalación Amazon CLI](https://docs.aws.amazon.com/es_es/cli/latest/userguide/getting-started-install.html)


# ¿Que es Terraform?

Terraform es una herramienta de infraestructura como código que le permite crear, cambiar y crear versiones de recursos 
locales y en la nube de forma segura y eficiente.

Codifica las API de las distintas nubes en archivos de configuración declarativos.

- Terraform utiliza HCL, (HashiCorp Configuration Language)

Es lo que comúnmente se llama Infraestructura como código

![img.png](img/que_es_terraform.png)

Reduce el error aumentando la automatización al aprovisionar la infraestructura como código.

Se puede utilizar una estructura de código semejante sea cual sea la nube o infraestructura que se pretenda automatizar.

Permite crear entornos de pruebas, test y producción con la misma configuración de una forma rápida.

Actualmente podemos trabajar con Terraform de varias formas:

- **CLI**: Herramienta instalable que nos permite aplicar los cambios a una infraestructura. Descargar la CLI es totalmente gratuito.
- **Terraform** Cloud: Un entorno integrado que facilita la utilización de Terraform, que permite un fácil acceso a datos
secretos y de estado compartidos, controles de acceso para aprobar cambios en la infraestructura, un registro privado para compartir módulos de Terraform, controles de políticas detallados para controlar el contenido de las configuraciones de Terraform
- **Terraform Enterprise**: Es semejante a Terraform Cloud, pero que permite a las empresas disponer de una instancia 
privada de Terraform Cloud, sin restricciones.

## Conceptos iniciales

Como en todo producto, es necesario conocer los distintos conceptos asociados:

**Infraestructura como código (IaC)** es la práctica de administrar la infraestructura en un archivo o archivos en lugar 
de configurarla manualmente a través de una interfaz de usuario.
- Los tipos de recursos de infraestructura administrados con IaC pueden incluir máquinas virtuales, grupos de seguridad, 
interfaces de red y muchos otros.

**Provider**: un proveedor es una serie de plugins para  interactuar con proveedores de la nube, proveedores de SaaS y otras API.
- Cada proveedor agrega un conjunto de tipos de recursos y/o fuentes de datos que Terraform puede administrar.

**Recurso**: es el elemento más importante en el lenguaje Terraform. Cada bloque de recursos describe uno o más objetos 
de infraestructura, como redes virtuales, instancias de máquinas o componentes de nivel superior, como registros DNS, etc

**Terraform Registry**: Un repositorio de módulos escritos por la comunidad de Terraform, que se puede usar tal cual dentro 
de una configuración de Terraform o bifurcarse y modificarse.

- El registro puede ayudar a comenzar con Terraform más rápidamente, ver ejemplos de cómo se escribe Terraform y encontrar módulos prefabricados para los componentes de infraestructura que necesita.
- Tiene dos grandes partes: Providers y Modules
- Nos proporciona ejemplos de uso de cada recurso por cada provider.

![img.png](img/terraform_registry.png)

**Pasos en un aprovisionamiento**: Terraform divide el aprovisionamiento de infraestructura en una serie de pasos muy sencillos:

- Escribir los archivos de configuración de Terraform
- Creación del fichero(s) .tf de aprovisionamiento.
- Lanzamiento de comandos:

  - **terraform init**: se utiliza para inicializar un directorio de trabajo que contiene archivos de configuración de Terraform. Es el primer comando
  - **terraform validate**: se utiliza comprobar si los ficheros aportados son correctos.
  - **terraform plan**: permite obtener una vista previa de los cambios antes de aplicarlos. Así como un documento de trabajo.
  - **terraform apply**: sirve para realizar los cambios a la infraestructura. Estos cambios se aplican teniendo en cuenta qué se dispone en la infraestructura, sin duplicar ni reescribir elementos ya creados.
  - **terraform show**: muestra el estado actual de la infraestructura. Hay que tener siempre en cuenta que esta puede estar desactualizada.
  - **terraform destroy**: es el comando inverso al anterior. Elimina toda la infraestructura creada con un comando apply

**Plan de ejecución**: Es realmente el cambio que se realiza en los recursos teniendo en cuenta, el código creado y el estado en el que se encuentra nuestra cuenta cloud.

**Estado deseado**: Es el estado en el que debe quedar la infraestructura tras la aplicación del Plan de Ejecución. Esto implica que si, la infraestructura cambia, sólo se aplicarán los cambios que permitan llegar a ese Estado deseado


# Instraestructura con Terraform
***

## Crear un servidor en EC2
***

> :nota: Nota: Los bloques de cógido son acumulativos y se agruparán en el fichero [main.tf](Ejemplos/01-mi-primer-servidor/main.tf).

### Acceder a la consola de Amazon AWS 

Pinchando [aquí](https://aws.amazon.com/es/console/) puede acceder a la consola de AWS

Una vez dentro accederíamos a la creación de instancias de EC2. 

### Creación de carpeta y fichero terraform 

Desde la terminal, creamos una carpeta donde haremos los ejercicios. 

````bash
mkdir Terraform
cd Terraform

mkdir mi-primer-servidor
cd mi-primer-servidor

nano main.tf
````

### Instanciar el provider de AWS

El provider en este ejemplo será el pluggin de terraform que nos permite acceder a la API de AWS. 
Por lo tanto si vamos a trabajar en AWS necesitaríamos el provider de AWS, si por lo contrario trabajásemos con Google 
Cloud Platform, necesitaríamos el de Google.

Para saber como funciona el provider de AWS podemos ir a la documentación oficial de Terraform

- [Documentación Oficial Provider AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

Ahora vamos a escribir el provider de AWS, este nos pide un argumento de forma obligatoria, y es la región: 

````terraform
provider "aws"{
  region="eu-west-3"
}
````

### Diferentes métodos de autenticación

Provider a través de la API se va a conectar a AWS, pero para conectarnos a AWS necesitaremos un método de autenticación.

En la siguiente página puedes consultar cuales son todos los [métodos de autenticación de AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration)

Aquí veremos dos: 

- Usando un código y clave de acceso en el provider de AWS, tendríamos que poner el access_key y el secrect_key de la 
cuenta de IAM de AWS. El problema es que pondríamos las claves de acceso visibles para todo el mundo que tenga acceso al 
fichero generado. La forma de implementar este método sería en el provider de AWS: 

````terraform
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
````

- Usando el fichero de credenciales de AWS. Este lo tendremos que configurar si no lo hemos hecho con ``aws configure``
y nos generará las claves de acceso en la ruta ``~/.aws/credentials``

### Crear el servidor

Ahora lo que vamos a crear es la instancia de EC2. Como hemos puesto que el provider es AWS, podemos usar todos los recursos
de ese servidor. Estos secursos nos viene en la documentación oficial de terraform en el provider AWS.

````terraform
# Una buena práctica de terraform es usar _ en lugar de -

resource "aws_instance" "mi_servidor"{
  
}
````

El recurso de AWS instance tiene dos argumentos obligatorios, eso lo podemos ver en la documentación oficial pinche [aquí](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance). 

Estos dos arguentos son el AMI (el identificador de la imagen del sistema operativo) 
y el instance_type que sería el tamaño de la instancia, nosotros usaremos la gratuita. 

![img.png](img/aws_instance_argument.png)

Podemos consuntar el AMI de la máquina en la creación de la instancia de EC2 a través de la página web: 

![img.png](img/ami_ubuntu.png)

````terraform
resource "aws_instance" "mi_servidor"{
  ami = "ami-05b5a865c3579bbc4"
  instance_type = "t2.micro"
}
````

Ahora ya tenemos el fichero creado, pero tenemos que decirle a terraform que nos lo ejecute, para ello tendremos que 
primero iniciar terraform

````bash
terraform init
````

Terraform init va a ver todos los provider que hemos definido en nuestro fichero de configuración, y como todos son plugins, 
se va a descargar todos los que sean necesarios para nosotros. 

![img.png](img/terraform_init.png)

Cuando tengamos el providre podemos hacer ``terraform plan``, este va a cogar nuestra configuración, 
el estado real de nuestra cuenta y va a intentar definir un plan para llegar desde el mundo real hasta 
nuestra configuración. Terraform nos dirá que lo nuevo es instalar un servidor:

![img.png](img/terraform_plan.png)

Si queremos ejecutar los cambios haremos ``terraform apply``, nos pedirá si queremos ejecutar estos cambios y si le damos a ``yes``
nos desplegará la configuración. 

Una vez creado, y si nos vamos a la consola de AWS, veremos que tendremos una instancia de EC2 ejecutándose:

![img.png](img/instancia_ec2_running.png)

### Modificar script de inicio

Hemos creado una instancia de EC2 vacía, pero si queremos que por ejemplo tenga una web en la instancia de EC2, tendremos 
que añadir más información

Vamos a escribir los comandos necesarios para ejecutar una servidor en el puerto 80:80 que muestra un fichero index html 
con el mensaje "Hola Transformers" 

Dentro del bloque resource, añadiremos información

````terraform
resource "aws_instance" "mi_servidor"{
  ami = "ami-05b5a865c3579bbc4"
  instance_type = "t2.micro"
  
  #### NUEVO
  // Escribimos un "here document" que es
  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  #### NUEVO
}
````

Si añadimos esto al [main.tf](Ejemplos/01-mi-primer-servidor/main.tf) y hacemos ``terraform apply``, va a coger nuestra 
configuración e intentará desde el mundo real, llegar a esta configuración objetivo.

Como tenemos la anterior máquina ejecutándose, lo que nos dirá terraform es que tiene que hacer un reemplazamiento, esto
significa que tendrá que eliminar la máquina anterior y crear una nueva. 

### Modificar el Security Group

Todas las máquinas que nos crea AWS, por defecto no tienen ninguna regla ingres ni agres, eso significa que está 
totalmente aislado de internet. Por lo que si el servidor se está ejecutando y nosotros queremos acceder al puesto 8080, 
no podríamos porque no hemos definido ninguna regla que nos permita abrir el puerto 8080 a todas las Ips, en particular 
a nuestra IP.

Ahora vamos a escribir un recurso que se llama Segurity group para dejarnos el acceso. 

No necesitamos en este caso ninguna degrees URL, porque nuestro servidor no necesita acceso a internet. 
No necesita instalar ningún paquete o ninguna aplicación.

Vamos a escribir nuestro segurity group y para ello escribiremos el recurso:

````terraform
resource "aws_security_group" "mi_grupo_de_seguridad" {
  name   = "primer-servidor-sg"
  
  vpc_id = data.aws_vpc.default.id
  
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 8080 desde el exterior"
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
  }
}

````

Ahora tendremos que editar nuestro resource, porque tendremos que asociar este security_group con nuestra instancia, 
para ello usaremos el vpc_security_group_ids

````terraform
resource "aws_instance" "mi_servidor"{
  ami = "ami-05b5a865c3579bbc4"
  instance_type = "t2.micro"
  
  ### NUEVO
  vpc_security_group_ids = [ aws_security_group.mi_grupo_de_seguridad.id ]
  ### NUEVO
  
  // Escribimos un "here document" que es
  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
}
````

También tendremos que añadir la vpc que tendrá en cuenta para la implementación: 

````terraform
data "aws_vpc" "default" {
  default = true
}
````

Si tras añadir esto, ejecutamos ``terrafrom apply`` nos avisará que va a cambiar nuesta instancia del servidor, y como 
la otra vez nos avisará de "forces replacement" que significa que nos borrará la instancia y creará una nueva 

### Acceder y cambiar el nombre del servidor

Ahora que tenemos nuestra instancia levantada, solo nos quedaría probarla, para ello vamos a irnos a la instancia en la 
consola, y copiar la IPv4 pública y ponerle al final el puerto 8080

![img.png](img/instancia_ec2_puerto8080.png)

Copiamos la DNS y añadimos el puerto ``ec2-15-237-60-152.eu-west-3.compute.amazonaws.com:8080``

![img.png](img/instancia_ec2_puerto8080_levantado.png)

Ahora vamos a cambiar el nombre del servidor, si nos vamos a la zona de instancias, vemos que este servidor no tiene 
ningún nombre asociado, esto puede hacer que cuando tengamos muchas instancias no septamos que instancia levanta.

Si nos vamos a nuestro códgio, nos vamos a aws_instance, podemos añadir un tag, y como argumento el nombre, esto nos 
cambiaría el nombre del servidor.

````terraform
resource "aws_instance" "mi_servidor"{
  ami = "ami-05b5a865c3579bbc4"
  instance_type = "t2.micro"
  
  vpc_security_group_ids = [ aws_security_group.mi_grupo_de_seguridad.id ]
  
  // Escribimos un "here document" que es
  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  ### NUEVO 
  tags = {
    Name = "servidor-1"
  }
  ### NUEVO
}
````

Si realizamos los cambios y lanzamos ``terraform apply``, vamosa  modificar el nombre del servidor. 

![img.png](img/modify_instance_name.png)

Si le decimos que si, vemos que ya está cambiado el nombre del servidor:

![img.png](img/modify_instance_name_v2.png)


### Destruir el servidor y todos los recursos asociados

La siguiente tarea es destruir todos los recusos asociados, para eso terraform tiene un comando que se llama 
``terraform destroy`` este terraform destroy, cogerá todos los recursos asociados al fichero y los destruirá.

## Terraform provider vs Terraform Resource
***

Ahora que hemos creado nuestra primer aplicación con terraform, conveniente conocer la diferencia entre provider y resource 

> :bulb: Terraform se basa en plugins, de los cuales los más importantes son los _providers_  
>  Un _resource_ es un bloque de código que describe uno o más objetos en nuestra infraestructura

### Terraform Provider

![img_1.png](img/tf-resource-diagram.png)

- **Terraform Core**: Binario o CLI que nosotros ejecutamos al escribir `terraform`
- **Terraform Provider o Plugins**: Binario estático que se comunica con el *core* usando RPC. Los *providers* tienen las
  siguientes responsabilidades:
  1. inicializar las bibliotecas para hacer llamadas a la API de nuestra infraestructura
    (AWS en el ejemplo); 
  2. Autenticación con nuestra infraestructura; 
  3. Definir los _resources_ que se relacionarán con servicios específicos de la infraestructura

![](img/tf-resource-diagram-aws.svg)
  
El Terraform Core será el que gestiona el Terraform plugin, que en el ejemplo anterior es el Provider de AWS. 

### Terraform Resource 

Un Resource o Recurso es un componente de un proveedor Cloud. 

Muestras que en provider puede ser AWS, un recurso sería una instancia EC2

**Un recurso describe uno o más componentes en nuestra infraestructura**

Si utilizamos un plugin de Github, un provider de Github, un recurso sería por ejemplo un repositorio. 

### Terraform Provider Provisioner

Un tipo especial de provider es un provisioner

Su objetivo es ejecutar comandos o scripts sobre los recursos que hemos creado. 

### :computer: Ejemplo 

```terraform
provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "mi_servidor" {
  ami                    = "ami-0e169fa5b2b2f88ae"
  instance_type          = "t2.micro"
}
```

En el ejemplo anterior declara un provider `aws` y un recurso `aws_instance`. Con el provider decimos los recursos que
podemos instanciar y en qué infraestructura. Con el recurso estamos referenciando a una instancia en nuestra cuenta de
AWS. En el caso de no existir, esta instancia será creada.

### Lista de Providers

Podemos consultar todos los providers que nos ofrece Terraform en Registry. 


## Terraform State
***

Una parte importante en Terraform son los State. El estado nos define la diferencia entre lo que tenemos configurado en 
el mundo real, y lo que tenemos en nuestro fichero de configuración. 

En el ejemplo anterior del Servidor de Ec2, podríamos tener en el mundo real ninguna instancia, y en el ficheor de 
configuración la creación de una. 

Si vamos a la carpeta donde tenemos el fichero main.tf que hemos lanzado antes, veremos que se nos ha creado un fichero ``terraform.tfstate``

![img_1.png](img/terraform_state.png)

Si tenemos le damos a ``terraform apply`` la información que nos sale antes de darle a confirmar es el estado, y este se guarda en este fichero. 

## Otros ficheros
***

Ahora lo que vamos a ver son otros ficheros que nos crea terraform al ejecutarse. 

### .terraform.lock.hcl

Este fichero, se va a crear cuando se inicializa terraform, y nos guardará y creará una lista con todos los providers 
que hemos utilizado. Esto permite que si compartimos código, otro compañero puede ejecutar con la misma versión del 
provider que nosotros hemos usado y evitar errores. Para actualizar las versiones tendremos que hacer:

````bash
terraform init -upgrade
````

Esto nos actualizará las versiones de los providers. 

### Carpeta .terraform

Aquí nos descargará los providers que estamos usando. 

![img.png](img/terraform_providers.png)

La siguiente vez que hagamos terraform apply no tendrá que descargar este fichero.

### terraform.tfstate.backup

Cada vez qeu se escriba el fichero tfstate, se hace una copia de seguridad de lo anterior en el fichero ``terraform.tfstate.backup``.

## Terraform Outputs

Ahora el siguiente concepto será Terrafrom Outputs, uno de os casos de uso de esto es por ejemplo cando hemos creado la 
instancia de EC2, que hemos tenido que ir a mirar la DNS a la instancia levantada en la consola. 

Pero ¿Hay alguna forma de hacerlo sin tener que entrar en la consola?

Para hacerlo, nos vamos a la carpeta y crearemos un fichero llamado ``output.tf``, una vez en este fichero vamos a crear lo siguiente:

````terraform
output "dns_publica" {
  value = ""
}
````

Esto nos creará una output, pero nos falta el calor que queremos que nos devuelva en el output, para ello tendremos que entender el resource. 
En el resource hay un parámetro que se llama ``public_dns``, además tendremos que poner el nombre del servidor, quedaría así:

````terraform
output "dns_publica" {
  value = aws_instance.mi_servidor.public_dns
}
````

Una vez que hagamos terraform apply, nos mostrará este valor de salida. 

![img.png](img/terraform_output.png)

Pero si queremos que nos salta la dirección completa incluido el puerto 8080, tendríamos que modificar el output con interpolación:

````terraform
output "dns_publica" {
  descripcion = "DNS pública del servidor"
  value = "http://$(aws_instance.mi_servidor.public_dns}:8080"
}
````

### Ejercicio 

Imprimir la IPV4 de nuestro servidor. 

## Load Balancer

Para este apartado, vamos a usar el EC2 creado en el apartado anterior, pero con un Load Balancer, lo que nos generaría 
una arquitectura como esta:

![img.png](img/load_balancer_01.png)

Antes de empezar tendremos que asegurarnos que no tenemos nada del ejercicio de Ec2 creado, para ello haremos un 
``Terraform destroy``

Todo el código implementado en este bloque lo encontraremos en [03 Variables Terraform](Ejemplos/03-variables-terraform)

### Modificar los nombres del servidor actual

En primer lugar tendremos que modificar el nombre de los servidores, como según arquitectura tendremos 2, no se podrán 
llamar igual. 

Cambiaremos el nombre del servidor, y añadiremos "Servidor 1" al mensaje "Hola Terraformers"
````terraform
resource "aws_instance" "servidor-1" { # CAMBIO NOMBRE SERVIDOR
  ami                    = "ami-05b5a865c3579bbc4"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  // Escribimos un "here document" que es
  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers! Servidor 1" > index.html 
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "servidor-1"
  }
}
````

### Creación de la segunda instancia

Replicaremos el código anterior, cambiando servidor 1 por servidor 2

````terraform
resource "aws_instance" "servidor-2" { # CAMBIO NOMBRE SERVIDOR
  ami                    = "ami-05b5a865c3579bbc4"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  // Escribimos un "here document" que es
  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers! Servidor 2" > index.html 
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "servidor-2"
  }
}
````

### Crear el Data Source para las subnets

Por defecto AWS nos va a crear una subnets en cada AZ, cuando creamos una instancia de EC2 según la subnets que le 
asignemos se desplegará en una zona o en otra.

Si no definimos nada se desplegará en la de por defecto que es la a. 

El problema es, que no conocemos el nombre de las subnets, porque a terraform no se lo hemos dicho. Para solucionarlo, 
podríamos mirarlo y pegarlo en el código

````terraform
resource "aws_instance" "servidor-2" { 
  ami                    = "ami-05b5a865c3579bbc4"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-07cdb18a5354e168f" # ASIGNACIÓN SUBNET
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  // Escribimos un "here document" que es
  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers! Servidor 2" > index.html 
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "servidor-2"
  }
}
````

Para no tener que comprobar en la consola el nombe de la subnet, podemos usar los Data Source de terraform. 
Aquí puedes ver la [Documentación de Data Source](https://developer.hashicorp.com/terraform/language/data-sources)

Crearemos un grupo de código nuevo

````terraform
data "aws_subnet" "az-a" {
  availability_zone = "eu-west-3a"
}
````

````terraform
data "aws_subnet" "az-b" {
  availability_zone = "eu-west-3b"
}
````

Ahora en nuestro recurso de instancia en lugar de poner el id de la subnet referenciamos a los datos obtenidos:


````terraform
resource "aws_instance" "servidor-1" { 
  ami                    = "ami-05b5a865c3579bbc4"
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnet.az_a.id # ASIGNACIÓN SUBNET
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  // Escribimos un "here document" que es
  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers! Servidor 1" > index.html 
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "servidor-1"
  }
}

resource "aws_instance" "servidor-2" { 
  ami                    = "ami-05b5a865c3579bbc4"
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnet.az_b.id # ASIGNACIÓN SUBNET
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  // Escribimos un "here document" que es
  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers! Servidor 2" > index.html 
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "servidor-2"
  }
}
````

Ahora solo queda cambiar los output 

````terraform
output "dns_publica_servidor_1" {
  descripcion = "DNS pública del servidor"
  value = "http://$(aws_instance.servidor-1.public_dns}:8080"
}
````
````terraform
output "dns_publica_servidor_2" {
  descripcion = "DNS pública del servidor"
  value = "http://$(aws_instance.servidor-2.public_dns}:8080"
}
````

### Aplicación de cambios

Como siempre vamos a aplicar los cambios a través de los comandos que ya conocemos ``terraform apply``. 

Esto nos creará las instanacias y podremos validar que están bien:

![img.png](img/load_balancer_02.png)

### Creación de Load Balancer (LB)

Para crearlo podemos ir a la documentación oficial de terraform sobre el load balancer. 

- [Documentación terraform LoadBalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)

Al final de nuestro main vamos a escribir nuestro código de load balancer. Entre las especificaciones, tendremos que 
definir el security groups, que nos va a definir que podamos acceder a este load balancer. Este segurity group que tendremos, 
se encargará de recoger las peticiones y pasarlas a las EC2, por lo que podremos definir que vayan por el puerto 80 y 
en la url no tendremos que poner el puerto 8080

````terraform
resource "aws_lb" "alb" {
  load_balancer_type = "applicaction"
  name = "terraformers-alb"
  security_groups = [aws_security_group.alb.id]
  subnets = [ data.aws_subnet.az-a.id , data.aws_subnet.az-b.id ]
}
````

Nuestro security group ahora tiene que hacer dos cosas, por un lado recoger peticiones de entrada (ingress) pero por 
otro lado derivarlas a las instancias de EC2 (egress), para ello vamos a definir este código

````terraform
resource "aws_security_group" "alb" {
  name = "alb-sg"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 80 desde el exterior"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 8080 desde nuestros servidores"
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
  }
}
````

### Creación de Target Group

El target Group será cada una de nuestras instancias, nos englobará las dos instancias en un único target, y nos permitirá 
enrutar el tráfico a nuestras instancias. 

- [Documentación TargetGroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)

En primer lugar crearemos el target-group que lo llamaremos this, y configuraremos que escuchará en el puerto 80, donde 
teníamos el load balancer, tendremos que conectarla a la vpc por defecto, para ello usaremos un Data Source:

````terraform
data "aws_vpc" "default" {
  default = true
}
````

También tendrmeos que definir el protocolo, que será el HTTP, y el health_check, que comprobará si la instancia a la 
que va a mandar el tráfico está correcta para que si no lo está no mandarlo. 

````terraform
# ----------------------------------
# Target Group para el Load Balancer
# ----------------------------------
resource "aws_lb_target_group" "this" {
  name     = "terraformers-alb-target-group"
  port     = 80
  vpc_id   = data.aws_vpc.default.id
  protocol = "HTTP"
  
  # Esto quiere decir que enviará una petición al path raiz y que si devuelve un 200 que es que está bien, funciona. 
  # Este si escucha en el 8080, que es el que tiene nuestra instancia. 
  health_check {
    enabled  = true
    matcher  = "200"
    path     = "/"
    port     = "8080"
    protocol = "HTTP"
  }
}
````

### Creación de los Attachments

Ahora nos quedaría definir los attachment, que es como cada una de nuestras instancias se conecta al target group.  

````terraform
# -----------------------------
# Attachment para el servidor 1
# -----------------------------
resource "aws_lb_target_group_attachment" "servidor_1" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.servidor_1.id
  port             = 8080
}

# -----------------------------
# Attachment para el servidor 2
# -----------------------------
resource "aws_lb_target_group_attachment" "servidor_2" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.servidor_2.id
  port             = 8080
}
````

### Crear Listener para nuestro LB

Ahora vamos a crear el Listener para nuestro LoadBalancer. Esto es necesario porque en nuestro LB vamos a necesitar un 
Listener para que nos redirija todas las peticiones entrantes del puerto 80 a nuestro Target Group. 

- [Documentación AWS Listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) 

Para ello vamos a utilizar el recurso "aws-lb-listener"

````terraform
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }
}
````

Ahora que tenemos todo conectado, y para más seguridad, tendremos que quitar los accesos permitidos a nuestras instancias,
por defectoe estaba desde cualquier IP, pero ahora solo será accesible desde nuestro LoadBalancer, así las haremos mucho 
más seguras.

````terraform
resource "aws_security_group" "mi_grupo_de_seguridad" {
  name   = "primer-servidor-sg"
  vpc_id = data.aws_vpc.default.id
  ingress {
    cidr_blocks = [aws_security_group.alb.id]
    description = "Acceso al puerto 8080 desde el exterior"
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
  }
}
````

Ahora podemos actualizar los outputs para que nos imprima por pantalla el DNS de nuestro load balancer

````terraform
output "dns_load_balancer" {
  description = "DNS pública del load balancer"
  value       = "http://${aws_lb.alb.dns_name}"
}
````

#### Validación

Ahora que tenemos todo creado ejecutaremos nuestro código, veremos que nos añade 6 elementos y nos modifica 1 en el plan
de ejecución. 

También tendremos un load balancer asignaco a dos zonas de disponibilidad: 

![img.png](img/load_balancer_03.png)

Y un target group 

![img.png](img/load_balancer_03.png)

Si consultamos la dns, y recargamos la página veremos que cambia el mensaje 1 y 2 según la zona conectada. 

# Infraestructura Reutilizable 
***

Hasta ahora hemos visto la creación de distintos componentes, pero si necesitamos muchas instancias de Ec2 por ejemplo, 
es poco práctico porque tendríamos que replicar código, ahora vamos a ver como podríamos reutilizar código y hacerlo más 
reutilizable. 

## Variables de Terraform
***

Las variables nos permiten tener el código mucho más parametrizado. No teniendo que repetir valores en diferentes lugares.

Las variables se pueden definir en cualquier configuración de Terraform, pero lo más acetado sería en un fichero llamado
``variables.tf``

Tenemos diferentes tipos de variables, que los podemos dividir en dos grupos: 

- tipos simples
  - String
  - Number
  - Bool

- tipos compuestos
  - list
  - set
  - map
  - object 
  - tuble

Para referenciar las variables, usaríamos vars y el nombre de la variable. 

Para probarlo, vamos a cambiar el código del main.tf creado anteriormente, para sustituir la referencia al puerto 8080, 
por una variable. 

Para ello, vamos a crear un fichero llamado ``variables.tf`` y vamos a crear tres variables:

```terraform
variable "puerto_servidor" {
  description = "Puerto para las instancias EC2"
  type        = number
}

variable "puerto_lb" {
  description = "Puerto para el Load Balancer"
  type        = number
}

# Nos permite redimensionar la instancia verticalmente. 
variable "tipo_instancia" {
  description = "Tipo de la instancia EC2"
  type        = string
}
```

Si ahora nos vamos al fihero main.tf, podremos cambiar las referencias 

````terraform
resource "aws_security_group" "mi_grupo_de_seguridad" {
  name = "primer-servidor-sg"

  ingress {
    security_groups = [aws_security_group.alb.id]
    description     = "Acceso al puerto 8080 desde el exterior"
    from_port       = var.puerto_servidor
    to_port         = var.puerto_servidor
    protocol        = "TCP"
  }
}
````

También podemos cambiarlo en la declaración del html:

````terraform
# añadimos la variable entre ${}
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers! Soy servidor 2" > index.html
              nohup busybox httpd -f -p ${var.puerto_servidor} &
              EOF
````

También cambiamos el tipo instancia, y el resultado lo tendríamos en el fichero [main.tf](Ejemplos/03-variables-terraform/main.tf)

En los outputs también podemos usar las variables, consultar fichero [outputs.tf](Ejemplos/03-variables-terraform/outputs.tf)

Ahora podríamos hacer un terraform apply 

### Instanciar Variables

Ahora vamos a ver como instanciar las variables, tenremos las siguientes formas:

- [Introduciendo valores en consola](#introducciendo-valores-en-consola)
- [Flag -var](#flag--var)
- [Fichero tfvars](#fichero-tfvars)
- [Fichero terraform.tfvars](#fichero-terraform-tfvarsjson)
- [Fichero terraform-tfvars.json](#fichero-terraform-tfvarsjson)
- [Fcihero .auto.tfvars/.autotfvars.json](#fichero-autotfvarsautotfvarsjson)
- [Variables de Entorno](#variables-de-entorno)
- [Variables por defecto](#variables-por-defecto)

#### Introducciendo valores en consola

Si realizamos el apply sin el fichero variables.tf, o comentamos el valor por defecto, nos pedirá instroducir por consola
el valor de las variables: 

![img.png](img/variables_01.png)

#### Flag -var

En el momento de realizar el apply, podríamos introducir las variables:

````bash
terraform apply -var="puerto_lb=80" -var="puerto_servidor=8080" -var="tipo_instancia=t2-micro"
````

#### Fichero tfvars

El siguiente sería crear un fichero tfvars al que llamaremos [t2medium.tfvars](Ejemplos/03-variables-terraform/t2medium.tfvars)

````terraform
puerto_servidor = 8080
puerto_lb       = 80
tipo_instancia  = "t2.medium"
````

Para usar este fichero tendríamos que usar el valor -var-file y como valor sería la ruta del fichero: 

````bash
terraform apply -var-file "t2medium.tfvars"
````

#### Fichero terraform-tfvars.json

Ahora vamos a ver como poder escribir el mismo fichero anterior pero en formato json, lo que nos generaría un fichero llamado
[t2medium.tfvars.json](Ejemplos/03-variables-terraform/t2medium.tfvars.json)

````json
{
  "puerto_servidor": 8080,
  "puerto_lb": 80,
  "tipo_instancia": "t2.medium"
}
````

La forma de ejecutarlo sería igual pero llamando a este ficehro 

````bash
terraform apply -var-file "t2medium.tfvars.json"
````

#### Fichero .auto.tfvars/.autotfvars.json

Si estos dos ficheros que hemos visto, los creamos con el prefijo .auto y la extensión, como viene el el nombre, del título, 
no tendríamos que referenciar el fichero usando -var-file

#### Variables de Entorno

Ahora vamos a ver como definir el valor de estas variables usando variables de entorno.

Tendríamos que crear la variable de entorno con la siguiente estructura:

TF_VAR y el nombre de la variable, de esta forma terraform sabe que esas variables de entorno hacen referencia a variables del proceso de ejecución:

````bash
export TF_VAR_puerto_servidor=8080
export TF_VAR_puerto_lb=80
export TF_VAR_tipo_instancia="t2.medium"
````

Si creamos estas variables de entorno, bastaría con hacer ``terraform apply`` para que terraform las use en la ejecución

#### Variables por defecto

Por último sería usar las variables por defecto:

````terraform
variable "puerto_servidor" {
  description = "Puerto para las instancias EC2"
  type        = number
  default     = 8080
}

variable "puerto_lb" {
  description = "Puerto para el Load Balancer"
  type        = number
  default     = 80
}

variable "tipo_instancia" {
  description = "Tipo de la instancia EC2"
  type        = string
  default     = "t2.micro"
}
````

### Reglas de preferencia

Por último habría que ver las reglas de preferencias, si creas variables en distintos sitios, que orden sigue, las 
reglas de preferencia sería la siguiente:

1. Variables de entorno
2. Ficheros `terraform.tfvars`
3. Ficheros `terraform.tfvars.json`
4. Ficheros `.auto.tfvars` / `.auto.tfvars.json`
5. Flag `-var` / `-var-file`


## Tipado dinamico variables
***

En el apartado anterior vimos que todas las variables iban definidas por un tipo, ahora vamos a ver como podemos crear 
variables con tipado dinámico:

````terraform
variable "variable_dinamica" {
  description = "El tipo de esta variable será dado en la primera asignación"
  type = any
}
````

Any es una palabra reservada, que nos sirve para que el valor de la variable se asigne hasta la instanciación. 

Vamos a crear un fichero al que llamaremos `variables.tf` con las siguientes variables:

````terraform
variable "variable_dinamica" {
  type = bool
}

output "valor_variable_dinamica" {
  value = var.variable_dinamica
}
````

Esto aunque no cree nada, podremos hacer un terraform apply para ver que pasa:

![img.png](img/variables_dinamicas_01.png)

Ahora si volvemos a ejecutar e intentamos darle otro valor, nos daría un error:

![img.png](img/variables_dinamicas_02.png)

Si en lugar de `bool`, lo cambiamos a `any`, podemos realizar las mismas pruebas, y cada vez que le demos valor a la variable, 
nos permite cambiar su valor:

![img.png](img/variables_dinamicas_03.png)

También podemos definir tipos completos, como por ejemplo una lista de string ["maria", "raquel"]

También podemos definir en la declaración de la variable que sea de tipo lista `list()`, pero si ponemos any, no tenemos que
definir los elementos de la lista `lista(any)`

Si al crear la lista le introducimos varios tipos, cogerá el valor genérico:

![img.png](img/variables_dinamicas_04.png)

## Variables: Mapas y validaciones
***

Ahora vamos a probar los mapas y validaciones, para probarlo vamos a partir del fichero [main.tf](Ejemplos/02-load-balancer/main.tf) del apartado [load_balancer](#load-balancer)

El fichero tiene de forma harcodeada la ami que estamos consultando `ami-05b5a865c3579bbc4`. Pero ahora podemos crear una
variable de tipo mapa, que identifique la región con la variable ami de la imagen ubuntu que queremos usar. 

Ahora vamos a crear unas variables:

````terraform
variable "ubuntu_ami" {
  description = "AMI por region"
  type = map(string)

  default = {
    eu-west-3 = "ami-05b5a865c3579bbc4" # Ubuntu en Paris
    eu-west-1 = "ami-0aef57767f5404a3c" # Ubuntu en Dublin
  }
}
````

una vez que tengamos esto, tenemos que ir al main.tf y cambiar las referencias ``ami  = "ami-05b5a865c3579bbc4"`` por 
``ami = var.ubuntu_ami["eu-west-3"]``

Otro apartado interesante son las validaciones, para evitar un error se pueden crear validaciones que seguren que 
el valor de la variable cumpla unas características. 

Por ejemplo con la variable puerto_servidor: 

````terraform
variable "puerto_servidor" {
  description = "Puerto para las instancias EC2"
  type        = number
  default     = 8080

  validation {
    condition     = var.puerto_servidor > 0 && var.puerto_servidor <= 65536
    error_message = "El valor del puerto debe estar comprendido entre 1 y 65536."
  }
}
````

Creamos primero la condición y luego el mensaje en caso de no cumplirse

## Bucles y Meta-Argumentos
***

En el código que hemos usado para crear el load_balancer, hemos visto que hemos repedido código al crear por ejemplo 
dos instancias con la misma configuración. Podríamos usar estos blucles para reutilizar código

Terraform es un lenguaje declarativo, eso quiere decir que lo que escribimos es el estado final, eso implica que no tiene
herramientas de lenguaje convencional, como fors o whiles, pero terraform lo soluciona con los *Meta-arguments*

Los meta-arguments son los siguientes:

- count
- for_each
- depends_on
- provider
- lifecycle

Los meta-argumentos son palabras reservadas que interpreta Terraform para hacer una acción, por ejemplo el count es algo que podemos
añadir a cualquier resource con un tipo number, y vamos a definir cuantas veces queremos que ese recurso que estamos creando
se repita. 

## Count
***

Para hacer las pruebas de esto, vamos a crear un nuevo fichero [main.tf](Ejemplos/06-bucles-meta-argumentos/01-count-con-numero) 
que nos va a crear un User IAM:

````terraform
provider "aws" {
  region = "eu-west-3"
}

resource "aws_iam_user" "ejemplo" {
  name = "usuario-ejemplo"
}
````

Si quisiesemos crear dos usuarios una solución no válida sería copiar y pegar, pero para eso está el método count.
Si ponemos `count = 2` dentro del recurso, nos creará dos veces este usuario, pero si no ponemos nada más, nos dará 
un error porque no podemos crear dos usuarios con el mismo nombre, para solucionarlo usaríamos los indices: 

````terraform
# -------------------------
# Define el provider de AWS
# -------------------------
provider "aws" {
  region = "eu-west-3"
}

# ---------------------------------
# Crea un <var.usuarios> de IAM
# ---------------------------------
resource "aws_iam_user" "ejemplo" {
  count = 2

  name = "usuario-ejemplo.${count.index}"
}
````

Esta solución nos crearía una lista, pero otra solución más fácil sería como la que vemos en el fichero [main.tf de expresiones](Ejemplos/06-bucles-meta-argumentos/02-count-con_expresion) 
que es usando variables y expresiones:

````terraform
provider "aws" {
  region = "eu-west-3"
}

variable "usuarios" {
  description = "Nombre de usuarios IAM"
  type        = list(string)
}

resource "aws_iam_user" "ejemplo" {
  count = length(var.usuarios)

  name = "usuario-${var.usuarios[count.index]}"
}
````

La lista que introduzcamos en la variable usuarios, tendría los nombres `['maria', 'raul']`

## For-each
***

Ahora vamos a ver como implementarlo con un for-each, al ahcerlo, nos va a solucionar un error que tiene el count y list, 
y es que si ejecuramos en un orden y luego lo cambiamos `['raul', 'maria']` nos renombrará los dos iam. 

````terraform
provider "aws" {
  region = "eu-west-3"
}

variable "usuarios" {
  description = "Nombre usuarios IAM"
  type        = set(string)
}

resource "aws_iam_user" "ejemplo" {
  for_each = var.usuarios

  name = "usuario-${each.value}"
}
````

Con `each.value` hacemos referencia al valor al valor de la lista, y no al índice de la lista, de esta forma creará o editará 
en función del valor y no del nombre. 

## Cuando usar Count o For-each
***

### Buble Count

- Repite un resource un número de n de veces
- Usando length y count.index podemos iterar sobre una lsita
- Usando count un recurso se convierte en una lista de recursos
  - aws_instance.servidor[0] y aws_instance.servidor[1]
  
#### Expresiones del Bucle Count

- `count = length(var..)`

Las expresiones usadas en count deben ser conocidas **antes** de ejecutar ninguna operación remota. Es decir, **no**
pueden referenciar atributos que no sean conocidos hasta que se aplique la configuración (como es el caso de los 
identificadores)

#### Problema con Bucle Count

Dada la lista `["maria", "manuel", "carlos"]`, si la cambiamos por `["maria", "carlos"]` va a cambiar varios recursos en lugar
de uno (el correspondente a "manuel")

### Bucle For_each

- Itera sobre un **set** o un **map** y crea resources por cada elemento
- Podemos usar each.key y each.value para acceder a los valores actuales
- Usando for_each un recurso se convierte en un mapa de recursos:
  - `aws_instance.servidor["ser-1"]` y `aws_instance.servidor["ser-2"]`

#### Keys en Bucle For_each

`for_each = toset(var..)`

Las keys en for_each deben ser valores conocidos (como ocurría con count)
No se acepta el valor de funciones impuras como uuid, timestamp.

### Cuando usar count y cuando For_each

Si los recursos a crear son **idénticos** (y como mucho difieren en un número enero) -> Count
Si los recursos tienen valores diferentes -> for_each

## Expresiones for
***

Estas expresiones nos permitiría por ejemplo iterar en una lista con todas la información generar en ficheros de configuración. 

Vamos a verlo en un ejercicio:

### Expresion for: count

Vamos a partir del ejemplo del ejercicio [count main.tf](Ejemplos/06-bucles-meta-argumentos/01-count-con-numero)

En este ejemplo usábamos el índice para recorrer el recursos y crear tantos usuarios como valor tenga el count. 
Pero ¿Cómo podríamos hacer para imprimir todos los arn que hemos generado?

Por ejemplo si creamos 5 usuarios y queremos imprimir el arn del usuarios 2: 

````terraform
# Tenemos que acceder al elemnto que queramos de la lista. Ejemplo es el nombre del resource
output "arn_usuario" {
  value = aws_iam_user.ejemplo[2].arn
}
````

Pero si queremos recorrer los 5 resource usaríamos for: 

````terraform
output "arn_todos_usuarios" {
  value = [for usuario in aws_iam_user.ejemplo : usuario.arn]
}
````

### Expresion for: for_each

Ahora vamos a ver como podríamos usar a todos los usuarios del arn creado en for_each, partiremos de ese buble [count main.tf](Ejemplos/06-bucles-meta-argumentos/02-count-con_expresion)

Ahora tenemos que acceder en lugar de posiciones, con valores: 

Para un usuario en concreto:

````terraform
output "arn_usuario" {
  value = aws_iam_user.ejemplo["manuel"].arn
}
````
Para iterar con todos los usuarios: 

````terraform
# Al final me imprimirá un output con el nombre y el arn. Esto nos creará un mapa, y para ello necesitamos corchetes y un =>
output "nombre_a_arn" {
  value = { for usuario in aws_iam_user.ejemplo : usuario.name => usuario.arn }
}
````

## Expresiones splat
***

Volvemos a partir del ejemplo de [count main.tf](Ejemplos/06-bucles-meta-argumentos/02-count-con_expresion)  

Si queremos añadirle al fichero un output con una lista splat podríamos: 

````terraform
output "arn_todos_usuarios" {
  value = aws_iam_user.ejemplo[*].arn
}
````
Con esto iteraríamos para recoger el arn de todos los usuarios con el *

## Variables Local
***

Podríamos **repetir** la misma expresión en una configuración usando variables local.

Por ejemplo, si partimos del ejercicio de [load-balancer](Ejemplos/02-load-balancer) vemos que al igual que con variables
normal, hay muchas que se repiten, para eso podemos usar variables locales, si no nos hacen falta en otro fichero:

Por ejemplo para la region

````terraform
locals {
  region = "eu-west-3"
  ami    = var.ubuntu_ami[local.region]
}
````
Podemos referenciarlas usando `local.region`

También podríamos por ejemplo crear una variable local a partir de una externa, como por ejemplo lo de la ami:
````terraform
locals {
  region = "eu-west-3"
  ami = var.ubuntu_ami[local.region]
}
````

Esto últimos lo sustituimos el `local.ami` por `ami = var.ubuntu_ami["eu-west-3"]` del fichero [seccion mapas main.tf](Ejemplos/05-mapas-validaciones)

## Refactorizar Load-Balancer

Ahora vamos a refactorizar todo el código que hemos visto hasta ahora, usando los bucles. El ejercicio creaba dos 
servidores repitiendo código, ahora vamos a cambiarlo para usar estructuras de repetición. 

Para ello, vamos a partir de la última versión del load balancer, que se adjunta en el siguiente fichero [codigo-de-partida](Ejemplos/09-refactor-load-balancer/codigo-de-partida)

En primer lugar, cambiaremos el proceso que crea dos servidores por un único proceso:

````terraform
resource "aws_instance" "servidor_1" {
  ami                    = local.ami
  instance_type          = var.tipo_instancia
  subnet_id              = data.aws_subnet.az_a.id
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  // Escribimos un "here document" que es
  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers! Soy servidor 1" > index.html
              nohup busybox httpd -f -p ${var.puerto_servidor} &
              EOF

  tags = {
    Name = "servidor-1"
  }
}
````

Como se diferencian el 1 y el 2 en varios sitios por el nombre, es mejor usar un `for_each`, vamos a usar una variable de tipo
mapa. 

````terraform
variable "servidores" {
  description = "Mapa de servidores con su correspondiente AZ"

  type = map(object({
    nombre = string,
    az     = string
    })
  )

  default = {
    "ser-1" = { nombre = "servidor-1", az = "a" },
    "ser-2" = { nombre = "servidor-2", az = "b" },
    "ser-3" = { nombre = "servidor-3", az = "c" }
  }
}
````

Ahora podemos generar el bucle for-each, para ello tendremos que cambiar la generación de las aws_subnet para que no
estén duplicados

````terraform
data "aws_subnet" "az_a" {
  availability_zone = "${local.region}a"
}
````

El resultado seria un `for_each` sobre cada uno de los elementos de `servidores`. El segundo lo podemos eliminar. 

````terraform
data "aws_subnet" "public_subnet" {
  for_each = var.servidores

  availability_zone = "${local.region}${each.value.az}" # Cone sto estamos recuperando el valor de la AZ value.az
}
````

Ahora vamos a montar el servidor. Hay un punto complejo que es el de recuperar la subnet, pero como tenemos el each, podemos
recupearla a través de la key del each, para que sea la misma. También hay que cambiar el nombre y los tags. 

````terraform
resource "aws_instance" "servidor" {
  for_each = var.servidores

  ami                    = local.ami
  instance_type          = var.tipo_instancia
  subnet_id              = data.aws_subnet.public_subnet[each.key].id 
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  // Escribimos un "here document" que es
  // usado durante la inicialización
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers! Soy ${each.value.nombre}" > index.html
              nohup busybox httpd -f -p ${var.puerto_servidor} &
              EOF

  tags = {
    Name = each.value.nombre
  }
}
````

Otro cambio es en el load balancer, teníamos una lista de todas las subnet, pero podemos hacer un for para 
recuperar todas las subnet y no tener que hacer la lista o cambiarla a mano en lugar de estar parametrizada. 

````terraform
resource "aws_lb" "alb" {
  load_balancer_type = "application"
  name               = "terraformers-alb"
  security_groups    = [aws_security_group.alb.id]

  subnets = [data.aws_subnet.az_a.id, data.aws_subnet.az_b.id]
}
````

Cambiaríamos la lista por un for al map:

````terraform
resource "aws_lb" "alb" {
  load_balancer_type = "application"
  name               = "terraformers-alb"
  security_groups    = [aws_security_group.alb.id]

  subnets = [for subnet in data.aws_subnet.public_subnet : subnet.id]
}
````

Por último tenemos un attachment a cada uno de los servidores 

````terraform
resource "aws_lb_target_group_attachment" "servidor_1" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.servidor_1.id
  port             = var.puerto_servidor
}
````

Al cambiarlo quedaría así: 

````terraform
resource "aws_lb_target_group_attachment" "servidor" {
  for_each = var.servidores

  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.servidor[each.key].id
  port             = var.puerto_servidor
}
````

Puedes ver el resultado final en el fichero [main.tf](Ejemplos/09-refactor-load-balancer/main.tf)

También tendremos que cambiar el fichero [output.tf](Ejemplos/09-refactor-load-balancer/outputs.tf) para reducir la duplicación.

````terraform
output "dns_publica_servidores" {
  description = "DNS pública del servidor"
  value       = [for servidor in aws_instance.servidor : "http://${servidor.public_dns}:${var.puerto_servidor}"]
}
````

## Modulos

Que pasa si el fichero `main.tf` empieza a ser muy grande, ¿Cómo modularizamos el código en trozos aislados y reusables?

La solución que da a esto terraform son los módulos. Los módulos son directorios, un directorio donde tengas un main.tf, 
terraform ya lo considera como un módulo. Se puede llamar desde otra carpeta donde tengas otro fichero de configuración tf. 

Ahora vamos a modificar nuestra función para crear dos módulos, por un lado la creación de las instancias y por otro la 
creación del loadbalancer. 

El resultado será la siguiente configuración y la puede consultar en pinchando en [10-Modulos](Ejemplos/10-Modulos):

![img.png](img/Modulos.png)

Partiremos del ejercicio anterior [09-refactor-load-balancer](Ejemplos/09-refactor-load-balancer). 

### Modulos - instancias ec2

Empezaremos la creación del módulo instancias_ec2, para ello tendremos que definir nuestras [variables.tf](Ejemplos/10-Modulos/modulos/instancias-ec2/variables.tf):

- puerto_servidor
- tipo_instancia
- ami_id
- servidores 

Modificaremos alguna variables para que en lugar de generar cosas por defecto podamos pasárselo en la invocación. 
Por ejemplo el id de la subnet, si nuestro módulo solo crea instancias ec2, debería ser abstracto del id de la subnet.

El siguiente paso es crear el [main.tf](Ejemplos/10-Modulos/modulos/instancias-ec2/main.tf), tendremos que ver que 
ficheros son los necesarios para su creación. Posterior mente el [output.tf](Ejemplos/10-Modulos/modulos/instancias-ec2/outputs.tf)

### Modulos - load-balancer

Empezaremos la creación del módulo instancias_ec2, para ello tendremos que definir nuestras [variables.tf](Ejemplos/10-Modulos/modulos/loadbalancer/variables.tf):

- puerto load balancer
- puerto servidor
- subnets
- instancias_ids: Este será el output del apartado anterior que lo necesitaremos como input para este.
- 
El siguiente paso es crear el [main.tf](Ejemplos/10-Modulos/modulos/loadbalancer/main.tf), tendremos que ver que 
ficheros son los necesarios para su creación. Posterior mente el [output.tf](Ejemplos/10-Modulos/modulos/loadbalancer/outputs.tf)

### Aplicar los módulos. 

Por último tendríamos que instanciar estos dos módulos, el código resultante lo puedes encontrar [aquí](Ejemplos/10-Modulos)

Primero tendríamos que llamar al instance-ec2

````terraform
module "servidores_ec2" {
  source = "./modulos/instancias-ec2" # decimos donde está el código

  # Tenemos que iniciar todas las variables que hacían falta y que no tenía el proyecto.  
  tipo_instancia = "t2.micro"

  servidores = {
    for id_ser, datos in var.servidores :
    id_ser => { nombre = datos.nombre, subnet_id = data.aws_subnet.public_subnet[id_ser].id }
  }

  puerto_servidor = local.puerto_servidor
  ami_id          = var.ubuntu_ami[local.region]
}
````

Luego llamaríamos al módulo del load_balancer 

````terraform
module "load_balancer" {
  source = "./modulos/loadbalancer" # decimos donde está el código. 

  # inicializamos las variables que no teníamos antes en default 
  subnet_ids      = [for subnet in data.aws_subnet.public_subnet : subnet.id]
  instancia_ids   = module.servidores_ec2.instancia_ids # Las instancias del módulo ec2. 
  puerto_lb       = local.puerto_lb
  puerto_servidor = local.puerto_servidor
}
````

Por último modificaríamos el output para hacer referencia al output del load balancer: 

````terraform
output "dns_load_balancer" {
  description = "DNS pública del load balancer"
  value       = module.load_balancer.dns_load_balancer
}
````

## Creacion de dos entornos Desarrollo y Produccion

Vamos a crear dos carpetas dev y prod, donde meteremos el main, outputs y variables del ejercicio anterior. 

![img_1.png](img/entornos.png)

luego podemos crear una variable por entorno y hacer referencia a la variable por entorno. 

El ejercicio resuelto lo podemos encontrar [aquí](Ejemplos/11-diferentes-entornos)


## Modulos open source

En terraform registry podemos buscar módulos para tener que evitar crear ciertos módulos. Por ejemplo si buscamos uno de 
instancias de ec2

- [Modulo creación instancia ec2](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest/examples/complete)

Uso del módulo:

````terraform
module "ec2-instance_example_complete" {
  source  = "terraform-aws-modules/ec2-instance/aws//examples/complete"
  version = "5.1.0" # Vesrión que os descarguéis. 
}
````

# Terraform State

## ¿Que es Terraform State?

Es un fichero Json, donde almacenamos las referencias denuestro código Terraform a la infraestructura real. 

Si perdemos el fichero tfstate, Terraform no sabrá la infraestructura que ya fue creada. 

Los secrets o datos vulnerables son expuestos en el estado. 

La API de este dichero es privada, **no** debemos hacer modificaciones manuales.

### Dificultades a solventar

- Cómo vamos a compartir este fichero tfstate si tiene información tan sensible
- Si lo comparto, significa que más de una persona va a acceder a este fichero, como puedo hacer para que no se pisen
los cambios, tendrá que ser con acceso exclusivo. Dos usuarios no deben modificar el estado a la vez. 
- Además si tenemos varios entornos, tendremos que asegurar de aislar el estado en diferentes entornos. Un cambio 
en desarrollo no debe afectar a producción. 

## Almacenar el estado en Git. 

Cuando hablamos de compartir, lo primero que podemos pensar es control de versiones, Git. ¿Es buena idea compartir el 
estado en Git?

No es buena idea compartir el estado en Git, las razones son las siguientes:

- **Errores manuales y frecuentes**: Podemos cometer errores, como por ejemplo olvidarnos de actualizar la copia en local (hacer un pull).
- Es difícil implementar un acceso exclusivo.
- Las contraseñas de los recursos (secrets) son expuestos.

## Terraform backend. 

Ahora que hemos visto que en git no es bueno almacenar el estado, vamos a ver un concepto nuevo, que es el Terraform Backend. 

Este define donde se almacena el estado de Terraform, y define dónde se ejecutan los comandos Terraform (Terraform plan, 
Terraform apply..)

Hasta ahora hemos usando el Backend en local, pero hay mas tipos de backend. 

- **Standard**: Solo implementa el almacenado del estado. Los comandos y operaciones de terraform se ejecutarían usando
el backend local.
- **enhanced** (mejorado): Implementa el almacenado del estado y dónde se ejecutan los comandos de terraform.
  - local: El de por defecto y que ya conocemos
  - remote: Usa el Terraform Cloud, que es un ervicio que provee Hashicorp que es la empresa que mantiene Terraform. 

## Backend en S3

Vamos a escribir un bucket de código en S3, estas primeras pruebas las haremos con un almacenamiento cloud, por la estabilidad 
que dan en cuanto a disponibilidad, por el precio que tiene y por la facilidad de creación. 

Vamos a crear un fichero [main.tf](Ejemplos/12-backend-s3)

Como siempre tenemos que decir el provider para decir que sea AWS: 

````terraform
provider "aws" {
  region = "eu-west-3"
}
````

Luego el resource que queremos, tendrá comentarios sobre lo que hace cada paso: 

````terraform
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-infraestructura-como-codigo" # Referencia al nombre del bucket

  lifecycle { # aquí pondremos un meta argumento de terraform
    prevent_destroy = true # Bajo ningún concepto puedo destruir este elemento. 
  }

  versioning { # El versionado nos va a permitir ir a versiones anteriores. 
    enabled = true
  }

  server_side_encryption_configuration { # Encriptación en el disco
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
````

Podemos ejecutarlo y nos creará el bucket. 

Ahora vamos a crear la tabla de DynamoDB donde podremos tener los locks:

````terraform
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-infraestructura-como-codigo-locks" # Nombre de la tabla
  billing_mode = "PAY_PER_REQUEST" # El tipo de pago
  hash_key     = "LockID" # El identificador de la tabla

  attribute { # Definimos la columna. 
    name = "LockID"
    type = "S"
  }
}
````

Ahora tenemos la infraestuctura que queremos para usarla en nuestro código. 

Ahora vamos a crear un bloque donde pondremos configuración propia de terraform y definiremos donde estará el fichero state. 

````terraform
terraform {
  backend "s3" { # Elemento backend
    bucket = "terraform-infraestructura-como-codigo" # El bucket que hemos creado
    key    = "servidor/terraform.tfstate" # En que parte vamos a almacenar este bucker. Podemos tener diferentes carpetas para un entorno.
    region = "eu-west-3" # Region

    dynamodb_table = "terraform-infraestructura-como-codigo-locks" # Donde tenemos la tabla de dynamo. 
    encrypt        = true # y vamos a decir que esté encriptado. 
  }
}
````

Ahora tendremos que hacer ``terraform init`` para que se inicialice con la nueva configuración. 

Nos preguntará si queremos hacer una copia del state en s3. Pulsamos si y nos lo copiará. 

Ahora vamos a crear un servidor, un recurso de instancia de aws:

````terraform
resource "aws_instance" "servidor" {
  ami           = "ami-05b5a865c3579bbc4"
  instance_type = "t2.micro"
}
````

Ahora vamos a simular que somos dos usuarios tocando a la vez el mismo fichero. Para ello ejecutaremos `terraform apply`
con dos terminales a la vez. Veremos que uno obtendrá el fichero y el otro no podrá cogerlo.

El problema de usar S3, es que hemos teniedo que conectarnos a AWS para montar un S3 que nos permitirá montar cosas en AWS, 
y no queda muy lógico. Para solucionarlo usaremos terraform cloud 


## Terraform Cloud

Ahora vamosa a probar la solución que nos da Terraform, que es Terraform Cloud. 
Primero vamos a crearnos un fichero [main.tf](Ejemplos/13-terraform-cloud/main.tf) y crearemos el provider y el resource
del servidor que hemos creado en el anterior ejercicio:

````terraform
provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "servidor" {
  ami = "ami-05b5a865c3579bbc4"
  instance_type = "t2.micro"
}
````

Ahora tendremos que hacer a la siguiente url [Terraform Cloud](https://app.terraform.io/app/TheBridge/workspaces/new). 

Nos tendremos que crear una organización si no la tenemos y luego podremos ver nuestros proyectos o workspaces:

![img.png](img/terraform_cloud.png)

Ahora vamos a crear un nuevo workspace, un proyecto nuevo. 

Vamos a seleccionar que tipo de workflow queremos, podríamos seleccionar para crearlo con un trigger desde una pull request 
por ejemplo, vamos vamos a crearlo desde nuestra máquina:

![img.png](img/terraform_cloud_v2.png)

En el siguiente paso le damos nombre y descripción y le damos a crear.

![img.png](img/terraform_cloud_v3.png)

Ahora si vemos la web nos pedirá hacer Terraform login para dar las creadenciales. 

![img.png](img/terraform_cloud_v4.png)

Al hacerlo, nos pedirá que accedeamos a una web y que le demos el token que ha generado

![img.png](img/terraform_cloud_v5.png)

Al ingresarlo estaremos conectados:

![img.png](img/terraform_cloud_v6.png)

Ahora vamos a usar el paso número 2, que es lo que nos pide la configuración después del login. Tendríamos que copiar 
el código en nuestro [main.tf](Ejemplos/13-terraform-cloud)

````terraform
terraform {
  cloud {
    organization = "TheBridge"

    workspaces {
      name = "terraform-infraestructura-como-codigo"
    }
  }
}
````

Ahora tenemos que darle acceso a Terraform Cloud para que acceda a AWS. Nosotros estamos usando credentials dentro de 
aws para logarnos, pero hará falta que Terraform se logue dentro de AWS. 

Si imprimimos lo que tenemos en `.aws/credentials` veremos nuestras credenciales. Si en Terraform en nuestro Workdspace, 
nos vamos a Variables vamos a definir unas variables de entorno, y aquí crearemos dos varaibles de entorno, la access key
y la secret key. Además le daremos a secret par que no se lo muestre a nadie. 

![img.png](img/terraform_cloud_07.png)

Con esto crearemos la variable `AWS_ACCESS_KEY_ID` y la variable `AWS_SECRET_ACCESS_KEY`

Ahora vamos a hacer un `terraform init`, antes borraremos el terraform.lock porque podemos tener problemas. 

Al hacer el `terraform apply`, nos dirá que va a ejecutarse en Terraform Cloud y nos dará una url, donde podremos 
ver de manera gráfica la ejecución y aceptarlo desde la interfaz gráfica o desde la terminal:

![img_1.png](img/terraform_cloud_08.png)

Si le damos a aplicar los cambios, luego tendremos que hacer un `terraform desploy` para borrarlos. Con esto nuestro 
terraform play nos saldrá de manera gráfica. 

![img.png](img/terraform_cloud_09.png)

## Terraform Workspaces

Ahora vamos a ver los workspace, que nos va a permitir crear distintos entornos. 

Si hacemos ``terraform workspaces list`` podremos ver los distintos workspace. 

Si hacemos `terraform workspaces --help` podremos ver las funcionalidades:

- delete    Delete a workspace
- list      List Workspaces
- new       Create a new workspace
- select    Select a workspace
- show      Show the name of the current workspace

Crear un nuevo workspace y seleccionarlo, nos permitirá ejecutar sin partir del state que ya teníamos, esta sería 
una forma de tener el workspace de dev y pro por ejemplo y ser ejecuciones aisladas. 

Esto solo podemos hacerlo si tenemos el state en la cloud.

## Terraform Graph

Vamos a ver una solución de terraform que nos permite ver un gráfico de todos los recursos que tenemos creados, para 
verlo de una forma más simple que el ``terraform plan``. Sería aplicar teoría de gráficos en los planes de arquitectura. 

Para ejecutar esto, tendremos que hacer terraform graph. Esto nos devolverá un plan en texto. Pero si usamos la app [Graphviz](https://graphviz.org/)
Si estamos en linux la podemos instalar con esta línea:

````bash
sudo apt install graphviz
````

Podemos ejecutagr luego la siguiente línea que nos descargará el gráfico de la ejecución en un fichero png:

````bash
terraform graph | dot -Tpng -o plan.png
````

Esto nos creará un gráfico con todas las dependencias. 

![img.png](img/terraform_graph.png)


## Importar infraestructura

Ahora otra cosa importante es ver como podríamos importar infraestructura que hemos creado previo a usar terraform a nuestra implementación
de arquitectura con terraform. 

Por ejemplo si nos creamos una nueva instancia, podríamos importarla usando `terraform import` a nuestro plan, para que al intentar crearla 
de nuevo, por ejemplo con un apply no la cree dos veces. 

Nos pedirá dos argumentos, el recurso donde queremos relacionar esa instancia, y el identificador que ha dado amazon a la instancia.

```bash
terraform import aws_instance.servidor i-00ebabdf61f9a3 # primero la referencia del recurso y luego la instancia. 
```
Si ejecutamos los lo importará y al ejecutar el terraform apply no nos pedirá crear de nuevo ese servidor. 

## Renombrar un servidor

Si tenemos un sevidor creado y lo queremos renombrar cambiando el nombre al recurso, nos dirá que va a destruirlo y 
crearlo de nuevo, esto es porque terraform solo ha detectado que el servidor que tenía en el terraform plan no existe y 
estás creado uno nuevo. 

Para solo renombrarlo tendríamos que ir a ``terraform state``. Si usamos ``terraform state mv`` y ponemos el original
y el destino, nos renombrará el servidor. 
