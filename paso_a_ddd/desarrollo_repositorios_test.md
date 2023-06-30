# Repositorios mockeados
Los repositorios mockeados nos sirven para realizar tests sin necesidad de una base de datos u otra herramienta de persistencia real. Esto hace que los tests sean más fáciles de hacer y más rápidos de ejecutar.

## Repositorios de lectura
En los repositorios que vayamos a usar para simular la lectura de una entidad u otros datos, usaremos la siguiente estructura:

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
La idea es tener una función (_returnOnFind_) que podamos llamar al iniciar nuestro test para cargar en el repositorio mockeado el dato que luego dicho repositorio nos debe devolver.

### Uso
```js
t.test("Se crea un asiento desde un evento de factura cliente creada", function () {
    const event = FacturaClienteCreadaEventMother.create();
    
    // Obtenemos la entidad (factura) que querremos encontrar
    const factura = FacturaClienteContabilidadMother.create(event);

    const creator = formDependencyContainer.get("contabilidad.asientofacturacliente.application.CrearAsientoFacturaCliente");

    // Cargamos la entidad en el repositorio mockeado
    creator.facturaRepository.returnOnFind(factura)

    // Al ejecutar su find(), el repositorio devolverá la entidad cargada
    creator.run(event);
    ...
}
```

## Repositorios de escritura
En los repositorios de escritura podremos:
* Comprobar que la entidad ha sido guardada (_save_ ha sido llamado).
* Obtener la entidad guardada para realizar comprobaciones

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
En el ejemplo, _assertSaved_ lanzará una excepción si no hemos llamado al método _save_, y la propiedad _asientoGuardado_ nos proporcionará la entidad enviada al save para comprobar que es como esperamos que sea.

## Uso
```js
t.describe("Crear asiento desde factura", function () {
    t.test("Se crea un asiento desde un evento de factura cliente creada", function () {
        // ...
        const event = FacturaClienteCreadaEventMother.create();
        const factura = FacturaClienteContabilidadMother.create(event);

        const creator = formDependencyContainer.get("contabilidad.asientofacturacliente.application.CrearAsientoFacturaCliente");

        creator.facturaRepository.returnOnFind(factura)

        creator.run(event);

        // Comprobarmos que creator.run llamó a save()
        creator.asientoRepository.assertSaved();

        // Obtenemos la entidad guardada para comprobar que es correcta
        const asientoGuardado = creator.asientoRepository.asientoGuardado.toPrimitives();

        t.expect(asientoGuardado.idFactura).toBe(factura.idFactura);
    })
}
TestCrearAsientoFacturaCliente;
```