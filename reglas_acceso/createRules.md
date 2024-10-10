# Manual desarrollo con ACL

---

# Parte 1. Creando reglas

---

## Aviso

 Solo se comprobará los permisos de acceso para las reglas existentes, es decir, si no se ha creado una regla de acceso al fichero transacciones_api, tendremos acceso por defecto.

 Hay que tener en cuenta que puede que exista un regla de acceso para transacciones/get pero no para transacciones/delete. En este caso comprobariamos la regla al hacer el get pero no para el delete.

## Preparando el entorno para la creación de reglas

- Lo primero que demos hacer el comprobar si el módulo al que queremos aplicar las reglas tiene una función `createRules()` en su script principal (ej: flfactteso.qs) dentro de nuestra extensión. Si ya lo tiene, podemos pasar al siguiente apartado. Si no, seguimos el resto de pasos
- Creamos en el script principal del módulo QS correspondiente la función `createRules()` que devuelva un array de reglas (por el momento vacío)
  ```js
  function oficial_getRules() {
    return new Array()
  }
  ```
- Si no estamos en oficial, concatenamos nuestras reglas con la extensión superior

  ```js
  function otraExt_getRules() {
    var _i = this.iface

    return new Array().concat(_i.__getRules())
  }
  ```

- No olvides incluir su declaración
  ```js
  function getRules() {
    return this.ctx.oficial_getRules()
  }
  ```
- Ahora comprobamos que nuestro módulo esté incluido en la lista de módulos a revisar. Esto lo comprobamos en `sistema/librería/flrules_api.py` en la función `get_modules()`. Si no está, lo añadimos
  ```python
  def get_modules(self):
      return ['flfacturac', 'flfactalma', 'flfactteso']
  ```

## Creando reglas CRUD

- Para crear reglas CRUD (create, read, update, delete) tenemos una función predefinida en `flfactppal` que ya hace todo el trabajo por nosotros. Vamos a poner un ejemplo:
  ```js
  flfactppal.iface.getCrudRules('reciboscli', 'Recibos de cliente')
  ```
- Como se puede intuir, esto devolverá las reglas CRUD para tabla `reciboscli`. En concreto las siguientes:

  | Regla             | Descripción                        |
  | ----------------- | ---------------------------------- |
  | **reciboscli**    | Recibos de cliente                 |
  | reciboscli/get    | Puede recibir recibos de cliente   |
  | reciboscli/post   | Puede crear recibos de cliente     |
  | reciboscli/patch  | Puede modificar recibos de cliente |
  | reciboscli/delete | Puede eliminar recibos de cliente  |
  |                   |                                    |

- La **primera regla** hace referencia al acceso general a reciboscli, que se evaluará si no está definido el valor de alguna del resto de reglas

- Ahora añadimos las reglas a nuestro `getRules()`

  ```js
  function oficial_getRules() {
    return new Array().concat(
      flfactppal.iface.getCrudRules('reciboscli', 'Recibos de cliente')
    )
  }
  ```

## Creando reglas personalizadas

- Pero no siempre las acciones a las que queremos limitar acceso son `get` o `post`. Podríamos tener una función `crearReciboPrivado()` a la que no queremos que todos los usuarios que accedan a reciboscli puedan tener acceso. Por lo que la añadimos a nuestras reglas. Para ellos necesitamos los siguientes datos:

  | Clave       | Descripción                            |
  | ----------- | -------------------------------------- |
  | idregla     | Identificador de la regla              |
  | grupo       | Tabla/Grupo de reglas al que pertenece |
  | descripcion | Nombre descriptivo de la regla         |
  |             |                                        |

- Vamos a añadirla a nuestras reglas

  ```js
  function oficial_getRules() {
    return new Array().concat(
      flfactppal.iface.getCrudRules('reciboscli', 'Recibos de cliente'),
      [
        {
          idregla: 'reciboscli/crearReciboPrivado',
          grupo: 'reciboscli',
          descripcion: 'Puede crear recibos privados',
        },
      ]
    )
  }
  ```
Nota: Si el grupo no existe, debemos crear antes una regla con *idregla* = *grupo* para crear el grupo y definir su nombre.

```js
{
  idregla: 'miGrupo',
  grupo: 'miGrupo',
  descripcion: 'Nombre de mi grupo',
},
```

- De esta manera devolveremos un total de 6 reglas:

  | Regla                             | Descripción                        |
  | --------------------------------- | ---------------------------------- |
  | reciboscli                        | Recibos de cliente                 |
  | reciboscli/get                    | Puede recibir recibos de cliente   |
  | reciboscli/post                   | Puede crear recibos de cliente     |
  | reciboscli/patch                  | Puede modificar recibos de cliente |
  | reciboscli/delete                 | Puede eliminar recibos de cliente  |
  | **reciboscli/crearReciboPrivado** | Puede crear recibos privados       |
  |                                   |                                    |

## Modelos ACL y modelos API
En ocasiones, un modelo de ACL engloba a más de un modelo API. Por ejemplo, si damos acceso a Pedidos de client, implícitamente lo estamos dando también a Líneas de pedidos de cliente.

Para ello, existe un diccionario en el que asociamos los modelos de API a modelos de ACL. En el ejemplo que indicábamos:

| Modelo API                          | Modelo ACL                 |
  | --------------------------------- | ---------------------------------- |
  | pedidoscli                        | pedidoscli                 |
  | lineaspedidoscli                  | pedidoscli                 |

Podemos modificar este diccionario mediante la función *getAclModel* del script principal de cada módulo. Ej:
``` js
function oficial_getAclModelDict()
{
	return {
		"lineaspresupuestoscli": "presupuestoscli",
		"lineaspedidoscli": "pedidoscli",
		"lineasalbaranescli": "albaranescli",
		"lineasfacturascli": "facturascli",
		"lineaspedidosprov": "pedidosprov",
		"lineasalbaranesprov": "albaranesprov",
		"lineasfacturasprov": "facturasprov"
	}
}
```
Solo es necesario establecer la correspondencia ente modelos cuando los nombres de estos no coinciden.

### Más

- [Volver al Índice](./index.md)
- [Parte 2: Aplicando reglas en PinebooAPI](./pinebooApi.md)
- [Parte 3: Aplicando reglas en Quimera](./quimera.md)
- [Parte 4: Aplicando reglas en AbanQ/Eneboo](./abanq.md)
