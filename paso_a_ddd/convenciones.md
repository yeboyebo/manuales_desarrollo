# Convenciones

## Clases
Usaremos _PascalCase_, con el mismo valor que el nombre del fichero, si se trata de su clase principal.
```js
class EjercicioFiscal { //...
```
## Variables y atributos
Usaremos _camelCase_.

### Atributos privados
**No** usamos el guión bajo para indicar que el atributo es privado.
```js
const v = this._miAtributo // Mal
const v = this.miAtributo  // Bien
```

### Acrónimos y siglas
En el caso de palabras formadas por iniciales (_IVA_, _IRPF_) indicamos solo la primera mayúscula. Ej:
```js
const codGrupoIVANegocio = "A" // Mal
const codGrupoIvaNegocio = "A" // Bien
```

## Funciones y métodos
Usaremos _camelCase_.

### Métodos privados
**No** usamos el guión bajo para indicar que el método es privado
```js
const v = this._miMetodo() // Mal
const v = this.miMetodo()  // Bien
```

### Acrónimos y siglas
En el caso de palabras formadas por iniciales (_IVA_, _IRPF_) indicamos solo la primera mayúscula. Ej:
```js
const g = getGrupoIVANegocio() // Mal
const g = getGrupoIvaNegocio() // Bien
```

## Ficheros y carpetas

### Carpetas
Usaremos minúsculas, sin separación entre palabras.
```sh
/contexts/empresa/ejerciciofiscal
```

### Ficheros (general)
Usaremos _PascalCase_.
```sh
/contexts/empresa/ejerciciofiscal/domain/EjercicioFiscal.qs
```
Por requerimientos legacy, los nombres de los ficheros no pueden coincicir aunque estén en distintos directorios.

### Ficheros: Entidades
Descripción de la entidad. Como el nombre debe ser único, debemos ser lo suficientemente específicos para garantizar que no se repita.
```sh
/contexts/ventas/pedido/domain/LineaPedidoCliente.qs
```

### Ficheros: Tests de casos de entidades
[Nombre del la entidad] + _.test.qs_
```sh
/contexts/empresa/ejerciciofiscal/test/domain/EjercicioFiscal.test.qs
```


### Ficheros: Casos de uso
Descripción del caso de uso con un verbo en infinitivo al comienzo.
```sh
/contexts/empresa/ejerciciofiscal/application/CrearEjercicioFiscal.qs
```

### Ficheros: Tests de casos de uso
[Nombre del fichero de caso de uso] + _.test.qs_
```sh
/contexts/empresa/ejerciciofiscal/test/application/CrearEjercicioFiscal.test.qs
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

## Otros

### Trailing comma
Dejaremos siempre la _trailing comma_ (coma al final del último elemento) en diccionarios y listas, para facilitar su ampliación.
```js
const valoresDic = {
  "valorUno": 1,
  "valorDos": 2,
}

const valoresArr = [
  "Elemento Uno",
  "Elemento Dos",
]
```
