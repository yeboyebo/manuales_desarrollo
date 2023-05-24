# Eneboo tools / Mejoras

## Que al hacer el build se borre la carpeta

### Pedido por

Antonio

### Motivo

Siempre que queremos crear el build nuevo tenemos que borrar manualmente la carpeta build.

### Propuesta

```sh
eneboo-assembler build [extension] src
```

Si la carpeta existe y tiene cambios pendientes de meter en el parche

```sh
La carpeta [extension] ya existe y tiene archivos con modificados antes de la última actualización del parche ¿sobreescribir? (S/N)
```

## Recargar un único fichero tocado en otra extensión

### Pedido por

Antonio

### Motivo

Acelerar el tiempo de generación de build si hemos tocado un archivo en otra extensión dependiente de aquella en la que estamos trabajando.

### Propuesta

```sh
eneboo-assembler update [extension] [fichero]
```

El assembler construye solo el fichero, bajándolo del módulo donde esté otra vez y aplicándole todos los cambios de las extensiones en las que se modifique el fichero

## Recargar una extensión con cambios en extensiones dependientes

### Pedido por

Antonio

### Motivo

Acelerar el tiempo de generación de build si hemos tocado varios archivos en otras extensiones dependientes de aquella en la que estamos trabajando.

### Propuesta

```sh
eneboo-assembler update [extension]
```

El assembler construye solo los ficheros que estan en otros parches y tienen fecha de modificación superior a la del parche de nuestra extensión. Puede realizar el proceso anterior para cada fichero encotrado.

### Más

- [Volver al Índice](./index.md)
