# Docker Jasper Server / Instalación

### Lee esto antes.

- [Pasos previos](./migracion_docker_postgres.md)

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

En este momento es probable que no salga un error que nos indique que nos falta algunos permisos, si es asi debemos lanzar algunos comandos para cambiar eso.

Primero agregaremos a nuestro usuario al grupo de **docker** y volvemos a probar:

```
sudo gpasswd -a $USER docker
newgrp docker
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
* se van a generar en *EXTERNAL_VOLUME* del anfitrión tres carpetas:
    * pddata. Esta carpeta contiene todos los ficheros de configuración de postgres, desde habilitar ips, hasta cambiar puertos, etc.
    * cron. Ficheros de cron para habilitar tareas programadas. 
    * backup. Acceso a los últimos dumps generados.

* Para cambiar la versión de postgresql, debemos cambiar la versión en  le Dockerfile y vovler a hacer build. Es recomendable realizar un backup previo por si la actualización de la versión produce algún problema con los datos existentes:
```
FROM postgres:15.4
```
## Notas
* La ip es la misma que la del anfitrión. 
* Si ya existe un servidor de postgres , hay que deshabilitarlo para levantar este.
* Los ficheros de cron , inicialmente funciona. Para habilitarlo , hay que entrar una vez en el docker y ejecutar '*crontab -e*':
```console
    docker ps // Para ver nuestro CONTAINER ID. Ejemplo 086bbf520c72
    docker exec -i -t 086bbf520c72 /bin/bash
    root: crontab -e 
```
* Editamos los datos:
    * Vía Google drive (Usando /backup/backup_drive.sh):
        * remote_profile_name: Nombre instalacion para almacenar las copias en remoto.
        * db_user_name: Usuario de postgres.
        * db_user_pass: Password de postgres.
        * db_port: Puerto postgres (Opcional). Default: 5432
        ```
        * 1 * * * /backup/backup_drive.sh remote_profile_name db_user_name db_user_pass db_port??5432
        ```

    * Vía SCP. Editamos los datos (Usando /backup/backup.sh)  (remote_user, remote_host y db_port son opcionales):
        * db_user_name: Usuario de postgres.
        * db_user_pass: Password de postgres.
        * remote_profile_name: Nombre instalacion para almacenar las copias en remoto.
        * db_port: Puerto postgres (Opcional). Default: 5432
        * remote_user: Usuario remoto (Opcional). Default: yeboyebo_backup
        * remote_host: Servidor remoto (Opcional). Default: 81.169.149.68
        ```
        * 1 * * * /backup/backup.sh db_user_name db_user_pass remote_profile_name db_port??5432 remote_user??yeboyebo_backup remote_host??81.169.149.68
    ```

* Al guardar tenemos que obtener el siguiente mensaje: 
```console
crontab: installing new crontab
```

### Más

- [Volver al Índice](./index.md)