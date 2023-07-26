## Mappers.
### J
¿Porque existe la opcion de añadir varios mappers? ¿Me parece ver una herencia tipo AbanQ? No lo veo de esta manera.

Mappers. ¿Porque no hacerlo simplemente como lo hago yo en EnebooAsientosFacturaClienteMapper? Es propio de la entidad, y el repo lo utilizara dependiendo del contexto

### A
Es porque distintos proyectos necesitan distintos mappers. Un proyecto puede poder informar una primitiva con el campo A y otro con el campo B, o incluso una estructura distinta. Por ejemplo, para tallas y colores tenemos
```js
lineapedido = {
	articulo: ..,
	precio: ...,
	config: {
		talla: ...,
		color: ...,
	}
}
```
mientras para tapizado tenemos:
```js
lineapedido = {
	articulo: ..,
	precio: ...,
	config: {
		tela: ...,
		modelo: ...,
		patas: ...,
	}
}
```
Algo que se me ocurre ahora es usar Strategy:
```js
lineapedido = {
	articulo: ..,
	precio: ...,
	config: mapperConfigStrategy.run(tableRow)
}
```
Creo que esto está mejor que lo del array de mappers. ¿Ideas?


## Repos
### J.
El EnebooCursorClient podria tener un metodo UPSERT que deja todo muy limpito

### A.
Estaría bien, pero tengo que pasar al EnebooCursorClient mucha información del agregado a guardar. Ten en cuenta que para agregados compuestos la cosa se complica, tipo:
```js
function save(carrito) {
    const carritoPrevio = this.find(carrito.id())
    if (carritoPrevio == null) {
        EnebooCursorClient.insertNew(carrito.toPrimitives(), "to_carritos", this.mapperCarrito)
        EnebooCursorClient.save1MNew([], carrito.toPrimitives()["lineas"], "to_lineascarrito", this.mapperLineas, carrito)
    } else {
        EnebooCursorClient.updateNew(carrito.toPrimitives(), "to_carritos", this.mapperCarrito)
        EnebooCursorClient.save1MNew(carritoPrevio.toPrimitives()["lineas"], carrito.toPrimitives()["lineas"], "to_lineascarrito", this.mapperLineas, carrito)
    }
}
```

## Itest
### J.
En mis ejemplos he cambiado los nombres de algunas cosas que dejan todo mucho más claro. Por lo que "returnOnFind" ahora es "shouldFind" y "findReturn" es "mockFind" o "mockedFind"

### A.
OK, estoy haciendo los cambios solo en _EjercicioFiscal_, cuando todos los criterios estén claro tocaré el resto de ficheros. Si ves algún cambio en otra carpeta es porque aprovecho para cambiar alguna cosa al testear. La doc ya está con estos nombres.

## Entities
### J.
Hay una parte en la que utilizas FechaHora como valueObject, pero llamas a un metodo "creaFecha", mientras que en otros VO haces un new. Debería haber convención ahí. Propongo: si es un valor, new, y varios: "fromPrimitives"

Entities. Igual en toPrimitives, en unas se utiliza value, en otras se utiliza fecha. Mas cohesion aqui

### A.
Al margen de si aquí debería usar un value object Fecha, y no FechaHora, hay un tema con los nombres de los atributos de los value object que devuelven más de un valor.
* StringValueObject devuelve el string en el atributo _.value_
* Moneda devuelve dos valores, _.importe_ y _.divisa_
Una convención sería usar _value_ para los que solo devuelven un valor.

En el caso que comentas, _FechaHora_ puede devolver fecha y hora completas o solo fecha.

## Entities. Create.
### J.
Se dice aquí que create actua de intermediaro con los use cases y que facilita la creación. No. Create es la funcion a la que se llama cuando se crea un registro NUEVO, que no existia antes. Si se saca de base de datos, pase por caso de uso o no, se llama a fromPrimitives, que es si que facilita la creacion. De hecho, create podria/deberia llamar a fromPrimitives

### A.
Lo he reescrito, yo lo ententiendo igual que tú. Revísalo a ver si lo ves bien y comentamos.

## UseCases.
### J.
En la funcion run se estan creando los valueObjects dependientes, y no creo que deba ser asi. Eso podria estar en la funcion "fromPrimitives" (que se llamara a traves de create) // Ademas están los problemas descritos antes en las entities.

