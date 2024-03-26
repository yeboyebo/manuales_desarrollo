# Conexión con API

## Invalid token

### Desde Eneboo

## Tests

### Features
Error:
```sh
Error: ResolveMessage {}
...
```
Posible causa:

El fichero *application.yaml* que apunta a la ruta del controlador no contiene una ruta válida en el valor *class*.


Errir:
```sh
AssertionError: err must be an Error
...
```
Posibles causas:

* El fichero de controller no está definido o su ruta no coincide con la ruta especificada en src/apps/[...]/dependency-injection/apps/[...]/application.yaml

* El fichero de caso de uso no está definido o su ruta no coincide con la ruta especificada en el fichero application.yaml
