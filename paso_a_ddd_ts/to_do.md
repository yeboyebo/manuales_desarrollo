## Mapeo de domain a db record con campos calculados / estructuras anidadas
Ver _src/packages/olula/ventas/ventatpv_sm/infrastructure/SupaTsLineaVentaTpvMapper.ts_
como ejemplo de mapper completo a pasar a usar con Entity o con lo que decidamos que usamos para cargar / volcar datos.

## Repositorios o queries cacheados
Para valores de configuración que cambian muy poco (código de serie del punto de venta, ejercicio actual)

## Transaccionalidad (unit of work?)
https://medium.com/@edin.sahbaz/implementing-the-unit-of-work-pattern-in-clean-architecture-with-net-core-53efb7f9d4d

## Concurrencia (optimista o pesimista)


## Continuar TPV
+ UOW
+ No puedo borrar un pago de un arqueo cerrado
+ Repositorios obtienen la secuencia (next id)




# Desarrollo de una nueva funcionalidad (caso de uso)
## Test de aplicación
Antes de comenzar con el desarrollo del caso de uso, creamos un test de aplicación.

Ejemplo:

*src/packages/olula/ventas/ventatpv/tests/application/CambiarPagoVentaTpv.test.ts*

```ts
it("Modificamos un pago a partir de sus primitivas", async () => {
	const total = 10;
	const pagado = 8;
	const nuevoPagado = 2;
	const { venta } = await guardaVenta(total, pagado);
	const divisaId = ConfigTpv.getDivisa(venta.puntoVentaId);

	const ventaId = venta.id;
	const pagosIniciales = await repoPagos.getFromVenta(ventaId);

	const pago = pagosIniciales[0];
	pago.importe = new Dinero(nuevoPagado, divisaId);

	await casoDeUso.run(ventaId.value, {
		idpago: pago.id.value,
		cambios: PagoVentaTpvSchema.dump(pago),
	})

	const ventaGuardada = await repoVenta.mustFind(ventaId);

	expect(ventaGuardada.totales.pagado.importe()).toBe(nuevoPagado);
	// etc...
});
```
Al lanzar el test, si está bien configurado, debemos obtener el error de que el fichero que define el caso de uso todavía no existe.
```sh
src/packages/olula/ventas/ventatpv/tests/application/CambiarPagoVentaTpv.test.ts:
error: Cannot find module "../../application/CambiarPagoVentaTpv.js" from "/home/antonio/gits/temporal-server-name/src/packages/olula/ventas/ventatpv/tests/application/CambiarPagoVentaTpv.test.ts"
```
## Desarrollo de caso de uso
Desarrollamos el caso de uso hasta cumplir el test.

## Ampliación de tests de aplicación
Incluimos más tests de aplicación que aseguren el buen funcionamiento del caso de uso en todos los casos.

## Test de integración
Si el caso de uso incorpora alguna llamada todavía no definida en los repositorios de producción, crearemos el correspondiente test de integración.
```ts
it("Debe modificar pagos de una venta", async () => {
	const test = { importe: 10, multiplo: 2 };
	const pagoDeVenta1 = PagoVentaTpvMother.basico({ ventaId: "1", importe: test.importe });
	const pagoDeVenta2 = PagoVentaTpvMother.basico({ ventaId: "1" });

	await repository.save(pagoDeVenta1);
	await repository.save(pagoDeVenta2);

	const pagosAntes = await repository.getFromVenta(new VentaTpvId("1"));
	const pagoAntes = pagosAntes.find(
		(pago) => pago.id.value === pagoDeVenta1.id.value,
	) as PagoVentaTpv;

	expect(pagoAntes).toBeDefined();
	pagoAntes.importe = pagoAntes.importe.multiply(test.multiplo);
	await repository.save(pagoAntes);

	const pagosDespues = await repository.getFromVenta(new VentaTpvId("1"));
	const pagoDespues = pagosDespues.find(
		(pago) => pago.id.value === pagoDeVenta1.id.value,
	) as PagoVentaTpv;

	expect(pagosDespues).toHaveLength(2);
	expect(pagoDespues.importe.importe()).toBe(test.importe * test.multiplo);
});
```

# Desarrollo de nueva funcionalidad (conexión con el caso de uso)
## Ruta
Añadimos la ruta en el correspondiente fichero *routes.ts*.
```ts
	const borrarPagosController = container.get<BorrarPagosVentaTpvPatchController>(
		"apps.api.controllers.BorrarPagosVentaTpvPatchController",
	);
	router.patch(
		"/ventastpv/:ventaId/delete_pago",
		(req: Request, res: Response) => void borrarPagosController.run(req, res),
	);
```
## Controlador
### Dependencia de controlador
Incluimos la dependencia en el correspondiente fichero.

