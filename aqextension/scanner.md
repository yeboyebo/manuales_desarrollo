### Manual AQExtension

## scanner

# Descripción
permite operar con scanners tanto en windows como en linux

# Argumentos
- **list**. Obtiene un listado pos stdout(terminal) con los escaneres registrados en el S.O.
- **adquire**. Solicita escanerar documentos.
    - **url**. Url del scanner.
    - **source** (opcional). Especifica origen de los documentos a escanear. Por defecto *flatbed*
    - **dpi** (opcional). Especifica la resolución a usar. Por defecto *200*
    - **mode** (opcional). Especifica el modo del escaneo. disponibles **Gray**, **Color** y **Lineart**. por defecto *Gray*
    - **fichero_salida** (opcional). Especifica el fichero de salida. Por defecto */tmp_so/document.pdf*



# Ejemplos de llamada
```
aqextension scanner list
aqextension scanner adquire hpaio:/usb/Deskjet_1510_series?serial=CN3C71HM1B05YR
```

## Más

- [Volver al índice de AQExtension](./index.md)