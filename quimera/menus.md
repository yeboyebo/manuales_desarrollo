# Quimera / Menús

Las aplicaciones de Quimera tienen dos menús por defecto, el menú de aplicación, a la izquierda, y el menú de usuario, a la derecha

## Añadir opciones al menú de aplicación

En *static/appmenu.js* añadimos un nodo como el del ejemplo:
```js
export default parent => ({
  ...parent,
  areaClientes: {
    title: 'Área de clientes',
    items: {
      ...parent?.areaClientes?.items,
      areaClientes: {
        rule: 'AreaClientes:visit',
        title: 'Pedidos',
        icons: ['receipt', 'outlined_flag'],
        color: 'warning',
        variant: 'main',
        url: '/areaclientes/pedidos'
      },
    },
  }
})
```

En el archivo *index.ts* de la extensión donde añadamos la opción de menú debemos comprobar que se añada la clave menus al objeto exportado:

```js
import AppMenu from './static/appmenu'
import UserMenu from './static/usermenu'

...
  menus: {
    app: AppMenu,
    user: UserMenu,
  },
...
```
Si solo añadimos opciones de un tipo (aplicación o usuario) no es necesario añadir la otra clave.

## Control de acceso
La clave *rule* de cada item del menú indica la regla de acceso que se aplicará para mostrar o no la opción en el menú.

Si ninguno de los items de una misma sección de menú debe ser mostrado, la propia sección se oculta, evitando mostrarse sin opciones.

Más sobre control de acceso [aquí](/reglas_acceso/index.md).


### Más

  * [Volver al Índice](./index.md)
