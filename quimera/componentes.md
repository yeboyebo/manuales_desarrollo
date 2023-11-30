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

Cuando un QBox es el principal elemento de la pantalla podemos usar el props maxWidth para controlar el tamaño de la pantalla, por defecto esta a 800px

## QListModel
Crea una lista de items de tipo *ItemComponent* basada en una estructura (*data*) que contiene un diccionario y un array.

La propiedad *modelName* se usa para generar nombres de acciones a llamar (p.e. *onModelNameItemChanged*).

```html
<QListModel data={pedidos} modelName='pedidos' ItemComponent={ListItemMisPedidos}
>
```

## Acciones en table

Para poder realizar acciones en una tabla  utilizamos un componente Column.Action, en la propiedad value podemos obtener el objeto linea y el indice de la linea(idx) 
Este indice es un autonumerico y podemos utilizarlo para enviarlo como index al Field editable ya que este campo es obligatorio.
Tambien podemos utilizar su valor para el id ya que es obligatorio para poder editar correctamente el campo.


```html
  <Column.Action
    id="aenviar"
    header="Cantidad"
    width={80}
    value={(linea, idx) => (
          <Field.Float
            id={`cantidad/${idx}`}
            field="cantidad"
            value=linea.cantidad)}
            index={idx}
            onClick={event => event.target.select()}
            onKeyPress={event => onKeyCantidadPressed(event, linea)}
          />
    )}
  />
```

### Acciones Field.Select

Para campos editables con Field.Select necesitamos tambien indicar el campo index, pero este caso podemos utilizar como index un campo de la linea para poder tener acceso desde el payload.


```html
    <Field.Select
      getOptions={getOptions}
      options={options}
      id={linea/codUbicacionArticulo}
      index={linea.idlinea}
      noOptionsText="Indica el código de ubicación"
      {...props}
      async
    />
```

Este campo lanzara on on{id}Changed, en este caso onLineaChanged, podemos capturar este evento y comprobar si el campo que esta cambiando es el que nos interesa para poder hacer la edicion a mano
```html
  onLineaChanged:
    - _type: setItem
      condition:
        operator: A = B
        A:
          payloadPath: field
        B:
          const: "codUbicacionArticulo"
      path: lineas.dict
      key:
        payloadPath: index
      prop: codUbicacionArticulo
      value:
        payloadPath: value
    - _type: patch
      condition:
        operator: A is defined
        A:
          payloadPath: value
      schema: lineasPedidoCli
      action: cambiar_ubicacion_articulo
      ....
```

### Más

  * [Volver al Índice](./index.md)
