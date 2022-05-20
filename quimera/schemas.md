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

### Más

  * [Volver al Índice](./index.md)
