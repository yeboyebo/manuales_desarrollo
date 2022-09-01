# Modelos / Uso básico

Llamamos modelo a la representación de un objeto de negocio (cliente, factura, etc.) en una estructura de datos, generalmente un diccionario.

Por ejemplo, un modelo de artículo puede ser:
```js
articulo = {
    "referencia": "REF1",
    "descripcion": "Producto de ejemplo"
    "pvp": 10,
    ...etc
}
```

El objetivo de usar modelos es aislar el acceso a base de datos y limitarlo a las fases inicial y final de una función o rutina programable. Cagaremos los datos de la BD en modelos, operaremos con ellos y luego los guardaremos.

La librería **MODEL** nos permite crear y cargar modelos.

## Crear un modelo: *formMODEL.crea*
La función *crea* guarda el modelo en base de datos usando cursores.

Para crear un modelo, la sintaxis es:
```js
formMODEL.crea(dictModelo, nombreTabla)

// Ejemplo:
const miArticulo = {
    "referencia": "REF1",
    "descripcion": "Producto de ejemplo"
    "pvp": 10,
    ...etc
}
formMODEL.crea(miArticulo, "articulos")
```
Las claves del diccionario deben coincidir con los campos de la tabla asociada.

## Cargar un modelo: *formMODEL.carga*
La función *carga* lee un cursor de la base de datos y lo carga en un diccionario.

Para cargar un modelo, la sintaxis es:
```js
dictModelo = formMODEL.carga(valorPK, nombreTabla)

// Ejemplo:
const miArticulo = formMODEL.carga("REF1", "articulos")
```

## Buscar modelos: *formMODEL.busca*
La función *busca* obtiene los modelos que cumplen una condición en la base de datos y los devuelve como un array de diccionarios.

Para cargar un modelo, la sintaxis es:
```js
modelos = formMODEL.busca(clausulaWhere, nombreTabla)

// Ejemplo:
const articulos = formMODEL.busca("pvp >= 10", "articulos")
/* La función devuelve:
[
    {"referencia": "REF1", "descripcion 1": "Desc1", "pvp": 10, ...},
    {"referencia": "REF2", "descripcion 2": "Desc2", "pvp": 20, ...},
    ...
    {"referencia": "REFN", "descripcion N": "DescN", "pvp": 23, ...}
]*/
```

## Cambiar un modelo: *formMODEL.cambia*
La función *cambia* modifica el registro principal asociado al modelo.

Para cambiar un modelo, la sintaxis es:
```js
modelos = formMODEL.cambia(valorPK, nombreTabla, cambio)

// Ejemplo:
formMODEL.cambia("REF1", "articulos", {
	"descripcion": "Nueva descripcion",
	"pvp": 6
})
```

## Borrar un modelo: *formMODEL.borra*
La función *borra* elimina el registro principal asociado al modelo.

**Importante: La función no borra los registros M1 del modelo, solo se borran si en los before/afterCommit del cursor se ha incluido el borrado o hay un *delC* en los metadatos.**

Para borrar un modelo, la sintaxis es:
```js
modelos = formMODEL.borra(valorPK, nombreTabla)

// Ejemplo:
formMODEL.borra("REF1", "articulos")
```
 
### Más

  * [Volver al Índice](./index.md)
