# QS Test

## Descripción

Es un ejecutable que permite correr los tests de qsa como si fuese jest.

## Pasos previos

- [Ir a configuración de QS Modules](./config.md)

## Ejecución

Para ejecutar los tests debemos utilizar la siguiente sintaxis:

```sh
qs-test <ruta> [opciones] [otrosArgs]
```

Donde las opciones son:

| Opción         | Descripción                         | Default |
| -------------- | ----------------------------------- | ------- |
| --project=name | Nombre del proyecto (conexión a bd) | No      |
| --mode=mode    | Modo de test (unit / integration)   | unit    |
| --help         | Muestra la ayuda                    |         |

Ejemplos:

```sh
qs-test . --project=sanhigia

qs-test contexts/ventas/ --project=monterelax --mode=integration
```

- [Volver al índice](./index.md)
