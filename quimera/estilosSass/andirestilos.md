## Añadir estilos CSS/SASS a view/componet

### Crear fichero SCSS
Para añadir estilos css a una vista o componente, solo hay que crear un fichero:

 ***NombreView***.style.scss



 ```html
. ***NombreView*** {

}
```

 Siempre hay que añadir un className ***NombreView*** al primer Box o Container, asi nos facilita el tener esa clase como padre para el fichero CSS.

### Importar fichero SCSS

 Hay que importar el fichero que hemos creado en la view/component 

```html
import './***NombreView***.style.scss';
```

Podemos sobrecargar componentes o vistas que tengan estilos propios, hay que tener en cuenta que no se pierde ambos se suman.
