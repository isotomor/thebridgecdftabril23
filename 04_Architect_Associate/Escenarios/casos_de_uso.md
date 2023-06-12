# Casos de uso

## Caso de uso 1

Una empresa ejecuta una aplicación web pública de tres niveles en una VPC en varias zonas de disponibilidad. 
Las instancias de Amazon EC2 para el nivel de aplicación que se ejecutan en subredes privadas deben descargar parches de 
software de Internet. Sin embargo, no se puede acceder directamente a las instancias EC2 desde Internet.
- ¿Qué medidas se deben adoptar para que las instancias EC2 puedan descargar los parches necesarios? (Selecciona DOS):

1. Configurar una gateway NAT en una subred pública.
2. Definir una tabla de enrutamiento personalizada con una ruta a la gateway NAT para el tráfico de Internet y asociarla a las subredes privadas para el nivel de aplicación.
3. Asignar direcciones IP elásticas a las instancias EC2.
4. Definir una tabla de enrutamiento personalizada con una ruta a la gateway de Internet para el tráfico de Internet y asociarla a las subredes privadas para el nivel de aplicación.
5. Configurar una instancia NAT en una subred privada.

## Caso de uso 2

Un arquitecto de soluciones desea diseñar una solución para ahorrar costes en las instancias de Amazon EC2 que no 
necesitan ejecutarse durante un cierre de la empresa de 2 semanas. Las aplicaciones que se ejecutan en las instancias 
EC2 almacenan datos en la memoria de las instancias que deben estar presentes cuando estas reanuden su funcionamiento.
- ¿Qué enfoque debe recomendar el arquitecto de soluciones para cerrar y reanudar las instancias EC2?


1. Modificar la aplicación para almacenar los datos en volúmenes de almacenes de instancias. Volver a conectar los volúmenes mientras los reinicia.
2. Realizar una instantánea de las instancias EC2 antes de detenerlas. Restaurar la instantánea después de reiniciar las instancias.
3. Ejecutar las aplicaciones en instancias EC2 habilitadas para hibernación. Poner en hibernación las instancias antes del cierre de laempresa de 2 semanas.
4. Anotar la zona de disponibilidad de cada instancia EC2 antes de detenerla. Reiniciar las instancias en las mismas zonas de disponibilidad después del cierre de la empresa de 2 semanas.

## Caso de uso 3

Una empresa tiene previsto ejecutar una aplicación de monitorización en una instancia de Amazon EC2 en una VPC. 
Las conexiones se realizan a la instancia EC2 mediante la dirección IPv4 privada de la instancia. Un arquitecto de 
soluciones debe diseñar una solución que permita que el tráfico se dirija rápidamente a una instancia EC2 en espera si 
la aplicación falla y es inaccesible.
- ¿Qué enfoque cumple estos requisitos?

1. Implementar un Application Load Balancer configurado con un agente de escucha para la dirección IP privada y registrar la instancia EC2 principal con el balanceador de carga. En caso de error, anular el registro de la instancia y registrar la instancia EC2 en espera.
2. Configurar un conjunto de opciones DHCP personalizadas. Configurar DHCP para que asigne la misma dirección IP privada a la instancia EC2 en espera cuando se produzca un error en la instancia EC2 principal.
3. Asociar una interfaz de red elástica secundaria a la instancia EC2 configurada con la dirección IP privada. Mover la interfaz de red a la instancia EC2 en espera si no se puede acceder a la instancia EC2 principal.
4. Asociar una dirección IP elástica a la interfaz de red de la instancia EC2 principal. Disociar la IP elástica de la instancia principal en caso de error y asociarla a una instancia EC2 en espera.

## Caso de uso 4

Una empresa utiliza instancias reservadas de Amazon EC2 para ejecutar su carga de trabajo de procesamiento de datos. 
El trabajo nocturno suele tardar 7 horas en ejecutarse y debe finalizar en un plazo de 10 horas. La empresa prevé un 
aumento temporal en la demanda al final de cada mes que hará que el trabajo supere el límite de tiempo con la capacidad 
de los recursos actuales. Una vez iniciado, el trabajo de procesamiento no se puede interrumpir antes de que termine. 
La empresa quiere implementar una solución que proporcione una mayor capacidad de recursos de la manera más rentable 
posible.
- ¿Qué debe hacer un arquitecto de soluciones para lograr esto?

1. Implementar instancias bajo demanda durante períodos de alta demanda.
2. Crear una segunda reserva de EC2 para instancias adicionales.
3. Implementar instancias de spot durante períodos de alta demanda.
4. Aumentar el tamaño de la instancia EC2 en la reserva de EC2 para asumir el aumento de la carga de trabajo.

## Caso de uso 5

