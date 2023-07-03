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

### Servidor web(Solo produccion)

Si queremos añadir una carpeta con archivos estaticos externa al proyecto de quimera, hay que buscar el fichero de configuracion de nuestro quimera en:

```
/etc/nginx/sites-available/***.conf
```

Editamos el fichero y añadimos la siguiente linea al final del fichero, despues de location /:

```
server {
    listen ****
    ******
    location / {
       *****
    }
    location /cdn/ {
        autoindex on;
        alias {rutaCarpeta};
    }
}
```

Donde alias puede ser por ejemplo '/var/www/media/'
La carpeta tiene que tener permisos de escritura y mejor si esta ubicada en /var/www/ porque el servidor web tiene permisos en esa ubicaciono si no habria que cambiar el usuario con:

```
chown -R www-data:www-data /ruta/carpeta/
```

Location /cdn/ puede ser cualquier cosa, pero tener en cuenta que en sobreescribira cualquier url de quimera, tiene que ser algo que no se este usando para ninguna url.


### Más

  * [Volver al Índice](./index.md)
