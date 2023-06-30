# Creación de una nueva entidad (asientos)

Nuestro caso de uso consiste en la creación de un asiento contable a partir de la creación de una factura de ventas.

El caso de uso tomará un evento de Factura Creada y a partir de él recuperará los datos de la factura y otros datos necesarios para realizar los cálculos y creará y guardará el asiento.

## Creamos el módulo
Si no encontramos un módulo donde encajar nuestro caso de uso, crearemos uno.

En nuestro caso, decidimos crear un módulo para cada caso de creación de asiento, así tendremos distintos módulos para crear asientos desde facturas de venta, de compra, pagos, remesas, etc.

La estructura de carpetas será:
* contabilidad (contexto)
    * asientofacturacliente (módulo)
        * application
        * domain
        * infrastructure
        * test

## Primer test
Creamos un primer fichero de tests que contendrá la primera llamada al caso de uso

_contabilidad/asientofacturacliente/test/TestCrearAsientoFacturaCliente.test.qs_
```js
function TestCrearAsientoFacturaCliente (t) {
    t.describe("Crear asiento desde factura", function () {
        t.test("Se crea un asiento desde una factura", function () {
            t.expect(1).toBe(1)
        })
    })
}
TestCrearAsientoFacturaCliente;
```
### Test
El test no tiene lógica y debe pasar un testeo inicial.

## Entidades, Mothers y Mocks necesarios
Debemos comprobar que disponemos de todas las clases accesorias del test, y crear las que haga falta. Estas pueden ser:
* Entidades con las que el caso de uso deba trabajar.
* Mothers para generar instancias de dichas entidades.
* Mocks de repositorios que simulen leer o guardar las entidades.

Nuestro caso de uso recibe un evento de Factura Creada. Creamos un fichero _mother_ para obtenerlo en el test:

_contabilidad/asientofacturacliente/test/FacturaClienteCreadaEventMother.qs_
```js
class FacturaClienteCreadaEventMother {

    static function create() {
        return {
            "idFactura": 125,
            "timestamp": "2019-01-01T00:00:00.000Z"
        }
    }
}
FacturaClienteCreadaEventMother;
```
Una vez recibido el evento, el caso de uso buscará la factura en el repositorio y la usará como base para generar el asiento. Necesitamos por tanto la entidad _FacturaClienteContabilidad_ y su correspondiente repositorio de test _MockedFacturaClienteContabilidadRepository_.

### FacturaClienteContabilidad
_contabilidad/asientofacturacliente/domain/FacturaClienteContabilidad.qs_
```js
class FacturaClienteContabilidad {
    var idFactura;
    var fecha;
    var total;
    var idEjercicio;

    function FacturaClienteContabilidad(data) {
        this.idFactura = data.idFactura;
        this.fecha = data.fecha;
        this.total = data.total;
        this.idEjercicio = data.idEjercicio;
    }

    function toPrimitives() {
        return {
            "idFactura": this.idFactura,
            "fecha": this.fecha,
            "total": this.total,
            "idEjercicio": this.idEjercicio
        }
    }
}
FacturaClienteContabilidad;
```

### MockedFacturaClienteContabilidadRepository
_contabilidad/asientofacturacliente/test/MockedFacturaClienteContabilidadRepository.qs_
```js
class MockedFacturaClienteContabilidadRepository {
    var findReturn;

    function returnOnFind(factura) {
        this.findReturn = factura;
    }

    function find(idFactura) {
        return this.findReturn;
    }
}
MockedFacturaClienteContabilidadRepository;
```
Más en [desarrollo de repositorios mockeados...](./desarrollo_repositorios_test.md)

### MockedAsientoFacturaClienteRepository
Una vez creado el asiento, lo guardaremos en su correspondiente repositorio.

_contabilidad/asientofacturacliente/test/MockedAsientoFacturaClienteRepository.qs_
```js
class MockedAsientoFacturaClienteRepository {
    var asientoGuardado = null;

    function getNextId() {
        return 1;
    }

    function save(asiento) {
        this.asientoGuardado = asiento;
    }

    function assertSaved() {
        if (this.asientoGuardado == null) {
            formError.raise({ "type": "AssertError", "message": "No se ha guardado ningún asiento" });
        }
    }
}
MockedAsientoFacturaClienteRepository;
```
Más en [desarrollo de repositorios mockeados...](./desarrollo_repositorios_test.md)

## Hacemos que el test llame al caso de uso
Ya disponemos de los repositorios necesarios para hacer un primer test que llame al caso de uso. Modificamos nuestro test así:

_contabilidad/asientofacturacliente/test/CrearAsientoFacturaCliente.test.qs_
```js
// Importaciones...

function TestCrearAsientoFacturaCliente (t) {
    t.describe("Crear asiento desde factura", function () {
        t.test("Se crea un asiento desde un evento de factura cliente creada", function () {
            const event = FacturaClienteCreadaEventMother.create();
            const factura = FacturaClienteContabilidadMother.create(event);

            const creator = formDependencyContainer.get("contabilidad.asientofacturacliente.application.CrearAsientoFacturaCliente");

            creator.facturaRepository.returnOnFind(factura)

            creator.run(event);

            creator.asientoRepository.assertSaved();

            const asientoGuardado = creator.asientoRepository.asientoGuardado.toPrimitives();
            t.expect(asientoGuardado.fecha).toBe(factura.fecha);
        })
    })
}
TestCrearAsientoFacturaCliente;
```

