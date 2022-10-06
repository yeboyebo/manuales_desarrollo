# Views

Las views o vistas son el elemento principal de Quimera. Generalmente representan una página de nuestra app, pero también es posible incluirlas en otras views.

Una vista es un componente de React que define un contexto de tipo useState, este contexto proporciona acceso a:
* El estado del componente vista
* Una función *dispatch* que llama al reductor de la vista. El reductor, como veremos, es la función encargada de procesar acciones y devolver el estado resultante.

## Estructura
Una vista se define en una carpeta con el nombre de la vista en formato NombreVista, que contiene los siguientes ficheros:

### NombreVista.ui.js
Define el componente HTML de la vista

### NombreVista.ctrl.js
Es la parte que gestiona el comportamiento y conecta con la API.

[Más sobre el controlador](./estructura_view/ficheros_ctrl.md)

### Más

  * [Volver al Índice](./index.md)
