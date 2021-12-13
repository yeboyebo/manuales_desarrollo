# Manual desarrollo con ACL
---------------------------
# Parte 2. Aplicando reglas en PinebooAPI
-----------------------------------------

## Es tu día de suerte

  * Por suerte, no tenemos que hacer nada para aplicar las reglas en PinebooAPI, ya que las mismas están creadas a su imagen y semejanza.
  * Las reglas `_model_/get` se comprobarán cuando realices un `get` sobre el modelo automáticamente, por lo que no tienes nada de que preocuparte.
  * En caso de que quieras limitar el acceso a un método concreto, solamente tienes que crear una regla que lo regule **¡y listo!**

## En caso de que queramos añadir permisos especiales

  * Comprobamos si un usuario es superusuario
  ```python
  is_superuser = qsa.fromProject('formflpermissions').iface.userIsSuperuser(
    _username_
  )
  ```

  * Comprobar si el usuario actual tiene permisos sobre una acción
  ```python
  is_allowed = qsa.fromProject('formflpermissions').iface.userIsAllowed(
    _verb_,
    _username_,
    _model_,
    _method_
  )
  ```

  * `_username_` => el nombre del usuario a comprobar (ej: `admin`)
  * `_model_` => nombre de la tabla/grupo de reglas (ej: `reciboscli`)
  * `_verb_` => tipo de peticion (ej: `get`)
  * `_method_` => si lo hay, metodo especial (ej: `crearReciboPrivado`)

### Más

  * [Volver al Índice](./index.md)
  * [Parte 1: Creando reglas](./createRules.md)
  * [Parte 3: Aplicando reglas en Quimera](./quimera.md)
  * [Parte 4: Aplicando reglas en AbanQ/Eneboo](./abanq.md)
