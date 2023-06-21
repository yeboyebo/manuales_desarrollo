# IDEAS

Siguiente: Cambiar ClienteCalculator por ClienteCreator

Apartado para ir anotando la descripción y uso de la carpeta Contexts

## Tipos de clases

### Value Objects

Al ser inmutables, se construyen principalmente con llamadas al constructor de la clase indicando todos los datos necesarios (no es cierto, se pueden construir desde un create).

### Entidades

Su constructor nunca admite parámetros?
Todas las entidades se construyen:

- Con el método estático _fromPrimitives_ (carga desde BD, etc.)
- Con el método estático _create_ (nueva creación), o con clase _Builder_ / _Creator_

Dado que en qsa hay un problema en los métodos estáticos cuando creamos una instancia de la clase local, por la que _new this()_ y _new Nombre_clase()_ funcionan cada una de ellas solo en el caso de que se las llame de forma estática o dinámica:

- _new this()_ solo funciona con _Clase.metodo_estatico()_
- _new Nombre_clase()_ solo funciona con _instancia.metodo_estatico()_

Siempre usaremos la segunda opción, porque el gestor de dependencias siempre nos devuelve instancias de clases.

Llamaremos _nombreClaseFactory_ a las instancias que únicamente nos sirven como constructores de otras instancias. Las funciones de creación podrán ser extraídas a una clase Factory propiamente dicha más adelante si su complejidad sube.

### Respositorios

### DataMappers

### Clases de test _.test_, _.itest_

### Clases Mother para tests

### Clases de caso de uso (aplicación)

.

---

Build - Momento de la creación

Totalize, Calculate - Actualización

---

---

## Composición

Para construir una clase con otra(s) los pasos son:

- Declarar una propiedad que identifica la clase componente
- Inicializar a null la clase en el constructor
- Definir los _getters_
- Definir _fromPrimitives_ y _toPrimitives_
- Definir _equals_, si lo hay
- Definir _create_, orquestándolo en función de los casos y los componentes

---

Siguiente:

Ver caso de codEnvio en CondicionesVenta para extensión tienda_nativa

Estructura de carpetas: ¿?

Mejor la primera porque:

- Permite borrar lo que no se usa en base a las dependencias del proyecto
- Permite abrir el code con únicamente las carpetas necesarias

* Base
  - Context1
  - Context2
* Tienda_nativa

  - Context1
  - Context2

* ...Domain

  - CondicionesVenta
  - CondicionesVentaCarritoTiendaNativa
  - CondicionesVentaCarritoMON

---

Para crear un nuevo campo en el dominio (p.e. _observaciones_ de Carrito ecommerce):

- Identificar la entidad de la que forma parte (p.e. _condiciones_)

- Incluir el campo en la entidad:

```js
class CondicionesVenta {
    var _observaciones
    //...

    function CondicionesVenta() {
        this._observaciones = null
        //...
    }

    function observaciones() {
        return this._observaciones
    }

    //...

    static function fromPrimitives(primitives) {
        const condicionesVenta = new CondicionesVenta()

        condicionesVenta._observaciones = primitives["observaciones"]
        //---

        return condicionesVenta
    }

    function toPrimitives() {
        return {
            "observaciones": this._observaciones,
            //...
        }
    }

    static function create(seed, context) {
        const condicionesVenta = new CondicionesVenta()

        condicionesVenta._observaciones = formDICT.getClave(seed, "observaciones", null)

        //...

        return condicionesVenta
    }

    //...
}
```

- Incluir el campo en las funciones load y dump del mapper a base de datos (si el campo se guarda en BD)

```js
class CursorCabeceraVentaMapper {
  //...

  function load(tableRowData) {

    function asignaValorPrimitive(acum, campo, tableRowData) {
      var valorCampo = tableRowData[campo]
      switch (campo) {
        //...
        case "observaciones": {
            acum["condiciones"][campo] = valorCampo
            break
        }
        //...
      }
      return acum
    }
    //...
  }

  function dump(primitives) {
    const camposTabla = formMETA.getCamposTabla(this.tabla)

    function asignaValorCampo(acum, campo, primitives) {
      var valor
      switch (campo) {
        //...
        case "observaciones": {
          valor = primitives["condiciones"][campo]
          break
        }
        //...
      }
      //...
    }
    //...
  }
}

CursorCabeceraVentaMapper
```

