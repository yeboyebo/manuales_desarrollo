# Views

Las views o vistas son el elemento principal de Quimera. Generalmente representan una página de nuestra app, pero también es posible incluirlas en otras views.

Una vista es un componente de React que define un contexto de tipo useState, este contexto proporciona acceso a:
* El estado del componente vista
* Una función *dispatch* que llama al reductor de la vista. El reductor, como veremos, es la función encargada de procesar acciones y devolver el estado resultante.

## Estructura
Una vista se define en una carpeta con el nombre de la vista en formato NombreVista, que contiene los siguientes ficheros:

### NombreVista.ui.js
Define el componente HTML de la vista

### NombreVista.ctrl.js
Define el comportamiento del reductor de la vista, exportando dos valores:
* state: El estado inicial de la vista
* bunch: El bunch de grapes que definen cómo debe reaccionar la vista ante cada acción disparada con un dispatch.

### NombreVista.ctrl.json
El reductor de la vista puede estar total o parcialmente definido de forma estática en un fichero JSON. Las claves de esta estructura JSON son:
* shortcuts: Listado de shortcuts a incorporar al bunch
* state: El estado inicial de la vista
* bunch: El bunch de grapes estáticos que definen cómo debe reaccionar la vista ante cada acción disparada con un dispatch.

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

  * [Volver al Índice](./index.md)
