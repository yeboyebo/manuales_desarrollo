# Docker Postgres / Instalación

### Lee esto antes.

- [Pasos previos](./migracion_docker_postgres.md)

## Pasos previos
### Contraseña de postgres / usuario admin
Dado que vamos a hacer una copia de todos los usuarios del sistema a migrar, la contraseña del usuario que realizará las acciones del docker (típicamente postgres), es importante que conozcamos su contraseña. Si no la conocemos deberemos cambiarla en el postgres actual antes de continuar.

### Copia de los datos a llevar a la nueva instalación
Hacer un dump de usuarios y roles y de las bds que vayamos a pasar
```sh
pg_dumpall --globals-only -U antonio -h localhost -p 54322 > roles.dump
pg_dump yeboyebo -U antonio -h localhost -p 54322 > yeboyebo.dump
```

### Usuario de instalación
Si no podemos hacer la instalación con root, nos aseguramos que el usuario que usaremos pertenece al grupo docker.

```
sudo gpasswd -a $USER docker
newgrp docker
```
## Descarga de Github

El servidor de Postgres es un proyecto de docker. Clonamos el proyecto con:

```console
cd /opt
git clone https://github.com/yeboyebo/docker_postgres.git
```
Autenticar con el token generado en https://github.com/settings/tokens 
dando permiso a la parte de _repos_.
+ Username (p.e. _antonio-yeboyebo_)
+ Pass: el token generado

Obtendremos algo similar a:
```console
Clonando en 'docker_postgres'...
Username for 'https://github.com': antonio-yeboyebo
Password for 'https://```antonio-yeboyebo@github.com': 
remote: Enumerating objects: 44, done.
remote: Counting objects: 100% (44/44), done.
remote: Compressing objects: 100% (32/32), done.
remote: Total 44 (delta 15), reused 35 (delta 9), pack-reused 0
Desempaquetando objetos: 100% (44/44), 11.30 KiB | 680.00 KiB/s, listo.
```

__NOTA: Pensar política de tokens__

## Primer entorno

Para funcionar, el servidor debe detectar un fichero _.env_ en el directorio principal. La estructura de este fichero debe ser:

En _/opt/docker_postgres_

Fichero _.env_

```sh 
POSTGRES_USERNAME=**user**
POSTGRES_PASSWORD=**password**
## Carpeta externa donde generar las copias
EXTERNAL_VOLUME=/opt/postgres_data
```
__External volume__: Es aconsejable crear una carpeta externa distinta de la de la imagen de docker para guardar los datos externos.

__Notas sobre el usuario__: El usuario que creemos será el que se encargará de realizar todas las acciones automáticas (típicamente _postgres_). Como al finalizar la instalación restauraremos, en caso de que en el fichero de roles (p.e. _roles.dump_) ya exista el usuario, al restaurar su contraseña se cambiará a la de la instalación previa de postgres.

__EXTERNAL_VOLUME__: Cuando el docker se inicia la primera véz crea las carpetas de backup, cron, pgdata en la carpeta que especifiquemos como __EXTERNAL_VOLUME__. Desde aquí podemos hacer cambios en la configuración del docker , sin necesidad de entrar en el. No es necesario que sea la misma carpeta que hemos descargado de GIT.

## Instalación
Si tenemos el servicio de postgres corriendo, lo paramos:
```console
service postgres stop
```
Para mayor seguridad podemos cambiar el puerto de salida, por si postgres se reinicia, en el fichero _postgresql.conf_.

Una vez tengamos el fichero .env correcto podemos lanzar:

```console
cd /opt/docker_postgres
docker-compose build
```
Para arrancar el docker
```console
cd /opt/docker_postgres
docker-compose up
```
Al final nos debe aparecer _database system is ready to accept connectios_

Para dejar el docker levantado
```console
cd /opt/docker_posgres
docker-compose start
```

En caso que necesitemos para o reiniciar el docker utilizar start o stop:

```console
docker-compose up/stop
```

Cuando realizamos el primer "up":
* Se crea el usuario *POSTGRES_USERNAME* con el *POSTGRES_PASSWORD* con autenticación MD5 y se actualiza pg_hba.conf con soporte de MD5. 
* se van a generar en *EXTERNAL_VOLUME* del anfitrión tres carpetas:
    * pgdata. Esta carpeta contiene todos los ficheros de configuración de postgres, desde habilitar ips, hasta cambiar puertos, etc.
    * cron. Ficheros de cron para habilitar tareas programadas. 
    * backup. Acceso a los últimos dumps generados.

* Para cambiar la versión de postgresql, debemos cambiar la versión en el Dockerfile , cambiando la siguiente linea, por una nueva versión:
```
FROM postgres:15.4
```
Una vez realizamos el cambio lanzamos 
```console
docker-compose build
```

__NOTA__: Es recomendable realizar un backup previo por si la actualización de la versión produce algún problema con los datos existentes.

### Restaurar roles y bases de datos
```sh
createdb yeboyebo -E UNICODE -h localhost -p 5432 -U [POSTGRES_USERNAME]
psql yeboyebo -h localhost -p 5432 -U [POSTGRES_USERNAME] < roles.dump
psql yeboyebo -h localhost -p 5432 -U [POSTGRES_USERNAME] < yeboyebo.dump
# resto de bds...
```

### Evitar que el postgres nativo se levante al reiniciarse la máquina
```sh
systemctl disable postgresql
```

## Configuración de las copias de seguridad

### Indicar las BDs a copiar
En la carpeta EXTERNAL_VOLUME/backup/databases.txt

### Progamar las copias
Para habilitar el cron, hay que entrar __una primera vez__ en el docker y ejecutar '*crontab -e*':
```console
    docker ps // Para ver nuestro CONTAINER ID. Ejemplo 086bbf520c72
    docker exec -i -t 086bbf520c72 /bin/bash
```    
Y ya en la consola de docker
```console
    # root: crontab -e 
```
* Editamos los datos:
    * Vía Google drive (Usando /backup/backup_drive.sh):
        * remote_profile_name: Nombre instalacion para almacenar las copias en remoto. "_NO_SYNC_" no sincroniza con remoto.
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
En adelante, basta editar el fichero _root_ en _EXTERNAL_VOLUME/cron/root_ para añadir o modificar acciones de cron.

## Mantenimiento
Podemos acceder a la consola de forma de siempre.

Para reiniciar postgres, lo mejor es tirar y levantar el docker entero.


### Más

- [Volver al Índice](./index.md)