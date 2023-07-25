# Data Mappers

## Composición a partir de varios mappers
Los mappers deben estar preparados para realizar una carga o volcado de datos a partir de la combinación de uno o varios mappers individuales
```js
class CursorClienteMapperIvaNav {
    var mappers
    
    function CursorClienteMapperIvaNav() {
        this.mappers = QList.from([
            new CursorClienteMapper(),
            this
        ])
    }

    function loadPart(primitives, tableRow) {
        primitives["regimeniva"] = tableRow["codgrupoivaneg"]

        return primitives
    }

    function dumpPart(tableRow, primitives) {
        tableRow["codgrupoivaneg"] = primitives["regimeniva"]
        tableRow["regimeniva"] = "General"

        return tableRow
    }

    function load(tableRow) {
        return MapperEngine.load(tableRow, this.mappers)
    }

    function dump(primitives) {
        return MapperEngine.dump(primitives, this.mappers)
    }
}
CursorClienteMapperIvaNav
```

Si en un proyecto se necesita la combinación de varios mappers de extensiones, se creará un nuevo mapper con la correspondiente lista de _submappers_.

### MapperEngine
MapperEngine realiza las funciones de carga y volcado combinando las funciones _loadPart_ y _dumpPart_ de los mappers.