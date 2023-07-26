# Entities

Las entidades son representaciones de un objeto en el dominio (una factura, una línea de pedido, un ejercicio fiscal).

Las entidades se definen pues en la parte de dominio. Su implementación es una clase con la siguiente estructura.

## Constructor
El constructor toma los datos de entrada para asignarlos a cada uno de sus atributos.
``` js
    function EjercicioFiscal(data) {
        this.id = data.id;
        this.nombre = data.nombre;
        this.fechaInicio = data.fechaInicio;
        this.fechaFin = data.fechaFin;
        this.estado = data.estado;
        this.longSubcuenta = data.longSubcuenta;
        this.idEmpresa = data;
    }
```
Es deseable que el valor de cada atributo contenga no sea una primitiva sino un _value object_.

En el caso de varios atributos que estén relacionados, es bueno crear _value objects_ complejos para agruparlos y poder mover a su interior su lógica asociada (validaciones, etc.).

En el ejemplo del _EjercicioFiscal_ podríamos agrupar los atributos _fechaInicio_ y _fechaFin_ de tipo _FechaHora_ en un atributo _periodo_ de tipo _IntervaloDias_ (por hacer).

## Funciones _to / fromPrimitives_
Las funciones _toPrimitives_ y _fromPrimitives_ convierten una instancia de la entidad en primitivas (valores primarios del lenguaje como enteros, cadenas, arrays, etc.) y viceversa.

```js
    static function fromPrimitives(data) {
        return new this({
            "id": primitives.id,
            "nombre": primitives.nombre,
            "fechainicio": FechaHora.creaFecha(primitives.fechainicio),
            "fechaFin": FechaHora.creaFecha(primitives.fechaFin),
            "estado": primitives.estado,
            "longSubcuenta": new WholeNumberValueObject(primitives.longSubcuenta);,
            "idEmpresa": new EmpresaId(primitives.idEmpresa)
        });
    }

    function toPrimitives() {
        return {
            "id": this.id.value(),
            "nombre": this.nombre,
            "fechainicio": this.fechaInicio.fecha(),
            "fechaFin": this.fechaFin.fecha(),
            "estado": this.estado,
            "longSubcuenta": this.longSubcuenta.value(),
            "idEmpresa": this.idEmpresa.value
        }
    }
```
En el caso de atributos complejos, estos deben disponer también de sus funciones _to/fromPrimitives_.

## Función _create_
La función _create_ se usa para crear nuevas instancias de la entidad que todavía no están persistidas (o no van a persistirse). Prepara los datos para la llamada al constructor incluyendo lógica que facilita la creación, por ejemplo añadiendo valores por defecto.

Puede también crear la instancia a través de _fromPrimitives()_, en lugar de llamar directamente al constructor.
```js
    static function create(data) {
        return new this({
            "id": data["id"],
            "nombre": "nombre" in data ? nombre["data"] : "Ejercicio " + data["id"].value()
            "fechainicio": data["fechaInicio"],
            "fechaFin": data["fechaFin"],
            "estado": "estado" in data ? data["estado"] : "ABIERTO",
            "longSubcuenta": new WholeNumberValueObject("longSubcuenta" in data ? data["longSubcuenta"] : 10),
            "idEmpresa": new EmpresaId(data["idEmpresa"])
        });
    }
```
Puede incluir también validaciones de los datos previas a la llamada al constructur.

## Función _equals_
La función _equals_ determina si la entidad es igual a otra pasada por parámetro. Usaremos el operador = para atributos que son primitivas y el método _equals_ para atributos que son _value objects_.
```js
    function equals(other) {
        return this.id.equals(other.id) &&
            this.nombre == other.nombre &&
            this.fechaInicio.equals(other.fechaInicio) &&
            this.fechaFin.equals(other.fechaFin) &&
            this.estado == other.estado &&
            this.longSubcuenta.equals(other.longSubcuenta) &&
            this.idEmpresa.equals(other.idEmpresa)
    }
```
