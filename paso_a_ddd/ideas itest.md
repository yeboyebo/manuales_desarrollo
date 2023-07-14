# IDEAS I TEST

## QSA

### Precondiciones:
Tener la carpeta _.eneboocache_ en nuestro home.

### Preparar la BD de template
Ejemplo para el caso de la extensión de tallas y colores (proyecto _moda_)

Creamos una bd template abriendo Eneboo y seleccionando los valores:
+ nombre de la bd con el sufijo __template_ (_moda_template)
+ Driver SqLite

Cargamos los módulos de la extensión y hacemos que se lancen sus _init_ (abrimos una acción de cada módulo).

Cerramos Eneboo. Se deben haber creado dos ficheros:
``` sh
.eneboocache/UTF-8/moda_template.s3db
.eneboocache/moda_template
```
El primero es la base de datos SqLite3, el segundo, la carpeta caché de Eneboo para esta BD.

### Tests
En nuestros tests, deberemos usaremos la línea
``` js
EnebooCursorClient.cleanupDB()
```
para hacer una copia del template y limpiar la caché antes de realizar uno o varios tests.

## PYTHON

### Precondiciones:
Tener la carpeta _Pineboo/tempdata_ en nuestro home.

### Preparar la BD de template
Ejemplo para el caso de la extensión de tallas y colores (proyecto _moda_)

Creamos una bd template abriendo Pineboo con:
```sh
pineboo -s "miusuario::SQLite3 (SQLITE3)@localhost:0/moda_template"
```
 
Cargamos los módulos de la extensión y hacemos que se lancen sus _init_ (abrimos una acción de cada módulo).

Cerramos Pineboo. Se deben haber creado estos ficheros:
``` sh
Pineboo/tempdata/sqlite_databases/moda_template.sqlite3-wal
Pineboo/tempdata/sqlite_databases/moda_template.sqlite3-shm
Pineboo/tempdata/sqlite_databases/moda_template.sqlite3
Pineboo/tempdata/cache/moda_template
```
Los tres primeros son la base de datos SqLite3, el cuarti, la carpeta caché de Pineboo para esta BD.

### Tests
En nuestros tests, deberemos usaremos la línea
``` js
EnebooCursorClient.cleanupDB()
```
para hacer una copia del template y limpiar la caché antes de realizar uno o varios tests.


