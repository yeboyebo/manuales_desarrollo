# Herencia

## Implementar la herencia
Debemos declarar la clase padre la primera del script, y usar luego _extends_:
```js
Mapper = formImport.from("contexts/shared/infrastructure/Mapper.qs")
CursorClienteMapper = formImport.from("contexts/ventas/cliente/infrastructure/CursorClienteMapper.qs")


class CursorClienteMapperIvaNav extends Mapper {
    
    //...
}
CursorClienteMapperIvaNav
```

## Restricciones

### Layer Supertype
Debemos limitar el uso de herencias a clases muy básicas (Layer Supertype. https://martinfowler.com/eaaCatalog/layerSupertype.html).

Tipos que tienen heredan de una clase padre:
+ Value Objects heredan de _ValueObject_.

### Falta de contexto
Las clases base no pueden acceder a otras clases o librerías (_formARRAY_, _QList_, etc.)