Ejemplo de ruta:

*src/apps/api/backend/dependency-injection/apps/application.yaml*.
```yml
  apps.api.controllers.BorrarPagosVentaTpvPatchController:
    class: apps/api/backend/controllers/ventas/BorrarPagosVentaTpvPatchController
    arguments: []
```
### Implementación
Ejemplo de ruta:

*src/apps/api/backend/controllers/ventas/CrearPagosVentaTpvPatchController.ts*.
```ts
export default class CrearPagosVentaTpvPatchController implements Controller {
	async run(req: Request, res: Response): Promise<void> {
		try {
			const crearPagoVentaTpv = container.get<CrearPagoVentaTpv>(
				"contexts.ventas.ventatpv.pago.crear",
			);
			await crearPagoVentaTpv.run(req.params.ventaId, req.body);
			res.status(httpStatus.OK).send({});
		} catch (error) {
			// console.log("ERROR", error);
			res.status(httpStatus.INTERNAL_SERVER_ERROR).send({
				error: (error as Error).message,
			});
		}
	}
}
```
### Dependencia de caso de uso
Ejemplo de ruta:

*src/apps/api/backend/dependency-injection/ventas/ventastpv/application.yaml*.
```yml
  contexts.ventas.ventatpv.pago.borrar:
    class: packages/olula/ventas/ventatpv/application/BorrarPagoVentaTpv
    arguments: ["@contexts.ventas.ventatpv.pago.creator.uow"]
```
## Test de feature
Creamos un test que compruebe el *happy path* del caso de uso.

Ruta ejemplo:

*src/apps/api/backend/tests/ventas/ventastpv/crear_pagos.feature*
```
Feature: Crear un nuevo pago
  In order to poder crear pagos
  As a user
  I want to crear pagos en ventas abiertas

  Scenario: Crear un pago en una venta abierta
    Given soy un usuario logueado
    And he recargado la configuración de TPV
    And existe una venta abierta con Id 4
    And existe un arqueo abierto para "2024-01-01" y el punto de venta "PV1"
    And yo envio un PATCH request a "/ventastpv/4/add_pago" con body:
    """
    [{
      "idtpv_comanda": 4,
      "idpago": 1,
      "fecha": "2024-01-01",
      "importe": 10,
      "idtpv_arqueo": 4,
      "codpago": "CONT",
      "codtpv_puntoventa": "PV1",
      "codtpv_agente": "1",
      "codtienda": "2"
    }]
    """
    Then the response status code should be 200
    And the response should be empty
    And existe un pago con Id 1
```

# Prueba real (desde Eneboo)

## Adaptar llamada desde Eneboo
En el código qs, usamos la llamada y parámetros definidos en el fichero *routes*.
```js
	// ...
	case cursor.Edit: {
		const cambios = formCURSOR.toDict(cursor)
		const data = {
			"idpago": idPago,
			"cambios": cambios
		}
		const respuesta = formHTTP.iface.patch("ventastpv/" + idComanda + "/update_pago", data, { api: "olula" })
		return respuesta.ok
	}
	// ...
```
## Levantar servidor de pruebas
Modificamos el fichero *.env* para indicar los parámetros de conexión a la BD real:
```sh
# SUPATS_USER=yeboyebo
# SUPATS_PASSWORD=yeboyebo
# SUPATS_DATABASE=postgres_dev

SUPATS_USER=antonio
SUPATS_PASSWORD=1
SUPATS_DATABASE=fun_nadia
```
Levantamos el servidor de pruebas:
```sh
bun dev:api:backend

$ ENV=dev bun run ./src/apps/api/backend/start.ts
 Api Backend App is running at http://localhost:5000 in dev mode
  Press CTRL-C to stop
```


# Conexión de eventos

## Emisión de eventos

### Test de emisión en casos de uso
En los tests de caso de uso incluremos la comprobación de la emisión de los eventos que esperamos.
```ts
it("Creamos un pago a partir de sus primitivas", async () => {
	///...

	expect(eventBus.wasPublished("PagoVentaTpv.creado")).toBe(1);
});
```

### Clases de eventos
Crearemos nuestros eventos en la carpeta *events* de la carpeta *shared/domain* del contexto al que corresponde el agregado que genera el evento. Ejemplo de ruta:

*src/packages/olula/ventas/shared/domain/events/PagoVentaTpvCreadoEvent.ts*.

