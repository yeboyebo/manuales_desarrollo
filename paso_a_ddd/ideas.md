# IDEAS

Apartado para ir anotando la descripción y uso de la carpeta Contexts

## Tipos de clases

### Value Objects

### Entidades

Su constructor nunca admite parámetros?
Todas las entidades se construyen:

- Con el método estático _fromPrimitives_ (carga desde BD, etc.)
- Con el método estático _create_ (nueva creación), o con clase _Builder_ / _Creator_

### Respositorios

### DataMappers

### Clases de test _.test_, _.itest_

### Clases Mother para tests

### Clases de caso de uso (aplicación)

.

---

Build - Momento de la creación

Totalize, Calculate - Actualización

---

---

## Composición

Para construir una clase con otra(s) los pasos son:

- Declarar una propiedad que identifica la clase componente
- Inicializar a null la clase en el constructor
- Definir los _getters_
- Definir _fromPrimitives_ y _toPrimitives_
- Definir _equals_, si lo hay
- Definir _create_, orquestándolo en función de los casos y los componentes

---

Siguiente:

Ver caso de codEnvio en CondicionesVenta para extensión tienda_nativa

Estructura de carpetas: ¿?

Mejor la primera porque:

- Permite borrar lo que no se usa en base a las dependencias del proyecto
- Permite abrir el code con únicamente las carpetas necesarias

* Base
  - Context1
  - Context2
* Tienda_nativa

  - Context1
  - Context2

* ...Domain
  - CondicionesVenta
  - CondicionesVentaCarritoTiendaNativa
  - CondicionesVentaCarritoMON
