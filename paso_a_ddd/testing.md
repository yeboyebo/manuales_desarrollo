# Testing

## t.describe()
Representa una suite ((conjunto) de tests.

Los parámetros que esta función admite son:
+ Texto descriptivo de la suite.
+ Función de llamadas a los tests de la suite.
+ Opciones (parámetro opcional)

### Opciones
Ver opciones de __t.test()

## t.test()
Representa un test unitario.

Los parámetros que esta función admite son:
+ Texto descriptivo del test
+ Función de test
+ Opciones (parámetro opcional)

### Opciones
En las opciones podemos indicar un diccionario con distintas claves y valores:
+ Clave _include_. Valor: lista con los proyectos para los que el test debe lanzarse. El test solo se lanza si el proyecto actual está en la lista.
+ Clave _exclude_. Valor: lista con los proyectos para los que el test no debe lanzarse. El test solo se lanza si el proyecto actual __no__ está en la lista.
```js
 t.test("Uno más uno son tres", function () {
    t.expect(1 + 1).toBe(3)
}, {
    "include": ["of", "moda"]
})
```
## Tests de varios valores

```py
function TestValorPuntoClienteMON(t) {
    t.beforeEach(function () {
    });

    t.describe("TestValorPuntoClienteMON", function () {

        const validos = [
            { "value": 0, "desc": "cero" },
            { "value": 1.2, "desc": "decimal positivo" },
            { "value": 1, "desc": "entero positivo" }
        ]
        formARRAY.map(validos, function(valido) {
            t.test("Si se usa un valor " + valido["desc"] + ", se creará el valor", function () {
                const vo = new ValorPuntoClienteMON(valido["value"]);
                t.expect(vo.value()).toBe(valido["value"])
            })
        })

        const invalidos = [
            { "value": null, "desc": "nulo", "error": ValueNotDefined },
            { "value": undefined, "desc": "indefinido", "error": ValueNotDefined },
            { "value": "hola", "desc": "string", "error": InvalidTypeValue },
            { "value": -1.2, "desc": "negativo", "error": InvalidTypeValue }
        ]
        formARRAY.map(invalidos, function(invalido) {
            t.test("Si se usa un valor " + invalido["desc"] + ", se obtiene un error " + invalido["error"]["type"], function () {
                const f = function () {
                    const vo = new ValorPuntoClienteMON(invalido["value"]);
                }
                t.expect(f).toThrow(invalido["error"]);
            })
        })
    });
}
TestValorPuntoClienteMON;
```
## Test con base de datos (itest)
