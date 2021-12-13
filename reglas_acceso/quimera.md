# Manual desarrollo con ACL
---------------------------
# Parte 3. Aplicando reglas en Quimera
--------------------------------------

## Extendiendo de la extensión *login*

  * Debemos tener la extensión de `login` en nuestro proyecto, por lo que decidimos si la incluirá nuestro proyecto o la extensión en concreto.
  * Importamos la librería login en el index.ts de nuestro proyecto/extensión
    ```js
    import login from '@quimera-core/extensions/login'
    ```
  * Añadimos la extensión al array de dependencias
    ```js
    export default {
      path: ...,
      dependencies: [
        core,
        login
      ],
    }
    ```

## Restringiendo el acceso a Views

  * Para restringir el acceso a Views, debemos añadir, si no existe, una clave `rules` en el index.ts de nuestra extensión
    ```js
    export default {
      path: ...,
      dependencies: [...],
      rules: {

      }
    }
    ```

  * Dentro de este objeto, crearemos una propiedad `'_ViewName_:visit'`. El valor de esta propiedad determinará si es posible acceder a esta View.
    ```js
    export default {
      path: ...,
      dependencies: [...],
      rules: {
        'ListaRecibosCliente:visit': false,
      }
    }
    ```

  * Esto haría que nadie (salvo el superusuario) pueda entrar a la View `ListaRecibosCliente`. En proximas secciones veremos que valores puede recibir esta propiedad.

  * En caso de no tener permisos de acceso a una View, se devolverá una página 403

## Restringiendo la visualización de elementos

  * Lo primero que debemos hacer es tener una regla que mapee el acceso al componente o grupo de componentes. Lo haremos de la misma manera que `visit`, pero esta vez con una regla personalizada. Ej:
    ```js
    export default {
      path: ...,
      dependencies: [...],
      rules: {
        'ListaRecibosCliente:visit': false,
        'ListaRecibosCliente:botonera-superior': false,
      }
    }
    ```

  * Ahora podemos utilizar la regla `'ListaRecibosCliente:botonera-superior'` de dos maneras diferentes. La primera sería como un componente y la segunda como una función:

  * ACL por componente
    ```js
    <Can rule='ListaRecibosCliente:botonera-superior'>
      <Button id='boton1' ... />
      <Button id='boton2' ... />
      <Button id='boton3' ... />
    </Can>
    ```

  * ACL por función
    ```js
    if (ACL.can('ListaRecibosCliente:botonera-superior')) {
      // do stuff...
    }
    ```

## Posibles valores de restricción

  * **Estático** (`true`/`false`). Simple. Si es `true`, todo usuario tendrá acceso, mientras que si es `false`, solo un superusuario lo tendrá.
    ```js
    export default {
      path: ...,
      dependencies: [...],
      rules: {
        'ListaRecibosCliente:visit': false,
        'ListaRecibosCliente:botonera-superior': true,
      }
    }
    ```

  * **Check**. Una función que busca si el usuario tiene acceso (en la tabla flpermissions) a una determinada regla. En el siguiente ejemplo, solo los usuarios que tengan acceso a `reciboscli/get` podrán entrar a la view `ListaRecibosCliente`
    ```js
    export default {
      path: ...,
      dependencies: [...],
      rules: {
        'ListaRecibosCliente:visit': (check) => check("reciboscli.get"),
        'ListaRecibosCliente:botonera-superior': true,
      }
    }
    ```

  * **Check Múltiple**. Una función que busca si el usuario tiene acceso (en la tabla flpermissions) a una lista de reglas. Todas deben ser verdaderas.
    ```js
    export default {
      path: ...,
      dependencies: [...],
      rules: {
        'ListaRecibosCliente:visit': (check) => check(["reciboscli.get", "reciboscli/delete"]),
        'ListaRecibosCliente:botonera-superior': true,
      }
    }
    ```

  * **Check Condicional**. Concatenación `OR` de funciones Check.
    ```js
    export default {
      path: ...,
      dependencies: [...],
      rules: {
        'ListaRecibosCliente:visit': (check) => check("reciboscli.get") || check("reciboscli/delete"),
        'ListaRecibosCliente:botonera-superior': true,
      }
    }
    ```

### Más

  * [Volver al Índice](./index.md)
  * [Parte 1: Creando reglas](./createRules.md)
  * [Parte 2: Aplicando reglas en PinebooAPI](./pinebooApi.md)
  * [Parte 4: Aplicando reglas en AbanQ/Eneboo](./abanq.md)
