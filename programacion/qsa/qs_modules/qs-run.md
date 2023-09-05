# QS Run

## Descripción

Es un ejecutable que permite correr un script qs como si fuese un típico script js.

## Pasos previos

- [Ir a configuración de QS Modules](./config.md)

## Ejecución

Para ejecutar un fichero debemos utilizar la siguiente sintaxis:

```sh
qs-run <ruta_fichero> [opciones] [otrosArgs]
```

Donde las opciones son:

| Opción         | Descripción                                         | Default    |
| -------------- | --------------------------------------------------- | ---------- |
| --project=name | Nombre del proyecto (conexión a bd)                 | No         |
| --env=env      | Entorno (test / staging / development / production) | production |
| --help         | Muestra la ayuda                                    |            |

Ejemplos:

```sh
qs-run index.qs --project=test arg1 arg2 arg3

qs-run contexts/ventas/application/VentaCreator.qs --project=monterelax --env=development 156.00 "00001000456"
```

- [Volver al índice](./index.md)
