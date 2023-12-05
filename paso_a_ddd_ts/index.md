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

entre objetos de infraestructura y de negocio. Ejemplos: Dinero.ts <> EnvironmentArranger.ts

### Las primitivas no tienen interfaces:
```js
static fromPrimitives(primitives: any): VentaTpv {
    ...
}
```
### Explicar interfaz Primitives
¿Ficheros independientes? ¿independientes en carpeta primitives? ¿incluir en fichero de entidad junto con *Props (src/contexts/ventas/ventatpv/domain/VentaTpvCliente.ts)?

Mothers: los métodos _basico_ usan primitivas parciales (¿crear un nuevo tipo _PartialPrimitives_, usar _any_?)

### DateTimeValueObject
Es lioso (src/contexts/ventas/ventatpv/tests/domain/VentaTpvExpedicionMother.ts)

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


### Eventos necesitan más libertad de datos
(quitar _| any_ de aggregateRoor.ts > record)

### Funciones asíncronas y await ¿hace falta?

## REVISADO:

### Estructura de tests ?
tests
+ domain: mothers
+ infrastructue: tests y mocks de repo
+ applications: tests de aplicación

La interfaz del repositorio es con value object



## PENDIENTE
Ejemplo de memorepo
