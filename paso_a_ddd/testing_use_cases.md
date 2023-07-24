# Testing de casos de uso
Los elementos o pasos necesarios para crear un test de un caso de uso son los siguientes.

## Ficheros de test de caso de uso
Crearemos un fichero para cada caso de uso.

El fichero sigue la estructura descrita en [testing](./testing.md), implementando una función _t.test()_ para cada prueba del caso de uso.
```js
function TestCrearAsientoFacturaCliente (t) {
    t.describe("CrearAsientoFacturaCliente", function () {
        t.test("Se crea un asiento desde una factura de cliente", function () {
            const factura = FacturaClienteContabilidadMother.create();

            const creator = formDependencyContainer.get("contabilidad.asientofacturacliente.application.CrearAsientoFacturaCliente");
            creator.run({ "factura": factura });

            creator.asientoRepository.assertSaved();

            const asientoGuardado = creator.asientoRepository.asientoGuardado.toPrimitives();

            t.expect(asientoGuardado.expedicion.fecha).toBe(factura.fecha);
          })
    })
}
TestCrearAsientoFacturaCliente;
```

## Ficheros Mother
Los ficheros _mother_ permiten la generación de entidades y agregados a partir de pocos datos, agilizando la creación de tests y permitiendo que nos enfoquemos en la lógica a probar.
```js
class AsientosFacturaClienteMother {
    static function base(data) {
        const primitives = this.primitivesBase(data)
        return AsientoFacturaCliente.fromPrimitives(primitives);
    }

    static function primitivesBase(data) {
        const primitives = {
            "id": "id" in data ? data.id : 1,
            "expedicion": {
                "numero": "numero" in data ? data.numero : 1,
                "codEjercicio": "codEjercicio" in data ? data.codEjercicio : "2023",
                "fecha": "fecha" in data ? data.fecha : "2023-01-01"
            },
            // ...
        }
        return primitives
    }
}
AsientosFacturaClienteMother;
```
Aparte de _base()_, podemos crear tantas funciones como creamos conveniente, por ejemplo _facturaSinIva()_, _facturaNegativa()_, etc.

Separar la función _primitives[LoQueSea]_ nos permite acceder a ella en caso de que solo queramos las primitivas del Mother, para usarlas en una composición o en otro contexto.

## Ficheros Mock (repositorios)
Los _mock_ son clases que simulan el funcionamiento de una clase real sin realmente hacer nada por dentro. Mockear repositorios nos permitirá probar los casos de uso sin necesidad de disponer de un sistema de persistencia (p.e. base de datos), y así separar las pruebas del caso de las pruebas del repositorio.

Para usar un repositorio mockeado, creamos la correspondiente clave en el fichero de dependencias de test, _test.deps.qs_:
```js
"contabilidad.asientofacturacliente.domain.factura.repository": {
    "dep": "contexts/contabilidad/asientofacturacliente/test/mocks/MockedFacturaClienteContabilidadRepository.qs",
    "args": []
},
```
Y creamos el fichero del mock:
```js
class MockedAsientoFacturaClienteRepository {
    var mockFind;
    var asientoGuardado = null;
    static var idAsiento = 1

    function MockedAsientoFacturaClienteRepository() {
        this.mockFind = null;
        this.asientoGuardado = null;
    }

    function getNextId() {
        return this.idAsiento++
    }

    function save(asiento) {
        // Almacenar la entidad nos permitirá obtenerla luego y comprobar que sus datos son correctos.
        this.asientoGuardado = asiento;
    }

    function assertSaved() {
        if (this.asientoGuardado == null) {
            formError.raise({ "type": "AssertError", "message": "No se ha guardado ningún asiento" });
        }
    }

    function shouldFind(asiento) {
        // Indicamos lo que la siguiente función find() debe obtener
        this.mockFind = asiento;
    }

    function find(id) {
        return this.mockFind;
    }
}
MockedAsientoFacturaClienteRepository;
```
