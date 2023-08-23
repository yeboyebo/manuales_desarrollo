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

### setup de suite: _beforeAll_
Antes de comenzar una suite de tests, debemos preparar la base de datos para su uso. Esto implica copiar una plantilla (template) con la estructura y realizar la conexión.
``` js
t.describe("TestCursorEjercicioFiscalRepository", function () {
    // TO DO: Pasar a t.beforeAll (no funciona en python)
    BooEngine.setAdminMode(false)
    EnebooCursorClient.cleanupDB()
    // ...
```

### setup de test: _beforeEach_
Antes de comenzar cada test debemos asegurarnos de que:
+ Se han borrado los registros creados por el test
+ Se han creado los registros necesarios para el siguiente test
``` js
function cleanupDB() {
    const sqls = [
        "DELETE FROM ejercicios;"
    ]
    formARRAY.map(sqls, function (sql) {
        AQUtil.execSql(sql, EnebooCursorClient.conexion)
    })
}

t.beforeEach(function () {
    cleanupDB()
});
```

### Tests de guardado
Los pasos serán:
+ Crear un agregado mediante un _Mother_.
+ Guardar el agregado
```js
t.test("El repositorio guarda ejercicios fiscales", function () {
    const ejercicio = EjercicioFiscalMother.basico();

    const repository = formDependencyContainer.get("empresa.ejerciciofiscal.domain.repository");
    repository.save(ejercicio);
})
```
### Tests de guardado y carga
Los pasos serán:
+ Crear un agregado mediante un _Mother_.
+ Guardar el agregado
+ Buscar el agregado
+ Comprobar que el agregado recuperado es igual al guardado

```js
t.test("El repositorio recupera ejercicios fiscales", function () {
    const ejercicio = EjercicioFiscalMother.basico();
    const idEjercicio = ejercicio.id.value()

    const repository = formDependencyContainer.get("empresa.ejerciciofiscal.domain.repository");
    repository.save(ejercicio);

    const recuperado = repository.find(idEjercicio);

    t.expect(recuperado.equals(ejercicio)).toBe(true);
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
t.test("El repositorio modifica ejercicios fiscales", function () {
    const expected = {
        "nombre": "Ejercicio 1234"
    }
    const ejercicio = EjercicioFiscalMother.basico();
    const idEjercicio = ejercicio.id.value()

    const repository = formDependencyContainer.get("empresa.ejerciciofiscal.domain.repository");
    repository.save(ejercicio);

    const recuperado = repository.find(idEjercicio);
    recuperado.nombre = expected["nombre"];

    repository.save(recuperado);
    const modificado = repository.find(idEjercicio);

    t.expect(modificado.nombre).toBe(expected["nombre"]);
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
t.test("El repositorio borra ejercicios fiscales", function () {
    const ejercicio = EjercicioFiscalMother.basico();
    const idEjercicio = ejercicio.id.value()

    const repository = formDependencyContainer.get("empresa.ejerciciofiscal.domain.repository");
    repository.save(ejercicio);

    const recuperado = repository.find(idEjercicio);
    repository.del(idEjercicio);

    const borrado = repository.find(idEjercicio);

    t.expect(recuperado != null).toBe(true);
    t.expect(borrado == null).toBe(true);
})
```