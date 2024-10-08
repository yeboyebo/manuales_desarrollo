# Pineboo Server / Instalación

## Descarga de Github

El servidor de Pineboo es un proyecto de docker llamado pinebooapi. Clonamos el proyecto con:

```console
git clone git@github.com:yeboyebo/pinebooapi.git
```

## Primer entorno

Para funcionar, el servidor debe detectar un fichero _.env_ en el directorio principal. La estructura de este fichero debe ser:

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
PROJECT_NAME=monterelax
# Usa modulos python alojados en esta carpeta
# EXTERNAL_MODULES=/ruta/a/carpeta/
```

Si se usa la nueva parte del módulo de _contextos_, es necesario indicar una clave _PROJECT_NAME_. Consultar su valor con el equipo de desarrollo.

Copiamos en un fichero de texto esta estructura, sustituimos por nuestros datos locales, y lo guaramos con el nombre .env en _/pinebooapi_.

## Modificadores a tener en cuenta

Dentro de ./app/AQNEXT/pinebooSettings.py podemos usar los siguientes modificadores (\* valor por defecto)

```sh
pineboolib_app.AUTO_RELOAD_BAD_CONNECTIONS = *False # Durante una consulta, cuando se especifica a True y se detecta una sessión erronea, reinicia las conexiones del usuario. Cuando está False y se detecta la sesión erronea , lanzará una excepción:
"AttributeError:: Quite possibly, you are trying to use a session in which a previous error has occurred and has not been recovered with a rollback. Current session is discarded."
pineboolib_app.ENABLE_ACLS = *True # Activa o desactiva las ACLS del módulo de acceso instalado.

pineboolib_app.USE_ALTER_TABLE_LEGACY = *True # Si especificamos False , usará alembic para la regenración de tablas (solo usarlo en desarrollo, hay que estar muy seguro de hacerlo en producción)

pineboolib_app.USE_FLFILES_FOLDER_AS_STATIC_LOAD = *True # Habilita el uso de la carpeta especificada en pineboolib_app.PROJECT.USE_FLFILES_FOLDER como flfiles.

pineboolib_app.PROJECT.USE_FLFILES_FOLDER = *'' # Carpeta para ser usada como flfiles.

pineboolib_app.USE_WEBSOCKET_CHANNEL = *False # True habilita el uso de websocket

pineboolib_app.LOG_SQL = *False # True muestra debug del sql generado por sqlalchemy.


pineboolib_app.PROJECT.conn_manager.REMOVE_CONNECTIONS_AFTER_ATOMIC = * False # True cierra las conexiónes al terminar de ejecutar el decorador atomic. Esto es importante para que el pool de conexiones no se llene.





```

## Dar permisos a fichero docker.sock

```console
sudo usermod -a -G docker $USER
```

## Configuración postgresql

En /etc/postgresql/9.6/main/postgresql.conf, hay que dejar la siguiente linea de la siguiente forma

```
listen_addresses = '*'                  # what IP address(es) to listen on;
```

En /etc/postgresql/9.6/main/pg_hba.con, hay añadir una linea para que deje acceder desde el rango de ips que estamos utilizando, en el ejemplo al añadir 0.0.0.0/0 damos acceso a cualquier rango

```
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
host    all             all             0.0.0.0/0               md5
```

Para versiones de postgresql_server >= 13.0 tener en cuenta lo que se dice al respecto en [Postgresql Server / Instalación y configuración](../postgresql_server/configuracion.md).

Reiniciar postgresql

```
sudo service postgresql restart
```

## Comprobar antes de ejecutar

Si tenemos instalado la version de python >= 3.10, puede que nuestra versión de Docker esté desfasada y eso nos genere un problema en la lectura del comando. En ese caso ejecutaremos previamente el siguiente comando:

```console
alias docker-compose='docker compose'
```

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

Tras lenvantar el entorno (_docker-compose up_), la consola debe acabar indicándonos algo similar a:

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

## Actualización

- Ejecutar el comando siguiente comando con la versión a actualizar

```
pip3 install pineboo==0.99.78
```

- Editar el fichero Dockerfile de nuestro directorio de pinebooapi para informar la nueva versión

- Ejecutar desde nuestro directorio de pinebooapi

```
docker-compose build
```

### Más

- [Volver al Índice](./index.md)
