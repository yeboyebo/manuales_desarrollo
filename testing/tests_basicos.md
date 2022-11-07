# Testing / Tests básicos

El testing en el entorno de Eneboo / Pineboo(api) consistirá en la creación de un conjunto de ficheros test_X.py mediante los cuales automatizaremos el testeo de las funcionalidades a desarrollar.

## Crear un fichero de test
Cada ficheros de test contiene funciones que realizan pruebas unitarias sobre una funcionalidad relacionada.

El lenguaje de los ficheros de test es siempre Python.

### Nombre
Como convención, llamaremos a los ficheros de test con el mismo nombre que el fichero principal o acción que contiene la funcionalidad a probar, con el prefijo *test_*.

Por ejemplo, el fichero de test para testear facturas de cliente se llamará *test_facturascli.py*

### Estructura
Cada fichero de test tiene una estructura de clases, lo que permite sobreescribir un test si la funcionalidad que prueba se modifica en una extensión superior.

```py
import unittest
import sys

from pineboolib.loader.main import finish_testing
from pineboolib import application
from pineboolib.qsa import qsa
from pathlib import Path
from parameterized import parameterized

select = qsa.FLUtil.sqlSelect
script = qsa.from_project

class TestOficial(unittest.TestCase):
    """TestFLManager Class."""

    @classmethod
    def setUpClass(cls) -> None:
        """Ensure pineboo is initialized for testing."""
        path_root = Path(__file__).parents[3]
        sys.path.append(str(path_root))
        from sistema.libreria.scripts.T3ST import FormInternalObj as test

        modulos = {
            "flfactppal": {"path": "facturacion/principal", "init": True},
            "flfactalma": {"path": "facturacion/almacen", "init": True},
        }
        test.setup_test_folder(modulos)
        cls.lib = qsa.from_project("formT3ST")

    # tests...

    @classmethod
    def tearDownClass(cls) -> None:
        """Ensure test clear all data."""
        finish_testing(False)
```
La clase base debe contener los métodos *setUpClass* y *tearDownClass* que establecen y borran el entorno de test para el fichero.

*setUpClass* abre una base de datos SQLite y carga en ella los módulos indicados.

*tearDownClass* borra la base de datos y los ficheros de caché, si se incluye en el parámetro *false* en la función *finish_testing*, los ficheros de caché NO se borrarán, con lo que la ejecución de los tests será más rápida al no tener que traducirse el código QSA a partir de la segunda ejecución.

## Añadir un nuevo test al fichero
Podemos añadir un nuevo test incluyendo un nuevo método cuyo nombre comience por *test_*.

```py
    def test_suma(self) -> None:
        a = 1 + 1
        self.assertEqual(a, 2, "1 + 1 no es 2")
```
La librería *unittest* proporciona [distintos tipos de función *assert*](https://www.pythontutorial.net/python-unit-testing/python-unittest-assert/) para realizar la comprobación de los resultados.


## Lanzar los tests
Para lanzar los test ejecutamos *pytest* en una carpeta bajo la cual haya carpetas *test* que incluyan uno o más ficheros *test_*.py*.
```sh
cd modulos/facturacion/facturacion
~/modulos/facturacion/facturacion$ pytest
======================== test session starts ========================
platform linux -- Python 3.8.10, pytest-7.1.2, pluggy-1.0.0
rootdir: /home/antonio/modulos/facturacion/facturacion
collected 10  items
test_albaranescli.py ...                                      [ 30%]
test/test_flfacturac.py .......                               [100%]

======================== 10 passed in 10.07s ========================
```

## Valores por defecto para datos de prueba en BD
En la libraría de tests, *T3ST.py*, hay una varias funciones que nos agilizan la creación de datos de prueba:
### new
Nos permite crear registros de pruebas de forma ágil.

### get_valores_defecto
Nos permite crear valores por defecto para objetos de base de datos que necesitemos crear para nuestros tests.
```py
    def get_valores_defecto(self):
        return {
            "articulos": {
                "referencia": "#AUTO",
                "descripcion": "Artículo de pruebas",
            },
            ...
```
El valor *"#AUTO"* permite indicar que se use un valor autonumérico.

De esta forma, a menos que especifiquemos un valor especial en su creación, los objetos que creemos con *self.lib.new* se crearán con estos valores sin necesidad de indicarlos.
 
### Más
  * [Volver al Índice](./index.md)
