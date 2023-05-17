from flask import Flask, render_template, request, redirect
import boto3
import datetime
import json
import time

# Cargamos la Informacion de DynamoDB
dynamo_client = boto3.resource('dynamodb').Table('usuarios')


#Inicializamos la app
app = Flask(__name__)
    
#Ejecución
@app.route('/', methods=['GET', 'POST'])
def get_items():
    if request.method == 'POST':
        try:
            user_dict= json.dumps({"nombre":request.form['nombre'],"correo":request.form['correo'],"fecha":str(datetime.datetime.utcnow())}, indent=2, default=str)
            nombre = request.form['nombre'].replace(' ', '')
            file_name = f"{nombre}.json"
            client = boto3.client('s3')
            client.put_object(
                Bucket='usuarios-jsons', 
                Key=file_name,
                Body=user_dict)
            time.sleep(2)
            return redirect('/')
        except:
            return 'There was an issue updating'
    else:
        usuarios  = dynamo_client.scan()['Items']
        return render_template('index.html', tasks=list(usuarios))

@app.route('/nuevo_usuario/')
def nuevo_usuario():
    return render_template('nuevo_usuario.html')


if __name__ == '__main__':
    app.run()


