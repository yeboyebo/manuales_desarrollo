# Testing / Configuración Tests Eneboo QS

## Recomendaciones

Eneboo nos obliga a ejecutar el script cargado desde una base de datos. El testeo en SQLite será mucho más rápido, por lo que es la opción recomendada. También es posible hacerlo en PostgreSQL.

## Paso 1. Comprobar versión de Eneboo

Comprobamos que tengamos una versión de Eneboo igual o superior a la v2.6.0.1. Si no es así, debemos actualizarla.

## Paso 2. Crear base de datos para los Tests

Creamos una base de datos lanzando el siguiente comando:

```sh
# SQLite
~/ruta_hacia_eneboo/bin/eneboo -silentconn "test:yeboyebo:SQLite3:nogui"

# PostgreSQL
~/ruta_hacia_eneboo/bin/eneboo -silentconn "test:user:PostgreSQL:localhost:5432:password:nogui"
```

Aceptamos la creación de la BD

## Paso 3. Cargar módulo test_qs

Simplemente cargar el módulo como de costumbre. Podemos encontrarlo en los módulos oficiales dentro del área de sistema. Solamente será necesario ejecutar este paso la primera vez.

## Paso 4. Añadir nuestra ruta al path de eneboo

Para poder importar los ficheros de tests, eneboo debe conocer la ruta desde donde los lanzamos. Pra ello editamos el fichero _~/.qt/eneboorc_

En la parte de [application] añadimos una entrada para nuestra base de datos con la ruta de nuestros módulos/extensión

```sh
# SQLite
codepath/home/_user_/.eneboocache/UTF-8/test=/home/_user_/funcional/modulos

# PostgreSQL
codepath/test=/home/_user_/funcional/modulos
```

## A testear

Ya puedes empezar a hacer tests en [Testing Eneboo](./tests_qs.md)
