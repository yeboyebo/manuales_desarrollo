# Gestion de eventos y colas

## Intro
El sistema de eventos permite independizar procesos que se ejecutan como consecuencia de la ejecución de procesos anteriores, de forma que el código queda mejor organizado. [Mejorar]

La secuencia tipica de acciones en una gestión de eventos es la siguiente:

+ Un caso de uso genera un evento (p.e. *ventas.factura_creada*)

+ Un broker de eventos recibe el evento y lo reenvía a todas las colas asociadas al evento, y que van a consumirlo (p.e. *contabilidad.regenerar_asiento*, *tesorería.regenerar_recibos*)

+ Un proceso de consumo o suscriptor lee los eventos pendientes de procesar de la cola y los consume (produciendo, si es necesario, nuevos eventos)

### Colas síncronas
Las colas síncronas son aquellas que pasan el evento al suscriptor asociado de forma inmediata, en la propia transacción del caso de uso que lo genera.

Las colas síncronas reciben eventos que se generan y consumen en Olula.

### Colas asíncronas
Las colas asíncronas son aquellas en las que los eventos se guardan de forma persistente (tabla SQL) para ser consumidos más tarde, en una transacción distinta a la del caso de uso que los genera.

Las colas asíncronas reciben eventos que se generan en Eneboo y Olula, y se consumen solo desde Olula.

### Ventajas
El sistema de eventos ayuda a separar procesos disparados por una acción del usuario o de otros sistemas que afecta a distintos contextos.

Las colas asíncronas permiten acelerar el código, postergando procesos lentos
 
Las colas asíncronas evitan bloqueos entre procesos, haciendo las transacciones más cortas y simples.

## Asociación de eventos a colas

### Nomenclatura

Eventos: se construyen como contexto + "." + entidad + "_" + evento: `ventas.factura_creada`

Colas: se construyen como contexto + "." + accion_a_realizar: `contabilidad.regenerar_asiento`

### Broker de eventos
El broker de eventos es un sistema que asocia eventos generados en Eneboo u Olula a sus correspondientes colas.

En cada módulo de QSA hay un fichero *eventos_mmmmmmm.qs* (p.e. *eventos_factteso.qs*) en el que se define el broker para los eventos generados en ese módulo:

Estos mapas se unen todos en el fichero _EVENT.qs_ del módulo de librería.

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
Se utiliza la función formQUEUE_EVENTS.iface.crearRegistroPendiente(colaId, datosEvento, tipoEvento, intento, error_log = None, idPadre = None)

`NOTA: Cambiar por >` formEVENT.publicar(tipoEvento, datosEvento) en nueva acción EVENT.qs < Crear acción qsa EVENT para la creación de eventos desde QSA, dejar la otra función en QUEUE.py para los reintentos

## Publicación de eventos desde Olula en colas síncronas:
TO DO

## Creación del proceso consumidor
El consumidor será una función que reciba el evento y llame al caso de uso que lo debe procesar.

Puede encargarse de decidir si el evento se debe procesaro o no.

El consumidor se crea siempre en su correspondiente contexto de Olula

```py
from contexts.almacen.stock.application.totalizar_stock_fisico import comando as comando_totalizar_stock_fisico
from contexts.almacen.stock.pub import totalizar_stock_fisico

def totalizar(evento: Event) -> None:
    # TODO: Según el tipo de movimiento (PTE o HECHO) se llama a un caso de uso u otro

    comando = comando_totalizar_stock_fisico.crear({
        'stock_id': evento['payload']['stock_id'],
    })
    totalizar_stock_fisico(evento['username'], comando)
```
### Nomenclatura

El fichero que contiene el suscriptor, se llamará *accion_a_realizar* + _on.py_: `totalizar_on.py` y se guardará en la carpeta application del módulo correspondiente (`almacen/stock/application`).

## Asociación de colas a consumidores
El consumidor será una función que reciba el evento y llame al caso de uso que lo debe procesar.

Puede encargarse de decidir si el evento se debe procesaro o no.

La asociación de colas a consumidores se hace en `olula/contexts/shared/suscriptores_eventos.py`

TO DO: Tomar cada suscripción del _shared_ de su contexto.

```py
class Suscripciones:
    suscriptores_: None | Suscriptores = None

    @staticmethod
    def get_suscriptor(cola: str) -> Suscriptor:
        suscriptores = Suscripciones.get_suscriptores()
        return suscriptores[cola]

    @staticmethod
    def get_suscriptores() -> Suscriptores:
        if Suscripciones.suscriptores_ is None:
            Suscripciones.suscriptores_ = {
                'tesoreria.regenerar_recibos_venta': suscriptor_regenerar
            }
        return Suscripciones.suscriptores_
```

