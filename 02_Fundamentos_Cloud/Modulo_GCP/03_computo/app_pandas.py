import pandas as pd


def mi_funcion_python():
    # Crear un DataFrame de ejemplo
    data = {
    'Nombre': ['Juan', 'María', 'Pedro', 'Laura', 'Raul'],
    'Edad': [25, 30, 21, 35, 55],
    'Ciudad': ['Madrid', 'Barcelona', 'Sevilla', 'Valencia', 'Galicia']
    }

    df = pd.DataFrame(data)

    # Mostrar el DataFrame
    print(df)

    # Filtrar el DataFrame por edad mayor a 25
    mayores_de_25 = df[df['Edad'] > 25]
    print(mayores_de_25)

    # Calcular el promedio de edad
    promedio_edad = df['Edad'].mean()
    print("Promedio de Edad:", promedio_edad)


if __name__ == '__main__':
    mi_funcion_python()
