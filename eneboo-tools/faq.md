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

## Ficheros guardados con codificación incorrecta

### Causa
Cuando se han subido se han subido con la codificación que no debían y al generar el build da error

### Solución
Cambiar la codificación del fichero y revisar acentos. Para buscar los ficheros y cambiar la codificación de forma masiva podemos ejecutar lo siguiente:
```
temp='temp'
for file in $(find . -type f -name "*.ui")
    do
        firstline=`head -n 1 $file`
        if [ "$firstline" = "<xupdate:modifications>" ]; then
            if [[ $(file -bi "$file") == *iso-8859-1* ]]
            then
                iconv -f ISO-8859-15 -t UTF-8 $file -o $temp
                mv $temp $file
                echo $file
            fi
        fi
    done
```

Este script lo que hace es buscar en todos los ficheros ui contenidos en el directorio en el que se ejecute cuya codificación sea iso-8859-1 y su primera línea sea <xupdate:modifications> y le cambia la codificación a UTF-8.
De esta forna hemos cambiado todos los formularios de los parches a UTF-8

### Más

- [Volver al Índice](./index.md)
