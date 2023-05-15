# Política de ramas

## Para empezar a trabajar
- Creamos una rama nueva a partir de master con la siguiente nomenclatura
    -   Para desarrollos, ponddremos el priefijo DEV, codigo del cliente, el codigo de proyecto si lo tuviera y una pequeña descripción:
        Ej: DEV MON H2780 Añadir campo observación en el pedido automático de stock
    -   Para incidencias, FIX codigo del cliente, codigo de incidencia y descripción
        Ej: FIX SAN 492336 Error en calculo de stock

## Durante el desarrollo
- Haremos cambios en nuestra rama
- Podemos subir y bajar cambios en nuestra rama
- Si estamos trabajando en varias ramas a la vez, debemos acordarnos de cambair de rama
- Para hacer pruebas podemos mezclar master en nuestra rama para asegurarnos de tenerlo todo actualizado

## Subir a la rama master
Solamente subiremos a la rama master cuando vayamos a realizar la instación en el cliente

- Antes de subir, mezclar en nuestra rama la rama master para asegurarnos de tenerlo todo actualizado
- Hacer las pruebas necesarias
- Mezclar nuestra rama en master
- Borrar nuestra rama

## Mas cambios después de haber mezclado con master borrando la rama
Si una vez mezclado con master necesitamos realizar algún cambio más volveremos al paso 1 y crearemos de nuevo una rama. Si es sobre un error en un desarrollo podemos crear la rama como FIX en lugar de DEV



### Más

  * [Volver al Índice](./index.md)