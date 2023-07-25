# Testing de persistencia

## Configuración QSA

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

## Configuración Python

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

## Tests
En nuestros tests, deberemos usaremos la línea
``` js
EnebooCursorClient.cleanupDB()
```
para hacer una copia del template y limpiar la caché antes de realizar uno o varios tests.

### Tests de guardado
Los pasos serán:
+ Crear un agregado mediante un _Mother_.
+ Guardar el agregado
```js
t.test("El repositorio guarda la configuración", function () {
    const config = AsientosConfigMother.create();

    const repository = formDependencyContainer.get("contabilidad.asientofacturacliente.domain.configRepository");
    repository.save(config);
})
```
### Tests de guardado y carga
Los pasos serán:
+ Crear un agregado mediante un _Mother_.
+ Guardar el agregado
+ Buscar el agregado
+ Comprobar que el agregado recuperado es igual al guardado

```js
t.test("El repositorio recupera la configuración de asientos", function () {
    const config = AsientosConfigMother.create();

    const repository = formDependencyContainer.get("contabilidad.asientofacturacliente.domain.configRepository");
    repository.save(config);

    const recuperada = repository.find(config.codEjercicio);

    t.expect(recuperada.codEjercicio).toBe(config.codEjercicio);
    // ...
})
```

### Tests de modificación
Los pasos serán:
+ Crear un agregado mediante un _Mother_.
+ Guardar el agregado
+ Buscar el agregado
+ Modificar el agregado
+ Guarda el agregado (si el caso de uso no lo hace ya)
+ Recuperar el agregado y comprobar que las modificaciones se han guardado

```js
t.test("El repositorio modifica la configuración de asientos", function () {
    const config = AsientosConfigMother.create();

    const repository = formDependencyContainer.get("contabilidad.asientofacturacliente.domain.configRepository");
    repository.save(config);

    const recuperada = repository.find(config.codEjercicio);
    recuperada.cambiaNombre("Pepe")
    repository.save(recuperada)
    const recuperada2 = repository.find(config.codEjercicio);
    
    t.expect(recuperada2.nombre).toBe("Pepe");
    // ...
})
```

### Tests de Borrado
Los pasos serán:
+ Crear un agregado mediante un _Mother_.
+ Guardar el agregado
+ Buscar el agregado
+ Borrar el agregado
+ Buscar el agregado y comprobar que este no existe.

```js
t.test("El repositorio borra la configuración de asientos", function () {
    const config = AsientosConfigMother.create();

    const repository = formDependencyContainer.get("contabilidad.asientofacturacliente.domain.configRepository");
    repository.save(config);

    const recuperada = repository.find(config.codEjercicio);
    repository.del(recuperada)
    const recuperada2 = repository.find(config.codEjercicio);
    
    t.expect(recuperada2).toBe(null);
})
```