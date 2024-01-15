# Convenciones

## Clases
Usaremos _PascalCase_, con el mismo valor que el nombre del fichero, si se trata de su clase principal.
```js
class EjercicioFiscal { ... }
```
## Variables y atributos
Usaremos _camelCase_.

### Atributos privados
**No** usamos el guión bajo para indicar que el atributo es privado.
```js
const v = this.miAtributo  // Bien
const v = this._miAtributo // Mal
```
Para los atributos que son value objects usaremos un nombre igual o similar al value object.
```js
this.fecha = new Fecha("2023-12-31")
```
Si es necesario distinguirlo de otros, usamos un sufijo
```js
this.fechaAlta = new Fecha("2023-12-31")
this.fechaMod = new Fecha("2024-01-06")
```
Si dentro de la entidad parte del nombre del value object es redundante, lo omitiremos:
```js
class VentaTpv {
  ...
  this.ventaId = new VentaTpvId(1) // Bien
  this.ventaTpvId = new VentaTpvId(1) // Mal
  ...
}
```

### Claves de primitivas
Siempre que sea posible, las claves de primitivas tendrán el mismo nombre que el atributo que mapean.
```js
const primitives = {
  "lineaId": lineaId.value(),
  ...
}
```

### Acrónimos y siglas
En el caso de palabras formadas por iniciales (_IVA_, _IRPF_) indicamos solo la primera mayúscula. Ej:
```js
const codGrupoIvaNegocio = "A" // Bien
const codGrupoIVANegocio = "A" // Mal
```

## Funciones y métodos
Usaremos _camelCase_.

### Métodos privados
**No** usamos el guión bajo para indicar que el método es privado
```js
const v = this.miMetodo()  // Bien
const v = this._miMetodo() // Mal
```

### Acrónimos y siglas
En el caso de palabras formadas por iniciales (_IVA_, _IRPF_) indicamos solo la primera mayúscula. Ej:
```js
const g = getGrupoIvaNegocio() // Bien
const g = getGrupoIVANegocio() // Mal
```

## Ficheros y carpetas

### Carpetas
Usaremos minúsculas, sin separación entre palabras.
```sh
/olula/empresa/ejerciciofiscal
```

### Ficheros (general)
Usaremos _PascalCase_.
```sh
/olula/empresa/ejerciciofiscal/domain/EjercicioFiscal.qs
```
Por requerimientos legacy, los nombres de los ficheros no pueden coincicir aunque estén en distintos directorios.

### Ficheros: Entidades
Descripción de la entidad. Como el nombre debe ser único, debemos ser lo suficientemente específicos para garantizar que no se repita.
```sh
/olula/ventas/pedido/domain/LineaPedidoCliente.qs
```

Para las entiedades que son proyecciones de otras entidades en otros contextos, usaremos el nombre de la entidad del otro contexto + el nombre del contexto local:
```sh
/olula/ventas/shared/domain/EjercicioFiscalVentas.qs
```


### Ficheros: Value Objects
Descripción del valor encapsulado.
```sh
/olula/shared/domain/Dinero.qs
```

En caso de que el valor encapsulado sea un id, el nombre terminará en _Id_.
```sh
/olula/ventas/pedido/domain/PedidoVentaId.qs
```

### Ficheros: Tests de casos de entidades
[Nombre del la entidad] + _.test.qs_
```sh
/olula/empresa/ejerciciofiscal/test/domain/EjercicioFiscal.test.qs
```


### Ficheros: Casos de uso
Descripción del caso de uso con un verbo en infinitivo al comienzo.
```sh
/olula/empresa/ejerciciofiscal/application/CrearEjercicioFiscal.qs
```

### Ficheros: Tests de casos de uso
[Nombre del fichero de caso de uso] + _.test.qs_
```sh
/olula/empresa/ejerciciofiscal/test/application/CrearEjercicioFiscal.test.qs
```

## Claves de dependencias
Las claves seguirán una estructura jerárquica, usándose el punto como caracter separador.

Tenemos más flexibilidad para crear claves que para crear nombres de fichero, por lo que adoptamos reglas que las hacen ser más sencillas y aportar más semántica (más significado).

La estructura de cada clave sigue el siguiente patrón:
_[contexto].[agregado].[capa].[partes...].[tipo]_

