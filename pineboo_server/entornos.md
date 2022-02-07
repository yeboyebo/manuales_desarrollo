# Pineboo Server / Gestión de entornos

Cuando trabajemos en varios proyectos necesitaremos poder cambiar de entorno de forma rápida. Para ello hay que cambiar el fichero *.env*.

A continuación proponemos una forma de cambiar de entorno con agilidad.

## Carpeta envs
Creamos una carpeta *envs* en la carpeta superior a *pinebooapi*.  
```console
  mkdir envs
```
Copiamos en esta consola el fichero *.env* con el nombre asociado al proyecto al que apunte.
```console
  cp pinebooapi/.env envs/oficial
```
Iremos añadiendo a esta carpeta un fichero por cada entorno en el que queramos trabajar, que generalmente coincidirá con el nombre de una extensión o BD en la que estemos programando (*articuloscomp*, *fun_jsenar*, etc.).

## Fichero api.sh
Creamos un fichero *api.sh* en la carpeta superior a *pinebooapi* que recibirá como parámetro el nombre entorno en el que queremos trabajar, y lo levantará.
  ```sh
if [ -z "$1" ]
    then
        echo "API default"
    else
        echo "API $1"
        cp envs/$1 pinebooapi/.env
fi

cd pinebooapi
docker-compose up
docker-compose down
cd
```

Damos permiso de ejecución al fichero y podemos ejecutarlo de la siguientes forma
```console
. api.sh [nombre_entorno]
```
Donde *nombre_entorno* es el nombre del fichero en la carpeta *envs* a usar. Si no indicamos valor, levantaremos el servidor con el último entorno que hubiéramos establecido.

### Más

  * [Volver al Índice](./index.md)
