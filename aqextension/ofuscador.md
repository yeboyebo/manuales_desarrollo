### Manual AQExtension

## ofuscador

# Descripción
Ofusca desofusca una cadena dada.

# Acciones:
- **ofuscar** .Ofusca una cadena de texto:
    - argumento1. Texto usado como clave. (en base64)
    - argumento2. Texto a ofuscar (en base64)
- **desofuscar** .Desofusca un texto a partir de una cadena ofuscada.
    - argumento1. Texto usado como clave. ( en base64)
    - argumento2. Base64 a desofuscar.




# Ejemplo de llamada ofuscar
```
'hola guapo' -> aG9sYSBndWFwbw==
'soy el texto' -> c295IGVsIHRleHRv

./aqextension ofuscador ofuscar aG9sYSBndWFwbw== c295IGVsIHRleHRv

devuelve:

Z0FBQUFBQm5NZW5xajVhS1lDMnRUdzZPOHVlZGlQczVsT0pqT1JNNGdieThybGtQUWQ2dUpFRGZFVS03Vi1YUWVMR3htYV9XeVRYbXlueUU5dm9qTEUzQjFsYlNXUjVsVXhoenpjVDNoYUM3MjRrOGVmTTgwbVFrcTQwUkZwZHYzRmFSZ0VYeHdReUY3eXFFRElOaDZmbjdhcEJTT0luMkk5WENPZVlMaGtJOXdjNElweEtXTU1rPQ==

```

# Ejemplo de llamada desofuscar
```
'hola guapo' -> aG9sYSBndWFwbw==
Z0FB... # Base64 obtenido el el apartado de ofuscar

./aqextension ofuscador desofuscar aG9sYSBndWFwbw== Z0FBQUFBQm5NZW5xajVhS1lDMnRUdzZPOHVlZGlQczVsT0pqT1JNNGdieThybGtQUWQ2dUpFRGZFVS03Vi1YUWVMR3htYV9XeVRYbXlueUU5dm9qTEUzQjFsYlNXUjVsVXhoenpjVDNoYUM3MjRrOGVmTTgwbVFrcTQwUkZwZHYzRmFSZ0VYeHdReUY3eXFFRElOaDZmbjdhcEJTT0luMkk5WENPZVlMaGtJOXdjNElweEtXTU1rPQ==

devuelve:

'soy el texto'

```

## Más

- [Volver al índice de AQExtension](./index.md)