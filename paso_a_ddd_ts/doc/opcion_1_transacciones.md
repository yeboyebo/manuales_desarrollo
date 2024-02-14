## Controlador _CrearLineaVentaTpvPatchController_

Añadimos a la función _run_ la creación del Id de transacción, su asignación al caso de uso y la creación y el control de si se completa o no la transacción.

### TO DO:
Crear una clase TransactionalController que haga lo anterior y reciba un callback para llamar al run del caso de uso.
```ts
// TransactionalController
async runTransaction(useCase, runUseCaseCallback) {
    const transactionId = uuid.get();
    const client = await SupaTsClientFactory.createClient("olula", transactionId);
    useCase.setRequestId(transactionId);

    await client.runRawSelect("BEGIN");

    try {
        await runUseCaseCallback();

        await this.commit(client, transactionId);

        res.status(httpStatus.OK).send({});
    } catch (error) {
        console.error(error);
        await this.rollback(client, transactionId);

        res.status(httpStatus.INTERNAL_SERVER_ERROR).send({
            error: (error as Error).message,
        });
    }
}
// CrearLineaVentaTpvPatchController extends TransactionController
async run(req: Request, res: Response): Promise<void> {
    const crearLineaVentaTpv = DependencyInjection.get<CrearLineaVentaTpv>(
        "contexts.ventas.ventatpv.linea.creator",
    );
    this.runTransaction(
        crearLineaVentaTpv,
        async () => await crearLineaVentaTpv.run(req.params.ventaId, req.body)
    );
}
```

## Caso de uso _CrearLineaVentaTpv_
Añadimos una función para pasar el Id de transacción _setRequestId_ a la unit of work.

### TO DO:
Que los casos de uso hereden de _UseCase_, donde definimos _setRequestId_.

## Unit Of Work _CrearLineaVentaTpvUow_
Añadimos la función _setRequestId_, que llama a las respectivas funciones de los repos que contiene.

## Repositorios _LineaVentaTpvRepository_, etc.
Añadimos a la interfaz de los repositorios la función
```ts
setRequestId(requestId: string): void;
```
y modificamos _SupaTsRepository_ para poder modificar su cliente cuando recibe un Id de transacción (_requestId_).
```ts
// En clase SupaTsRepository
setRequestId(requestId: string) {
    this._transactionClient = SupaTsClientFactory.getClient(requestId);
}

async getClient(): Promise<SupaTsClient> {
    return this._transactionClient || (await this._client);
}
```

### TO DO:
Podemos volver a usar _SupaTsPool_ como cliente por defecto de los repositorios, así los repos que no estén en una transacción usarán el pool como antes y serán más rápidos. Esto es posible porque las interfaces de _SupaTsPool_ y _SupaTsClient_ son iguales para el uso que el repositorio les da.

## Traspaso de Id de transacción en Eventos
Si usamos InMemoryEventBus para eventos que deben procesarse en la misma transacción es necesario propagar la transacción.

### DomainEvent
Añadimos una propiedad opcional _requestId_

### DomainEventSubscriber
Añadimos una función _setRequestId_ a la interfaz.

### InMemoryEventBus
Añadimos una llamada a _setRequestId_ antes de llamar a la función _on_ que conecta con el suscriptor.

### UnitOfWork
Modificamos la publicación de los eventos para informar su propiedad _requestId_:
```ts
// Clase UnitOfWork
const eventsWithRequestId = events.map((event) => {
    event.setRequestId(this.requestId);
    return event;
});
await this.eventBus.publish(eventsWithRequestId);
```
### TO DO
Quizá crear una clase Subscriber (o usar UseCase) para no tener que crear _setRequestId_ en las clases de suscripción (similar a la clase UseCase para los casos de uso).

## Unit Of Work (Descripción)
Las clases que heredan de _UnitOfWork_ tienen como fin coordinar los repositorios que cada caso de uso necesita, para realizar la grabación de datos de forma ordenada y en un único paso (función _commit_).

También se encargan de la publicación de eventos.

Combinadas con las _TrackedEntityList_ de los repositorios permiten un manejo sencillo de las entidades usadas en un caso de uso, su obtención, persistencia y publicación de eventos.

### Pros
Uso más cómodo para el programador, con _commit_ en los casos de uso, para persistir los datos y publicar los eventos.

### Contras
+ Incluye un nivel más de complejidad (esto se simplificaría bastante con el _TO DO_).

+ Hace dos cosas (grabación y publicación de eventos). Quizá habría que crear dos clases, una con cada finalidad, y envolver una en otra.

### TO DO:
Crear una única clase UnitOfWork a la que pasemos un array de repositorios desde la inyección de dependencias.
```ts
// Nuevo acceso a repos desde el caso de uso:
const linea = this.uow.repos.lineas.find("1")
```

## Tracked Entity List
El objetivo de TrackedEntityList (TEL) es permitir tratar los repositorios como colecciones, habilitando métodos add, remove, etc., y controlando el estado (_new_, _dirty_, _deleted_) de sus elementos.

Aunque puede usarse de forma independiente, la hemos ligado a algunos repositorios para probar su uso.

Los repositorios contienen una TEL en la que registran las entidades que cargan, haciendo una copia de las mismas.

Cuando se llama a la función _flush_ de una TEL, ésta sabe qué elementos son nuevos (se añadieron con _add_), cuáles se borraron (se eliminaron con _remove_) y cuáles se han modificado (son distintos a su copia).

### Pros
Uso más cómodo para el programador, con _add_ y _remove_.

No sería necesario upsert, ya que sabemos qué elementos son nuevos y cuáles están modificados.

Una ventaja añadida de la TEL es que al explicitar el borrado de un elemento con _remove_ se puede llamar en ese momento a la función _recordDeleted_ (que podría pasar a la clase abstracta _AggregateRoot_), haciendo que no se olvide nunca esto.

### Contras
Es necesario para el programador saber que el repo contiene una TEL, y distinguir cuándo está buscando en la BD (con _find_, por ejemplo), y cuándo en la TEL que solo contiene las instancias cargadas o incluidas con _add_ (_findById_).

## TO DO
Bajar TEL a Repository para que todos los repositorios la puedan usar y simplificar.