## Consumo de procesos síncronos
TO DO

Se utiliza la función formQUEUE_EVENTS.iface.procesaCola(cola_id, datosEvento, tipoEvento, idDatabase= None):

## Consumo de eventos asíncronos
Cuando se activa el servidor de PinebooApi / Olula, se activa uno o varios demonios que escuchan en una o más colas (según configuración), y que consumen los eventos guardados.

Cada operación de consumo va en una transacción independiente que termina marcando el evento como OK, Error o Dead. Este marcado se produce en la misma transacción que el proceso de consumo, para asegurar la coherencia de los datos de la tabla de colas.

`LLAMADA PINEBOO-CORE`: 
```js
pineboo-core -s 'username:pass:PostgreSQL (PSYCOPG2)@localhost:5432/tablename' -x -c formQUEUE_EVENTS.iface.servicioTareasPendientes -vv
```

`TODO`: Los demonios se podrán configurar para usar una cola ('contabilidad.regenerar_asiento'), un grupo de colas ('contabilidad'), varios grupos, todo, todo menos un grupo, etc.

Cuando un proceso de consumo falla, se marca el registro como Error, y se duplica en estado Pendiente para volverse a intentar su consumo más tarde.

## TUTORIAL: Cómo crear un evento en eneboo y procesarlo en Olula
Vamos a ver un ejemplo que consistirá en publicar un evento `almacen.movimiento_creado` para recogerlo luego en un proceso que se encargue de totalizar el stock correspondiente.

### Añadimos el evento al broker
Como en este caso el evento está en 'flfactalma', vamos a `almacen/scripts/eventos_factalma.qs` y añadimos nuestro evento.

Como todos los eventos que genera Eneboo, su procesamiento será asíncrono (_sinc_ = _false_).

Llamaremos a la cola `almacen.totalizar_stock`.

```js
function getBroker() {
  const broker = {
    // ....
    'almacen.movimiento_creado': [
      {
        cola_id: 'almacen.totalizar_stock',
        sinc: false,
      }, 
    ],
  }
  return broker
}
```

### Publicamos el evento
En el punto del código donde queramos hacer la publicación, hacemos una llamada a la función `formQUEUE.publicar()`

```js
formQUEUE_EVENTS.iface.crearRegistroPendiente(colaId, datosEvento, tipoEvento, intento, error_log = None, idPadre = None)
// ANTONIO: Pasar a:
formEVENT.publicar(tipoEvento, datosEvento)

function oficial_aftercommit_movistock(curMS)
{
  //...
  if (curMS.modeAccess() == curMS.Insert) {
    formEVENT.publicar(
      "almacen.movimiento_creado",
      {
        movimiento_id: curMS.valueBuffer("idmovimiento"),
        stock_id: curMS.valueBuffer("idmovimiento"),
        estado: curMS.valueBuffer("estado")
      }
    )
  }
}

```

### Asociamos la cola al consumidor
Para asociar la cola al consumidor editamos `olula/contexts/shared/suscriptores_eventos.py`

TO DO: Actualizar cuando cada contexto asocie sus suscriptores

```py
from contexts.almacen.stock.pub import suscriptor_totalizar

class Suscripciones:
    # ...

    @staticmethod
    def get_suscriptores() -> Suscriptores:
        if Suscripciones.suscriptores_ is None:
            Suscripciones.suscriptores_ = {
                # ...
                'almacen.totalizar': suscriptor_totalizar
            }
        # ...
```

### Creamos el consumidor
El consumidor tiene como misión recibir el evento y llamar al caso de uso que debe procesarlo. En nuestro caso, el caso de uso que totaliza el stock físico.

Componemos el comando necesario y llamamos al caso de uso.

```py
from contexts.almacen.stock.application.totalizar_stock_fisico import comando as comando_totalizar_stock_fisico
from contexts.almacen.stock.pub import totalizar_stock_fisico

def totalizar(evento: Event) -> None:
    # TODO: Según el tipo de movimiento (PTE o HECHO) se llama a un caso de uso u otro

    comando = comando_totalizar_stock_fisico.crear({
        'stock_id': evento['payload']['stock_id'],
    })
    totalizar_stock_fisico(evento['username'], comando)
```



