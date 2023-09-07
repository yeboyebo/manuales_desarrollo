# Docker Jasper Server / Instalación

## Descarga de Github

El servidor de Postgres es un proyecto de docker. Clonamos el proyecto con:

```console
git clone git@github.com:yeboyebo/docker_postgres.git
```

## Primer entorno

Para funcionar, el servidor debe detectar un fichero _.env_ en el directorio principal. La estructura de este fichero debe ser:

```sh 
POSTGRES_USERNAME=**user**
POSTGRES_PASSWORD=**password**
EXTERNAL_VOLUME=/opt/yeboyebo/docker_postgres
```

## Instalacion

Una vez tengamos el fichero .env correcto podemos lanzar:

```console
docker-compose build
```

En este momento es probable que no salga un error que nos indique que nos falta algunos permisos, si es asi debemos lanzar algunos comandos para camniar eso.

Primero agregaremos a nuestro usuario al grupo de **doceker** y volvemos a probar:

```
sudo gpasswd -a $USER docker
newgrp docke
```

Si de nuevo vuele a fallar podemos intentar volver a logearnos o reiniciar:

```
sudo su $USER
```

En caso que necesitemos para o reiniciar el docker utilizar start o stop:

```console
docker-compose up/stop
```

## Configuración

Cuando realizamos el primer "up":
* Se crea el usuario *POSTGRES_USERNAME* con el *POSTGRES_PASSWORD* con autenticación MD5 y se actualiza pg_hba.conf con soporte de MD5. 
* se van a generar en *EXTERNAL_VOLUME* del anfitrión dos carpetas:
    * pddata. Esta carpeta contiene todos los ficheros de configuración de postgres, desde habilitar ips, hasta cambiar puertos, etc.
    * cron. Ficheros de cron para habilitar tareas programadas. 

* Para cambiar la versión de postgresql, debemos cambiar la versión en  le Dockerfile y vovler a hacer build. Es recomendable realizar un backup previo por si la actualización de la versión produce algún problema con los datos existentes:
```
FROM postgres:15.4
```
## Notas
* La ip es la misma que la del anfitrión. 
* Si ya existe un servidor de postgres , hay que deshabilitarlo para levantar este.
* Los ficheros de cron , inicialmente no existen porque aún no hay tareas programadas. Para habilitarlo , hay que entrar una vez en el docker y ejecutar '*crontab -e*':
```console
    docker exec -i -t 086bbf520c72 /bin/bash
    root: crontab -e 
```

### Más

- [Volver al Índice](./index.md)