# Testing

Los tests se guardan en la carpeta _tests_ de la carpeta de cada agregado.

Dentro de la carpeta tendremos la siguiente estructura:
+ __mocks__: Mocks de entidades
+ application: Test de integración
+ domain: Tests unitarios
+ infrastructure: Tests de infraestructura


## Testing features
### Filtrar los tests a lanzar (Tags)
Podemos filtrar los tests indicando etiquetas en cada uno de ellos y luego indicándolas al lanzar los tests:
```
@InProgress
Feature: Crear un nuevo pago
  In order to poder crear pagos
  As a user ...
```
```sh
bun test:features --tags=@InProgress
```
Podemos incluir más de una etiqueta con esta sintaxis (no probado):
```sh
bun test:features --tags='@Smoke or @Regression'
```

