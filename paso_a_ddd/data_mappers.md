# Data Mappers

## Composición a partir de varios mappers
Los mappers deben estar preparados para realizar una carga o volcado de datos a partir de la combinación de uno o varios mappers individuales
```js
class CursorClienteMapper {
    var condicionesMapper
    var ivaMapper
    
    function CursorClienteMapper(condicionesMapper, ivaMapper) {
        this.condicionesMapper = condicionesMapper
        this.ivaMapper = ivaMapper
    }

    function load(tableRow) {
        const primitives = {
            "idfiscal": {
                "tipo": tableRow["tipoidfiscal"],
                "codigo": tableRow["cifnif"]
            },
            "condiciones": this.condicionesMapper.load(tableRow),
            "regimeniva": this.ivaMapper.load(tableRow),
            // ...
        }

        return primitives
    }

    function dump(primitives) {
        var tableRow = {
            "tipoidfiscal": primitives["idfiscal"]["tipo"],
            "cifnif": primitives["idfiscal"]["codigo"],
            // ...
        }

        tableRow = formDICT.anadeClaves(tableRow, this.ivaMapper.dump(primitives))
        tableRow = formDICT.anadeClaves(tableRow, this.condicionesMapper.dump(primitives["condiciones"]))

        return tableRow
    }
}

CursorClienteMapper
```

Cada parte del mapper puede ser inyectada como dependencia (casos de _condiciones_ e _IVA_ en este ejemplo).
```js
const ventas = {
    "ventas.cliente.domain.mapper": {
        "dep": "contexts/ventas/cliente/infrastructure/mappers/CursorClienteMapper.qs",
        "args": [
            "@ventas.cliente.domain.mapper.condiciones",
            "@ventas.cliente.domain.mapper.iva",
        ]
    },
    "ventas.cliente.domain.mapper.condiciones": {
        "dep": "contexts/ventas/cliente/infrastructure/mappers/CursorCondicionesClienteMapper.qs",
        "args": []
    },
    "ventas.cliente.domain.mapper.iva": {
        "dep": "contexts/ventas/cliente/infrastructure/mappers/CursorIvaClienteMapper.qs",
        "args": []
    },
    //...
}
```
