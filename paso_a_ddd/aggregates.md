# Aggregates

Los _aggregates_ o agregados son entidades compuestas por una o más clases (otras entidades) sobre las que operan los casos de uso. Idealmente un caso de uso opera sobre un único _aggregate_.

Por ejemplo, si tenemos un _aggregate_ _PedidoCliente_ que se compone de las entidades _PedidoCliente_ y _LineaPedidoCliente_ no debemos crear un caso de uso que use directamente _LineaPedidoCliente_ (por ser parte del agregado) o que afecte a _PedidoCliente_ y a _FacturaCliente_ (por ser dos agregados distintos).

## Estructura
Usaremos el agregado _EjercicioFiscal_ para describir la estructura básica de un agregado real.

### Contexto
Lo primero que debemos hacer es pensar en qué contexto tiene sentido definir la estructura. En nuestro ejemplo, decidimos hacerlo en el contexto _empresa_.

La carpeta del agregado será entonces:
```sh
/contexts/empresa/ejerciciofiscal
```
La estructura típica de la carpeta del agregado es la siguiente:
```sh
(nombreagregado)
  - application
  - domain
  - infrastructure
    - mappers
    - persistence
  - test
    - application
    - infrastructure
    - persistence
    - mocks
    - mothers

```


Los ficheros que soportan la estructura del agregado

### Entidad principal (domain)
Representa la entidad principal del agregado, y contiene los métodos de creación y manipulación volcado a primitivas de sus datos.
```sh
/contexts/empresa/ejerciciofiscal/domain/EjercicioFiscal.qs
```
[Más sobre entidades](./entities.md)

### Casos de uso (application)
Los casos de uso son clases usadas para orquestar lógica de negocio que afecta a varios agregados (la que afecta a solo un agregado debe estar _dentro_ del agregado).

También representan los puntos de acceso a las funciones _CRUD_ (_create_, _read_, _update_, _delete_) del agregado.

Que afecte a varios agregados no quiere decir que modifique varios agregados, como hemos comentado, solo debe modificar uno.

```sh
/contexts/empresa/ejerciciofiscal/application/CrearEjercicioFiscal.qs
```
[Más sobre casos de uso](./use_cases.md)

### Repositorios (infrastructure / persistence)
Los repositorios son las clases responsables de guardar, modificar y recuperar agregados desde y hacia un sistema de persistencia (p.e. una base de datos).
```sh
/contexts/empresa/ejerciciofiscal/infrastructure/persistence/EjercicioFiscalRepository.qs
```
[Más sobre repositorios](./repositories.md)

### Mappers (infrastructure / mappers)
Los mappers son clases que cargan y vuelcan (_load_ / _dump_) la información desde el sistema de persistencia a primitivas del agregado.

Los mappers son utilizados por los repositorios para abstraer el paso de agregado de dominio a la capa de persistencia, y permiten combinarse para, en función de las dependencias activas, guardar unas estructuras u otras.

```sh
/contexts/empresa/ejerciciofiscal/infrastructure/mappers/EjercicioFiscalMapper.qs
```
[Más sobre mappers](./data_mappers.md)


### Tests de Casos de uso (test/application)
Los tests de casos de uso son ficheros que contienen una o varias funciones de tests que comprueban que el caso de uso funciona de forma correcta para sus distintas variantes.

```sh
/contexts/empresa/ejerciciofiscal/test/application/TestCrearEjercicioFiscal.qs
```
[Más sobre tests de casos de uso](./testing_use_cases.md)
