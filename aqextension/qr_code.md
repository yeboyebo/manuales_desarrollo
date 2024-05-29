### Manual AQExtension

## qrcode

# Descripción
Genera una imagen QR a partir de un texto dado

# Argumentos
- **fichero** . Ruta donde se va a generar el fichero
- **cadena** . Cadena con la que se va a genera el QR. los espacios en blanco se especifican como *þ*
- **parametros** (opcional). cadena con json que indica parametros diferentes a los por defecto.


# Parametros
Los parametros por defecto son los sguientes:
- **version** => 9.
- **error_correction** => ERROR_CORRECT_M.
- **box_size** => 3.
- **border** => 2.



# Ejemplos de llamada
```
aqextension qrcode /tmp/qr_generado.jpg estaeslacadena {"version":8,"box_size":4}
```

- [Volver al índice de AQExtension](../index.md)