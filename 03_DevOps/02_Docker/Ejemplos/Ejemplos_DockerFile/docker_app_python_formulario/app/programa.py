from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, BooleanField, SelectField
from wtforms.validators import DataRequired, ValidationError
from flask import Flask, render_template

carreras = (('Derecho', 'Derecho'), ('Medicina', 'Medicina'), ('Sistemas', 'Sistemas'), ('Diseño', 'Diseño'))

        
class DatosEstudiante(FlaskForm):

    def valida_promedio(form, field):
        try:
            numero = float(field.data)
        except:
            raise ValidationError('Debe de ingresar un número')
        if numero < 0 or numero > 10:
            raise ValidationError('Debe de ingresar un número entre 0 y 10')        

    nombre = StringField('Nombre', [DataRequired()], default = '')
    primer_apellido = StringField('Primer apellido', [DataRequired()], default = '')
    segundo_apellido = StringField('Segundo apellido', default = '')
    carrera = SelectField('Carrera', [DataRequired()], choices = carreras)
    semestre = SelectField('Semestre', [DataRequired()], choices = [(str(x), str(x)) for x in range(1, 50)])
    promedio = StringField('Promedio', [DataRequired(), valida_promedio], default = '0')
    alcorriente = BooleanField('Al corriente de pagos')
    enviar = SubmitField('Enviar')
    
            
app = Flask(__name__)
app.config['SECRET_KEY']='miClaveSuperSecreta'


def cargarDatos():
    with open('data/alumnos.txt', 'tr') as archivo:
        base = eval(archivo.read())
    cuenta=[]
    for c in base:
        cuenta.append(c['cuenta'])
    ucuenta = max(cuenta)
    return base, ucuenta


def guardarDatos(base):
    with open('data/alumnos.txt','w') as archivo:
        strbase = str(base)
        archivo.writelines(strbase)


@app.route('/', methods=['GET', 'POST'])
def index():
    base, ucuenta = cargarDatos()
    nuevo = dict()
    formulario = DatosEstudiante()
    if formulario.validate_on_submit():
        ucuenta+=1
        for campo in ['nombre', 'primer_apellido', 'segundo_apellido', 'carrera', 'semestre', 'promedio', 'alcorriente']:
            nuevo['cuenta']=ucuenta
            nuevo[campo]=formulario[campo].data
        base.append(nuevo)
        print("añadiendo...")
        print(base)
        guardarDatos(base)
    return render_template('formulario3.html', form=formulario)


if __name__ == '__main__':
    app.run(host='0.0.0.0')