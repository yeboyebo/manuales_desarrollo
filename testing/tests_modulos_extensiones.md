# Testing / Testear módulos y extensiones




## Testear módulos


## Testear extensiones

### Precondiciones
Dado que la estructura de ficheros de las extensiones es distinta de la de los módulos, debemos asegurarnos de que en el script *nuevo/sistema/libreria/scripts/T3ST.py* hay una clase que sobreescribe el método *create_test_folder* con el contenido del método *create_test_folder_usar_extensiones* de la clase oficial. El método en la clase oficial solo se usa para ser copiado y sobreescrito en clases de extensiones.

Ejemplo:
```py
# @class_declaration Sanhigia
class Sanhigia(Oficial):
    @classmethod
    def create_test_folder(cls, modules):
        return os.path.abspath(os.path.join(os.path.dirname(__file__),
                                            "..", "..", ".."))
```
### Modificar los valores por defecto
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
 
### Más
  * [Volver al Índice](./index.md)
