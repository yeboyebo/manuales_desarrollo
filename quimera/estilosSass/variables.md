### Crear fichero SCSS
En cada App hay finchero app/styles/_variables.scss

Para añadir una variable solo hay que respetar el formato:
--nombre-variable


 ```css
:root {
  --background-color: hsl(0deg 80% 50%);
  --main-color: #072146;
  --header-height: 47px;
  --mui-palette-menu-alternative: rgb(38, 118, 233);
}
```

Estas variables se pueden usar en cualquier fichero .style.scss con:

 ```css
.PedidosCli {
    .Title {
        color: var(--main-color);
    }
}
```

Utilizamos la pseudo-class :root para colocar las reglas en el nivel mas alto, pero tambien se podrian crear variables para alguna clase en concreto, en cualquier fichero scss, no es necesario usar siempre _variables

ver: https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties