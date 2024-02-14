# Curso programación QSA

## Principales funciones de un formulario
Formularios de edición más complejos que los maestros
Formularios de edición normalmente estamos dentro de una transacción y hasta que no se acepta no se guarda
En Formularios maestros tenemos más libertad de elegir cuando suceden las cosas

### Init
Debe de haber:
- Conexiones de botones
- LLamada a iniciaValoresCursor(cursor) cuando estamos en modo Insert
- Llamada a habilitarControles

### Habilitaciones
- Es un tema solo del formulario.
- En el init se llamaría a una función que se llamara habilitarControles
- habilitarControles
- Esta función pedirá el estado del formulario llamando a una función por ejemplo dameEstadoFormulario y dependiendo de ese estado habilitará/deshabilitara controles del formulario. 
- Esta función es fácilmente sobrecargable y se puede llamar en otro momento del formulario


### iniciaValoresCursor
- Inicia valores del cursor a los valores por defecto cuando estamos en modo insert
- Nunca hay que hacer mención al formulario, siempre al cursor, es decir, no usar this.child("....

### bufferChanged / bchCursor
- BufferChanged se lanza cuando cambia el valor del campo
- Desde hace tiempo se cambio para que esta función solo haga 3 llamadas
- Bchprecursor bchcursor y bchpostcursor
- El pre y el post se puede hacer mención a controles del formulario
- El bchcursor no se debe hacer mención al formulario ya que es que se llama en API
- En bchcursor es donde está el meollo
- Una de las funciones que se llama desde bchCursor es el commonCalculatField

### calculateField / commonCalculateField
- CommonCalculateField es una función que se le pasa el campo y el cursor y nos calcula el valor del campo, son cálculos comunes para los distintos tipos de documentos, al pasar el cursor nos calcula el valor correspondiente del cursor

### bufferCommited
- Para que se usa mucho es para conectar una subtabla de un formulario a una función la cual al actualizarse algún valor de esa tabla se lanzará la función conectada. 
- Esta función es del formulario. 
- Ejemplo, calcularTotales de un formulario al actualizarse un valor de la tabla.

## Otras funciones

### beforeCommit / afterCommit
- Estas funciones se llaman justo antes de guardarse un cursor de una tabla (before) o justo después de guardarse (after)te
- Siempre hay que llamar al beforeCommit del padre 
- Estas funciones solamente deben de contener llamadas a otras funciones y nunca tener la lógica ahí
- Estas funciones no deben de hacer mención a formularios
- Estas funciones deberíamos intentar no sacar mensajes

### extension
- En script de flfactppal.qs, existe una función llamada *extension* que te indica si una extensión está instalada o no.
- Esta función se debe de crear en todas las extensiones.

## Librería

### CURSOR.qs

### ARRAY.qs

### UI.qs

### SQL.qs


