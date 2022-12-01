# Expresiones regulares

Las expresiones regulares pueden crearse bien usando la sintáxis /*expresión*/ o usando el constructor *RegExp* como se muestra más abajo.

*NOTA: Si utilizamos el constructor *RegExp*, las barras inversas  '\\'  de la expresión regular deben duplicarse, por ejemplo '\d' pasaría a '\\\d'.*

Ejemplo creación expresión regular que re4conoce el patrón "QUANTITY=471 # Order quantity" y devuelve el número 471:

```
var directRegex = /([A-Z]+)=(\d+)/;
var str = "QUANTITY=471 # Order quantity";
str.match(directRegex);
directRegex.capturedTexts[2]; // "471";

    
var indirectRegex = new RegExp( "([A-Z]+)=(\\d+)" );
```
Funciones RegExp:
-  

- **toString()** : String; Deveuelve el patrón de la expresión regular como un string.

- **search( text : String )**: Number
    ```
    var re = /\d+ cm/; // uno o más digitos seguidos por un espacio después 'cm'

    re.search( "Un metro son 100 cm" ); // devuelve 13
    
    ```
    *Busca texto que coincida con el patrón definido por la expresión regular. La función devuleve la posición en el texto para la primera coincidencia o -1 si no hay ninguna*

- **searchRev( text : String )**: Number; Igual que search(), pero searchRev() busca en sentido inverso desde el final del texto. 

- **exactMatch( text : String )** : Boolean; Devuelve *true* si la coincidencia entre *text* y el patrón de la expresión regular es exacta, si no lo hace devuelve *false*.
    
### Más

- [Volver al Índice](./index.md)
