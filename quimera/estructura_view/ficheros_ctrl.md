# Ficheros de controlador

Los ficheros de controlador son el fichero dinámico (*.ctrl.js*) y el fichero estático (*.yaml.js*)

Estos ficheros define el comportamiento del reductor de la vista, exportando dos valores:
* state: El estado inicial de la vista
* bunch: El bunch de grapes que definen cómo debe reaccionar la vista ante cada acción disparada con un dispatch.

### NombreVista.ctrl.yaml
El reductor de la vista puede estar total o parcialmente definido de forma estática en un fichero YAML. Las claves de esta estructura YAML son:
* shortcuts: Listado de shortcuts a incorporar al bunch
* state: El estado inicial de la vista
* bunch: El bunch de grapes estáticos que definen cómo debe reaccionar la vista ante cada acción disparada con un dispatch.

## Sobrecarga del controlador
Los pasos para sobrecargar el controlador son:

1. Si no existe ya, crear la vista a sobrecargar en la extensión (carpeta)
1. Crear nuevos ficheros js / yaml en la extensión. Podemos copiar la estructura del js de aquí:
```js
import { applyBunch, shortcutsState, shortcutsBunch } from 'core/lib'
import data from './Checkout.ctrl.yaml'

export const state = parent => ({
  ...parent,
  ...shortcutsState(data.shortcuts),
  ...data.state
})

export const bunch = parent => {
  const parentConShortCuts = {
    ...parent,
    ...shortcutsBunch(data.shortcuts)
  }
  return {
    ...parentConShortCuts,
    ...applyBunch(data.bunch, parentConShortCuts),
  }
}
```
3. Publicarlos en el index.js de la vista
```js
// export { default as ui } from './Checkout.ui'
export { bunch, state } from './Checkout.ctrl'
// export { default as style } from './Checkout.style'
```
4. Incluimos la vista en nuestro *index.ts* de la extensión. Lo mejor es copiar las líneas correspondientes del *index.ts* de la extensión base.

**Sobrecarga del bunch en ficheros estáticos**
En el caso de sobrecargar una clave del bunch ya definida en extensiones base, podemos hacerlo de tres formas:
* apend: Es la forma por defecto, lo que indiquemos en el array de grapes asociado a la clave se añadirá después de los grapes de la extensión base.
* prepend: lo que indiquemos en el array de grapes asociado a la clave se añadirá antes de los grapes de la extensión base.
* override: lo que indiquemos en el array de grapes asociado a la clave se añadirá en lugar de los grapes de la extensión base.

La sintaxis para hacer esto es la del ejemplo:
```json
{
  "shortcuts": [],
  "state": {
    "filtroVisible": true
  },
  "bunch": {
    "onCatalogoFilterChanged": {
      "patch": "override",
      "grapes": [
        {
          "_type": "set",
          "path": "catalogo.filter",
          "value": {
            "payloadPath": "value"
          }
        },
        {
          "_type": "grape",
          "name": "getCatalogo"
        }
      ]
    }
  }
}
```

### Más

  * [Volver al Índice](../index.md)