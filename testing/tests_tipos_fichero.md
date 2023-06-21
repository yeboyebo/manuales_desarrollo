# Testing / Tipos de fichero de test

Dependiendo del tipo de test que queramos crear, usaremos un tipo de fichero u otro.

## Ficheros test_*.py (_test_articulos.py_)
Estos ficheros contienen tests unitarios y tests de dominio _sucios_. Sucios quiere decir que, aunque accedemos a clases de dominio que en teoría no acceden fuera de su propio dominio (repositorios, etc.) todavía contienen código legacy que realiza estos accesos.

Estos ficheros deben contener la mayor cantidad posible de tests unitarios razonables posible (en el sentido de que haya posibilidades de que ocurran).

Dado que todavía es necesario usar una base de datos como entorno para los tests, usamos también la función _cls.lib.api_create_ para crear y cargar las entidades de dominio sobre las que haremos pruebas. Esto nos evita por ahora tener que crear ficheros Mother que devuelvan entidades de dominio, y usar los _MotherApi_ que se usan también en ficheros _test_*_api.py_.

Lo típico en estos ficheros es tener una función que nos devuelva una instancia de una clase basada en un MotherApi:
```py
@classmethod
def fixture_nuevo_albaran(cls, albaran_data):
    repo = qsa.class_.AlbaranesProvRepository()
    albaran = cls.lib.api_create("albaranesprov", albaran_data)
    return repo.get_from_id(albaran["idalbaran"])

def test_lo_que_sea(self):
    albaran = self.fixture_nuevo_albaran(
        AlbaranProveedorMotherApi.default()
    )
```

Estos ficheros también contienen tests unitarios de dominio, que ejecutan código totalmente en memoria:

```py
def test_calcula_estado_servido_pedido(self):
    flfacturac = script("flfacturac").iface
    lineas = [
        {"cantidad": 1, "totalenalbaran": 1, "cerrada": False},
        {"cantidad": 1, "totalenalbaran": 0, "cerrada": False}
    ]
    self.assertEqual(
        flfacturac.calculaEstadoServidoPedido(lineas),
        "Parcial"
    )
```

## Ficheros test_*_api.py (_test_articulos_api.py_)

Estos ficheros contienen tests de llamadas a la API / casos de uso. Por ahora, al no tener capa de aplicación, cada función expuesta a la API representa un caso de uso que se ejecuta de forma transaccional.

Los pasos para realizar estos tests son siempre:
* Llamar a funciones de la API para preparar el test
* Llamar a la función de API a testear
* Cargar datos (también a través de la API) y comprobar

```py
def test_pagar_recibo(self):
    RecibosCliAPI = script("formreciboscli_api")
    FacturasCliAPI = script("formfacturascli_api")
    factura = self.lib.api_create("facturascli",
        FacturaClienteMotherApi.default())
    
    idfactura = factura["idfactura"]
    idrecibo = select("reciboscli", "idrecibo", "idfactura = " + str(idfactura))
    RecibosCliAPI.pagar_recibo(idrecibo)

    recibo = RecibosCliAPI.get_from_id(idrecibo)
    self.lib.check_dict_values(recibo, {
        "estado": "Pagado"
    })
    factura = FacturasCliAPI.get_from_id(idfactura)
    self.lib.check_dict_values(factura, {
        "editable": False
    })
```

Estos ficheros deben contener únicamente el _happy path_ de cada llamada a la API, y adicionalmente comportamientos que solo puedan comprobarse a través de la API.

Una vez nos aseguramos de que el test de API funciona, la casuística debe testearse en tests unitarios, en ficheros _test_*.py_.

### Más
  * [Volver al Índice](./index.md)
