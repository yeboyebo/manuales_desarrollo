# Pineboo Server / Carga desde ficheros

## Fichero de entrono

Para configurar nuestro en entorno para que la carga de ficheros sea automática debemos realizar algunos cambios en nuestro fichero de entrono.

```sh
# Carpeta local donde se está descargados los módulos a ejecutar (para carga estática).
MODULESDIR=/home/USER/modulos/

# Rutas relativas a MODULESDIR que indican carpetas de scripts incluidos en la carga estática. DEBEMOS COMENTAR ESTA LÍNEA
#STATIC_LOADER_DIRS=/pineboo/modules/facturacion/facturacion/scripts/,/pineboo/modules/facturacion/principal/scripts/,/pineboo/modules/facturacion/almacen/scripts/,/pineboo/modules/sistema/libreria/scripts/

# Añadimos la ruta del la carpeta 'flfiles' de la que colgarán nuestros ficheros en el docker.
FLFILES_FOLDER=/pineboo/modules/flfiles
```

## Carpeta 'flfiles'

Debemos crear un carpeta 'flfiles' donde colocar los ficheros a monitorizar. Se corresponderá con la ruta de 'MODULESDIR' en el fichero de entorno.

### Más

* [Volver al Índice](./index.md)
