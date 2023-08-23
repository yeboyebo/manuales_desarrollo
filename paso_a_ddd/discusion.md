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

### J.

Desde luego, es una opción mucho mejor que el array de Mappers. Pero pensando la complejidad que estamos añadiendo a cada uno de los ficheros, me hace replantearme el sistema de extensión que estamos montando. ¿Deberíamos pensar/considerar que hacen otras herramientas para personalizarlas mediante plugins? ¿Deberíamos tener distintas aplicaciones para cada cliente y una librería de dependencia central que actúe como core?

### A.
¿Cómo plantearíamos por ejemplo este caso de los mappers con el sistema de distintas aplicaciones? Cada app tendría su mapper y si añadimos una funcionalidad que implique ampliar el mapper se modifica el fichero de la app directamente? Quizá haya que hacerlo así, ejemplo:
+ Tengo la app cliente x y la app tallasycolores, que implementa toda la lógica de t&c.
+ Si el cliente compra la funcionalidad tallas y colores tengo que cambiar su mapper añadiendo las claves que faltan, nada de estrategias ni de composiciones.

¿Es esto lo que dices?

## Repos

### J.

El EnebooCursorClient podria tener un metodo UPSERT que deja todo muy limpito

### A.

Estaría bien, pero tengo que pasar al EnebooCursorClient mucha información del agregado a guardar. Ten en cuenta que para agregados compuestos la cosa se complica, tipo:

```js
function save(carrito) {
  const carritoPrevio = this.find(carrito.id());
  if (carritoPrevio == null) {
    EnebooCursorClient.insertNew(
      carrito.toPrimitives(),
      "to_carritos",
      this.mapperCarrito
    );
    EnebooCursorClient.save1MNew(
      [],
      carrito.toPrimitives()["lineas"],
      "to_lineascarrito",
      this.mapperLineas,
      carrito
    );
  } else {
    EnebooCursorClient.updateNew(
      carrito.toPrimitives(),
      "to_carritos",
      this.mapperCarrito
    );
    EnebooCursorClient.save1MNew(
      carritoPrevio.toPrimitives()["lineas"],
      carrito.toPrimitives()["lineas"],
      "to_lineascarrito",
      this.mapperLineas,
      carrito
    );
  }
}
```

### J.

```js
// En repo
function save(carrito) {
  const mappedCarrito = this.carritoMapper.toPersistence(carrito);

  EnebooCursorClient.from("carritos").upsert(mappedCarrito);

  const lineas = carrito.lineas;
  lineas.map(function (linea, i, a) {
    const lineaWithCarritoId = { ...linea, idCarrito: carrito.id.value };
    const mappedLinea =
      this.lineasCarritoMapper.toPersistence(lineaWithCarritoId);

    EnebooCursorClient.from("lineascarrito").upsert(mappedLinea);
  });

  // Faltaría añadir la parte de líneas borradas
}

// En client
function upsert(data) {
  const id = data.id;

  // Supongamos que ya sabemos la tabla, por el from de antes
  const previous = this.find(id);

  if (!previous) {
    return this.insert(data);
  }

  return this.update(data);
}
```

¿No?

### A.
Creo que para ver las líneas a borrar tienes forzosamente que hacer un una consulta en el repo, así que ahí ya sabes si vas a hacer update o insert. No lo veo más limpio, creo que mezclamos la función entre dos entidades (repo y client).

## Entities

### J.

Hay una parte en la que utilizas FechaHora como valueObject, pero llamas a un metodo "creaFecha", mientras que en otros VO haces un new. Debería haber convención ahí. Propongo: si es un valor, new, y varios: "fromPrimitives"

Entities. Igual en toPrimitives, en unas se utiliza value, en otras se utiliza fecha. Mas cohesion aqui

### A.

Al margen de si aquí debería usar un value object Fecha, y no FechaHora, hay un tema con los nombres de los atributos de los value object que devuelven más de un valor.

- StringValueObject devuelve el string en el atributo _.value_
- Moneda devuelve dos valores, _.importe_ y _.divisa_
  Una convención sería usar _value_ para los que solo devuelven un valor.

En el caso que comentas, _FechaHora_ puede devolver fecha y hora completas o solo fecha.

### J.

¿Estamos de acuerdo en que `creaFecha` podría ser un método `create` o `fromPrimitives` que solo recibe un parámetro? No se siquiera si estoy convencido de ello. Pero...¿no te obliga la implementación actual a conocer la estructura interna del value object?
En cuanto a la recepción me pasa exactamente lo mismo. ¿Porqué no tener un método `toPrimitives` que te devuelva un objecto con fecha y hora? Siendo hora `null` o lo que deba. De esa manera tendrás guardado un objeto primitivo del valor que representa y no sabrás de la estructura interna del VO. Posteriormente en el mapper se sacará solo el valor necesario, en este caso, la fecha.

