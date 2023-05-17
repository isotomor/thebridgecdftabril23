import json
import boto3
import dash
from dash import dcc
from dash import html
import random
import datetime

# Creamos una aplicación Flask
app = dash.Dash(__name__)

# Creamos una aplicación Dash
app.layout = html.Div([
    html.H1('Formulario de Usuarios'),
    dcc.Input(id='nombre', type='text', placeholder='Nombre', value=''),
    dcc.Input(id='email', type='email', placeholder='Email', value=''),
    html.Button('Enviar', id='submit-button', n_clicks=0),
    html.Div(id='output-container-button', children='Hit the button to update.')
])

# Creamos un cliente de boto3 para acceder a S3
s3 = boto3.client('s3')

today = datetime.date.today().strftime('%Y-%m-%d')


# Ruta para manejar la subida de datos del formulario
@app.callback(
    dash.dependencies.Output('output-container-button', 'children'),
    [dash.Input('submit-button', 'n_clicks'),
     dash.Input('nombre', 'value'),
     dash.Input('email', 'value')]
)
def submit_form(n_clicks, nombre, email):
    # Obtenemos los datos del formulario

    # Creamos un diccionario con los datos del usuario
    usuario = {
        'ID': random.randint(100000, 999999),
        'Nombre': nombre,
        'Correo electrónico': email,
        'Fecha de registro': today
    }

    # Guardamos los datos del usuario en un archivo JSON en S3
    s3.put_object(Bucket='formularios-json', Key=f'usuarios{today}.json', Body=json.dumps(usuario))


if __name__ == '__main__':
    app.run_server(port=8080, debug=True)
