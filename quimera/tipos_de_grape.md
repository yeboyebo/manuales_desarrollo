# Quimera / Tipos de grape

Hay distintos tipos de grape que realizan distintas acciones. A continuación listamos los más representativos, con su equivalente estático.

## Ficheros y formatos
Los grapes pueden definirse en los ficheros *ctrl.js*, en formato javascript/JSON, o en los *ctrl.yaml*, en formato YAML.

Intentaremos usar los grapes de YAML siempre que sea posible.

Más sobre YAML [aquí](https://www.cloudbees.com/blog/yaml-tutorial-everything-you-need-get-started)

## Grapes dinámicos (javascript, JSON)

Todas los grapes dinámicos están definidos en la función *eatGrape* del fichero *BaseApi.js*.

### appDispatch
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

## Grapes estáticos (YAML)
Todas los grapes estáticos están definidos en el diccionario *staticGrapes* del fichero *staticApi.js*.

## Condiciones
Todos los grape pueden tener una clave *condition*, que expresa la condición que debe cumplirse para que el grape se ejecute.

Ejemplo
```yaml
onInit:
  - condition:
      operator: A is defined
      A:
        statePath: inventario.data.codInventario
    _type: grape
    name: getLineas
```
Todas las posibles condiciones están definidas en el fichero *staticApi.js* e incluidas en el fichero de schema JSON *ctrl.schema.json*.


### Más

  * [Volver al Índice](./index.md)