### A.
creaFecha es un método estático de creación para un caso especial que creamos por conveniencia, en el que no hay hora, y donde la hora toma el valor por defecto 00:00:00. Es como _Moneda.euros(importe)_, que crea una moneda en Euros directamente.

Creo que no se trata tanto de conocer la estructura del value object como de poder acceder a su valor o parte de su valor de forma cómoda. A nivel de cliente del value object creo que es bueno poder extraer la fecha, la hora o todo junto en métodos separados. Tanto en este caso como en otros valueObjects que tengan varias propiedades significativas para el cliente (Moneda, etc.)


## Entities. Create.

### J.

Se dice aquí que create actua de intermediaro con los use cases y que facilita la creación. No. Create es la funcion a la que se llama cuando se crea un registro NUEVO, que no existia antes. Si se saca de base de datos, pase por caso de uso o no, se llama a fromPrimitives, que es si que facilita la creacion. De hecho, create podria/deberia llamar a fromPrimitives

### A.

Lo he reescrito, yo lo ententiendo igual que tú. Revísalo a ver si lo ves bien y comentamos.

### J.

Bien, solo un detalle. Creo que las validaciones previas a la llamada al constructor no deberían estar ahí. Ahora mismo pienso que esas validaciones se van a hacer o en el constructor de los VO correspondientes, o en el propio constructor de los agregados. Create solo es un intermediario que enlaza la creación en dominio, con el lanzamiento de los eventos.

### A.
OK, he cambiado en la doc el párrafo sobre validación del create al constructor.

Borra este aparado de este documento si lo ves bien.

## UseCases.

### J.

En la funcion run se estan creando los valueObjects dependientes, y no creo que deba ser asi. Eso podria estar en la funcion "fromPrimitives" (que se llamara a traves de create) // Ademas están los problemas descritos antes en las entities.

### A.

OK, a ver si definimos bien los criterios de dónde hacer las cosas en la creación (use case > create > fromPrimitives). Escribo algo para darle vueltas:

- Use Case:

  - Siempre recibe primitivas
  - Siempre llama a create (no a fromPrimitives)
  - Siempre pasa primitivas a create como primer parámetro, en un opcional segundo parámetro, se pasa contexto para que create ejecute lógica intrínseca al agregado.
  - En el caso de entidades compuestas (asiento), se pasan al create _principal_ las entidades componente construidas con su correspondiente create.

- create:

  - Siempre recibe primitivas, o entidades componente
  - Opcionalmente ejecuta lógica de negocio para determinar los valores definitivos de creación (posibles parámetros adicionales).
  - Puede usar fromPrimitives como método de creación.

- fromPrimitives:
  - Recibe primitivas y nada más (obvio)
  - La creación de value objects es directa, sin lógica de negocio (para usarse también para la creación de entidades persistidas).

Creo que en tu _CrearAsientoFacturaCliente_ > _AsientoFacturaCliente.create_ > _AsientoFacturaCliente.fromPrimitives_ hay una cosa incongruente. El use case pasa al create en la clave _partidas_ una lista de instancias (no primitivas) de partidas, y luego esa lista pasa al fromPrimitives. Funciona porque los atributos de partidas tienen el mismo nombre que las primitivas.

Debemos ver casos más complejos como el de _CrearCarritoECommerce_ y _CarritoECommerce.create_, a ver dónde se debería colocar la lógica que usa un segundo parámetro de creación.

Hablo siempre de entidades "normales", esto se puede cambiar si está justificado, pero por hacerlo todo con el mismo criterio.

### J.

No, a ver, así lo veo yo:

- Use Case:
	- Siempre recibe primitivas
	- **Llama a create solo cuando es un UseCase de creación**. En otros casos simplemente interactuará con el repositorio para recibir el agregado. (Find, Search, etc...)
	- **Siempre pasará un solo parámetro con las primitivas a create**. En caso de que se necesiten otras propiedades, como un contexto para rellenar campos vacíos o complementar información, se podrán seguir varias opciones:
		1.  Recuperar esa info en el caso de uso y completarla. En mi caso yo hice algo similar con un repositorio de configuración de asientos (cuentas especiales, subcuentas x ejercicio, etc...). Esto será para datos fijos que no intervienen en el dominio como tal.
		2.  Si solo queremos esos datos para completar campos obligatorios en base de datos, se piden/guardan directamente desde la implementación del repositorio.
		3.  En caso de querer esa funcionalidad de añadir contexto o dar valores por defecto (que vienen de bd), se pueden recibir esos datos en el caso de uso y mezclarlos con las primitivas dentro de un Servicio de dominio
	- En el caso de entidades compuestas (asiento), **también se pasan las entidades hijas como primitivas**, aquí tenías razón, no era congruente. Pero aquí tenemos dos opciones, hay que elegir una pensando lo siguiente: ¿Queremos que se lancen los eventos create? El padre no va a querer escucharlos, porque ni siquiera existe, pero....¿y si hay otro módulo que requiere saber cuando se crea una línea aunque no exista el pedido?
		1.  Hacer un create del hijo, pasarlo a primitivas, y añadirlo al padre (esto lanzará los eventos "create" del hijo).
		2.  Montar un objeto de primitivas y añadirlo a las primitivas del padre (no lanzará los eventos "create" del hijo).
