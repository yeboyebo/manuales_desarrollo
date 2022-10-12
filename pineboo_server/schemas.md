# Pineboo Server / Schemas

Los schemas de Pineboo Server permiten serializar y deserializar (cargar y volcar) datos que no envía la API convirtiéndolos a esquemas entendibles por Pineboo Server

## Marshmallow
Usamo la librería *marshmallow* (https://marshmallow.readthedocs.io/en/stable/index.html#) para realizar estas serializaciones.

### Campos no incluidos en la tabla principal de un esquema
A veces queremos que un esquema devuelva un valor útil para un esquema pero que no está en su tabla principal. Por ejemplo, para una línea de pedido podríamos querer el código de la familia de la referencia de la línea. Para hacer esto correctamente, seguimos estos pasos:

En el fichero *_api*, modificamos la función de mapa para hacer un join con la tabla auxiliar:

  
  ```python
  def get_mapa(self):
        return {
            'main_table': 'lineaspedidoscli',
            'join': 'lineaspedidoscli LEFT OUTER JOIN familias ON lineaspedidoscli.referencia = articulos.referencia',
            'order': 'idlinea',
            'schema': LineasPedidoscliSchema()
        }
  ```

Y en el fichero *_schema*, debemos indicar que el campo es externo a la tabla usando el parámetro *attribute*. Generalmente estos campos también deben ser *dump_only*.

  ```python
      codfamilia = fields.String(attribute="articulos.codfamilia", dump_only=True)
  ```

En el esquema del cliente quimera indicaremos que el campo no debe enviarse al servidor (es load only):
  ```js
  codFamilia: Field.String('codfamilia', 'Cód. Familia').dump(false),
  ```
## TO DO
API.py:

Modificar get y get_resources para que se haga un schema.dump de cada registro de la consulta. Parece que necesitaremos mapear campo de consult a campo de entrada del schema.dump, y aparte para la paginación habrá que conocer el tipo de los campos de BD ¿usar nombres completos tabla.campo y tirar de metadatos de Pineboo?


### Más

  * [Volver al Índice](./index.md)
