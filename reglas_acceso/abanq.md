# Manual desarrollo con ACL
---------------------------
# Parte 4. Aplicando reglas en AbanQ/Eneboo
-------------------------------------------

## Comprobar si el usuario actual es superusuario
  ```js
  var isSuperuser = formflpermissions.iface.isSuperuser();
  ```
## Comprobar si el usuario actual tiene permisos sobre una acción
  ```js
  var isAllowed = formflpermissions.iface.isAllowed('reciboscli/get');
  ```

### Más

  * [Volver al Índice](./index.md)
  * [Parte 1: Creando reglas](./createRules.md)
  * [Parte 2: Aplicando reglas en PinebooAPI](./pinebooApi.md)
  * [Parte 3: Aplicando reglas en Quimera](./quimera.md)
