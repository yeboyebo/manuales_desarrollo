### Manual AQExtension

## firma_pdf

# Descripción
Firma digitalmente un fichero pdf

# Argumentos
- **certificado** . Fichero con el certificado digital a usar.
- **password**. Contraseña del certificado digital.
- **fichero_original**. Fichero a firmar.
- **fichero_firmado**. Ruta donde se guardará el fichero una vez firmado.
- **marca_agua_mostrar** (opcional). Indica si se muestra una marca de agua indicando si el fichero está firmado. por defecto es False.
- **marca_agua_coordenandas** (opcional). Indica la posición de la marca de agua. 4 valores pserados por *-* . Por defecto 470-0-570-100.
- **pagina_firma** (opcional). Indica en que página se firmará. Por defecto es 0.


# Ejemplos de llamada
```
aqextension firma_pdf /home/usuario/ruta_certificado.p12 12345 /home/usuario/fichero.pdf /tmp/fichero_signed.pdf 

```

## Más

- [Volver al índice de AQExtension](../index.md)