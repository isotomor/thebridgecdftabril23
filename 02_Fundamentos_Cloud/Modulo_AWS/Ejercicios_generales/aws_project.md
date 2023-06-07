# Proyecto AWS
Organización: TheBrdige

Miembros:
- Diego Cuya
- David Fernandez
- Jose Angel Diaz

## Objetivo del proyecto:

Crear una tabla en DynamoDB que se actualiza mediante una función Lambda a partir de los datos introducidos en un formulario .html. Los datos del formulario se almacenarán en un bucket S3 de Amazon.

## Resumen:

- Creación de un bucket S3 de Amazon. Dos opciones: desde la interfaz gráfica o desde terminal:
```bash
$ aws s3 s3://bucket-name
```
- Creación de una tabla de DynamoDB. Dos opciones: desde la interfaz gráfica o desde un script de Python:

```py
import boto3

# Crear una instancia del recurso DynamoDB
dynamodb = boto3.resource('dynamodb')

# Crear la tabla en DynamoDB
table = dynamodb.create_table(
    TableName='users',
    KeySchema=[
        {
            'AttributeName': 'ID',
            'KeyType': 'HASH'
        }
    ],
    AttributeDefinitions=[
        {
            'AttributeName': 'ID',
            'AttributeType': 'N'
        }
    ],
    ProvisionedThroughput={
        'ReadCapacityUnits': 5,
        'WriteCapacityUnits': 5
        }
    )

# Esperar hasta que la tabla exista
table.wait_until_exists()

# Imprimir información sobre la tabla
print("La tabla 'users' ha sido creada en DynamoDB.")
```

- Desarrollo del código de la función Lambda en un script de Python. El script lo comprimimos en un .zip para pasarlo luego como argumento en la creación de la función Lambda desde la terminal.

```py
import boto3
import json

def lambda_handler(event, context):

    '''
    Función lambda de AWS.
    El objetivo es actualizar una tabla creada en DynamoDB con los
    datos del archivo JSON.
    Se lanza mediante un trigger que se activa cuando se  modifica
    o se sube un archivo JSON al bucket especificado.

    Args:
        event: evento generado por el trigger.
        context: objeto que proporciona información sobre el
        entorno de ejecución y la invocación de la función.

    Returns:
        Confirmación de la actualización de los datos.
    '''

    # Obtenención del nombre del archivo JSON creado en S3
    bucket = 'proyecto-aws'  # Nombre del bucket de AWS
    key = event['Records'][0]['s3']['object']['key']

    # Creación de una instancia de DynamoDB
    dynamodb = boto3.resource('dynamodb')

    # Obtención de la tabla de DynamoDB
    table = dynamodb.Table('users') # Indicar el nombre de la tabla

    # Lectura del contenido del archivo JSON desde S3
    s3_client = boto3.client('s3')
    response = s3_client.get_object(Bucket=bucket, Key=key)
    json_data = response['Body'].read().decode('utf-8')

    # Conversión del archivo JSON a un diccionario de Python
    data = json.loads(json_data)

    # Guardado de los datos en la tabla de DynamoDB
    table.put_item(Item=data)

    return {
        'statusCode': 200,
        'body': 'Datos guardados en DynamoDB'
    }
```

- Creación de un rol con los permisos necesarios para la ejecución de la función Lambda. Dos opciones:desde la interfaz gráfica o desde terminal:

1. creación de un archivo JSON llamado trust-policy.json con el siguiente contenido para definir la política de confianza del rol

```bash
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

2. Ejecutar el siguiente comando para crear el nuevo rol:

```bash
$ aws iam create-role --role-name my-role --assume-role-policy-document file://trust-policy.json --output text --query 'Role.Arn'
```
> El comando --output text --query 'Role.Arn' se utiliza para obtener solo el ARN (Amazon Resource Name) del rol recién creado como resultado del comando

3. ejecutar los siguientes comandos para añadir las políticas necesarias al rol:

```bash
$ aws iam attach-role-policy --role-name my-role --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess

$ aws iam attach-role-policy --role-name my-role --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess

