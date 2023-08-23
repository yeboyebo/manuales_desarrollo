# Repositorios

Aunque podemos crear repositorios para persistir nuestros datos en distintos sistemas de ficheros, bases de datoe, etc. en nuestro caso nos concentraremos en la persistencia de datos en nuestras bases de datos legacy.

## Repositorios Cursor (legacy)
Estos repositorios usan uno o varios mappers y la clase _EnebooCursorClient_ para conseguir la persistencia.
```js
class CursorEjercicioFiscalRepository {

    var mapperEjercicio
    
    function CursorEjercicioFiscalRepository(mapperEjercicio) {
        this.mapperEjercicio = mapperEjercicio
    }

    function find(codEjercicio) {
        const primitives = EnebooCursorClient.getDataFromTableRow("ejercicios", "codejercicio = '" + codEjercicio + "'", this.mapperEjercicio)
        if (!primitives) {
            return null
        }
        return EjercicioFiscal.fromPrimitives(primitives)
    }

    function save(ejercicio) {
        const ejercicioPrevio = this.find(ejercicio.id.value())
        if (ejercicioPrevio == null) {
            EnebooCursorClient.insertNew(ejercicio.toPrimitives(), "ejercicios", this.mapperEjercicio)
        } else {
            EnebooCursorClient.updateNew(ejercicio.toPrimitives(), "ejercicios", this.mapperEjercicio)
        }
    }

}
CursorEjercicioFiscalRepository
```

