### Manual AQExtension

## envio_mail

# Descripción
Servicios de SMTP e IMAP

# Argumentos
- **destinatarios**. Separado por comas.
- **usuario**. Usuario del email.
- **password**. Contraseña del email.
- **servidor_url**. Url del servidor.
- **servidor_puerto**. Puerto del servidor.
- **remitente**. Remitente.
- **ficheros_adjuntos** (opcional). Ficheros adjuntos al email, separados por *|||*. Para en blanco usar *AAAAAA*
- **imagen_firma** (opcional). fichero para usar como firma del email. Para en blanco usar *AAAAAA*
- **imagen_firma_ancho** (opcional). Indica el ancho de la imagen. Para en blanco usar *AAAAAA*
- **imagen_firma_alto** (opcional). Indica el ancho de la imagen. Para en blanco usar *AAAAAA*
- **fichero_title_y_body** (opcional). Indica un fichero que contiene el título del email (primera linea) y el cuerpo. Si se usa *AAAAAA* o no se especifica se buscará en fichero *correo.txt*
- **imap_puerto** (opcional). Indica el puerto de servicios imap. Para en blanco usar *AAAAAA*
- **imap_url** (opcional). Indica la url del servidor imap. Para en blanco usar *AAAAAA*
- **destinatarios_cc** (opcional). Separado por comas. Para en blanco usar *AAAAAA*
- **destinatarios_bcc** (opcional). Separado por comas. Para en blanco usar *AAAAAA*
- **starttls** (opcional). Especifica si se activa starttls. Por defecto es True. Para en blanco usar *AAAAAA*


# Ejemplos de llamada (título y cuerpo se espeficarían en correo.txt)
```
aqextension envio_email prueba@midominio.es usuario1 12345 smtp.micorreo.es 564 yo@midominio.es 

```

## Más

- [Volver al índice de AQExtension](../index.md)