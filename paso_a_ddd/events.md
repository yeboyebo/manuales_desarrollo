# Eventos

Un evento captura la memoria de algo interesante para el dominio.

Por ejemplo, un cambio en una factura (evento), es interesante para el contexto Contabilidad, porque seguramente haya que regenerar su asiento. De la misma forma, la creación de una nueva línea de pedido, supone un evento interesante para el contexto de Almacén, al tener que reservarse el correspondiente stock.

Usar eventos nos permite desacoplar las entidades que los producen de las que los comsumen.

## Registrar un evento
Los eventos son registrados por los agregados, para luego ser publicados una vez el caso de uso termina.

Para ello todos los agregados disponen de los siguentes métodos:
### record(_event_)
Registra un evento para ser publicado más tarde.
### flushEvents()
Devuelve un QList con los eventos registrados.

```js
class LineaPedidoVenta {
    // ...
    this.root.record({
        "name": "pedidoVentaLineaCambiada",
        "data": {
            "idLinea": this.id(),
            "cantidad": importes.cantidad
        }
    })
    // .....
}
```
En el caso de la línea de pedido, debemos hacer referencia a su agregado (root), que es quien dispone del método _record_.

Cuando registramos un evento necesitamos indicar:
* Nombre del evento
* Datos asociados. La estructura de estos datos debe ser siempre la misma para un mismo evento.

## Publicar eventos de un caso de uso
```js
EventBus = formImport.from("contexts/shared/infrastructure/InMemoryEventBus.qs");

class CrearStock {
    // ...
    function run() {
        // ...
        const moviStock = MoviStock.create(data)
        this.repo.save(moviStock)
        
        // .....
        EventBus.get().publish(moviStock.flushEvents());
    }
}
```

## Suscribirse a un evento
Mediante las suscripciones, asociamos los eventos con las funciones que los procesarán o _handlers_. Esto se hace en los ficheros _*.subs.qs_.
```js
EventBus = formImport.from("contexts/shared/infrastructure/InMemoryEventBus.qs");

function subs() {
    return {
        "crearStockOnPedidoVentaLineaCantidadCambiada": EventBus.get().register("pedidoVentaLineaCambiada", function (event) {
            const eventHandler = formDependencyContainer.get("almacen.movistock.application.crear.on.pedidoventalinea-cantidadcambiada");
            eventHandler.handle(event);
        })
    };
}

subs;
```
En este ejemplo el _handler_ obtenido de la dependencia _almacen.movistock.application.crear.on.pedidoventalinea-cantidadcambiada_ se asocia al evento _pedidoVentaLineaCambiada_.

## Implementar el handler
El manejador de un evento es una clase de la capa de aplicación que tiene como responsabilidad recibir el evento, preprocesarlo, y llamar a un _caso de uso_.
```json
    "almacen.movistock.application.crear.on.pedidoventalinea-cantidadcambiada": {
        "dep": "contexts/almacen/movistock/application/CrearMoviStockOnPedidoVentaLineaCantidadCambiada.qs",
        "args": [
            "@ventas.pedido.domain.repository",
            "@almacen.movistock.application.crear-from-sku"
        ]
    },
    "almacen.movistock.application.crear-from-sku": {
        "dep": "contexts/almacen/movistock/application/CrearMoviStockFromSku.qs",
        "args": [
            "@almacen.stock.domain.repository",
            "@almacen.movistock.domain.repository"
        ]
    },
```
La primera entrada de las dependencias mapea la clase que hará de _handler_. La segunda es un caso de uso convencional.

```js
class CrearMoviStockOnPedidoVentaLineaCantidadCambiada {
    ///...

    function handle(event) {
        const pedido = this.pedidoRepo.findFromLinea(event.idLinea);
        
        const linea = pedido.getLinea(event.idLinea);
        const referencia = linea.articulo.referencia
        const almacenId = pedido.envio.almacenOrigen
        const cantidad = linea.importes.cantidad
        this.moviStockCreator.run({
            "id": IdGenerator.run("MoviStock"),
            "sku": {
                "tipo": "referencia",
                "codigo": referencia
            },
            "codAlmacen": almacenId.value(),
            "cantidad": linea.importes.cantidad,
            //...
        })
    }
}
```
El _handler_ recibe el evento, obtiene los parámetros necesarios para ejecutar el caso de uso, y lo llama.