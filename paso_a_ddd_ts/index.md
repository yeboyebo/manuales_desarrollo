# DDD ts

---

## Índice

- [Testing](./testing.md)

### Más

- [Volver al índice de manuales](../README.md)



### nombre de primitivas = nombre de valueObject ? 
```js
return new LineaVentaTpv({
    lineaId: new LineaVentaTpvId(props.lineaId),
    //...
}
```

### Lugar donde poner los Ids más usados
Ahora en: 
src/contexts/shared/domain/

### Disinguir en

src/contexts/shared/domain/

entre objetos de infraestructura y de negocio

Dinero.ts <> EnvironmentArranger.ts

### Las primitivas no tienen interfaces:
```js
static fromPrimitives(primitives: any): VentaTpv {
    ...
}
```

### Imports
+ Todo rutas no relativas o sí cuando sea ./---
+ .js al final o nada

### Mothers y tests en tests/domain o carpeta Mothers

### Estructura de domain ?
domain
+ Events
+ Services
+ Errors
(entidades y value objects)


### Explicar interfaz Primitives

### Eventos necesitan más libertad de datos
(quitar _| any_ de aggregateRoor.ts > record)