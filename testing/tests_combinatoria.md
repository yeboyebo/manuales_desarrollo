# Testing / Combinatoria de entrada salida

Cuando queremos lanzar un test varias veces con distintos valores de entrada y salidas esperadas, podemos usar la librería _parameterized_, que nos facilita este trabajo

## Instalación
```sh
pip3 install ...
```

## Uso
```py
@parameterized.expand([
  ("Dos lineas, una servida, otra no",
  [
      {"cantidad": 1, "totalenalbaran": 1, "cerrada": False},
      {"cantidad": 1, "totalenalbaran": 0, "cerrada": False}
  ], "Parcial"),
  ("Dos lineas, ambas servidas",
  [
      {"cantidad": 1, "totalenalbaran": 1, "cerrada": False},
      {"cantidad": 1, "totalenalbaran": 1, "cerrada": False}
  ], "Sí"),
  ("Dos lineas, ninguna servida",
  [
      {"cantidad": 1, "totalenalbaran": 0, "cerrada": False},
      {"cantidad": 1, "totalenalbaran": 0, "cerrada": False}
  ], "No")
])
def test_calcula_estado_servido_pedido(self, _, lineas, expected):
  flfacturac = script("flfacturac").iface
  self.assertEqual(flfacturac.calculaEstadoServidoPedido(lineas), expected)
```

### Más
  * [Volver al Índice](./index.md)