Ejemplo de evento:
```ts
export class PagoVentaTpvCreadoEvent extends DomainEvent<PagoVentaTpv> {
	static eventName = "PagoVentaTpv.creado";
}
```

### Anotación del evento
Los eventos serán publicados al terminar el caso de uso, pero deben ser anotados para su publicación en el momento en el hecho que los dispara se producen.
```ts
	static create(props: PagoVentaTpvProps): PagoVentaTpv {
		const pago = new PagoVentaTpv(props);
		PagoVentaTpv.anotarCreacion(pago);
		return pago;
	}

	static anotarCreacion(pago: PagoVentaTpv): void {
		const event = new PagoVentaTpvCreadoEvent({
			aggregateId: pago.id.value,
			attributes: pago.toPrimitives(),
		});
		pago.record(event);
	}
```

## Suscripción a eventos
### Dependencia de la suscripción
En las dependencias del agregado que *recibirá* el evento, incluimos una dependencia con la etiqueta (*tag*) *domainEventSubscriber*.

Ruta ejemplo:

*src/apps/api/backend/dependency-injection/ventas/arqueotpv/application.yaml*.

```yml
  contexts.ventas.arqueotpv.TotalizarArqueoOnPagoVentaTpvCMB:
    class: packages/olula/ventas/arqueotpv/application/TotalizarArqueoOnPagoVentaTpvCMB
    tags:
      - { name: "domainEventSubscriber" }
```
### Testear el suscriptor
```ts
testsTotalizacion.map((test) => {
	it(test.desc, async () => {
		const importe = new Dinero(test.importe, divisaId);
		const expectedEfectivo = new Dinero(test.expected.efectivo, divisaId);
		const expectedTarjeta = new Dinero(test.expected.tarjeta, divisaId);
		const expectedVale = new Dinero(test.expected.vale, divisaId);
		const expectedEmisionVale = new Dinero(test.expected.emisionVale, divisaId);

		const arqueoId = await guardaArqueo(puntoVentaId);

		const pago = PagoVentaTpvMother.basico({
			ventaId: "1234",
			puntoVentaId: puntoVentaId.value,
			importe: importe.importe(),
			formaPago: test.formaPago,
			arqueoId: arqueoId.value,
		});
		await repoPagos.save(pago);

		await suscriptor.on(
			new PagoVentaTpvCreadoEvent({
				aggregateId: pago.id.value,
				attributes: pago.toPrimitives(),
			}),
		);
		const arqueoGuardado = await repoArqueo.mustFind(arqueoId);

		expect(arqueoGuardado.pagos.efectivo.equals(expectedEfectivo)).toBe(true);
		expect(arqueoGuardado.pagos.tarjeta.equals(expectedTarjeta)).toBe(true);
		expect(arqueoGuardado.pagos.vale.equals(expectedVale)).toBe(true);
		expect(arqueoGuardado.pagos.emisionVale.equals(expectedEmisionVale)).toBe(true);
	});
});
```
### Implementar el suscriptor
La clase suscriptora tendrá dos funciones:

**subscribedTo**: Devolverá el listado de eventos a los que está suscrita.

**on**: Implementará la acción a realizar al recibir uno de estos eventos.

```ts
export class TotalizarArqueoOnPagoVentaTpvCMB {
	constructor(private readonly uow: ArqueoTpvUow) {}

	subscribedTo() {
		return [PagoVentaTpvCreadoEvent];
	}

	async on(evento: PagoVentaTpvCreadoEvent): Promise<void> {
		const arqueoId = new ArqueoTpvId(evento.attributes.arqueoId as string);
		const arqueo = await this.uow.arqueos.mustFind(arqueoId);
		const divisaId = arqueo.pagos.divisaId;

		const formaPago = evento.attributes.formaPago as FormasPagoTpv;
		const importe = evento.attributes.importe as number;
		switch (formaPago) {
			case FormasPagoTpv.EFECTIVO: {
				const total = await this.uow.pagos.totalizarEfectivo(arqueoId, divisaId);
				arqueo.pagos.efectivo = total;
				break;
			}
			case FormasPagoTpv.TARJETA: {
				const total = await this.uow.pagos.totalizarTarjeta(arqueoId, divisaId);
				arqueo.pagos.tarjeta = total;
				break;
			}
			case FormasPagoTpv.VALE: {
				if (importe > 0) {
					const total = await this.uow.pagos.totalizarVale(arqueoId, divisaId);
					arqueo.pagos.vale = total;
				} else {
					const total = await this.uow.pagos.totalizarEmisionVale(arqueoId, divisaId);
					arqueo.pagos.emisionVale = total;
				}
				break;
			}
		}
		await this.uow.commit();
	}
}
```