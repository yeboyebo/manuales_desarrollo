# Configuración personal

## Crear un nuevo usuario:

Primero creamos el usuario con: 

    sudo adduser usuario

Añadimos el usuario al grupo de administradores:

    * Opcion 1
        sudo adduser usuario sudo
    * Opcion 2
        sudo usermod -a -G root usuario

## Cambiar nombre de la máquina

    sudo vi /etc/hostname
    - Recomendación: *YeboYeboNumeroExtension*. Ej: *YeboYebo05*

Cambiar nombre máquina anterior editando el fichero:

    sudo vi /etc/hosts

## Actualizar repositorios

Antes de empezar a instalar actualizamos los repositorios con:

    sudo apt-get update

## Codificación

Si hay problemas con la codificación al bajar funcionalidades debemos hacer lo siguietne:

 - En el **.bashrc** de vuestro home hay que añadir al final:

```
    export LC_ALL=es_ES@euro
    export LC_CTYPE=es_ES@euroduf
    export LC_TYPE=es_ES@euro
    export LANG=es_ES@euro
    export LANGUAGE=es_ES
```
- En **/etc/locale.gen** hay que buscar las siguientes líneas y dejarlas de la siguiente forma:

```
	# es_ES ISO-8859-1
    # es_ES.UTF-8 UTF-8
    es_ES@euro ISO-8859-15 
```
Por último regeneramos las variables con:

    sudo locale-gen


  * [Volver al Índice](./index.md)