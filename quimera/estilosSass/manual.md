## Recomendaciones de programacion

## Sintaxis

 Siempre hay que añadir un className ***NombreView*** al primer Box o Container, asi nos facilita el tener esa clase como padre para el fichero CSS.

 Utilizar siempre Upper Camel Case, la primera letra de cada palabra debe ser en mayusculas, sin espacios ni guiones.

Con SASS podemos anidar los estilos, lo que nos permite tener el codigo mas limpio y con menos lineas. Ejemplo:

  ```css
.PedidosCli {
    .ActionButton {
        padding: 10px;
        & .EnviarPDA {
            font-size: 10px;
            &:hover {
                color: red;
            }
        }
    }
    .Title {
        font-size: 14px;
    }
}
```

 Ver https://uniwebsidad.com/libros/sass/capitulo-4#reglas-anidadas
