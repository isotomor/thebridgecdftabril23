# Ejemplo 1: Aplicación móvil

Supongamos que la aplicación móvil recibe una media de 100 conexiones nuevas por segundo y cada una dura tres minutos.
Un cliente envía una media de cuatro solicitudes por segundo por conexión con 1000 bytes procesados por conexión. Usted
ha configurado 20 reglas en el balanceador de carga para dirigir las solicitudes del cliente. Calculamos los costos
mensuales del balanceador de carga de aplicaciones según el precio de la región EE. UU. Este de la siguiente manera:

- Conexiones nuevas (por segundo): cada LCU proporciona 25 conexiones por segundo. Dado que nuestra aplicación móvil usa
  100 conexiones nuevas por segundo, esto equivale a 4 LCU (100 conexiones por segundo/25 conexiones por segundo).
- Conexiones activas (por minuto): cada LCU proporciona hasta 3000 conexiones activas por minuto. Dado que la aplicación
  móvil recibe 100 conexiones por segundo y cada una dura tres minutos, esto equivale a un máximo de 18 000 conexiones
  activas por minuto o 6 LCU (18 000 conexiones activas por minuto/3000 conexiones activas por minuto).
- Bytes procesados (GB por hora): cada LCU proporciona 1 GB por hora. Dado que nuestra aplicación móvil transfiere una
  media de 1000 bytes de datos por conexión, esto equivale a 0,36 GB por hora o 0,36 LCU (0,36 GB/1 GB).
- Evaluaciones de reglas (por segundo): cada LCU proporciona 1000 evaluaciones de reglas por segundo. Dado que la
  aplicación recibe cuatro solicitudes por segundo por conexión, esto equivale a 400 solicitudes por segundo en todas
  las conexiones. Con 20 reglas configuradas, esto resulta en un máximo de 4000 evaluaciones de reglas por segundo (20
  reglas configuradas - 10 reglas gratis) \* 400 o 4 LCU (4000 evaluaciones de reglas por segundo/1000 evaluaciones de
  reglas por segundo).

Al utilizar estos valores, la tarifa por hora se calcula con base en la LCU máxima consumida en las cuatro dimensiones.
En este ejemplo, las conexiones activas (6 LCU) son mayores que las conexiones nuevas (4 LCU), el ancho de banda (0,36
LCU) y las evaluaciones de reglas (4 LCU). Esto da como resultado un cargo total de:

- 0,048 USD por hora (6 LCU \* 0,008 USD), o:
- 34,56 USD por mes (0,048 USD \* 24 horas \* 30 días)

# Ejemplo 2: balanceador de carga de aplicaciones solo con destinos de AWS Lambda

Supongamos que la aplicación recibe un promedio de 100 conexiones nuevas por segundo y que cada una dura 200
milisegundos. Un cliente envía una media de 100 solicitudes por segundo y 14 KB son los bytes procesados para las
solicitudes y respuestas de AWS Lambda durante la duración de la conexión. Usted ha configurado 20 reglas en el
balanceador de carga para dirigir las solicitudes del cliente. Calculamos los costos mensuales del balanceador de carga
de aplicaciones según el precio de la región EE. UU. Este 1 de la siguiente forma:

- Conexiones nuevas (por segundo): cada LCU proporciona 25 conexiones nuevas por segundo (cantidad media por hora). Como
  la aplicación recibe 100 conexiones nuevas por segundo, esto equivale a 4 LCU (100 conexiones por segundo/25
  conexiones por segundo).
- Conexiones activas (por minuto): cada LCU proporciona hasta 3000 conexiones activas por minuto. La aplicación recibe
  100 conexiones nuevas por segundo y cada una de ellas dura 200 milisegundos. Esto equivale a 100 conexiones activas
  por minuto o 0,03 LCU (100 conexiones activas por minuto/3000 conexiones activas por minuto).
- Bytes procesados (GB por hora): cada LCU proporciona 0,4 GB por hora para el tráfico Lambda. Dado que cada conexión de
  cliente transfiere una media de 14 KB de datos, esto equivale a 5,04 GB por hora (14 KB de bytes procesados por
  solicitud y respuesta \* 100 solicitudes por segundo \* 3600 segundos) o 12,6 LCU (5,04 GB/0,4 GB) por hora.
- Evaluaciones de regla (por segundo): por una cuestión de simplicidad, suponga que todas las reglas configuradas se
  procesan para una solicitud. Cada LCU ofrece 1000 evaluaciones de reglas por segundo (cantidad media por hora). Dado
  que la aplicación recibe 100 solicitudes por segundo, 20 reglas procesadas por cada solicitud equivale a un máximo de
  1000 evaluaciones de reglas por segundo (20 reglas procesadas – 10 reglas gratis) \* 100 o 1 LCU (1000 evaluaciones de
  reglas por segundo/1000 evaluaciones de regla por segundo).

