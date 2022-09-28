# Quimera / Tipos de grape

Hay distintos tipos de grape que realizan distintas acciones. A continuación listamos los más representativos, con su equivalente estático.

## appDispatch
Realiza un dispatch al controlador *Global.ctrl.js*. con los mismos parámetros que un dispatch normal.
Ejemplo:
```js
onWhoamiSucceeded: [
  {
    type: 'appDispatch',
    name: 'setUserData',
    plug: ({ response }) => ({ response })
  },
```


### Más

  * [Volver al Índice](./index.md)
