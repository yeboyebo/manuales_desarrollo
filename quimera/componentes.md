# Quimera / Componentes

Hemos creado distintos componentes para homogeneizar las páginas de quimera y ahorrar trabajo de desarrollo.

## Field
Representa un campo de formulario. Según el tipo dibujará uno u otro control. El valor que muestra se toma según este orden de prioridad:
* Si hay una propiedad value, toma su valor.
* Si está definido el id del Field como un string separado por puntos (p.e. *pedido.codigo*), toma el valor del estado siguiendo esa ruta, y llama a onRutaIdChanged (p.e. *onPedidoCodigoChanged*) si no hay una propiedad onChange definida.
  * En el caso de que el id use el separador "/" para el último elemento de la ruta, la llamada se hará hasta dicho separador, y el valor a su derecha será el campo *field* de la llamada onXChange. Por ejemplo, id='pedido.buffer/codCliente' dispara llamadas a *onPedidoBufferChanged* con el valor *codCliente* como parámetro *field*.

### Float / Int
Mejora de rendimiento:

En el caso de fields de tipo Float o Int, si no necesitamos usar el *useState* para obtener el valor del field porque lo pasamos por una propiedad _value_ que nunca es _undefined_ y lo gestionamos en nuestro propio _onChange_, el campo renderiza más rápido (menos veces) al no usar el contexto de _useState_.

## QBox
[to do]

## QListModel
Crea una lista de items de tipo *ItemComponent* basada en una estructura (*data*) que contiene un diccionario y un array.

La propiedad *modelName* se usa para generar nombres de acciones a llamar (p.e. *onModelNameItemChanged*).

```html
<QListModel data={pedidos} modelName='pedidos' ItemComponent={ListItemMisPedidos}
>
```

### Más

  * [Volver al Índice](./index.md)
