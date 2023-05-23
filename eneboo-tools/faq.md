# Eneboo tools / FAQ

## En la clase [mrelax] existen funciones para diferentes clases (file:...)

### Causa
Hay funciones que empiezan por:
```js
function mrelax_... (correcto)
```
Y hay funciones que empiezan por otra cosa

### Solución
Buscar en el fichero del parche "function " y localizar las funciones que no tienen el prefijo correcto para cambiarlas.

Si hay dudas con el caso concreto, consultar.


## UNEXPECTED ERROR ComputePatch: No se pudo aplicar el parche para [flcontmode.ui]
```sh
UNEXPECTED ERROR ComputePatch: No se pudo aplicar el parche para flcontmode.ui
Traceback (most recent call last):
...
  File "/home/antonio/codebase/extensiones_2.5.0/modelo347/patches/modelo347/flcontmode.ui", line 1
lxml.etree.XMLSyntaxError: Namespace prefix xupdate on 
modifications is not defined, line 1, column 23
```

### Causa
Problema de codificación de un fichero.

```js
function mrelax_... (correcto)
```
Y hay funciones que empiezan por otra cosa

### Solución
Los ficheros ui de parche deben estar en UTF-8 mientras que los ficheros construidos del todo deben estar en ISO.

Abrimos el fichero del parche con _gedit_ y lo "guardamos como" indicando codificación UTF8.

### Más

- [Volver al Índice](./index.md)
