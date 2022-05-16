# Quimera / Views maestro detalle

Vamos a explicar cómo genera una vista maestro - detalle
## Controlador
Creamos un shortcut de tipo *Model* para el modelo a representar (en el ejemplo, *Categorias*)

```json
{
  "shortcuts": [
    {
      "type": "Model",
      "name": "categorias",
      "id": "idCategoria",
      "schema": "categorias",
      "url": "/admin/catalogo/categorias",
      "logicDelete": true
    }
  ],
  "state": {},
  "bunch": {
    "onInit": [
      {
        "_type": "grape",
        "name": "getCategorias"
      }
    ]
  }
}
```


## Vista
En la vista principal, usaremos un control *QMasterDetail*, indicando las vistas o subvistas que corresponden a maestro y detalle.

```js
function Categorias({ idCategoria, _useStyles }) {

  const [{ categorias }, dispatch] = useStateValue()

  useEffect(() => {
    dispatch({
      type: 'onInit'
    })
  }, [])

  useEffect(() => {
    dispatch({
      type: 'onIdCategoriasProp',
      payload: { id: idCategoria ? parseInt(idCategoria) : '' }
    })
  }, [idCategoria])

  const callbackCategoriaCambiada = useCallback((payload) => dispatch({ type: 'onCategoriasItemChanged', payload }), [])

  return (
    <Quimera.Template id='Categorias'>
      <QMasterDetail
        MasterComponent={<Quimera.SubView id='Categorias/CategoriasMaster' idCategoria={idCategoria} />}
        DetailComponent={<Quimera.View id='Categoria' initCategoria={categorias.dict[categorias.current]}
          callbackChanged={callbackCategoriaCambiada}
        />}
        current={categorias.current}
      />

    </Quimera.Template>
  )
}
```
### Más

  * [Volver al Índice](./index.md)

