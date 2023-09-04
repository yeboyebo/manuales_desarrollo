# Modelos / Subesquemas M1

A veces un modelo no puede definirse únicamente como un registro en base de datos, sino que tiene una estructura más compleja.
Por ejemplo, un pedido está definido por su cabecera y sus líneas.

Para definir estos modelos más complejos, usamos los esquemas M1. Por ejemplo:

```js
"albaranescli": {
    "funInicio": Albaranescli.iniciaValoresCursor,
    "funCambio": Albaranescli.bChCursor,
    "M1": [
        {
            "id": "lineas",
            "tabla": "lineasalbaranescli",
            "campoM1": "idalbaran",
            "idModelo": "lineasalbaranescli",
            "funAgregar": Albaranescli.calcularTotalesCursor
        }
    ]
},
"lineasalbaranescli": {
    "funInicio": Lineasalbaranescli.iniciaValoresCursor,
    "funCambio": Lineaspedidoscli.commonBChCursor,
    "ordenCampos": ["idalbaran", "referencia", "cantidad"]
},
```

## Estructura de los subesquemas M1

Los subesquemas M1 se definen en un array bajo la clave *M1* del esquema padre. Cada elemento del array define un subesquema. A continuación definimos las distintas claves que el diccionario de subesquema puede contener:

### id
Identificador del subesquema dentro del array. Es también la clave del modelo que incluirá los datos asociados. Por ejemplo, para las líneas de un albarán, el *id* es *lineas*:
```js
const miAlbaran = {
    "codcliente": "000001",
    "lineas": [
        { "referencia": "REF1", "cantidad": 1 },
        { "referencia": "REF2", "cantidad": 1 },
    ]
}
```
### tabla
Nombre de la tabla asociada.

### idModelo
Clave del esquema asociado al subesquema. Suele coincidir con el valor de la clave *tabla*.

### funAgregar
Función que se ejecutará sobre un cursor del registro padre tras crear, modificar o borrar registros asociados sobre el subesquema.

## Uso de subesquemas M1
### Alta de modelos con subesquemas M1
Podemos guardar el modelo en base de datos con la función *crea*:
```js
const miAlbaran = {
    "codcliente": "000001",
    "lineas": [
        { "referencia": "REF1", "cantidad": 1 },
        { "referencia": "REF2", "cantidad": 1 },
    ]
}
formMODEL.crea(miAlbaran, "albaranescli")
```
La función *crea* hará lo siguiente:
1. Creará el registro de cabecera usando las funciones de inicio y cambio para todos los valores especificados.
1. Para cada clave M1, creará los registros especificados, usando las funciones de inicio y cambio del esquema asociado en el subesquema.
1. Lanzará la función de agregación (*funAgregacion*) del subesquema sobre el cursor de la cabecera (si está definida).

### Carga de modelos con subesquemas M1
Si un esquema tiene subesquemas asociados, la función *carga* cargará los datos asociados a todos los subesquemas.
```js
const miAlbaran = formMODEL.carga(12, "albaranescli")
/* Si el albarán contiene líneas, obtenemos algo así como:
{
    "idalbaran": 12,
    "codigo": "20220A000001",
    "codcliente": "000001",
    ...(resto de datos de cabecera)
    "lineas": [
        { "idlinea": 123, "referencia": "REF1", ...etc },
        { "idlinea": 122, "referencia": "REF2", ...etc },
    ]
}
*/
```
Podemos especificar los tipos de registros hijo que queremos cargar indicando un tercer parámetro en la función:
```js
// No carga datos de ningún subesquema:
const miAlbaran = formMODEL.carga(12, "albaranescli", { "M1": [] })
// Carga datos del subesquema lineas:
const miAlbaran = formMODEL.carga(12, "albaranescli", { "M1": [{ "id": "lineas" }] })
```

### Búsqueda de modelos con subesquemas M1
La función *busca* dispone del mismo parámetro de opciones que la función *carga*, por lo que podemos indicar qué datos de subesquemas queremos incluir en el resultado de la búsqueda.

Como la función *carga*, si no especificamos opciones obtendremos los datos de todos los subesquemas M1 asociados al esquema que busquemos.

### Más

  * [Volver al Índice](./index.md)
