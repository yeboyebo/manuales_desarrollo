# Descripción del problema

## Requerimientos para el desarrollo

### Importaciones directas por proyecto
Dado un proyecto, la importación de clases y ficheros debe ser directa siempre que se pueda, no usando el contenedor de dependencias.

### Solo usar y ver los ficheros necesarios
Dado un proyecto, solo debemos ver en el entorno de trabajo aquellos ficheros que realmente son usados por el proyecto.

## Requerimientos para el despliegue

### Solo usar y ver los ficheros necesarios
Al igual que para el desarrollo, no debemos incluir ficheros que no se usen por:
* Rendimiento.
* Protección del software de clientes.

### Un repositorio por proyecto
Tener un repositorio por proyecto facilitará su paquetización y su despliegue automatizado.

# Solución con preproceso
La solución con preproceso implica separar las carpetas de repositorio fuente y repositorio de trabajo / publicación, usando unas funciones de preproceso para mover información de uno a otro, basadas en los ficheros de dependencias.

## Repositorios y carpetas de desarrollo

### Repositorio src
Actual reposiotorio de código fuente.

No se trabaja sobre él.

Registra todos los cambios sobre el código fuente en forma de ramas y commits estándares de git.

### Carpeta de desarrollo de proyecto
Una por proyecto.

Se trabaja sobre ellas.

Se generan automáticamente desde src y sus cambios pasan automáticamente a src.

### Repositorios de proyecto
Un repositorio por proyecto o extensión.

Se generan automáticamente desde src.

Solo registran publicación de nuevas versiones a instalar.

## Pasos de desarrollo
Los pasos para el desarrollo con esta solución son:

### Creación de rama de desarro
Creación normal en una rama de desarrollo en el repositorio src.

### Creación de la carpeta de desarrollo
```sh
qs-task set-project monterelax
```
Esta tarea lee las dependencias de _monterelax.deps_ y crea una carpeta _/dev/monterelax_ basada en su contenido.

La carpeta generada debe contener todos los ficheros necesarios para ser una solución final testeable e instalable.

### Desarrollo
Desarrollo normal sobre _dev/monterelax_.

### Paso a src
Bien con un escuchador, bien con un fichero testigo, podemos detectar los ficheros cambiados en _dev/monterelax_ y pasarlos a su misma ruta en _src_.

Para ello la cabecera de los ficheros seguirá una estructura de este tipo
```js
// #DEF_DEPENDENCY ArticuloLineaPedido = venta.pedido.domain.linea.articulo
// AUTO INIT
import ArticuloLineaPedido from "(ruta obtenida de deps)" 
// AUTO END
// ...
const a = new ArticuloLineaPedido()
// ...
 ```
La función de pasar a src, que sería similar a 
```sh
qs-task save-project monterelax
```
elimina la parte _AUTO_ del fichero y copia el resto en _src_.

La orden _qs-task set-project_ usa las líneas _DEF_DEPENDENCY_ para generar las líneas _AUTO_ en cada fichero de la carpeta de desarrollo.

## Pasos de despliegue
Los pasos para el despliegue con esta solución son:

### Actualización del repositorio de proyecto
Lanzamos la siguiente orden:
```sh
qs-task publish-project monterelax
```
Esto bajará el poyecto de git, generará la carpeta de forma similar a la de desarrollo, hará un commit, y la publicará, lanzando los procesos automáticos de testeo y despliegue.

