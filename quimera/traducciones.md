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
      "medidas": "MESURES",
      "comprar": "Afegir"
    },
    "description": {
      "part1": "Edita <1>src/App.js</1> y guarda para recargar.",
      "part2": "Aprende React"
    }
  }
}
```

## Llamadas a la función de traducción

### Traducciones desde los ficheros *ui*
```js
import { useTranslation, Trans } from 'react-i18next';

function Componente({ ..props }) {
  const { t } = useTranslation()
  return (
    <Typography variant='h7'>{t('itemCatalogo.medidas')}</Typography>

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

### Traducciones de campos *Schema.Field*, *Filter.Field*
Las etiquetas de estos campos se traducen automáticamente si en la definición del esquema indicamos la clave de traducción.
```js
export default (parent) => ({
  ...parent,
  catalogo:
    Schema('to_articulos', 'codplanta')
      .fields({
        descripcion: Field.Text('descripcion', 'catalogo.descripcion'),
        // ...
      }),
  // ...
})
```
XXXX Claves de traducción automáticas schemas.catalogo.descripcion

### Más

  * [Volver al Índice](./index.md)
