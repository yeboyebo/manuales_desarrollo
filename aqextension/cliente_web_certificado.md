### Manual AQExtension

## cliente_web_certificado

# Descripción
Permite conexiones API REST con servicios que requieren autenticación personal por medio de certificados.

# Argumentos
- **tipo** . Especifica a que servicios se va a realizar la conexión.
    - **batuz**
        - **url**. Url de los servicios.
        - **cert_file**. Fichero que contiene el certificado.
        - **cert_pass**. Constraseña del certificado.
        - **body_file**. Fichero que contiene el body de la llamada.
        - **desc_file**. Fichero que contiene una descripción de la llamada.
        - **result_file**. Ruta donde encontraremos el fichero con la respuesta.



# Ejemplos de llamada
```
aqextension cliente_web_certificado batuz https://servicios.com/apirest /home/usuario/fichero_certificado.p12 12345 /tmp/fichero_body.txt /tmp/fichero_desc.txt /tmp/resultado.txt
```

## Más

- [Volver al índice de AQExtension](../index.md)