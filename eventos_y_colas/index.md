# Gestion de eventos y colas

## Intro
El sistema de eventos permite independizar procesos que se ejecutan como consecuencia de la ejecución de procesos anteriores, de forma que el código queda mejor organizado. [Mejorar]

+ Un caso de uso genera un evento (p.e. *ventas.factura_creada*)

+ Un broker de eventos envía el evento a todas las colas asociadas que van a consumirlo (p.e. *contabilidad.regenerar_asiento*, *tesorería.regenerar_recibos*)

+ Un proceso de consumo o suscriptor lee los eventos pendientes de procesar de la cola y los consume (produciendo, si es necesario, nuevos eventos)

### Colas síncronas
Las colas síncronas son aquellas en los suscriptores del evento lo consumen de forma inmediata, en la propia transacción del caso de uso que los genera.

Las colas síncronas reciben eventos que se generan y consumen en Olula.

### Colas asíncronas
Las colas asíncronas son aquellas en las que los eventos se guardan de forma persistente (tabla SQL) para ser consumidos más tarde, en una transacción distinta a la del caso de uso que los genera.

Las colas asíncronas reciben eventos que se generan en Eneboo y Olula, y se consumen solo desde Olula.

### Ventajas
Las colas asíncronas permiten acelerar el código, postergando procesos lentos, y evitar bloqueos, haciendo las transacciones más cortas y simples.

## Asociación de eventos a colas

### Broker de eventos
El broker de eventos es un sistema que asocia eventos generados en Eneboo u Olula a sus correspondientes colas.

En cada módulo de QSA hay un fichero *eventos_mmmmmmm.qs* (p.e. *eventos_factteso.qs*) en el que se define el broker para los eventos generados en ese módulo:

`NOTA`: Hacerlo como como se hace en librería flpermissions.oficial_getAclModelsDict

Estos mapas se unen todos en el fichero _EVENT.qs_ del módulo de librería.

`NOTA`: _EVENT.qs_ es el equivalente a flpermissions, por hacer

El broker tiene esta estructura:
```js
const brokerConfig = {
  [tipo_evento]: [
    {
      cola_id_: [nombre_cola],
      sinc: [true/false]
    }
    // ,...
  ]
  // ,...
}
// Ejemplo
const brokerConfig = {
  'ventas.factura_cambiada': [
    {
      cola_id: 'contabilidad.regenerar_asiento',
      sinc: true,
    }, 
    {
      cola_id: 'tesoreria.regenerar_recibos_venta',
      sinc: true
    }
  ],
  'tesoreria.recibo_pagado': [
    {
      cola_id: 'tesoreria.actualizar_riesgo',
      sinc: false
    }
  ]
}
```
Donde:
+ _cola_id_ es el id de la cola
+ _sinc_ indica si la cola es síncrona o asíncrona

Nota: El prefijo de los eventos y las colas no es el nombre del módulo QSA, sino el del contexto de Olula al que el evento pertenece. Por ejemplo. el módulo facturación de QSA se divide en dos contextos, compras y ventas, en Olula.


## Publicación de eventos desde Eneboo en colas asíncronas:
Cuando se quiere generar un evento desde el código QSA, llamamos a:
```js
formEVENT.publicar([tipo_evento], [datos_evento])
```

Esta función escribe en la tabla de eventos los registros correspondientes a todos los suscriptores que el evento tenga que sean de tipo asíncrono (los síncronos son siempre ignorados desde Eneboo).

`NOTA`: Función a desarrollar, tabla a crear

Tabla: flqueues / flcolas:
+ id: serial
+ idcola: Nombre de la cola
+ tipoevento: Tipo del evento
+ payload: Datos del evento (json)
+ usuario
+ fecha / hora o timestamp creación
+ estado: Pendiente, OK, Error, Dead, 
+ fecha / hora o timestamp inicio procesamiento
+ fecha / hora o timestamp fin de procesamiento / error
+ numintento
+ datos error: traza, etc.

## Publicación de eventos desde Olula en colas asíncronas:
Por ahora se puede llamar al código traducido de EVENT.qs

## Publicación de eventos desde Olula en colas síncronas:
TO DO

## Consumo de procesos síncronos
TO DO

## Consumo de eventos asíncronos
Cuando se activa el servidor de PinebooApi / Olula, se activa uno o varios demonios que escuchan en una o más colas (según configuración), y que consumen los eventos guardados.

Cada operación de consumo va en una transacción independiente que termina marcando el evento como OK, Error o Dead. Este marcado se produce en la misma transacción que el proceso de consumo, para asegurar la coherencia de los datos de la tabla de colas.

`NOTA`: Proceso  a desarrollar, podemos usar lo ya hecho de cron

Los demonios se podrán configurar para usar una cola ('contabilidad.regenerar_asiento'), un grupo de colas ('contabilidad'), varios grupos, todo, todo menos un grupo, etc.

`NOTA`: Esto de arriba no es necesario por ahora

Cuando un proceso de consumo falla, se marca el registro como Error, y se duplica en estado Pendiente para volverse a intentar su consumo más tarde.

`NOTA`: Procesar (configurable) cada 0seg, 5seg, 60seg ¿hace falta un campo de timestamp "siguiente intento"?

Los suscriptores se declara en Olula en una estructura del siguiente tipo:

```py
suscriptores = {
  'contabilidad.regenerar_asiento': (funcion olula suscriptora),
  'tesoreria.regenerar_recibos': (funcion olula suscriptora),
  #...
}
```

`NOTA`: Estudiar si esto se puede hacer con decoradores, si no por ahora usar un diccionario estático .

```py
@suscrito_a('tesoreria.regenerar_recibos')
def regenerar_recibos(evento: Evento):
  #...
```







