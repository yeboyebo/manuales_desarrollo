# Quimera / Views maestro detalle (con buffer)

Vamos a explicar cómo genera una vista de detalle
## Controlador
Creamos un shortcut de tipo *DetailBuffer* para el modelo a representar (en el ejemplo, *Categorias)

```json
{
  "shortcuts": [
    {
      "type": "DetailBuffer",
      "name": "categoria",
      "id": "idCategoria",
      "schemaName": "categorias",
      "deleteConfirmQuestion": {
        "titulo": "Borrar categoría",
        "cuerpo": "La categoría se borrará"
      }
    }
  ],
  "state": {},
  "bunch": {
    "onCategoriaSectionAccepted": [
      {
        "_type": "grape",
        "name": "saveCategoria"
      }
    ],
    "onCategoriaSectionCancelled": [
      {
        "_type": "grape",
        "name": "loadBufferCategoria"
      }
    ],
    "onAtrasClicked": [
      {
        "_type": "grape",
        "name": "cancelCategoria"
      }
    ]
  }
}
```


## Vista
La vista de detalle, si está asociada a una vista maestro - detalle, recibe dos parámetros:

* *callbackChanged*: Callback para llamar al maestro indicando cambios en el detalle (modificación, borrado, etc.)
* *init(Modelo))*: Objeto con los valores iniciales del modelo.

Ambos parámetros son incluidos en sendos *useEffect* para meterlos en el estado.

```js
function Categoria({ callbackChanged, initCategoria, useStyles }) {
  const [{ categoria }, dispatch] = useStateValue()
  const classes = useStyles()

  useEffect(() => {
    dispatch({
      type: 'onInit',
      payload: {
        callbackCategoriaChanged: callbackChanged
      }
    })
  }, [callbackChanged])

  useEffect(() => {
    dispatch({
      type: 'onInitCategoria',
      payload: {
        initCategoria
      }
    })
  }, [initCategoria])
  ...
}
```

Para conectar los cambios en los datos con los grapes que guardan o restauran los datos, debemos nombrar nuestras secciones de forma acorde con los nombres de los grapes.

Por ejemplo, para *onCategoriaSectionAccepted* y *onCategoriaSectionCancelled*, usaremos secciones con el actionPrefix *categoria*

```js
<QSection title='Categoria' actionPrefix={'categoria'}
    dynamicComp={() => <Field.Schema id={`categoria.buffer.nombre`} schema={schema} label='' fullWidth autoFocus />}
    >
    <Typography variant='h5'>{categoria.buffer.nombre}</Typography>
</QSection>
```

### Más

  * [Volver al Índice](./index.md)