$ aws iam attach-role-policy --role-name my-role --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
```

- Creación de una función Lambda. Dos opciones: desde la interfaz gráfica o desde terminal:

```bash
$ aws lambda create-function \
  --function-name lambda_name \
  --runtime python3.10 \
  --role arn:aws:iam::aws_user_id:role/lambda_name \
  --handler lambda_function.lambda_handler \
  --zip-file fileb://lambda_function.zip \
  --region eu-west-3
```

> - function name: The name of the Lambda function.
> - runtime: The identifier of the function's runtime . Runtime is required if the deployment package is a .zip file archive.
> - role: The Amazon Resource Name (ARN) of the function's execution role.
> - handler: The name of the method within your code that Lambda calls to run your function. required if the deployment package is a .zip file archive.
> - zip-file: The path to the zip file of the code you are uploading.
> - region: The region to use.

- Creación de un trigger que lanzará la función Lambda. Dos opciones: desde la interfaz gráfica o desde terminal:

```bash
$ aws s3api put-bucket-notification-configuration \
  --bucket proyecto-aws \
  --notification-configuration '{
    "LambdaFunctionConfigurations": [
      {
        "LambdaFunctionArn": "arn:aws:lambda:eu-west-3:aws_user_id:function:lambda_name",
        "Events": ["s3:ObjectCreated:*"],
        "Filter": {
          "Key": {
            "FilterRules": [
              {
                "Name": "suffix",
                "Value": ".json"
              }
            ]
          }
        }
      }
    ]
  }
```

### Hasta aquí hemos configurado todo lo necesario en AWS para desarrollar el proyecto. El siguiente paso es el desarrollo del código HTML. El código lo guardaremos en una carpeta con el nombre "templates" y tendrá el nombre "index.html".

```html
<!DOCTYPE html>
<html>
<head>
    <title>Base de Datos de Usuarios</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
        }
    </style>
</head>
<body>
    <h1>Base de Datos de Usuarios</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Correo electrónico</th>
            <th>Fecha de registro</th>
        </tr>
        {% for user in users %}
        <tr>
            <td>{{ user.ID }}</td>
            <td>{{ user.Nombre }}</td>
            <td>{{ user["Correo electrónico"] }}</td>
            <td>{{ user["Fecha de registro"] }}</td>
        </tr>
        {% endfor %}
    </table>


    <h2>Formulario de Registro</h2>
    <form method="POST" action="/">
        <label for="idInput">ID:</label>
        <input type="text" id="idInput" name="id" required><br><br>

        <label for="nombreInput">Nombre:</label>
        <input type="text" id="nombreInput" name="nombre" required><br><br>

        <label for="correoInput">Correo electrónico:</label>
        <input type="email" id="correoInput" name="correo" required><br><br>
        <label for="fechaInput">Fecha de registro:</label>
        <input type="datetime-local" id="fechaInput" name="fecha" required><br><br>

        <button type="submit">Guardar</button>
    </form>
</body>
</html>
```

### Ya tenemos todo lilsto para desarrollar el código principal de la aplicación en un script de Python:

```py
'''Main Module'''

from flask import Flask, render_template, request, redirect, url_for
import boto3
import json
import time


app = Flask(__name__)

# Configuración de la conexión a S3
s3_client = boto3.client('s3')
bucket_name = 'proyecto-aws'  # Reemplazar con el nombre del bucket en S3

# Configuración de la conexion a DynamoDB
dynamodb = boto3.resource('dynamodb')
table_name = 'users'  # Reemplazar con el nombre de la tabla en DynamoDB
table = dynamodb.Table(table_name)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        # Obtención los datos ingresados en el formulario html
        id = int(request.form['id'])  # Conversión del campo 'ID' a un número entero
        nombre = request.form['nombre']
        correo = request.form['correo']
        fecha = request.form['fecha']

        # Creación del objeto JSON con los datos del usuario
        usuario = {
            "ID": id,
            "Nombre": nombre,
            "Correo electrónico": correo,
            "Fecha de registro": fecha
        }

        # Generación de nombre único para el archivo JSON utilizando la fecha y hora actual
        timestamp = int(time.time())  # Obtiene la marca de tiempo actual en segundos
        file_name = f'datos{timestamp}.json'  # Nombre del archivo JSON

        # Guarda el objeto JSON en S3
        s3_client.put_object(
            Body=json.dumps(usuario),
            Bucket=bucket_name,
            Key=file_name
        )

        time.sleep(3)
        # Redirecciona a la misma página para recargar
        return redirect(url_for('index'))


    # Obtiene todos los usuarios de la tabla en DynamoDB
    response = table.scan()
    users = response['Items']

    return render_template('index.html', users=users)


