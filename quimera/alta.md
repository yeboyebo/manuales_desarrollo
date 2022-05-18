# Quimera / Views alta de registro

Vamos a explicar cómo genera una vista de alta de registro
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
      "mode": "insert"
    }
  ],
  "state": {},
  "bunch": {
    "onNuevaCategoriaSectionAccepted": [
      {
        "_type": "grape",
        "name": "saveCategoria"
      }
    ],
    "onNuevaCategoriaSectionCancelled": [
      {
        "_type": "grape",
        "name": "cancelCategoria"
      }
    ]
  }
}
```


## Vista
En la vista, creamos un formulario con campos de tipo *Field.Schema*, incluidos en una sección conectada por el actionPrefix a los grapes que guardan o cancelan el registro.

```js
function CategoriaNueva({ callbackGuardado, useStyles, ...props }) {
  const [{ categoria }, dispatch] = useStateValue()
  const schema = getSchemas().categorias

  useEffect(() => {
    dispatch({
      type: 'init',
      payload: {
        callbackCategoriaChanged: callbackGuardado,
        ...props
      }
    })
  }, [callbackGuardado])

  return (
    <Quimera.Template id='CategoriaNueva'>
      <QSection actionPrefix='nuevaCategoria' title='Nueva categoria' alwaysActive
        dynamicComp={() => (
          <Grid container>
            <Grid item xs={12}>
              <Field.Schema id='categoria.buffer/nombre' schema={schema} fullWidth autoFocus />
            </Grid>
          </Grid>
        )}
        saveDisabled={() => !schema.isValid(categoria)}
      ></QSection>
    </Quimera.Template>
  )
}
```


### Más

  * [Volver al Índice](./index.md)

