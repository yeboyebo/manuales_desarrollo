# Manual desarrollo con ACL
# Parte 3. Aplicando reglas en Quimera

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

### Más

  * [Volver al Índice](./index.md)
  * [Parte 1: Creando reglas](./createRules.md)
  * [Parte 2: Aplicando reglas en PinebooAPI](./pinebooApi.md)
  * [Parte 4: Aplicando reglas en AbanQ/Eneboo](./abanq.md)
