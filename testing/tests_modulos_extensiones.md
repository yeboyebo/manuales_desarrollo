# Testing / Testear módulos y extensiones




## Testear módulos


## Testear extensiones

### Precondiciones
Dado que la estructura de ficheros de las extensiones es distinta de la de los módulos, debemos asegurarnos de que en el script *nuevo/sistema/libreria/scripts/T3ST.py* hay una clase que sobreescribe el método *create_test_folder* con el contenido del método *create_test_folder_usar_extensiones* de la clase oficial. El método en la clase oficial solo se usa para ser copiado y sobreescrito en clases de extensiones.

Otro método que debemos sobrecargar es el que devuelve el nombre de la extensión que está siendo probada. Este nombre sirve para identificar la carpeta de caché y base de datos temporal que usará el módulo de tests para funcionar más rápido.

Ejemplo:
```py
# @class_declaration Sanhigia
class Sanhigia(Oficial):
    @classmethod
    def create_test_folder(cls, modules):
        return os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))
    
    @classmethod
    def get_tested_extension_name(cls):
        return "fun_jsenar"
```
### Modificar los valores por defecto (obsoleto, ver Mothers)
Si una extensión exige la introducción de nuevos campos en alguno de los registros de BD, podemos sobreescribir *get_valores_defecto* de *T3ST.py* para incluirlos:

```py
# @class_declaration Sanhigia
class Sanhigia(Oficial):
  [...]
  def get_valores_defecto(self):
    valores = super().get_valores_defecto()
    valores["clientes"]["telefono1"] = "123456789"
    valores["clientes"]["email"] = "test@email.com"
    return valores
```

### Crear un nuevo archivo de test
Para scripts que la funcionalidad añade, lo mejor casi siempre será crear un nuevo archivo de test. Por ejemplo, para *miscript.qs* crearemos *test_miscript.py*.

Crearemos el archivo copiando y renombrando el archivo de test del módulo donde se encuentre, y vaciando sus funciones (excepto *setUpClass* y *tearDownClass*).

### Ampliar un archivo de tests con tests propios de la extensión
Lo primero es cerciorarnos de que la cadena de herencia de oficial para el archivo es la siguiente:
```py
# @class_declaration Oficial */
class Oficial:
  #...

# @class_declaration Head */
class Head(Oficial):
  pass

# @class_declaration Testpedidoscli */
class Testpedidoscli(Head, unittest.TestCase):
  pass
```
De esta forma podemos crear nuevos tests o anular los que no apliquen, sin que estos se dupliquen:
```py
# @class_declaration Sanhigia */
class Sanhigia(Oficial):
  # Nuevo test
  def test_sanhigia_x(self):
    # ...

  # Test de oficial anulado
  def test_oficial_x(self):
    self.assertTrue(True)
```


### Más
  * [Volver al Índice](./index.md)
