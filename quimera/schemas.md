# Quimera / Schemas

Los schemas son mapas que establecen la correspondencia entre las estructuras de datos que recibimos o enviamos a las APIs y los objetos que internamente manejamos en Quimera.

## Declaración
Los schemas se declaran en el fichero  *[extension]/static/schemas.js*

Ejemplo:
```js
import { Schema, Field } from 'core/lib'

export default (parent) => ({
  ...parent,
  categorias:
    Schema('to_categorias', 'idcategoria')
      .fields({
        idCategoria: Field.Int('idcategoria', 'ID').auto(),
        nombre: Field.Text('nombre', 'Nombre'),
        idCatPadre: Field.Int('idcatpadre', 'Id Categoria Padre'),
        metatags: Field.Text('metatags', 'Meta Tags'),
        urlkey: Field.Text('urlkey', 'URL Key'),
        habilitado: Field.Bool('habilitado', 'Habilitado'),
        incluirEnMenu: Field.Bool('incluirenmenu', 'Incluir en menu'),
        ordenenMenu: Field.Int('ordenenmenu', 'Orden en menu'),
        metatile: Field.Text('metatile', 'Meta Tile'),
        idStoreview: Field.Int('idstoreview', 'Id Storeview'),
      })
      .filter(() => ['1', 'eq', '1'])
      .order(() => ({ field: 'idcategoria', direction: 'ASC' })),
})
```

### Subschemas
Podemos introducir subschemas en nuestros schemas para definir listas de registros asociadas a los registros de nuestro esquema, por ejemplo, líneas de una factura.
```js
  Schema('to_carritos', 'idcarrito')
    .fields({
      idCarrito: Field.Int('idcarrito', 'Id. Carrito'),
      nombreCliente: Field.Text('nombrecliente', 'Nombre Cliente').required(),
      total: Field.Currency('total', 'Total'),
    })
    .subschemas({
      lineasCarrito: Subschema.List('lineas', 'lineaCarrito')
    }),
```
El único tipo soportado por ahora en los subschemas es *List* (array de registros), sus parámetros son:
* **apiKey**: clave del subschema en los datos provenientes la API (*lineas* en el ejemplo).
* **esquema**: nombre del esquema asociado al subschema (*lineaCarrito* en el ejemplo), que debe estar declarado por su parte en el correspondiente fichero *schemas.js*.

### Más

  * [Volver al Índice](./index.md)
