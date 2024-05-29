### Manual AQExtension

## sftp

# Descripción
Permite enviar/recibir ficheros a servicio sftp

# Argumentos
- **username**. Nombre de usuario.
- **password**. Contraseña.
- **url**. Url del servicio
- **modo**.
    - **get_dir**. Descarga el contenido de una carpeta desde el servido a local.
        - **local_dir**. Carpeta local.
        - **remote_dir**. carpeta remota.
    - **put_dir**. Envia el contenido de una carpeta desde local al servicio.
        - **local_dir**. Carpeta local.
        - **remote_dir**. Carpeta remota.
- **puerto**. Puerto usado por el servicio.


# Ejemplos de llamada
```
aqextension sftp usuario1 12345 https://servidor_sftp.com get_dir /home/usuario/remoto datos
```

## Más

- [Volver al índice de AQExtension](./index.md)