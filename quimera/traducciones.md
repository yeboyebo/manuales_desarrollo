# Quimera / Traducciones

## Indicar los idiomas disponibles por proyecto
En cada proyecto podemos decidir qué idiomas estarán disponibles.
Indicaremos esto en la clave *languages* del fichero *project.js*

```js
export default {
  path: 'projects/mi-proyecto',
  dependencies: [
    core,
    login,
    ...
  ],
  languages: {
    es: { nativeName: 'Español' },
    ca: { nativeName: 'Català' },
    en: { nativeName: 'English' }
  },
  ...
}
```

## Selector de idioma
Si en nuestro proyecto hemos establecido una clave *languages* con más de un lenguaje asociado, en el componente Header por defecto aparecerá un control de selección de idioma.

TO DO: Componentizar el selector para poder sobrecargar el estilo y ponerlo en otra posición.

## Ficheros de traducciones
Para cada extensión, incluiremos los ficheros de traducciones en el fichero *index.js* de la carpeta *static/translations* de cada extensión.
Su estructura es la siguiente:
```js
import ca from './translations.ca.json'
import es from './translations.es.json'
// resto de idiomas
const t = {
  es,
  ca,
  // ...resto de idiomas
}
export { t as translations }
```
Y en la carpeta *static/translations* crearemos un fichero *translations.xx.json* por idioma, donde *xx* es el código del idioma:
```json
{
  "translation": {
    "itemCatalogo": {
      "medidas": "MESURES (MAX {{maxMedida}})",
      "comprar": "Afegir"
    },
    "description": {
      "part1": "Edita <1>src/App.js</1> y guarda para recargar.",
      "part2": "Aprende React"
    }
  }
}
```

Una vez creada la carpeta *translations*, debemos incluirla en el *index.ts* de la extensión.
```js
import { translations } from './static/translations'
//...
export default {
  //...
  translations
}
```
## Llamadas a la función de traducción

### Traducciones desde los ficheros *ui*
```js
import { useTranslation, Trans } from 'react-i18next';

function Componente({ ..props }) {
  const { t } = useTranslation()
  return (
    <Typography variant='h7'>{t('itemCatalogo.medidas', { maxMedida: 10 })}</Typography>

    <Trans i18nKey='description.part1'>
      Edit <code>src/App.js</code> and save to reload.
    </Trans>
  )
}
```
[Más información sobre el componente *Trans* aquí.](https://react.i18next.com/latest/trans-component)

### Traducciones desde los ficheros *ctrl*
```js
import { util } from 'quimera'

const t = util.translate
```
Esta función es la misma que la que obtenemos con *useTranslation*.

### Traducciones de campos *Schema.Field*, *Filter.Field*
Las etiquetas de estos campos se traducen automáticamente si en el fichero de traducciones hay una clave *schemas.[schema].[campo]*.
```js
export default (parent) => ({
  ...parent,
  catalogo:
    Schema('to_articulos', 'codplanta')
      .fields({
        descripcion: Field.Text('descripcion', '[valor si no hay traducción]'),
        // ...
      }),
  // ...
})
```
```json
{
  "translation": {
    "schemas": {
      "catalogo": {
        "descripcion": "Description"
      }
    }
  }
}
```
### Traduccions de menús
Reproduciremos la estructura del menú en cada fichero de taducciones en la clave *appmenu*, usando las claves *title* e *items* para el nombre de grupo y sus opciones.

Definición del menú (*appmenu.js*):
```js
export default parent => ({
  ...parent,
  catalogo: {
    title: 'Catálogo!', // Valor en caso de que no haya traducción
    items: {
      tienda: {
        title: 'Tienda!', // Valor en caso de que no haya traducción
        icons: ['shopping_cart', null],
        color: 'primary',
        variant: 'main',
        url: '/catalogo'
      },
    },
  },
})
```

Fichero de traducciones (*translations.es.json*):
```json
"translation": {
  "appmenu": {
    "catalogo": {
      "title": "Catálogo",
      "items": {
        "tienda": "Tienda"
      }
    }
  },
  // ...
}
```

### Traducciones de opciones en campos de selección *Select*
Tanto en el esquema como en las definiciones externas de las opciones, sustituiremos la clave value por la traduccion correspondiente.

**Esquemas**
```js
export default (parent) => ({
  ...parent,
  catalogo:
    Schema('to_articulos', 'codplanta')
      .fields({
        // ...
        exposicionSolar: Field.Options('vb_exposicionsolar').options([
          { key: 1, value: 'schemas.catalogo.exposicionSolar_sol' },
          { key: 2, value: 'schemas.catalogo.exposicionSolar_solsombra' },
          { key: 3, value: 'schemas.catalogo.exposicionSolar_sombra' }
        ]),
      }),
  // ...
})
```

```json
{
  "translation": {
    "schemas": {
      "catalogo": {
        "exposicionSolar": "Exposición solar",
        "exposicionSolar_sol": "SOL",
        "exposicionSolar_solsombra": "SOL/SOMBRA",
        "exposicionSolar_sombra": "SOMBRA"
      }
    }
  }
}
```

### Traducciones en componentes personalizados
El componente incluirá la traducción automática de los textos que reciba como propiedades.
```js
function FiltroDisponibles({ id, label, ...props }) {
  // ...
  return (
    <Field.CheckBox
      // ...
      label={util.translate(label)}
      {...props}
    />
  )
}
```

### Traducciones en componentes de quimera comps
Para los textos fijos de los componentes (etiquetas de botones, etc.),el componente usará *util.translate* y colocaremos sus traducciones en la carpeta *libs/comps/static/translations*.


### Más

  * [Volver al Índice](./index.md)
