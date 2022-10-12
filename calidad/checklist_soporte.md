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
- Identificar documentación a modificar / generar
```

El desarrollador comprueba que comprende el problema y recoge los datos necesarios para poder resolver la incidencia.

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
NIK Documentación:
    - https://github.com/yeboyebo/manuales_publicos/tree/master/extensiones/igic_canarias)
```
Añade los siguiententes puntos de verificación:
```txt
- Cambio instalado y probado (Pasar a bloqueo si es el cliente quien debe confirmar la prueba)
- Correo de confirmación enviado (plantilla)
```

## Para pasar a *Resuelto*
Hay que marcar como hechos los puntos de tests, etc.
- Las tareas de tests, asserts, controles están realizadas
- La documentación está generada
- El cambio está instalado y funcionando: Probar si es posible, pedir prueba a cliente y bloquear si no lo es
- El correo de resolución de incidencia (plantilla) está enviado
