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

### Más

  * [Volver al Índice](./index.md)