### Dependencias del caso de uso
Nuestra clase de caso de uso va a necesitar varios parámetros en su creación:
* Repositorio de facturas de cliente para obtener la factura cuyo asiento queremos crear.
* Repositorio de asientos de factura de cliente para guardar el asiento.

Incluimos las dependencias correspondientes para el caso de uso en el contexto _contabilidad_:

_dependency_injection/contexts/contabilidad.deps.qs_
```js
const contabilidad = {
    "contabilidad.asientofacturacliente.application.CrearAsientoFacturaCliente": {
        "dep": "contexts/contabilidad/asientofacturacliente/application/CrearAsientoFacturaCliente.qs",
        "args": [
            "@contabilidad.asientofacturacliente.domain.repository",
            "@contabilidad.asientofacturacliente.domain.facturaRepository",
        ]
    },
    "contabilidad.asientofacturacliente.domain.repository": {
        "dep": "contexts/contabilidad/asientofacturacliente/infrastructure/SupaQSAsientosRepository.qs",
        "args": []
    },
    "contabilidad.asientofacturacliente.domain.configRepository": {
        "dep": "contexts/contabilidad/asientofacturacliente/infrastructure/SupaQSAsientosConfigRepository.qs",
        "args": []
    },
}
contabilidad;
```
Y para el caso de los tests:

_dependency_injection/environments/test.deps.qs_
```js
const test = {
    // ....
    "contabilidad.asientofacturacliente.domain.repository": {
        "dep": "contexts/contabilidad/asientofacturacliente/test/MockedAsientosRepository.qs",
        "args": []
    },
    "contabilidad.asientofacturacliente.domain.facturaRepository": {
        "dep": "contexts/contabilidad/asientofacturacliente/test/MockedFacturaClienteContabilidadRepository.qs",
        "args": []
    },
}
test;
```
### Primera versión del caso de uso CrearAsientoFacturaCliente
Ya podemos crear clase del caso de uso
_contabilidad/asientofacturacliente/application/CrearAsientoFacturaCliente.qs_
```js
// Importaciones...

class CrearAsientoFacturaCliente {
    var asientoRepository;
    var facturaRepository;

    function CrearAsientoFacturaCliente(asientoRepository, facturaRepository, asientosConfigRepository) {
        this.asientoRepository = asientoRepository;
        this.facturaRepository = facturaRepository;
    }

    function run(event) {
        const factura = this.facturaRepository.find(event.idFactura);

        const nextId = this.asientoRepository.getNextId();

        const asiento = Asiento.create({
            "idAsiento": nextId,
            "fecha": factura.fecha,
            "idEjercicio": factura.idEjercicio,
        });

        this.asientoRepository.save(asiento);
    }
}
CrearAsientoFacturaCliente;
```

### AsientoFacturaCliente
Nuestro caso de uso necesita crear una entidad _AsientoFacturaCliente_. Definimos una versión mínima de esta entidad.

_contabilidad/asientofacturacliente/domain/AsientoFacturaCliente.qs_
```js
class AsientoFacturaCliente {
    var fecha;
    var idEjercicio;

    function AsientoFacturaCliente(data) {
        this.fecha = data.fecha;
        this.idEjercicio = data.idEjercicio;
    }

    static function create(data) {
        return new this(data);
    }

    function toPrimitives() {
        return {
            "fecha": this.fecha,
            "idEjercicio": this.idEjercicio,
        }
    }
}
AsientoFacturaCliente;
```
### Test
Volvemos a testear, ya debemos poder crear una factura y guardarla en el respositorio

## Añadiendo la partida de ventas
Los asientos están formados por dos o más partidas. En el caso de las facturas de venta, las partidas mínimas son la partida de ventas y la partida de cliente.

### Configuración de contabilidad
Para crear la partida de ventas necesitamos saber cuál es la subcuenta de ventas por defecto de la empresa. Para ello crearemos un nuevo repositorio que nos devuelva los parámetros de configuración de contabilidad.

_contabilidad/asientofacturacliente/test/MockedAsientosConfigRepository.qs_
```js
AsientosConfigMother = formImport.from("contexts/contabilidad/asientofacturacliente/test/AsientosConfigMother.qs");

class MockedAsientosConfigRepository {
    function get() {
        return AsientosConfigMother.create({});
    }
}
MockedAsientosConfigRepository;
```
Su correspondiente mother:
_contabilidad/asientofacturacliente/test/AsientosConfigMother.qs_
```js
AsientosConfig = formImport.from("contexts/contabilidad/asientofacturacliente/domain/AsientosConfig.qs");

class AsientosConfigMother {
    static function create(data) {
        return new AsientosConfig({
            "cuentaVentas": "cuentaVentas" in data ? data.cuentaVentas : "700000"
        });
    }
}
AsientosConfigMother;
```
Y su correspondiente entidad:

