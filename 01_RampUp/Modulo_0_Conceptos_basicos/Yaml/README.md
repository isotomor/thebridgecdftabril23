![](../../img/TheBridge_logo.png)

# YAML
***

![img_4.png](../img/Yaml_logo.png)

AML es un lenguaje de serialización de datos que suele utilizarse en el diseño de archivos de configuración.

En este documento veremos los conceptos básicos de YAML, que usaremos más adelante.

El inicipio de un cocumento comienta con tres guiones *---*

## Comentarios

Para escribir comentarios usaremos la tecla almuadilla *#*. Yaml admite comentarios de una sola línea.  

````yaml
---
# Esto s un comentario
````

## Tipos Escalar

Nuestro objeto raíz (que continúa para todo el documento) será un mapa, que es equivalente a un diccionario, hash u objeto 
en otros idiomas. 

````yaml
clave :  valor 
otra_clave :  Otro valor va aquí. 
a_number_value :  100 
Scientific_notation :  1e+12 
````

El número 1 será interpretado como un número y no como un booleano. 
Si quiere que se interprete como un valor boleano, debe usar true. 

````yaml
booleano :  verdadero 
valor_nulo :  nulo 
otro_valor_nulo :  ~ 
clave con espacios :  valor
````

Yes y no, se evalúan como valores booleanos (verdaderos y falsos respectivamente):
Para poder usar el valor real (string) se debe usar comillas símples o dobles. 

````yaml
no :  no             # se evalúa como "falso": false 
yes :  no            # se evalúa como "verdadero": false 
no_encerrado :  yes  # se evalúa como "no_encerrado": true 
encerrado :  "yes"    # se evalúa como "cerrado": yes
````

Tenga en cuenta que las cadenas no necesitan estar entrecomilladas. Sin enbargo, pueden ponerse con comillas:

````yaml
however: 'A string, enclosed in quotes.'
'Keys can be quoted too.': "Useful if you want to put a ':' in your key."
single quotes: 'have ''one'' escape pattern'
double quotes: "have many: \", \0, \t, \u263A, \x0d\x0a == \r\n, and more."
````

Los caracteres especiales deben estar entre comillas simples o dobles

````yaml
caracteres_especiales :  "[ John ] & { Jane } - <Doe>"
````

Las cadenas de varias líneas se pueden escribir como un 'bloque literal' (usando |), o como un 'bloque plegado' (usando '>').

- El bloque literal convierte cada salto de línea dentro de la cadena en un salto de línea literal (\n).
- El bloque plegado elimina las líneas nuevas dentro de la cadena.

````yaml
# Bloque literal
literal_block: |
  This entire block of text will be the value of the 'literal_block' key,
  with line breaks being preserved.

  The literal continues until de-dented, and the leading indentation is
  stripped.

      Any lines that are 'more-indented' keep the rest of their indentation -
      these lines will be indented by 4 spaces.
````

````yaml
# Bloque plegado
folded_style: >
  This entire block of text will be the value of 'folded_style', but this
  time, all newlines will be replaced with a single space.

  Blank lines, like above, are converted to a newline character.

      'More-indented' lines keep their newlines, too -
      this text will appear over two lines.
````

|- and >- elimina las líneas en blanco finales (también llamadas "tiras" literales/de bloque)

```yaml
literal_strip: |-
  This entire block of text will be the value of the 'literal_block' key,
  with trailing blank line being stripped.
```
````yaml
block_strip: >-
  This entire block of text will be the value of 'folded_style', but this
  time, all newlines will be replaced with a single space and 
  trailing blank line being stripped.
````

|+ and >+  mantiene líneas en blanco al final (también llamado literal/bloque "mantener")

```yaml
literal_keep: |+
  This entire block of text will be the value of the 'literal_block' key,
  with trailing blank line being kept.
```
````yaml
block_keep: >+
  This entire block of text will be the value of 'folded_style', but this
  time, all newlines will be replaced with a single space and 
  trailing blank line being kept.
