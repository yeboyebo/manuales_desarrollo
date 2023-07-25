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
/contexts/empresa/ejerciciofiscal/application/CrearEjercicioFiscal.qs
/contexts/ventas/pedidocliente/application/LineaPedidoCliente.qs
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

### Entidades de un agregado
Entidades principales del agregado:

_[contexto].[agregado].domain.aggregate_
```js
// EjercicicioFiscal
empresa.ejerciciofiscal.domain.aggregate
```
Entidades secundarias del agregado:

_[contexto].[agregado].domain.[entidad]_
En _entidad_ indicaremos únicamente el texto que identifique a la entidad dentro del agregado (no repetiremos el nombre del agregado).
```js
// SerieEjercicioFiscal
empresa.ejerciciofiscal.domain.serie
```

### Repositorios
Entidades principales del agregado:

_[contexto].[agregado].domain.repository_
```js
// Repositorio de EjercicicioFiscal
empresa.ejerciciofiscal.domain.repository
```

Entidades secundarias del agregado:

_[contexto].[agregado].domain.[entidad].repository_
En _entidad_ indicaremos únicamente el texto que identifique a la entidad dentro del agregado (no repetiremos el nombre del agregado).
```js
// Repositorio de SerieEjercicioFiscal
empresa.ejerciciofiscal.domain.serie.repository
```

### Mappers
Entidades principales del agregado:

_[contexto].[agregado].domain.mappers_
```js
// Mapper de EjercicicioFiscal
empresa.ejerciciofiscal.domain.mapper
```

Entidades secundarias del agregado:

_[contexto].[agregado].domain.[entidad].mapper_
```js
// Mapper de SerieEjercicioFiscal
empresa.ejerciciofiscal.domain.serie.mapper
```
En _entidad_ indicaremos únicamente el texto que identifique a la entidad dentro del agregado (no repetiremos el nombre del agregado).

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
