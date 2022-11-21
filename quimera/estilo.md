# Quimera / Estilo

## Secciones
Las secciones se crean conel componente *QSection*. Para preservar el ritmo de lectura, en función del tamaño de la tipografía que usemos en la versión estática de la función, daremos a esta un margen mayor o menor.

TO DO: Tabla con tipografías y márgenes

## Overrides en el tema
Dada una clase compleja como:
```css
.MuiAutocomplete-inputRoot.[class*="MuiInput-root"][class*="MuiInput-marginDense"] .MuiAutocomplete-input:first-child
```

La podemos sobrecargar en el tema comocomo:
```js
MuiAutocomplete: {
  inputRoot: {
    '&&[class*="MuiInput-root"][class*="MuiInput-marginDense"] .MuiAutocomplete-input:first-child': {
      paddingBottom: '4px'
    }
  }
},
```

### Más

  * [Volver al Índice](./index.md)
