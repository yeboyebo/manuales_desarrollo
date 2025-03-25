# Despliegue automático
El despliegue automático consta de dos partes principales:

+ Crear la rama y la Github action

+ Crear 

## Crear la rama y la Github Action

### Crear la rama de despliegue
+ Creamos la rama en github a partir de master [NombreApp]_Produccion.

  + Ejemplo: `Guanabana_Produccion`

### Fichero de Github actions
El fichero describe las acciones a realizar cuando se haga un commit sobre la rama de despliegue.

+ En `codebase/.github/workflows/` creamos un nuevo fichero Deploy_[NombreApp].yml a partir del fichero Deploy_Plantilla.yml.template:

  `Deploy_Plantilla.yml.template` > `Deploy_Guanabana.yml`

+ Modificamos el fichero con los datos del despliegue:

  + Cambiamos `[NombreApp]` > `Guanabana`
  + Cambiamos `[nombre_rama]` > `fun_guanabana`
  + Cambiamos `[nombre]` > `guanabana`
  + Si no vamos a desplegar en Kubernetes, borramos completamente la clave `deploy-to-cluster`.

Checks:

  + pinebooapi_[nombre] es el repo en DockerHub
  + [NombreApp]_Produccion es el nombre de la rama en GitHub
  + [nombre]-deployment es el nombre del deployment en Kubernetes (si desplegamos en Kubernetes), especificado en el fichero de despliegue de Kubernetes, en la clave _metadata_ > _name_

### Fichero Dockerfile
El fichero Dockerfile 

+ En `codebase/.despligue` creamos un nuevo fichero Dockerfile_[NombreApp] a partir del fichero Dockerfile_Plantilla

  `Dockerfile_Plantilla` > `Dockerfile_Guanabana`

  + Cambiamos `[nombre_rama]` > `fun_guanabana`

Checks:

  + El nombre del fichero Dockerfile_[Aplicacion] generado coincide con la clave `name: Build and push > _file_` del fichero de github asociado Deploy_[Aplicacion].yml

## Crear el Repositorio en Docker Hub

Creamos en dockerhub ([hub.docker.com](https://hub.docker.com) (claves en bitwarden)) el respositorio __privado__ `pinebooapi_[nombre]`(p.e. pinebooapi_sanhigia). El nombre del repositorio (pinebooapi_guanabana en este ejemplo) debe ser el que se indica en la clave `Build and push` > `tags` del fichero Deploy_[aplicacion].

## Despliegue en local del servidor (no Kubernetes)
El despliegue en local es el que haremos sobre un servidor del cliente

### Establecer la carpeta de despliegue
En la carpeta de despliegue del servidor delcliente debemos incluir:

+ En fichero `.env` con los valores de environment necesarios. Cambiar del fichero .env estos valores respecto del fichero de desarrollo:

```ini
  + (parámetros de acceso a la BD)
  + PINEBOODIR=/src/pineboo/
  + MODULESDIR=/src/codebase/extensiones_2.5.0/fun_jsenar/build/final/
  + FLFILES_FOLDER=/src/codebase/extensiones_2.5.0/fun_jsenar/build/final/
  + EXTERNAL_MODULES=/src/codebase/olula
  + PROJECT_NAME=[nombre de la carpeta del cliente en olula/apps]
```

+ Una copia del fichero de despliegue `despliegue_local.sh` que tenemos en `codebase/despliegue`, cambiando:
  + `[nombre]` por `guanabana`, p.e. `REPO=yeboyebohub/pinebooapi_guanabana`


## Despliegue en servidor de cliente:

+ Hacemos un push de la rama `[NombreApp]_Produccion`.

+ Esperamos a que las acciones terminen en [github](https://github.com/yeboyebo/codebase/actions).

+ Entramos en [hub.docker.com](https://hub.docker.com/repositories/yeboyebohub) y para el reposiorio de despliegue copiamos el TAG asociado a la última subida (push). Para ello pulsamos en el enlace de la subida y sacamos el tag del título de la página:
Ejemplo: `yeboyebohub/pinebooapi_guanabana:a53dc48bd5efd3ecd4b7fa7db212fbdee6b792e3` > Tag = a53dc48bd5efd3ecd4b7fa7db212fbdee6b792e3

+ En el servidor del cliente:
  - Miramos si hay un docker levantado y si existe lo mataremos:

    ``` 
    docker ps
    ```
    Si no hay un docker levantado nos devolverá:

    ```

    CONTAINER ID   IMAGE                                     COMMAND                  CREATED      STATUS      PORTS                                                 NAMES

    ```

    Si hay un docker levantado nos devolverá algo así:

    ```

    CONTAINER ID   IMAGE                                     COMMAND                  CREATED      STATUS      PORTS                                                 NAMES
    31257e34eae7   yeboyebohub/pinebooapi_guanabana:latest   "/bin/bash -c '/usr/…"   5 days ago   Up 5 days   8080/tcp, 0.0.0.0:8080->8000/tcp, :::8080->8000/tcp   goofy_haibt


    ```

    Nos fijaremos en el CONTAINER ID para matarlo:

    ``` sh
      docker kill 31257e34eae7
    ```

 
  - Accedemos a la carpeta de despliegue del cliente y lanzamos el sh de despliegue.


    ``` sh
    sh despliegue_local.sh [TAG]
    ```
    La primera vez deberemos introducir el usuario y login de dockerhub

    Si tras lanzar el despliegue no aparece la imagen con docker ps, podemos ver qué ha fallado entrando en modo interactivo:
    ```sh
      docker run -p 8080:8000 --expose 8080 --env-file .env -it --entrypoint /bin/bash yeboyebohub/pinebooapi_hispanicfiber:latest
    ```
    Y ejecutando dentro del contenedor:

    ```sh
    python3 app/manage.py runserver 0.0.0.0:8000
    ```
### Ver el log de pinebooapi en local
Para ver el log entramos en la consola de docker:
```sh
docker ps
```
(obtenemos el CONTANIER_ID)
```sh
docker exec -it CONTAINER_ID /bin/bash
```
Una vez en la consola de docker usamos tail, cat, etc para ver el fichero en `app/logs/yebo.log`.
```sh
$ tail -n 100 app/logs/yebo.log
```

Podemos realizar búsquedas dentro del fichero de log estando dentro de la carpeta logs:

```sh
  yeboyebo@31257e34eae7:/src/app/logs$ grep palabra_a_buscar $(find . -name .log)

```

Salimos de la consola con exit
```sh
$ exit
```

### Reiniciar pinebooapi en local
Para reiniciar, podemos usar el script sin indicar la etiqueta:
``` sh
sh despliegue_local.sh
```
Como alternativa, podemos también matar el docker como se describe en _Ver el log de pinebooapi en local_ y luego lanzar la última línea del script de despliegue local.


### Más

  * [Volver al Índice](./index.md)