if __name__ == '__main__':
    app.run()
```

### El siguiente paso del proyecto es conseguir lanzar la aplicación en una instancia EC2 de Amazon.

- Creación de la instancia desde la interfaz gráfica.

- Configurar la instancia para poder ejecutar la aplicación. Para ello podemos hacer uso de un playbook de Ansible:

```bash
---
- name: EC2 init setup
  hosts: aws_test
  vars:
    user_path: /home/ubuntu
    remote_path: /home/vinxu
    awscli_url: 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
  tasks:

    - name: Create ec2_init_config folder
      file:
        path: "{{user_path}}/ec2_init_config"
        state: directory

    - name: Create .aws folder
      file:
        path: "{{user_path}}/.aws"
        state: directory

          #- name: Create aws folder
          #file:
          #path: "{{user_path}}/aws"
          #state: directory

    - name: Create init_requirements folder
      file:
        path: "{{user_path}}/init_requirements"
        state: directory

    - name: Update apt list
      apt:
        update_cache: yes
      become: True

    - name: Install software properties common
      apt:
        name: software-properties-common
        state: latest
      become: True

    - name: Install unzip
      apt:
        name: unzip
        state: latest
      become: True

    - name: Install Python
      apt:
        name: python3
        state: latest
      become: True

    - name: Install pip
      apt:
        name: pip
        state: latest
      become: True

    - name: Download awscliv2.zip
      ansible.builtin.get_url:
        url: "{{awscli_url}}"
        dest: "{{user_path}}/awscliv2.zip"
        mode: '0655'

    - name: Extract awscliv2.zip
      shell: unzip awscliv2.zip -d $HOME/aws
      args:
        chdir: "{{user_path}}"

    - name: Install AWS CLI
      shell: sudo "{{user_path}}"/aws/aws/install --update
      args:
        chdir: "{{user_path}}"
      become: True

    - name: Download requirements.txt file
      copy:
        src: "{{remote_path}}/bootcamp_cloud/aws_ansible/requirements.txt"
        dest: "{{user_path}}/init_requirements"
        mode: 0644

    - name: AWS config file
      copy:
        dest: "{{user_path}}/.aws/config"
        content: |
          [default]
          region = eu-west-3
          output = json
          [profile itadmin]
          region = eu-west-3
          output = json

    - name: Install Python modules
      pip:
        requirements: "{{user_path}}/init_requirements/requirements.txt"
...
```

### Ejecutar en instancia EC2

- Para runear en un servidor publico tenemos que instalar nginx

- A continuación, tenemos que editar un archivo

```bash
$ cd /etc/nginx/sites-available/ ---- aqui creamos un archivo

$ sudo nano nomre.conf ---- y pregmaos esto

$ server {
    listen 80;
    server_name tu_dominio_o_ip;

    location / {
        proxy_pass http://localhost:5000;  # Cambia el puerto si tu aplicación Flask se está ejecutando en un puerto diferente
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

- Ahora para activarlo creamos un enlace simbólico en el directorio en el que creamos el archivo

```bash
$ sudo ln -s /etc/nginx/sites-available/nombre.conf /etc/nginx/sites-enabled/
$ sudo service nginx restart
```

- El siguiente paso es activar los puertos:

```bash
$ sudo ufw status
$ sudo ufw enable
$ sudo ufw allow 80
$ sudo ufw allow 5000
$ sudo ufw status
```
> Esto es para poner el firewall, abrir puertos y checkaaerlo

- Por último editamos el archivo .aws/config y le añadimos:

```bash
aws_access_key_id = TU_ACCESS_KEY_ID
aws_secret_access_key = TU_SECRET_ACCESS_KEY
```

- Modificamos los permisos del archivo y ya lo tendremos todo a punto:
```bash
$ chmod 600 ~/.aws/config
```