- create:
	- **Siempre recibe primitivas**
	- **NO** ejecuta lógica de negocio para determinar los valores definitivos de creación.
	- Puede usar fromPrimitives como método de creación. **O debe**

Efectivamente, mi ejemplo era incongruente como digo arriba. Habría que elegir una de las dos opciones que he comentado.

### A.
Entiendo, voy a intentar aplicar lo que dices a los casos de pedido / carrito
Sobre la composición padres hijos, otra opción sería:

1. Creamos el padre a través de primitivas
2. Cramos los hijos mediante un método addPartidas / addLineas del padre al que pasamos ¿primitivas o instancias de entidades hijas?

Esto tiene la ventaja de, en el caso de pedidos, por ejemplo, permitir calcular datos de la cabecera (totales, etc) al incluir una nueva línea.

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

- Desde eneboo/pineboo, aquí podemos usar una función de obtener serial y pasar el dato.
- Desde quimera. Aquí, mejor que obtenerlo en el cliente, hacemos que sea la API (la típica función _post_) la que añada el Id. Esto no es lo ideal pero ahorra llamar desde el cliente para saber cuál es el siguiente serial, y mantenemos la "pureza" de los casos de uso.

¿Te parece bien?

### J.
Desde eneboo/pineboo OK.
Desde quimera me parece mal, porque:
	1. Obliga a crear un controller (Post) específico para quimera, que será exactamente igual que los demás, pero creará y devolverá un ID.
	2. El controller debería saber cual es el repositorio y pedirle un Id. Si esto se cambiase a otra estructura, dejaría de funcionar, porque el getNextId es propio del repo de eneboo.
	3. No te permite hacer optimistics updates. Es decir, llamar a la API de creacion, y añadir tu agregado sin necesidad de esperar a que te devuelvan si todo ha ido OK o no y recibir los datos que has creado.

¿Que opciones tenemos? Pocas y no sencillas
	1. Migrar de serials a uuids
	2. Que siempre se llame con un uuid y que el servidor guarde una relación entre uuids y serials

No sabría que hacer aquí porque no parecen opciones viables.

### A.
Lo de los uuids lo dejamos para la fase 2. Creo que meternos ahora en esto es abrir otro frente, y ya tenemos bastantes.

Creo que lo hacemos en quimera como he propuesto, así los contextos están limpios de esta mala práctica y tenemos localizado el lugar donde hacemos la trápala (en la API de Quimera) cuando vayamos a cambiar a uuid o se nos ocurra algo mejor.

## Testing TestingPersistence

### J.

¿Puede ser que se este creando una funcion cleanupDB por cada suite de tests? Esto no lo veo para nada. ¿Que es BooEngine? ¿Como va la segunda fase de esto?

### A.

Esto está a medio, el setupDB lo debería hacer el módulo de test una sola vez cada ejecución.

También quiero poder hacer _qs-task all:e2e_ y probar uno tras otro todos los proyectos, mostrando un resumen al final. Aquí sí habría que hacer un setupDB por cada proyecto.

BooEngine es una clase para ayudarnos capturar y memorizar los metadatos de cada BD, ahora mismo en flfiles de la BD _test_. Eneboo y Pineboo tienen métodos distintos, de ahí el nombre y los dos ficheros.

De la segunda fase, Jose ha creado ya un comando para crear la BD, me falta probarlo. Lo de guardarlas en un único lugar (eneboo y pineboo) no parece fácil, no creo que sea un problema grave de todas formas. Me falta juntar las piezas.

### J.
Ok. Dejamos esto aquí hasta que podamos hacerlo todo.
En cuanto al `qs-task all:e2e` se puede hacer ya, concatenando comandos. Ej: `qs-task mon:e2e && qs-task gan:e2e && qs-task otro:e2e`
Para el setupDb si que habría que añadir un parámetro al `qs-test` que fuese "preload" o algo así. Ej: `qs-test monterelax unit --preload ./preload.qs` (no recuerdo como era la sintaxis) y ahí es donde irían los hooks generales (beforeAll, beforeEach, etc...) que se aplican a todos los tests y también podría ir la función setupDb.

### A.
Voy a probarlo como dices. Una vez eliminemos los dichosos debugs deben salir los resultados uno tras otros. Si luego hacemos una versión para solo indicar si el proyecto entero pasa o no pasa, podemos hacer el `qs-task all:e2e` y ver algo así como:
MON [OK]
SAN [OK]
EGI[KO!]
y luego ya ir a los que fallen a ver qué pasa