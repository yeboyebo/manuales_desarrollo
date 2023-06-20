# IDEAS TEST

Apartado para ir anotando la descripción y uso de la carpeta Contexts

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
