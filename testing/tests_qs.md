# Testing / Tests Eneboo QS

## Lectura previa

La convención en cuanto a nomenclatura es que el fichero se llame igual que la clase que queremos probar, seguido de _.test.qs_

Ejemplo: _FacturasTotalizador.qs_ => _FacturasTotalizador.test.qs_

Si no has configurado el entorno de test, puedes hacerlo en [Configuración Testing Eneboo](./tests_qs_config.md)

## Creación de un nuevo test

Supongamos que queremos testear nuestra clase FacturasTotalizador. Para ello, lo primero que debemos hacer es crear un nuevo fichero _FacturasTotalizador.test.qs_

Dentro crearemos una función con el mismo nombre que el fichero precedido de la palabra _Test_ y, después, escribiremos el nombre de la función a modo de _export_.

```js
function TestFacturasTotalizador() {}

TestFacturasTotalizador;
```

## Agregando contexto

Los tests deben estar encapsulados en una función que les de contexto, para esto utilizamos _describe_, que viene incluido en el parámetro que recibe la función (que hemos llamado _t_ por ser concisos). _describe_ recibe un texto a modo de título (recomendable utilizar el nombre del fichero o una versión extendida de este), y una función _callback_ que incluirá posteriormente nuestros tests.

```js
function TestFacturasTotalizador(t) {
  t.describe("TestFacturasTotalizador", function () {});
}

TestFacturasTotalizador;
```

## Añadiendo casos de uso

Cada uno de nuestros tests necesita su propio caso de uso, donde comprobaremos escenarios como "la factura debe tener un total de 150€" o "la comisión debe ser 0 cuando el agente no tiene el % de comisión indicado". Para esto vamos a utilizar _test_, también incluido en nuestro parámetro _t_. _test_, al igual que _describe_, recibe un título y un _callback_.

```js
function TestFacturasTotalizador(t) {
  t.describe("TestFacturasTotalizador", function () {
    t.test("la factura debe tener un total de 150€", function () {});
    t.test(
      "la comisión debe ser 0 cuando el agente no tiene el % de comisión indicado",
      function () {}
    );
  });
}

TestFacturasTotalizador;
```

## Comprobando que realmente es correcto

Para hacer estas comprobaciones, nuestro parámetro _t_ incluye una librería _expect_, a la que le pasaremos el valor a comprobar y tendremos una serie de funciones de comprobación. Por ejemplo: _toBe_, _toBeTruthy_, _toBeFalsy_, _toHaveLength_, _toBeDefined_, etc...

Supongamos que tenemos acceso a _FacturaMother_ y _FacturasTotalizador_ ya que ese no es el objetivo de esta lección:

```js
function TestFacturasTotalizador(t) {
  t.describe("TestFacturasTotalizador", function () {
    t.test("la factura debe tener un total de 150€", function () {
      const factura = FacturaMother.random();

      const totalizer = new FacturasTotalizador();
      const totalizada = totalizer.run(factura);

      t.expect(totalizada.total).toBe(150);
    });
    t.test(
      "la comisión debe ser 0 cuando el agente no tiene el % de comisión indicado",
      function () {
        const factura = FacturaMother.clienteSinComision();

        const totalizer = new FacturasTotalizador();
        const totalizada = totalizer.run(factura);

        t.expect(totalizada.comision).toBe(0);
      }
    );
  });
}

TestFacturasTotalizador;
```

## Más funcionalidad. Hooks

Adicionalmente, se pueden añadir 4 testing hooks a nuestros tests. Son los siguientes (en orden de llamada): _beforeAll_, _beforeEach_, _afterEach_ y _afterAll_.

Por supuesto están disponibles en nuestro parámetro _t_.

Es importante destacar que deberán declararse antes de _describe_.

En este caso, vamos a sacar la funcionalidad común de crear el totalizador en cada test. Lo haremos con un _beforeEach_ para que se ejecute antes de cada test.

```js
function TestFacturasTotalizador(t) {
  var totalizer;

  t.beforeEach(function () {
    totalizer = new FacturasTotalizador();
  });

  t.describe("TestFacturasTotalizador", function () {
    t.test("la factura debe tener un total de 150€", function () {
      const factura = FacturaMother.random();
      const totalizada = this.totalizer.run(factura);

      t.expect(totalizada.total).toBe(150);
    });
    t.test(
      "la comisión debe ser 0 cuando el agente no tiene el % de comisión indicado",
      function () {
        const factura = FacturaMother.clienteSinComision();
        const totalizada = this.totalizer.run(factura);

        t.expect(totalizada.comision).toBe(0);
      }
    );
  });
}

TestFacturasTotalizador;
```