### A.
OK, a ver si definimos bien los criterios de dónde hacer las cosas en la creación (use case > create > fromPrimitives). Escribo algo para darle vueltas:
* Use Case:
    * Siempre recibe primitivas
    * Siempre llama a create (no a fromPrimitives)
    * Siempre pasa primitivas a create como primer parámetro, en un opcional segundo parámetro, se pasa contexto para que create ejecute lógica intrínseca al agregado.
    * En el caso de entidades compuestas (asiento), se pasan al create _principal_ las entidades componente construidas con su correspondiente create.

* create:
    * Siempre recibe primitivas, o entidades componente
    * Opcionalmente ejecuta lógica de negocio para determinar los valores definitivos de creación (posibles parámetros adicionales).
    * Puede usar fromPrimitives como método de creación.

* fromPrimitives:
    * Recibe primitivas y nada más (obvio)
    * La creación de value objects es directa, sin lógica de negocio (para usarse también para la creación de entidades persistidas).

Creo que en tu _CrearAsientoFacturaCliente_ > _AsientoFacturaCliente.create_ > _AsientoFacturaCliente.fromPrimitives_ hay una cosa incongruente. El use case pasa al create en la clave _partidas_ una lista de instancias (no primitivas) de partidas, y luego esa lista pasa al fromPrimitives. Funciona porque los atributos de partidas tienen el mismo nombre que las primitivas. 

Debemos ver casos más complejos como el de _CrearCarritoECommerce_ y _CarritoECommerce.create_, a ver dónde se debería colocar la lógica que usa un segundo parámetro de creación.

Hablo siempre de entidades "normales", esto se puede cambiar si está justificado, pero por hacerlo todo con el mismo criterio.

## UseCases. Event Bus
### J.
Creo que sería buena practica empezar a meter el eventBus en los use cases y lanzar los eventos de creacion en el metodo create (aunque nadie los escuche, pero ya estan ahi para poder hacerlo)

### A.
OK, si quieres edita el ejemplo de la doc y lo añades como mejor veas. La idea sería basarnos en los ejemplos de la doc para crear los snippets que comentaste el otro día.

## UseCases. IDs 
### J.
Se especifica al final que el caso de uso es el responsable de crear los IDs, incluso los serial. Esto es falso, ya que estamos creando solamente los serial aquí porque no veíamos otra opción. Asi que esto me recuerda que lo estamos haciendo mal y que deberíamos pasarle es ID desde "el cliente", en este caso Eneboo/Pineboo, y así tendrá acceso al nuevo ID al guardar sin tener que preguntar a BD. Creo que es importante refactorizar esto.

### A.
OK. Hay varias formas de acceder a los contextos:
* Desde eneboo/pineboo, aquí podemos usar una función de obtener serial y pasar el dato.
* Desde quimera. Aquí, mejor que obtenerlo en el cliente, hacemos que sea la API (la típica función _post_) la que añada el Id. Esto no es lo ideal pero ahorra llamar desde el cliente para saber cuál es el siguiente serial, y mantenemos la "pureza" de los casos de uso.

¿Te parece bien?

## Testing TestingPersistence
### J.
¿Puede ser que se este creando una funcion cleanupDB por cada suite de tests? Esto no lo veo para nada. ¿Que es BooEngine? ¿Como va la segunda fase de esto?

### A.
Esto está a medio, el setupDB lo debería hacer el módulo de test una sola vez cada ejecución.

También quiero poder hacer _qs-task all:e2e_ y probar uno tras otro todos los proyectos, mostrando un resumen al final. Aquí sí habría que hacer un setupDB por cada proyecto.

BooEngine es una clase para ayudarnos capturar y memorizar los metadatos de cada BD, ahora mismo en flfiles de la BD _test_. Eneboo y Pineboo tienen métodos distintos, de ahí el nombre y los dos ficheros.

De la segunda fase, Jose ha creado ya un comando para crear la BD, me falta probarlo. Lo de guardarlas en un único lugar (eneboo y pineboo) no parece fácil, no creo que sea un problema grave de todas formas. Me falta juntar las piezas.