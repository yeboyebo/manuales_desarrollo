# Paso a DDD
---------------------------

## Paso a tres niveles
El objetivo es desplazar toda la lógica de negocio a la capa de dominio / servicios / API, de forma que esta sea común a los clientes web y Eneboo, y pueda comenzar a ser refactorizada.

### División de scripts en carpetas / capas:
* Scripts: Scripts legacy
* Domain: Entidades y value objects.
* RestAPI: Ficheros _schema.py y _api.py
* SQLRepository: Ficheros de repositorio

### Uso de delegate commit
La nueva versión de eneboo permite llamar a la API para cada commitBuffer automático (cierre de formulario), con lo que se puede llamar a una función común que haga el commit en servidor y ejecute el código traducido.

[Más...](./delegate_commit.md)

Las tareas para este punto serían:
* Incluir una función por defecto *delegateCommit* en cada módulo.
* Identificar las llamadas que no deben hacerse con la función por defecto para crear sus correspondientes agregados (p.e. *facturascli / lineasfacturascli*) y llamar a su interfaz en lugar de a la de la tabla.

### Llamadas explícitas a la API desde eneboo
Se localizan, refactorizan y sustituyen las funciones complejas de modificación de datos (copia de documentos, paso de un documento a otro, etc.) para ser ejecutadas en servidor. En general se trata de todas las llamadas del código legacy que se realizan en una transacción manual (*transaction(false)* o *sys.runTransaction()*)

[Más...](../pineboo_server_desde_eneboo/index.md)

Las tareas para este punto serían:
* Determinar las llamadas a modificar de cada módulo / acción legacy.
* Refactorizar, testear y habilitar las llamadas API para cada una de ellas.

### Transacciones
Las transacciones siguen ligadas al fichero API.py, que las abre y cierra si la función de API termina sin levantar una excepción.

Las acciones de before/afterCommit se ejecutan en servidor en los commits del código.

## Creación de aggregates
Los agregados más necesarios son los que ahora mismo realizan acciones para asegurar su coherencia que están repartidas en varios momentos del ciclo de vida de un formulario (p.e. gestión de líneas de una factura y cálculo de su total).

### LegacyEntity
Las entidades a crear heredarán de la clase *LegacyEntity*. Esta clase incluye una interfaz similar a la de un FLSqlCursor, con lo que puede inyectarse en funciones legacy que lo obtengan como parámetro, y mediante *formCURSOR.isFake(cursor)* ir añadiendo el comportamiento basado en una entidad completa y no un cursor de una tabla.

Ver por ejemplo *FacturaCli* en *facturacion/domain*.

### Creación de value objects
(por hacer)

### Cambio de afterCommits
Para pasar los *afterCommits*, hay dos alternativas:
* Si la acción que realizan está relacionada con el agregado, se cambia por una llamada explícita en el correspondiente método de la entidad principal.
* Si la acción que realizan no está ligada con el agregado, se debería levantar un evento que será procesado de forma asíncrona, fuera de la transacción. Como solución intermedia y temporal, se saca del afterCommit y se realiza una llamada explícita en la grabación, a través del repositorio.
[Más...](./after_commit.md)

## Eventos
Dejamos los eventos para la última fase. La idea es:
* Usar Rabbit MQ como gestor.
* Implementar varias colas / estados para los eventos que fallen y desarrollar un sistema / metodología de revisión de estos fallos.
* Desarrollar tests para eventos (gestión del multihilo)

## Estado final

### Capa de dominio
Con entidades y value objects, agregados

Eventos de dominio gestionados por colas. Rabbit MQ.

Gestión de errores en la capa de dominio.

### Capa de servicios
Gestiona las transacciones y orquesta cambios de la capa de dominio
### Capa SQL Repository (adaptador)
Con repositorios asociados a cada agregado
### Capa RestAPI (adaptador)
Enruta las peticiones REST y las redirige a los servicios correspondientes.
