# Checklists de incidencias

## Al comenzar con la tarea (*Recibido*)
Copiar este texto en la descripción de la tarea cuando está la incidencia está Recibida.

```txt
- Datos adicionales:
    o Solicitud de datos adicionales hecha (paso a bloqueado)
    o Realizar llamada aclaratoria
    o Preguntar al desarrollador original
    o N/A
- Entendemos la incidencia y somos capaces de reproducirla.
- Email de confirmación de recepción enviado (plantilla)
- Calificar impacto sobre el cliente (sistema de hashtags)
- Crear nuevos tests a pasar
- Asserts
- Controles redundantes a implementar
- Si contine un jasper probar con versión 6.16.0 de eneboo-reports y actualizarla en el cliente si no la tiene actualizada
- Identificar documentación a modificar / generar
```

El desarrollador comprueba que comprende el problema y recoge los datos necesarios para poder resolver la incidencia.
Debemos establecer la prioridad de la tarea y su **Fecha de entrega** según la prioridad:
- P1. Prioridad Alta. El cliente no puede trabajar. La **Fecha de entrega** debe ser hoy.
- P2. Prioridad Media. Es importante pero no impide que sigan trabajando. La **Fecha de entrega** debe ser de 3 días
- P3. Prioridad Baja. La **Fecha de entrega** debe ser de 5 días.

Debemos dejar la fecha de ejcución vacía

## Para pasar a *En Resolución*
La persona que valida y completa la checklist indicando su código:
```txt
NIK Datos adicionales: N/A
NIK Entendemos la incidencia y somos capaces de reproducirla.
NIK Email de confirmación de recepción enviado (plantilla)
NIK Calificar impacto sobre el cliente (sistema de hashtags)
NIK Tests_
    - Test 1
    - Test 2
NIK Asserts: N/A
NIK Controles redundantes a implementar: N/A
NIK Si contine un jasper probar con versión 6.16.0 de eneboo-reports y actualizarla en el cliente si no la tiene actualizada
NIK Documentación:
    - https://github.com/yeboyebo/manuales_publicos/tree/master/extensiones/igic_canarias)
```
Añade los siguiententes puntos de verificación:
```txt
- Cambio instalado y probado (Pasar a revisión cliente si es el cliente quien debe confirmar la prueba)
- Correo de confirmación enviado (plantilla)
```
Debemos dejar la fecha de ejecución vacía

## Para pasar a *Bloqueado*
Si no podemos continuar con una tarea por falta de información, por no poder probar, porque necesitamos ayuda... Esa tarea pasa a **Bloqueado**. Al pasarla debemos especificar en **Fecha de ejecución** la fecha en la que la bloqueamos

## Para pasar a *Revisión cliente*
Cuando una tarea está finalizada e instalada pero necesitamos la confirmación del cliente para darla por resuelta debemos pasarla a **Revisión cliente**. Al pasarla debemos especificar:
-  En **Fecha de ejecución** la fecha en la que realizaremos la siguiente acción en caso de que no obtengamos respuesta del cliente.
- Un comentario con la acción a realizar. 
Ej. Fecha de ejecución: 25/10/222 Comentario: Volver a preguntar al cliente si ha podido probarlo. Significa que el dia 25, si no hemos obtenido respuesta, debemos voler a preguntarle al cliente y establecer una nueva fecha de ejecución y una nueva acción en el comentario.

## Para pasar a *Resuelto*
Hay que marcar como hechos los puntos de tests, etc.
- Las tareas de tests, asserts, controles están realizadas
- La documentación está generada
- El cambio está instalado y funcionando: Probar si es posible, pedir prueba a cliente y bloquear si no lo es
- El correo de resolución de incidencia (plantilla) está enviado

Hay que establecer en **Fecha de ejecución** la fecha en la que se da por resuelta