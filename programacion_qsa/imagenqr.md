# Crear Imagen QR a partir de un String

Teniendo las variables:

* **rutaQr** Ruta donde se va a guardar la imagen con el nombre de la imagen
* **qrString** Código qr a crear
    
    NOTA IMPORTANTE: si el string del código qr lleva espacios sustituir por el carácter þ para que el comando no los tome como parámetros, en aqextension luego los vuelve a convertir en espacios
    


Ejecutamos lo siguiente:
```
var comando = ["qrcode", rutaQr, qrString];
res = formCMD.ejecutarAQExtension(comando);
```

### Más

- [Volver al Índice](./index.md)
