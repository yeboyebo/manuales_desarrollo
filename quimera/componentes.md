# Quimera / Llamadas a la API

Las llamadas a la API envían o reciben información al servidor.

## POST
En una llamada POST (alta), necesitamos indicar:
* **schema**: El nombre del esquema a usar
* **action**: (opcional) Acción a lanzar, si no es la acción por defecto "post"
* **data**: Array de valores "key": "value" a enviar, las claves deben corresponder a campos del esquema.
* **success**: Nombre del grape a llamar si el post tiene éxito

Ejemplo:
```json
"onAnadirProductoACarritoClicked": [
    {
        "_type": "post",
        "schema": "nuevaLineaCarrito",
        "action": "anadir_producto",
        "data": [
          {
            "key": "referencia",
            "value": {
              "payloadPath": "referencia"
            }
          },
          {
            "key": "cantidad",
            "value": {
              "payloadPath": "cantidad"
            }
          },
          {
            "key": "idCarrito",
            "value": {
              "const": null
            }
          }
        ],
        "success": "onProductoAnadidoAlCarrito"
     }
],
```

### Más

  * [Volver al Índice](./index.md)