Una empresa tiene un sistema de votación en línea para un programa semanal de televisión en directo. Durante las 
transmisiones, los usuarios envían cientos de miles de votos en cuestión de minutos a una flota front-end de 
instancias de Amazon EC2 que se ejecutan en un grupo de Auto Scaling. Las instancias EC2 escriben los votos en una 
base de datos de Amazon RDS. Sin embargo, la base de datos es incapaz de seguir el ritmo de las solicitudes que 
provienen de las instancias EC2. Un arquitecto de soluciones debe diseñar una solución que procese los votos de la 
manera más eficiente y sin tiempo de inactividad.
- ¿Qué solución cumple estos requisitos?

1. Migrar la aplicación front-end a AWS Lambda. Utilizar Amazon API Gateway para enrutar las solicitudes de los usuarios 
a las funciones Lambda.
2. Escalar la base de datos horizontalmente para convertirla en una implementación Multi-AZ. Configurar la aplicación 
front-end para que escriba en las instancias de base de datos primarias y secundarias.
3. Configurar la aplicación front-end para que envíe votos a una cola de Amazon Simple Queue Service(Amazon SQS). 
Aprovisionar instancias de trabajadores para leer la cola de SQS y escribir la información de votación en la base de 
datos.
4. Utilizar Amazon EventBridge (Amazon CloudWatch Events) para crear un evento programado para volver a aprovisionar la
base de datos con instancias más grandes y optimizadas de memoria durante los períodos de votación. Al terminar la 
votación, volver a aprovisionar la base de datos para usar instancias más pequeñas.

## Caso de uso 6

Una empresa tiene una arquitectura de aplicaciones de dos niveles que se ejecuta en subredes públicas y privadas. 
Las instancias de Amazon EC2 que ejecutan la aplicación web se encuentran en la subred pública y una instancia EC2 para 
la base de datos se ejecuta en la subred privada. Las instancias de la aplicación web y la base de datos se ejecutan en 
una sola zona de disponibilidad (AZ).
- ¿Qué combinación de pasos debe utilizar un arquitecto de soluciones para proporcionar una alta disponibilidad para 
esta arquitectura? (Selecciona DOS).

1. Crear nuevas subredes públicas y privadas en la misma zona de disponibilidad.
2. Crear un grupo de Amazon EC2 Auto Scaling y Application Load Balancer que abarque varias zonas de disponibilidad 
para las instancias de aplicaciones web.
3. Agregar las instancias de aplicaciones web existentes a un grupo de Auto Scaling detrás de un Application Load 
Balancer.
4. Crear nuevas subredes públicas y privadas en una nueva zona de disponibilidad. Crear una base de datos mediante una 
instancia EC2 en la subred pública de la nueva zona de disponibilidad. Migrar el contenido de la base de datos antigua 
a la nueva base de datos.
5. Crear nuevas subredes públicas y privadas en la misma VPC, cada una en una nueva zona de disponibilidad. Crear una 
instancia de base de datos Multi-AZ de Amazon RDS en las subredes privadas. Migrar el contenido de la base de datos 
antigua a la nueva instancia de base de datos.

## Caso de uso 7

Un sitio web ejecuta una aplicación web personalizada que recibe una ráfaga de tráfico todos los días al mediodía. 
Los usuarios cargan nuevas imágenes y contenido a diario, pero se han quejado de los tiempos de espera. La arquitectura 
utiliza grupos de Amazon EC2 Auto Scaling y la aplicación tarda 1 minuto en iniciarse de forma sistemática al arrancar 
antes de responder a las solicitudes de los usuarios.
- ¿Cómo debe rediseñar la arquitectura un arquitecto de soluciones para responder mejor a los cambios del tráfico?

1. Configurar un balanceador de carga de red con una configuración de inicio lento.
2. Configurar Amazon ElastiCache para Redis para descargar solicitudes directas de las instancias EC2.
3. Configurar una política de escalado por pasos de Auto Scaling con una condición de preparación de instancias EC2.
4. Configurar Amazon CloudFront para que utilice un Application Load Balancer como origen.

## Caso de uso 8 

Una aplicación que se ejecuta en AWS utiliza una implementación de clúster de base de datos Multi-AZ de Amazon Aurora 
para su base de datos. Al evaluar las métricas de rendimiento, un arquitecto de soluciones descubrió que las lecturas 
de la base de datos provocaban una E/S alta y añadían latencia a las solicitudes de escritura en la base de datos.
- ¿Qué debe hacer el arquitecto de soluciones para separar las solicitudes de lectura de las solicitudes de escritura?

1. Habilitar el almacenamiento en caché de lectura directa en la base de datos Aurora.
2. Actualizar la aplicación para que lea desde la instancia en espera Multi-AZ.
3. Crear una réplica de Aurora y modificar la aplicación para que utilice los puntos de enlace apropiados.
4. Crear una segunda base de datos Aurora y vincularla a la base de datos primaria como réplica de lectura.
