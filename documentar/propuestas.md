# Propuestas y ciclo de aprobación

## Anotar la propuesta

1. Crear el proyecto en ERP

1. Crear la tarea con el nombre completo del proyecto en el tablero de *Propuestas*, dentro del proyecto *Propuestas*, en la columna *Por hacer*. Poner como fecha de ejecución la fecha actual mas 7 dias. Y poner un comentario: Propuesta envaida el [fecha del envio]

## Crear y enviar la propuesta

1. Crear documento en manuales_publicos/propuestas con nombre = *CLI_H____.md*, basado en la plantilla *propuestas/plantilla.md*

2. Ver si hay que incluir documentación en el presupuesto

3. Enviar el documento (y presupuesto opcionalmente), con la siguiente plantilla:

    Asunto:
    ```txt
    Propuesta AAAASSNNNNNN. #CLI #____ Nombre del proyecto
    ```

    Cuerpo
    ```txt
    Hola [Cliente],

    te pasamos la propuesta del desarrollo:

    #CLI #____ Nombre del proyecto

    Tienes la descripción del nuevo funcionamiento aquí:

    [https://yeboyebo.github.io/manuales_publicos/propuestas/H____.html]

    Quedamos a la espera de tu confirmación o comentarios.

    Un saludo
    ```

4. Pasar la tarea del tablero a *En revisión técnica* / *En revisión económica*.

## Enviar recordatorio

1. Cuando pasa una semana desde el envío (ha vencido su fecha de ejecución), enviar un correo de recordatorio con:

    Asunto:
    ```
     "Recordatorio propuesta...(resto de asunto original)
    ```

    Cuerpo:
    ```
    Hola [Cliente],
    
    te recordamos que esta propuesta está pendiente de aprobación. En caso de no recibir respuesta en los próximos 7 días, la propuesta será cancelada. 

    (resto del cuerpo original)

Cambiar fecha de ejcución como fecha del recordatiro más 7 días.
Poner un comentario en la tarea para indicar que se ha enviado el recordatorio y la fecha en la que se ha enviado. (Recordatorio enviado el [fecha recordatorio])

## Anular la propuesta

Cuando pasan dos semanas desde el envío (ha vencido la fecha de ejecución):
- Pasarla a cancelada (mover el documento a la carpeta de canceladas/suspendidas
- Poner la tarea de dailyjob como terminada)


## Modificar la propuesta

1. Modificar la propuesta, indicando las partes eliminadas con [~~tachados~~][NUEVO: ...]

2. Enviar el correo de actualización del documento (y presupuesto opcionalmente), con la siguiente plantilla:

    Asunto:
    ```txt
    Propuesta actualizada AAAASSNNNNNN. #CLI #____ Nombre del proyecto
    ```

    Cuerpo
    ```txt
    Hola [Cliente],

    hemos actualizado la propuesta:

    #CLI #____ Nombre del proyecto

    Para incluir los siguientes cambios:
      * [cambio 1]
  
    Tienes la descripción del nuevo funcionamiento aquí:

    [https://yeboyebo.github.io/manuales_publicos/propuestas/H____.html]

    Quedamos a la espera de tu confirmación o comentarios.

    Un saludo
    ```

1. Pasar la tarea del tablero a *En revisión técnica* / *En revisión económica*.

## Aprobar la propuesta

1. Aprobar el presupuesto en el ERP.
1. Mover la tarea del tablero *Propuestas* a *Completada*.
1. Publicar el proyecto en *dailyjob*.
1. Incluir subtarea si hay que generar documentación de cliente
1. Mover el documento de propuesta en *manuales_publicos* de la carpeta raíz a la carpeta *por desarrollar*.
1. Enviar correo de confirmación:

 Asunto:
    ```txt
    Propuesta aprobada AAAASSNNNNNN. #CLI #____ Nombre del proyecto
    ```

    Cuerpo
    ```txt
    Hola [Cliente],

    Confirmamos la aprobación la propuesta:

    #CLI #____ Nombre del proyecto

    Para incluir los siguientes cambios:
      * [cambio 1]
  
    Se planificará y realizará el desarrollo de acuerdo con las especificaciones descritas en

    [https://yeboyebo.github.io/manuales_publicos/propuestas/por%20desarrollar/CLI_HXXXX.html]

    Un saludo
    ```

## Realizar la propuesta

1. Pasar los textos de las especificaciones al manual o manuales correspondientes.
1. Mover el documento de propuesta a *propuestas/hechas*.
1. Enviar correo de notificación de desarrollo realizado.

    Asunto
  
    ```txt
    Instalación de proyecto #CLI #____ Nombre del proyecto
    ```

    Cuerpo
    ```txt
    Hola [Cliente],

    hemos instalado los cambios referentes al proyecto

    #CLI #____ Nombre del proyecto

    Tienes la descripción del nuevo funcionamiento aquí:

    [https://yeboyebo.github.io/manuales_publicos/....html]

    Un saludo
    ```

### Más

  * [Volver al Índice](./index.md)