- Incluir el campo y su valor por defecto en los correspondientes archivos _Mother_ para los tests.

```js
//...
{
  "condiciones": {
    "observaciones": null,
    //...
  }
  //...
}
//...
```

Para extender una entidad añadiéndole nuevas propiedades en un proyecto o extender una entidad común de varias entidades derivadas (_CondicionesVenta_ a _CondicionesVentaCarritoECommerce_), crearemos dos clases:

- Clase componente (_CondicionesVentaCarritoECommerceComp_) contendrá los nuevos atributos, y las funciones asociadas (_getter_, _fromPrimitives_, _toPrimitives_, _create_)

- Clase compuesto (_CondicionesVentaCarritoECommerce_) que orquesta la composición de las dos clases:
  - _CondicionesVentaCarritoECommerceComp_
  - _CondicionesVenta_

La clase compuesto tendrá la siguiente estructura:

```js
class CondicionesVentaCarritoECommerce {
    var base
    var logistica

    function CondicionesVentaCarritoECommerce() {
        this.base = null
        this.logistica = null
    }


    //...

    function toPrimitives() {
        return formDICT.anadeClaves(
          this.base.toPrimitives(),
          this.logistica.toPrimitives()
        )
    }

    static function fromPrimitives(primitives) {
        const condicionesVenta = new this()

        condicionesVenta.base = CondicionesVentasBase.fromPrimitives(primitives)
        condicionesVenta.logistica = CondicionesVentaLogistica.fromPrimitives(primitives)

        return condicionesVenta
    }

    function equals(other) {
        return this.base.equals(other.base)
            && this.logistica.equals(other.logistica)
    }

    static function create(seed, context) {
        const condicionesVenta = new this()

        condicionesVenta.base = CondicionesVentaBase.create(seed, context)
        condicionesVenta.logistica = CondicionesVentaLogistica.create(seed, context)

        return condicionesVenta
    }
}
CondicionesVentaCarritoECommerce
```
Llamaremos _facetas_ a cada uno de los apartados de un componente de alto nivel de una entidad. _base_ y _logistica_ son facetas del componente _CondicionesVenta_, que es un componente de la entidad _CarritoECommerce_.

Solo son susceptibles de composición por extensión las clases que representan _facetas_, no las propias entidades. Así, podemos crear un _CondicionesVentaLogistica_ para ampliar nuestro componente _CondicionesVentaX_, pero no podemos ampliar _CarritoECommerce_ o _LineaCarritoECommerce_ con nuevas facetas, siempre tenemos que ampliar alguna de las _facetas_ ya existentes de la entidad, no la propia entidad.
De esta forma, la sintaxis para acceder a una propiedad de la entidad será:
```js
const valor = instanciaEntidad.componente.faceta.prop
/// Ejemplos
const valor = miCarrito.condiciones.logistica.prop
const valor = miCarrito.condiciones.base.prop
```

Lo siguientes pasos serían:

- Incluir los nuevos atributos en sus correspondientes mappers

---
## Propuestas

.value en value objects

Cambiar nombre value objects de NombreValueObject a NombreValue

Tipo de value objects para Ids, tener prop id() y no value() para cosas como _formaPago.id()_

test: expect().toBeEqualTo(), tener toString() en todos los VO

equals: tener un type para comprobar tipos en igualdad de, por ejemplo, formaPagoId ¿?

## Pendiente

- Logistica, Comercial, Impuestos, estado, ?. Divisa en Condiciones?
- Tests de repositorios
- Mothers por proyectos (primitives base)
- Ver folio de notas
- Tests de fromPrimitives en cada entidad
- Nomenclatura de ficheros application, creators, etc.

