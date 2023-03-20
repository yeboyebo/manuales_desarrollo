# Testing / Valores por defecto y ficheros _mother_

Para generar de forma ágil datos de prueba usaremos las clases _Mother_ y _MotherApi_. Estos clases fabrican objetos con valores por defecto y automatizan la generación de identificadores de registros.

### Ejemplo de fichero mother: _ArticuloMotherApi.py_
```py
from sistema.libreria.contexts.shared.test.EntityMotherApi import EntityMotherApi

# @class_declaration Oficial */
class Oficial(EntityMotherApi):
    _referencia = 0

    @classmethod
    def default(cls, data={}):
        return {
            "referencia": cls.get_next_referencia(),
            "descripcion": "Artículo de test",
            "pvp": 10,
            **data
        }

    @classmethod
    def iva_reducido(cls, data={}):
        return {
            **cls.default(),
            "codimpuesto": "RED",
            **data
        }

    @classmethod
    def get_next_referencia(cls):
        cls._referencia += 1
        return str(cls._referencia).zfill(10)


# @class_declaration ArticuloMotherApi */
class ArticuloMotherApi(Oficial):
    pass
```
En este ejemplo vemos que, si no especificamos la referencia del artículo, la clase nos devolverá un autonumérico con ceros a la izquierda.

## Uso de clases Mother en los tests
Podemos usar estas clases para construir modelos de qsa o clases de dominio. En el caso de los _MotherApi_, contamos además con una función _create_ en la librería _T3ST_ que podemos llamar para crear una entidad en base de datos a través de unos datos generados por un fichero _mother_.
```py
factura = self.lib.api_create("formfacturascli_api",
    FacturaClienteMotherApi.default())
```

## Inicialización de referencias por defecto en cada fichero test
A veces sucede que, por ejemplo, para un fichero de test de facturas de cliente, queremos que cuando llame a _FacturaClienteMotherApi.default()_, la factura creada se asocie a un determinado cliente, y a un determinado artículo.

De esta forma, a menos que cambie los parámetros de la llamada a la clase _mother_, sabré cómo serán todas las facturas que creo en los tests del fichero.

Para ello, cada clase _MotherApi_ tiene una propiedad _default_id_ que podemos establecer para indicar qué identificador usar cuando necesitemos una instancia de la entidad asociada al Mother.

En la función _carga_estaticos_ de cada fichero de test, haremos algo similar a esto:
```py
ref_gen_10 = self.lib.api_create("formarticulos_api",
    (ArticuloMotherApi.default())
ArticuloMotherApi.default_id = ref_gen_10
```
Con esto indico que cada vez que un fichero _mother_ necesite en su interior referenciar a un artículo existente por defecto, se el artículo que acabamos de crear.

### Más
  * [Volver al Índice](./index.md)