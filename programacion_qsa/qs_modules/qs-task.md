# QS Task

## Descripción

Es un ejecutable que permite correr tareas como si fuesen scripts del package.json

## Pasos previos

- [Ir a configuración de QS Modules](./config.md)

## Configuración

Las tareas deben estar registradas en un fichero _qsa.task.json_ en formato "clave: comando".

Ejemplo:

```json
{
  "test:ventas:mon": "qs-test contexts/ventas/ --project=monterelax"
}
```

```
Puedes ver las tareas existentes lanzando simplemente qs-task
```

## Ejecución

Para ejecutar una tarea debemos utilizar la siguiente sintaxis:

```sh
qs-task <tarea> [otrosArgs]
```

Ejemplo:

```sh
qs-task test:ventas:mon
```

- [Volver al índice](./index.md)
