![](../../../img/TheBridge_logo.png)

# Amazon Web Services (AWS) - Ejercicios


## Ejercicio 1

Este desarrollo es para una empresa que trabaja con datos y tiene la necesidad de que cada vez que se crea un fichero Json 
en un bucket de almacenamiento de S3, se lance una función que guarde el contenido de ese fichero en una base de datos montada en DynamoDB.

La estructura del Json que reciben es la siguiente:

````json
{
    "ID": 123456,
    "Nombre": "Juan Pérez",
    "Correo electrónico": "juan.perez@example.com",
    "Fecha de registro": "2022-01-01T10:00:00Z"
}
````

La empresa trabaja de manera agile intentando ir al mínimo viable por lo que su primer objetivo es crear una base de datos en
diamoDB, luego crear una función que reciba a mano un json y por último que ese json lo lea desde un almacenamiento S3. 

# Ejercicio 2 

El siguiente requerimiento de la empresa es que una vez que tenga una base solida de usuarios en dynamoDB, quieren 
realizar una página web que muestre toda su base de datos de usuario de esta manera puedan tener un inventario sólido, 
como primeros pasos les sirve realizar la ejecución de la web en local, si ven que es viable se plantean ejecutarlo con EC2.
Como no tienen mucho conocimiento en programación web, el cliente ha concedido a la consultora usar ChatGPT. 

# Ejercicio 3 (Avanzado)

Una vez que tengan realizados los ejercicios anteriores, se plantean la realización de un formulario web para no tener que 
rellenar a mano los json de usuarios y guardarlos en S3. Para ello se plantean crear una aplicación web en el lenguaje que decida 
el proveedor que levante un formulario y que al guardar genere un fichero json en S3. 
Cuando se genere este fichero, al crearse en S3 se disparará automáticamente la función que dispare el primer requerimiento 
y a su vez quedará actualizado en la app de seguimiento de usuarios. 
