# Reglas documentación

Utilizaremos para documentar *Markdown* que permite crear contenido de una manera sencilla.

En el siguiente enlace hay un pequeño manual:

https://markdown.es/sintaxis-markdown/

## Estructura de página de manual
La estructura de las páginas contendrán los siguientes apartados:

### Título
Es el título de la funcionalidad que queremos explicar su uso, por ejemplo si queremos explicar como realizar una factura rectificativa, el título sería Factura rectificativa.
El título iría siempre precedido con una *#*

### Objetivo
En objetivo indicaremos en dos o tres líneas que es lo que queremos hacer en la funcionalidad que estamos explicando.
La palabra *Objetivo* iría precedido de *###* 

### Proceso
En el proceso indicaremos los pasos que hay que realizar para cumplir el objetivo de la funcionalidad. Los pasos los enumeraremos si es necesario


## Normas generales
Seguiremos las siguientes normas generales a la hora de la redacción:

### Tiempo verbal
Utilizaremos la primera persona del plural para la redacción, por ejemplo:
  ```
    Pulsaremos sobre el botón de imprimir
  ```

### Formularios o Pestañas
Para mencionar un formulario o una pestaña utilizaremos la negrita, para ello el control que queremos nombrear irá entre **, por ejemplo 
  ```
  **nombre_formulario**
  ```
  que obtendríamos como resultado **nombre_formulario**

### Campos 
Para mencionar un campo utilizaremos la cursiva, para ello el campo que queremos nombrear irá entre *, por ejemplo 
  ```
  *nombre_control*
  ```
  que obtendríamos como resultado *nombre_control*

### Imágenes
Haremos uso de imágenes cuando sea necesario. 
Las imágenes las guardaremos dentro de la carpeta *img* ubicada dentro de la ruta que está la funcionalidad, por ejemplo, si queremos utilizar imágenes en el manual de factura rectificativa, la ruta donde deben de estar las imagenes de ese manual sería:
  ```
  ERP\oficial\areafacturacion\facturascli\img
  ```
Las imágenes las crearemos con el nombre de la acción dónde se van a mostrar  
La sintáxis para utilizar una imagen será la siguiente
  ```
  ![Texto que se muestra si no se puede carga la imagen](./img/nombreimagen.png)
  ```

### Código
Para los manuales técnicos en los que tengamos que escribir código, podremos enmarcar el código entre 3 tildes abiertas ```
Por ejemplo:

```
    ``` 
    Esto es un trozo de código
    ```
  
```
Obtenemos como resultado:

``` 
  Esto es un trozo de código
```

### Enlace a WEB
Utilizaremos enlaces a webs cuando sea necesario, sólamente con escribir la dirección con http:// o con https:// se crea el enlace.
Por ejemplo
```
  http://www.google.es
```

Obtenemos como resultado:

http://www.google.es

Podemos crear enlaces a una web y utilar la palabara referencia que hemos creado, por ejemplo podemos referencias la palabra *google* a la dirección www.google.es.

Esto se haría de la siguiente forma:

```
  [google]: http://www.google.es
```
[google]: http://www.google.es

Una vez que hemos creado la referencia podemos utilizar la palabra google en nuestro manual y aparecerá como un link.
Por ejemplo
```
  Buscaremos en [google] información sobre....
```

Obteniendo como resultado:

Buscaremos en [google] información sobre....

### Más

  * [Volver al Índice](./index.md)