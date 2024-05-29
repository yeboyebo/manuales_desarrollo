### Manual AQExtension

## cliente_web

# Descripción

El comando cliente_web no facilita la comunicacion con un API REST.


# Argumentos
 - fichero: Ruta a un fichero que contiene las ordenes.


# Fichero
El fichero contiene un JSON que especifica los parámetros de la llamada al API REST y el posterior proceso de los datos. Los parametros disponibles son los siguientes:

- **codificacion** (opcional). Especifica la codificación que ha de tener la respuesta. Por defecto "ISO-8859-15".
- **enable_debug** (bool) (opcional). Muestra un debug adicional al ejecutar el comando. También genera un fichero en /tmp/debug.txt con los debug emitidos. Por defecto es False
- **fentrada** (opcional). Ruta a fichero que contiene el payload de la llamada. Por defecto en blanco. **Solo para XMLRPC y TEST**
- **fsalida** (opcional). Ruta a fichero que contine la respuesta devuelta en la llamada.Por defecto se mostrará como texto en stdout (terminal).
- **only_key** (opcional). Cuando la respuesta es un json y está especificado fsalida, podemos espeficar que solo se devuelva un valor del json. Por defecto en blanco.
- **close_when_finish** (bool) (opcional). Indica si al finalizar la llamda derramos aqextension , o por el contrario se deja abierto a la escucha de una nueva llamada. Por defecto es False
- **metodo** . Especifica el método a usar:
    - GET, POST, PATCH, DELETE:
        - **tipo_payload** (opcional). Indica si el payload es tipo JSON o texto plano. Si es JSON la respuesta sera devuelta en JSON también.
        - **params**.
        - **headers**. 
        - **data**.
        - **cert**.
        - **verify**.
        - **url**.

    - XMLRPC
        - **url** . Url del servidor.
        - **ws** . Atributos de la url.
        - **formato** (opcional). Indica el formato del payload enviado (**fentrada**). Puede ser JSON, XML u otro. Por defecto JSON.
    - TEST (Simulación de llamada)
        - **formato** (opcional). Indica el formato del payload enviado (**fentrada**). Puede ser JSON, XML u otro. Por defecto JSON.

    





# Ejemplos de llamada
```
aqextension cliente_web /tmp/fichero_request.txt
```

## Más

- [Volver al índice de AQExtension](./index.md)

