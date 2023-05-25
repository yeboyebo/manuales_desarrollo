# Quimera / Imágenes


## Imágenes internas
Debemos crear las imágenes de un proyecto en la carpeta de proyecto *public/img*.

La referenciaremos con la ruta */img/logoFinanciadoUE.jpg*

```html
<img
    src='/img/logoFinanciadoUE.jpg'
    height={100}
    alt='Financiado por la Unión Europera. NextGenerationEU'
/>
```

## Imágenes externas

### Docker

En *docker-compose.yml* añadimos a *volumes*  la siguiente variable:

```yml
- ${IMAGESVOL}:/static/images
```

Y en el *Dockerfile* añadimos las siguientes lineas para crear la carpeta dentro del docker al hacer el build:

```
RUN mkdir /static/
RUN mkdir /static/images/
```

### Enviroment

En el archivo *.env* del proyecto añadimos la ruta de la carpeta donde vamos a crear las imagenes. Utilizando la variable *IMAGESVOL*, que apuntará a la ruta */static/images* dentro del docker.

```
IMAGESVOL=/home/user/carpetaConImagenes/
```

Hay que construir de nuevo el docker(*docker-compose build*) para que los cambios sean efectivos.

### Más

  * [Volver al Índice](./index.md)
