# Testing / Tests de código legacy

## Estrategia
La estrategia para que el código legacy pueda ser testeado y refactorizado consiste en realizar unos pocos tests funcionales que sirvan como red de seguridad, para luego refactorizar el contenido de cada funcionalidad usando muchos pequeños tests unitarios.

Los pasos para lograr esto son los siguientes:

### Localizar casos de uso a testear
Determinaremos funcionalidades completas que tienen sentido de negocio a testear, por ejemplo _Aprobar presupuesto_, _Crear factura_

### Limpiar los accesos al UI
Refactorizaremos el caso de uso para separar las interacciones de la interfaz de la lógica de negocio pura.

Este es un paso delicado puesto que todavía no podemos probar automáticamente que esta refactorización es correcta.

### Crear un test funcional para _happy path_ del caso de uso
En el correspondiente archivo _test_loquesea_cursor.py_ crearemos al menos un test que compruebe que el código funciona correctamente a nivel global.

### Localizar posibles tests unitarios que realizar dentro del caso de uso
Buscaremos lógica con un cierto nivel de complejidad que pueda ser extraida y probada por separado.

### Separar en lo posible acceso a base de datos de lógica de negocio
De esta forma acabaremos con una función que no depende del UI ni de la BD, que únicamente recibe una entrada y produce una salida, que es lo ideal para testear.

### Crear tests unitarios
Crearemos tests unitarios en los ficheros _test_¿?.py_

### Probar de forma manual en Eneboo / Pineboo
Hay que tener en cuenta que los tests se realizan con código traducido qsa y en una BD SQLite, siempre debemos hacer una prueba final de la funcionalidad en un entorno con UI para comprobar que no nos hemos saltado ningún paso y que la cadena de funciones que hemos refactorizado es correcta.



### Más
  * [Volver al Índice](./index.md)
