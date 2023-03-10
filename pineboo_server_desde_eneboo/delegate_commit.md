# Pineboo Server desde Eneboo / Delegate commit

## Objetivo
La opción de Delegate Commit es un paso más en el objetivo de pasar la funcionalidad de negocio del ERP (todo lo que modifica la base de datos) a la parte servidor de Pineboo a través de su API.

La idea final es que la API de Pineboo Server sirva las peticiones de clientes Eneboo, de clientes Quimera, o de cualquier otro sistema que queramos conectar.

## En qué consiste
Delegate commit es una opción de ejecución de Eneboo que modifica el comportamiento del motor cuando este maneja un _cursor automático_.

Llamamos _cursor automático_ a los cursores que el motor usa automáticamente cuando conectamos los slots _insertRecord_, _editRecord_ o _deleteRecord_ a señales que emite un componente _FLTableDB_ (tablas de Eneboo).

Cuando _delegate commit_ está activo, en lugar de hacerse un commitBuffer automático cuando creamos, editamos o borramos un registro de un _cursor automático_, el motor de Eneboo hace una llamada a la función _delegateCommit_ del script principal del módulo al que pertenece la tabla del cursor (_flfacturac_, _flfactalma_, etc)

El caso más básico de esta función es este:
```js
function oficial_delegateCommit(cursor)
{
	return formHTTP.iface.saveCursor(cursor, accion)
}
```

Lo que _formHTTP.iface.saveCursor(cursor, accion)_ hace es llamar a Pineboo Server y pedirle que guarde el cursor.
Una vez llamado, y si la llamada es correcta, el cliente Eneboo hace los refrescos necesarios para mostrar los datos actualizados.

## Activación
Activamos delegateCommit incluyendo una clave _delegateCommit_ en el fichero de configuración _$HOME/.qt/eneboorc_
```conf
[application]
...
delegateCommit=true
```
Esto activa _delegate commit_ para todos los cursores excepto para los de tablas de sistema (_flfiles_, _flmodules_, etc.)

## Casos especiales
Hay un caso especial en el que una llamada por defecto de _delegate commit_ no funcionará correctamente, y es el caso en el que tenemos un formulario de edición con una subtabla, y las operaciones que hagamos con los elementos de la subtabla afectan a los datos del formulario.

Típicamente, es el caso de un formulario de pedido con la subtabla de líneas. Los cambios en las líneas afectan a los totales del pedido por lo que no basta con hacer un _delegate commit_ de la línea de pedido. En este caso deberíamos llamar a la función _add_linea_ / _edit_linea_ / _delete_linea_ de la API del pedido.

Para ello, modificamos _oficial_delegateCommit_ para que, en el caso de que la tabla a guardar sea la de líneas de pedido, llamemos a la función de API correcta y no a la de commit buffer por defecto.

*NOTA: ver implementación de este caso en flfactuac*

## Evolución
A medida que vayamos enriqueciendo las funciones de API, debemos eliminar paulatinamente lad llamadad a *formHTTP.iface.saveCursor* para irlas sustituyendo por llamadas a las funciones de API específicas para cada tabla.

### Más

  * [Volver al Índice](./index.md)
