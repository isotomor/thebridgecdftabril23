import boto3
import dash
from dash import html

# Configura la conexión a la tabla de DynamoDB
dynamodb = boto3.resource('dynamodb')
tabla_usuarios = dynamodb.Table('tablon_usuarios')

# Obtener los elementos de la tabla
response = tabla_usuarios.scan()
items = response['Items']

# Crea una aplicación de Dash
app = dash.Dash(__name__)

# Crea el diseño de la aplicación
app.layout = html.Div(children=[
    html.H1(children='Tabla de usuarios'),

    # Crea la tabla utilizando Dash y la biblioteca PrettyTable
    dash.dash_table.DataTable(items)
])

if __name__ == '__main__':
    # Ejecuta la aplicación
    app.run_server(debug=True)