_Contexto_: Contexto (_bounded context_) en el que se engloba el fichero (_ventas_, _contabilidad_, etc.).
_Agregado_: Nombre del agregado principal dentro del contexto (_pedido_ en _ventas_, _asiento_ en _contabilidad_, etc.).
_Capa_: Capa en la que se ubica el fichero. Los posibles valores de capa son:
* application
* domain
* infrastructure
* test
_Partes_: Entidad o entidades que forman parte del agregado y que se definen o usan en el fichero. Esta parte es opcional y su ausencia indica que el fichero se ocupa de la parte principal del agregado. Si la parte del agregado es una colección y el fichero afecta a la condición entera, indicaremos el nombre de la parte en plural (_lineas_ por _linea_).
_Tipo_: Tipo de fichero. Los tipos están ligados a las capas:
* application
  * (Caso de uso): Para los casos de uso indicaremos un verbo en español que haga referencia al objetivo del caso de uso (_crear_, _cambiar_, _aprobar_, etc.).
  * (Caso de uso.on.Evento): Podemos incluir el sufijo _on.[evento]_ cuando el caso de uso sea disparado por un evento (_contabilidad.asientofacturaventa.application.asiento.crear.on.facturaventacreada_).
* domain
  * (sin tipo): Definición de entidad
  * repository: Repositorio
  * mapper: Mapper
  * query: Query (repositorio de solo lectura)
  * (Servicio): Para los servicios de dominio indicaremos una palabra en inglés indicando el tipo de servicio (_creator_, _calculator_, etc.).
* infrastructure
* test
  * mother: Mother


### Entidades de un agregado
_[contexto].[agregado].domain.aggregate_
```js
// EjercicicioFiscal
empresa.ejerciciofiscal.domain.aggregate
```
Entidades parciales del agregado:

_[contexto].[agregado].domain.[entidad]_
```js
// SerieEjercicioFiscal
empresa.ejerciciofiscal.domain.serie
```

### Repositorios
_[contexto].[agregado].domain.repository_
```js
// Repositorio de EjercicicioFiscal
empresa.ejerciciofiscal.domain.repository
```
Entidades parciales del agregado:

_[contexto].[agregado].domain.[entidad].repository_
```js
// Repositorio de SerieEjercicioFiscal
empresa.ejerciciofiscal.domain.serie.repository
```
### Mappers
_[contexto].[agregado].domain.mapper_
```js
// Mapper de EjercicicioFiscal
empresa.ejerciciofiscal.domain.mapper
```

Entidades parciales del agregado:

_[contexto].[agregado].domain.[entidad].mapper_
```js
// Mapper de SerieEjercicioFiscal
empresa.ejerciciofiscal.domain.serie.mapper
```
### Mothers
_[contexto].[agregado].test.mother_
```js
// Mother de EjercicicioFiscal
empresa.ejerciciofiscal.test.mother
```
Entidades parciales del agregado:

_[contexto].[agregado].test.[entidad].mother_
```js
// Mother de SerieEjercicioFiscal
empresa.ejerciciofiscal.test.serie.mother
```
En el caso de que el fichero genere una estructura de primitives en lugar de una instancia, el sufijo será _primitives.mother_, en lugar de _mother_.

### Casos de uso
_[contexto].[agregado].test.mother_
```js
// Caso de uso para crear un asiento de factura de venta
contabilidad.asientofacturaventa.application.crear

```
En caso de que el caso de uso se dispare por un evento:

_[contexto].[agregado].application.[entidad].[caso_de_uso].on.[evento]_
```js
// Caso de uso para crear un asiento de factura de venta al crearse una factura de venta
contabilidad.asientofacturaventa.application.asiento.crear.on.facturaventacreada
```

## Claves de diccionarios en general
Usaremos _camelCase_.
```js
const valores = {
  "valorUno": 1,
  "valorDos": 2,
}
```

### Excepciones
+ Nombres de campos en los mapper a repositorios legacy (usamos minúsculas).

## Idioma:
### Español para
+ Value objects y entidades creados en domain y application y sus propiedades: _Dinero.sumar_
Excepciones: 
+ Funciones estándar como equals, fromPrimitives, toPrimitives
+ Prefijos como get*, set*, find*, load*, dump*
+ Sufijos que denotan la naturaleza de la entidad o la propiedad como *Repository, *Id, etc.


### Inglés para
+ Value objects primarios usados en otros value objects: _NumericValueObject.value_


## Errores

## Eventos

## Otros


