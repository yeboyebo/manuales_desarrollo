# Quimera / Views maestro detalle

Vamos a explicar cómo genera una vista maestro - detalle
## Controlador
Creamos un shortcut de tipo *Model* para el modelo a representar (en el ejemplo, *Categorias*)

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

