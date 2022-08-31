# Modelos / Esquemas

Cuando definimos un modelo, queremos hacerlo de la forma más sencilla posible. Por ejemplo, cuando creamos un cliente, si todos los datos vamos a introducir distintos de los datos por defecto de un cliente son su nombre y su CIF, querríamos hacerlo de la siguiente forma:

```js
const cliente = {
    "nombre": "Yeboyebo",
    "cifnif": "A1234567"
}
formMODEL.crea(cliente, "clientes")
```
Los esquemas nos permiten conseguir esto indicando las funciones a ejecutar cuando se crea o modifica un modelo.

## Fichero de esquemas por módulo: *X_modelos.qs*

Cada módulo tiene (o debe tener), una entrada en la función *getModulos* de *MODEL.qs*:

```js
function getModulos()
{
    const modulos = []
    if (sys.isLoadedModule("flfactppal")) {
        modulos.push({ "idmodulo": "flfactppal", "script": formfactppal_modelos.iface })
    }
    //...etc
    return modulos
}
```
Esta función define dónde encontrar los scripts que definen los modelos de cada módulo.

**Los modelos que no tienen funciones asociadas (uso básico) NO tienen por qué estar creadas en el fichero de modelos, funcionan igualmente.**

Para crear el primer modelo de un módulo deberemos darlo de alta en la función *getModulos* y crear la correspondiente acción / script en el módulo correspondiente.

### Estructura del fichero
La única función del fichero es *cargaEsquemas*, esta función devuelve las estructuras de datos que definen el esquema de cada modelo.

Ejemplo (factppal_modelos.qs):
```js
function oficial_cargaEsquemas()
{
    const Clientes = formRecordclientes.iface

    const esquemas = {
        "clientes": {
            "funInicio": Clientes.iniciaValoresCursor,
            "funCambio": Clientes.bChCursor
        }
    }
    return esquemas
}
```
Cada clave del diccionario principal corresponde a un esquema.

## Estructura del esquema

A continuación definimos las distintas claves que el diccionario de esquema puede contener:

### funInicio
Función a llamar cuando se va a crear un modelo, antes de establecer los datos que enviamos por parámetro, típicamente *iniciaValoresCursor*.
### funCambio
Función a llamar cuando se modifica un valor en el modelo, típicamente *bChCursor*.
### ordenCampos
Listado de campos que define el orden en el que se establecen los campos en el cursor desde el modelo. Por ejemplo, cuando enviamos una línea de pedido con el valor:
```js
{
    "referencia": "R1",
    "pvp": 99
}
```
Sabemos que tras indicar la referencia, la descripción y el precio de la línea se calcularán automáticamente (con *funCambio*). Como lo que queremos es que nuestra línea tenga como precio el valor que nos viene por parámetro, definiremos en nuestro esquema:
```js
ordenCampos: ["referencia"]
```
con lo que indicamos es que, si la referencia viene incluida en los parámetros de entrada, este será el primer campo a establecer, y después todos los demás. Así nos aseguramos que *pvp* se establecerá después de ejecutar *funCambio* para *referencia*.

```js
```
### Más

  * [Volver al Índice](./index.md)