_contabilidad/asientofacturacliente/domain/AsientosConfig.qs_
```js
class AsientosConfig {
    var cuentaVentas;

    function AsientosConfig(data) {
        this.cuentaVentas = data.cuentaVentas;
    }

    function toPrimitives() {
        return {
            "cuentaVentas": this.cuentaVentas
        }
    }
}
AsientosConfig;
```
Añadimos el repositorio de configuración de contabilidad a los parámetros del caso de uso en sus dependencias:

dependency_injection/contexts/contabilidad.deps.qs_
```js
const contabilidad = {
    "contabilidad.asientofacturacliente.application.CrearAsientoFacturaCliente": {
        "dep": "contexts/contabilidad/asientofacturacliente/application/CrearAsientoFacturaCliente.qs",
        "args": [
            // ...,
             "@contabilidad.asientofacturacliente.domain.configRepository"
        ]
    },
    // ...
    "contabilidad.asientofacturacliente.domain.facturaRepository": {
        "dep": "contexts/contabilidad/asientofacturacliente/infrastructure/SupaQSFacturaClienteContabilidadRepository.qs",
        "args": []
    },
}
contabilidad;
```
Y para el caso de los tests:

_dependency_injection/environments/test.deps.qs_
```js
const test = {
    // ....
    "contabilidad.asientofacturacliente.domain.configRepository": {
        "dep": "contexts/contabilidad/asientofacturacliente/test/MockedAsientosConfigRepository.qs",
        "args": []
    },
}
test;
```
### Partida en el test
Lo primero es siempre cambiar el test de acuerdo con lo que esperamos conseguir tras el cambio. En nuestro caso, queremos que el asiento tenga una partida de ventas.

_contabilidad/asientofacturacliente/test/CrearAsientoFacturaCliente.test.qs_
```js
// Importaciones...

function TestCrearAsientoFacturaCliente (t) {
    t.describe("Crear asiento desde factura", function () {
        t.test("Se crea un asiento desde un evento de factura cliente creada", function () {
            /// Código anterior...
            t.expect(asientoGuardado.partidas.length != 0).toBe(true);

            const partidaVentas = asientoGuardado.partidas[0];
            t.expect(partidaVentas.debe).toBe(factura.total);
            t.expect(partidaVentas.haber).toBe(0);
        })
    })
}
TestCrearAsientoFacturaCliente;
```
Esperamos que nuestra entidad Asiento Factura Cliente tenga una nueva propiedad _partidas_ que contenga una lista de las partidas del asiento.

### Partida en el caso de uso
El caso de uso recibe un tercer parámetro con el repositorio de configuración, crea la partida y la pasa a la función de creación del asiento.

_contabilidad/asientofacturacliente/application/CrearAsientoFacturaCliente.qs_
```js
// Importaciones anteriores...
PartidaAsiento = formImport.from("contexts/contabilidad/asientofacturacliente/domain/PartidaAsiento.qs");

class CrearAsientoFacturaCliente {
    // Propiedades anteriores...
    var asientosConfigRepository;

    function CrearAsientoFacturaCliente(asientoRepository, facturaRepository, asientosConfigRepository) {
        // Asignaciones anteriores
        this.asientosConfigRepository = asientosConfigRepository;
    }

    function run(event) {
        const factura = this.facturaRepository.find(event.idFactura);
        const config = this.asientosConfigRepository.get();

        // ...

        const partidaVentas = PartidaAsiento.create({
            "idCuenta": config.cuentaVentas,
            "debe": factura.total,
            "haber": 0
        });

        const asiento = Asiento.create({
            // Claves anteriores
            "partidas": List.from([ partidaVentas ])
        });

        this.asientoRepository.save(asiento);
    }
}
```

### Entidad partida y ampliación de agregado Asiento Factura Cliente
Crearemos la entidad Partida

_contabilidad/asientofacturacliente/domain/PartidaAsiento.qs_
```js
class PartidaAsiento {
    var idCuenta;
    var debe;
    var haber;

    function PartidaAsiento(data) {
        this.idCuenta = data.idCuenta;
        this.debe = data.debe;
        this.haber = data.haber;
    }

    static function create(data) {
        return new this(data);
    }

    function toPrimitives() {
        return {
            "idCuenta": this.idCuenta,
            "debe": this.debe,
            "haber": this.haber
        }
    }
}
PartidaAsiento;
```

Y la añadiremos al agregado Asiento Factura de Cliente:
_contabilidad/asientofacturacliente/domain/AsientoFacturaCliente.qs_
```js
class AsientoFacturaCliente {
    // Propiedades anteriores...
    var partidas;

    function AsientoFacturaCliente(data) {
        // Asignaciones anteriores...
        this.partidas = data.partidas;
    }

    // ...

    function toPrimitives() {
        return {
            // Claves anteriores...
            "partidas": this.partidas.map(function(partida) {
                return partida.toPrimitives();
            }).get()
        }
    }
}
AsientoFacturaCliente;
```
### Test
Volvemos a testear y comprobamos que los tests pasan
_____




¿snippets?