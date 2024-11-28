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

Creamos en dockerhub ([hub.docker.com](https://hub.docker.com)) el respositorio __privado__ `pinebooapi_[nombre]`(p.e. pinebooapi_sanhigia). El nombre del repositorio (pinebooapi_guanabana en este ejemplo) debe ser el que se indica en la clave:

## Despliegue en local del servidor (no Kubernetes)
El despliegue en local es el que haremos sobre un servidor del cliente

### Establecer la carpeta de despliegue
En la carpeta de despliegue del servidor delcliente debemos incluir:

+ Un fichero `docker-compose.yml` copia de `codebase/despliegue/docker-compose-local.yml`

+ En fichero `.env` con los valores de environment necesarios. Cambiar del fichero .env estos valores respecto del fichero de desarrollo:
  + (parámetros de acceso a la BD)
  + PINEBOODIR=/src/pineboo/
  + MODULESDIR=/src/codebase/extensiones_2.5.0/fun_jsenar/build/final/
  + FLFILES_FOLDER=/src/codebase/extensiones_2.5.0/fun_jsenar/build/final/
  + EXTERNAL_MODULES=/src/codebase/olula

+ Una copia del fichero de despliegue `despliegue_local.sh` que tenemos en `codebase/despliegue`, cambiando:
  + `[nombre]` por `guanabana`, p.e. `REPO=yeboyebohub/pinebooapi_guanabana`


## Despliegue en servidor de cliente:

+ Hacemos un push de la rama `[NombreApp]_Produccion`.

+ Esperamos a que las acciones terminen en [github](https://github.com/yeboyebo/codebase/actions).

+ Entramos en [hub.docker.com](https://hub.docker.com/repositories/yeboyebohub) y para el reposiorio de despliegue copiamos el TAG asociado a la última subida (push).

+ En el servidor del cliente, accedemos a la carpeta de despliegue del cliente y lanzamos el sh de despliegue
:
``` sh
sh despliegue_local.sh [TAG]
```
La primera vez deberemos introducir el usuario y login de dockerhub

TO DO:
 + Que Iván lo valide
 + Ver lo de arrancar el pineboo de eventos
 + Ver cómo volver a versión anterior
 + Ver si la secuencia del sh es correcta o se puede hacer mejor para interrumpir lo mínimo
 + Ver volcado a log de docker-compose up


### Más

  * [Volver al Índice](./index.md)