````

## Collection Types

El anidamiento usa sangría. Se prefiere una sangría de 2 espacios (pero no es obligatorio).

````yaml
a_nested_map:
  key: value
  another_key: Another Value
  another_nested_map:
    hello: hello
````

Los mapas no tienen que tener claves de cadena. 
````yaml
0.25: a float key
````

Las teclas también pueden ser complejas, como objetos de varias líneas ¿Usamos? seguido de un espacio para indicar el inicio de una clave compleja.
````yaml
? |
  This is a key
  that has multiple lines
: and this is its value
````


YAML también permite el mapeo entre secuencias con la sintaxis de clave compleja
Las secuencias (equivalentes a listas o arrays) se ven así

````yaml
a_sequence : 
  -  Elemento 1 
  -  Elemento 2 
  :  0,5   # secuencias pueden contener tipos dispares. 
  -  Elemento 4 
  -  clave :  valor
    otra_clave :  otro_valor 
  -  -  Esta es una secuencia 
    -  dentro de otra secuencia 
  -  -  -  Indicadores de secuencia anidados 
      -  se pueden contraer
````

Dado que YAML es un superconjunto de JSON, también puede escribir mapas de estilo JSON y secuencias
````yaml
json_map :  {  "clave" :  "valor"  } 
json_seq :  [  3 ,  2 ,  1 ,  "despegue"  ] 
y las comillas son opcionales :  {  clave :  [  3 ,  2 , 1 ,  despegue  ]  } 
````

## Caracteres adicionales en YAML

YAML también tiene una función útil llamada 'anclas', que le permite duplicar fácilmente contenido en su documento

Anclajes identificados por & carácter que definen el valor.

Alias identificados por el carácter * que actúa como comando "ver arriba".

Ambas claves tendrán el mismo valor: 

````yaml
contenido_anclado :  &nombre_ancla  # Esta cadena aparecerá como el valor de dos claves. 
otro_ancla :  *nombre_ancla 
````

Las anclas se pueden usar para duplicar/heredar propiedades

````yaml
base :  &base
  nombre :  Todos tienen el mismo nombre 
````

La expresión regular << se llama 'Fusionar clave de tipo independiente del idioma'. Se utiliza para:

indicar que todas las claves de uno o más mapas especificados deben insertarse en el mapa actual. 

NOTA: Si la clave ya existe, el alias no se fusionará

````yaml
base :  &base
  nombre :  Todos tienen el mismo nombre 

foo : 
  << :  *base  # no fusiona el ancla 
  edad :  10 
  nombre :  John 
bar : 
  << :  *base  # base ancla se fusionará 
  edad :  20 
````

foo y el bar también tendría nombre: Todos tienen el mismo nombre

YAML también tiene etiquetas, que puede usar para declarar tipos explícitamente.

Sintaxis: !![typeName] [value] 

````yaml
explicit_boolean :  !!bool  true 
explícito_integer :  !!int  42 
explícito_float :  !!float  -42.24 
explicit_string :  !!str  0.5 
explicit_datetime :  !!timestamp "2022-11-17 12:34: 56.78 +9" 
explicit_null :  !!null  null 
````

Las cadenas y los números no son los únicos escalares que YAML puede entender.
También se analizan los literales de fecha y hora con formato ISO. 

````yaml
datetime_canonical :  2001-12-15T02:59:43.1Z 
datetime_space_separated_with_time_zone :  2001-12-14 21:59:43.10 -5 
date_implicit :  2002-12-14 
date_explicit :  !!timestamp 2002-12-14 
````

Puede encontrar más información sobre como se aplica yaml en cada lenguaje aquí: [https://yaml.org/](https://yaml.org/)

Puede practicar con yaml aquí: [https://www.yamllint.com/][https://www.yamllint.com/]


















