# Pineboo Server / Instalación

## Descarga de Github
El servidor de Pineboo es un proyecto de docker llamado pinebooapi. Clonamos el proyecto con:
  ```console
  git clone git@github.com:yeboyebo/pinebooapi.git
  ```
## Primer entorno
Para funcionar, el servidor debe detectar un fichero *.env* en el directorio principal. La estructura de este fichero debe ser:

  ```sh
# Puerto por el que se publica la API de Pineboo
PORT=8005
DOCKER_IP=55
# IP de docker, puede obtenerse con ifconfig buscando la entrada "docker"
DBHOST=172.17.0.1
WEBHOST=172.17.0.1
# Parámetros de conexión a la base de datos
DBNAME=oficial
DBUSER=antonio
DBPASSWORD=mipassword
DBPOST=5432
# Carpeta local donde se volcará el código Python / traducido de flfiles
PINEBOODIR=/home/antonio/pineboo/
# Carpeta local donde se están descargados los módulos a ejecutar (para carga estática)
MODULESDIR=/home/antonio/modulos/
# Ruta relativa a PINEBOODIR que indica la carpeta temporal
TEMPDIR=/pineboo/pineboo/tempdata
# Rutas relativas a MODULESDIR que indican carpetas de scripts incluidos en la carga estática
STATIC_LOADER_DIRS=/pineboo/modules/facturacion/facturacion/scripts/,/pineboo/modules/facturacion/principal/scripts/,/pineboo/modules/facturacion/almacen/scripts/,/pineboo/modules/facturacion/tpv/scripts/,/pineboo/modules/sistema/libreria/scripts/
WEBSOCKET=True
USE_ATOMIC_LIST=True;
  ```

Copiamos en un fichero de texto esta estructura, sustituimos por nuestros datos locales, y lo guaramos con el nombre .env en */pinebooapi*.

## Primera ejecución
Como en cualquier proyecto docker, lo primero es construirlo, y luego levantarlo.
```console
cd pinebooapi
docker-compose build
docker-compose up
...
docker-compose down
```

## Comprobación
Tras lenvantar el entorno (*docker-compose up*), la consola debe acabar indicándonos algo similar a:
```console
(...)Listening on TCP address 0.0.0.0:8000
```
Podemos comprobar que el entorno se ha levantado y está escuchando indicando esta URL en el navegador:
```url
http://localhost:[PORT]/api
```
y obteniendo un error similar a
```
Page not found (404)
Request Method:	GET
Request URL:	http://localhost:8005/api
Using the URLconf defined in YBAQNEXT.urls, Django tried these URL patterns, in this order:

api/
admin/
[name='index']
login [name='authentication']
login/ [name='authentication']
logout [name='logout']
getToken [name='getToken']
[name='root']
The current path, api, didn't match any of these.

You're seeing this error because you have DEBUG = True in your Django settings file. Change that to False, and Django will display a standard 404 page
```
### Más

  * [Volver al Índice](./index.md)
