# Pineboo Server desde Eneboo / Configuración

## Tablas de autenticación
La autenticación de primer nivel y el uso de tokens de autenticación necesita de la existencia de dos tablas que Django genera de forma automática, *auth_user* y *authtoken_token*. Para generarlas:
  ```console
  cd carpeta_con_pinebooapi
  docker-compose run django bash
  > python manage.py makemigrations
  > python manage.py migrate
  > exit
  ```

  Para poder usar el token con pinebooapi y olula, desde una consola de postgres:
  ```sql
  ALTER TABLE authtoken_token ALTER COLUMN key TYPE VARCHAR(400);
  ```

## Checklist inicial
Antes de continuar debemos asegurarnos de que tenemos instalado:
* [Pineboo Server](../pineboo_server/instalacion.md)
* Una versión de Eneboo que contenga **AQExtension**. Para comprobarlo hay que ver que en la carpeta *bin* del directorio de instalación de Eneboo hay un fichero ejecutable llamado *aqextension*.

## URL de la API 
Indicamos la URL de la API en Eneboo, en Facturacion > Principal > Configuracion, pestaña *Servidor*.

![Formulario URL](img/url_api.png)

## Obtención del token
Para evitar pedir la contraseña en cada llamada, cada usuario tiene asociado un token de autenticación en su ficha de usuario (Facturación > Principal > Usuarios).

Una vez establecida su contraseña, pulsamos el botón *Obtener token*. Si todo va bien, el campo *token* se informará automáticamente.

![Usuarios](img/usuarios.png)

## Activar llamadas a Pineboo Server
Para activar las llamadas de forma global, insertamos el siguiente registro en la tabla flsettings:

```
flkey = 'usarServidorPineboo_firma'
valor = 'true'
```

Ciertas extensiones pueden tener activado esto por defecto, sobrecargando la función *usarServidorPineboo* de *flfactppal.qs*:
```js
function jsenar_usarServidorPineboo() {
  return true
}
```

### Más

  * [Volver al Índice](./index.md)
