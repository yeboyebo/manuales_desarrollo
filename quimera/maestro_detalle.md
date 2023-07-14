# Quimera / Views maestro detalle

Vamos a explicar cómo genera una vista maestro - detalle
## Controlador
Creamos un shortcut de tipo *Model* para el modelo a representar (en el ejemplo, *Presupuestos*)

```yaml
{shortcuts:
  - type: Model
    name: presupuestos
    id: idPresupuesto
    schema: presupuestoscli
    url: "/ventas/presupuestos"
    logicDelete: true
state:
  filtroVisible: false
bunch:
  onInit:
    - _type: grape
      name: getPresupuestos
```

Donde:
```yaml
name: Este nombre se usara para los dispatch que se lanzen sobre la vista, ej. on{**name**}ItemReceived, normalmente usaremos nombre de la tabla por defecto pero podemos usar cualquier nombre.
id: Clave de la tabla utilizada para peticiones API
schema: Nombre del schema definido en static/schemas.js normalmente sera nombre de la tabla pero pueden existir multiples schemas sobre una tabla para diferentes acciones.
url: url de la view definida en {extension}/index.js
```

## Vista
En la vista principal, usaremos un control *QMasterDetail*, indicando las vistas o subvistas que corresponden a maestro y detalle.

```js
import { useCallback, useEffect } from 'react'
import Quimera, { useStateValue, PropValidation, useWidth } from 'quimera'
import { QMasterDetail } from 'quimera-comps'

function PresupuestosCli({ idPresupuesto }) {
  const [{ presupuestos }, dispatch] = useStateValue()

  // Llamamos a onInit siempre que se recarga la view
  useEffect(() => {
    dispatch({
      type: 'onInit'
    })
  }, [])

  // Si por navegación entran en un elemento concreto, llamamos al grape *onIdElementosProp*
  useEffect(() => {
    dispatch({
      type: 'onIdPresupuestosProp',
      payload: { id: idPresupuesto ? parseInt(idPresupuesto) : '' }
    })
  }, [idPresupuesto])

  // Callback con el que la vista detalle nos indica que un elemento ha cambiado
  const callbackPresupuestoCambiado = useCallback((payload) => dispatch({ type: 'onPresupuestosItemChanged', payload }), [])

  return (
    <Quimera.Template id='PresupuestosCli'>
      <QMasterDetail
        MasterComponent={
          <Quimera.SubView id='PresupuestosCli/PresupuestosCliMaster' idPresupuesto={idPresupuesto} />
        }
        DetailComponent={
          <Quimera.View id='PresupuestoCli'
            initPresupuesto={presupuestos.dict[presupuestos.current]}
            callbackChanged={callbackPresupuestoCambiado}
          />
        }
        current={presupuestos.current}
      />
    </Quimera.Template>
  )
}

PresupuestosCli.propTypes = PropValidation.propTypes
PresupuestosCli.defaultProps = PropValidation.defaultProps
export default PresupuestosCli
```

Podemos usar cualquier tipo de view tanto para maestro como detalle, normalmente como vemos en el ejemplo mandremos al detalle un callbackChanged, para recibir los cambios realizados en la vista hija y poder realizar acciones en el controlador, en la vista del detalle en este caso hay que activar el evento callbackChanged con un useEffect:

```js
************
function PresupuestoCli({ callbackChanged, initPresupuesto, useStyles }) {
  const [{ lineas, logic, presupuesto, vistaDetalle }, dispatch] = useStateValue();
  const classes = useStyles();
  const width = useWidth();

  useEffect(() => {
    util.publishEvent(presupuesto.event, callbackChanged);
  }, [presupuesto.event.serial]);
***********
```

Este useEffect dispara el evento callbackChanged, cada vez que cambie un elemento en el presupuesto y podermos capturar el evento en el controlador del padre con:

```yaml
  changePresupuestosItem:
    - gePresupuestos
```

Con este ejemplo estamos actualizando la tabla de master cada vez que cambie un elemento del hijo.

## Filtro

## Alta
Para realizar las altas, usaremos una vista específica con nombre *NuevoMiVista*. Para navegar a esta vista la opción estándar es conectar un botón y controlar el alta con un grape que actuará de callback:
```yaml
onNuevoPresupuestoClicked:
  - _type: navigate
    url:
      const: "/ventas/presupuestos/nuevo"
onNewPedidoChanged:
  - onPresupuestosNewItemChanged
  - addPresupuestosItem
```
### Más

  * [Volver al Índice](./index.md)