En este caso, la dimensión con mayor uso de LCU es la dimensión de bytes procesados y, por tanto, emplearemos el uso de
LCU para la dimensión de bytes procesados en nuestros cálculos de facturación. El cargo de LCU por hora es 0,1008 USD (
12,6 LCU\*0,008 por LCU). Al agregar el cargo por hora de 0,0225 USD, los costos totales del balanceador de carga de
aplicaciones son los siguientes:

- 0,1233 USD por hora (cargo de 0,0225 USD por hora + cargo de 0,1008 USD por LCU); o
- 88,78 USD por mes (0,1233 USD \* 24 horas \* 30 días).

100 solicitudes por segundo equivale a 259,2 millones (100 \* 3600 \* 24 \* 30) de solicitudes al mes. Esto equivale a
0,34 USD por millón de solicitudes (88,78 USD/259,2)

# Ejemplo 3: balanceador de carga de aplicaciones con destinos de Amazon EC2 y AWS Lambda

Supongamos que la aplicación recibe un promedio de una conexión nueva por segundo y que cada una dura dos minutos. Un
cliente envía una media de 50 solicitudes por segundo. El total de bytes bidireccionales que se transfieren a través del
balanceador de carga por cada solicitud/respuesta es de 10 KB. En promedio, el 60 por ciento de las solicitudes se
entregan por instancias de Amazon EC2 como destino y el 40 por ciento por funciones de AWS Lambda como destino. Usted ha
configurado 50 reglas en el balanceador de carga para dirigir las solicitudes de los clientes. Calculamos los costos
mensuales del balanceador de carga de aplicaciones según el precio de la región EE. UU. Este 1 de la siguiente forma:

- Conexiones nuevas (por segundo): cada LCU proporciona 25 conexiones nuevas por segundo (cantidad media por hora). Como
  la aplicación recibe una conexión nueva por segundo, esto equivale a 0,04 LCU (una conexión por segundo/25 conexiones
  por segundo).
- Conexiones activas (por minuto): cada LCU proporciona hasta 3000 conexiones activas por minuto. La aplicación recibe
  una nueva conexión por segundo, cada una de las cuales dura dos minutos. Esto equivale a 120 conexiones activas por
  minuto o 0,04 LCU (120 conexiones activas por minuto/3000 conexiones activas por minuto).
- Bytes procesados (GB por hora): cada LCU proporciona 1 GB de bytes procesados por hora para los destinos de Amazon
  EC2. Dado que cada conexión de cliente transfiere una media de 300 KB de datos para una instancia EC2 como destino,
  esto equivale a 1,08 GB por hora o 1,08 LCU (1,08 GB/1 GB) para destinos EC2. Cada LCU proporciona 0,4 GB de bytes
  procesados para destinos de AWS Lambda. Dado que cada conexión de cliente transfiere 200 KB para destinos Lambda, esto
  equivale a 0,72 GB por hora o 1,8 LCU (0,72 GB/0,4 GB) para destinos de Lambda. El uso total de LCU para una dimensión
  de bytes procesados en destinos EC2 y Lambda es de 2,88 LCU.
- Evaluaciones de regla (por segundo): por una cuestión de simplicidad, suponga que todas las reglas configuradas se
  procesan para una solicitud. Cada LCU ofrece 1000 evaluaciones de reglas por segundo (cantidad media por hora). Dado
  que la aplicación recibe 50 solicitudes por segundo, 50 reglas procesadas por cada solicitud equivale a un máximo de
  2000 evaluaciones de reglas por segundo (50 reglas procesadas – 10 reglas gratis) \* 50 o 2,00 LCU (2000 evaluaciones
  de reglas por segundo/1000 evaluaciones de reglas por segundo).

Al utilizar estos valores, la tarifa por hora se calcula con base en la LCU máxima consumida en las cuatro dimensiones.
En este ejemplo, el uso de LCU por dimensión de bytes procesados (2,88 LCU) es mayor que las conexiones nuevas (0,04
LCU), las conexiones activas (0,04 LCU) y las evaluaciones de reglas (2,00 LCU), lo que resulta en un cargo total de
0,0230 USD por hora (2,88 LCU \* 0,008 USD por LCU) o 16,56 USD por mes (0,0230 USD \* 24 horas \* 30 días).

Al agregar el cargo por hora de 0,0225 USD, los costos totales del balanceador de carga de aplicaciones son los
siguientes:

- 0,0455 USD por hora (cargo de 0,0225 USD por hora + cargo de 0,0230 USD por LCU); o
- 32,76 USD por mes (0,0455 USD \* 24 horas \* 30 días)

El balanceador de carga recibe 20 solicitudes por segundo para destinos Lambda, lo que equivale aproximadamente a 51,8
millones de solicitudes al mes. El costo de uso mensual de LCU para las solicitudes de AWS Lambda es de 10,37 USD (cargo
de 1,8 LCU/hora \* 24 horas \* 30 días\* 0,008 USD por LCU). Esto equivale a 0,20 USD por millón de solicitudes como
costos de uso de LCU en destinos Lambda.