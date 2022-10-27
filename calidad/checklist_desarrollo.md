# Checklists de desarrollo

## Al comenzar con la tarea (*Por hacer*)
Copiar este texto en la descripción de la tarea cuando está Por Hacer.

```txt
- Código:
  * DRY
  * Desacople lectura / proceso / escritura
  * Abstracción en models
  * No usamos bucles (map / filter / reduce)
  * Naming
- Tests que deben pasar
- Asserts
- Controles redundantes a implementar
- Si contine un jasper probar con versión 6.16.0 de eneboo-reports y actualizarla en el cliente si no la tiene actualizada
- Tareas de seguimiento
- Esquema de documentación
```

El desarrollador realiza un análisis de lo que la tarea pide y
* Crea una estructura mínima y unos esquemas de funciones a llamar, cumpliendo los criterios del apartado *Código*
* Propone tests, asserts y controles redundantes
* Crea un esquema de documentación
* Convoca reunión de paso a En progreso / envía petición

## Para pasar a *En Progreso*
La persona que valida y completa la checklist indica su código:
```txt
POZ Código:
  * DRY
  * Desacople lectura / proceso / escritura
  * Abstracción en models
  * No usamos bucles (map / filter / reduce)
  * Naming
AND Tests que deben pasar:
  - Crear un X y pulsar Y, debe pasar Z
  - Test 2
LOR Asserts: N/A
ANT Controles redundantes a implementar: N/A
LOR Si contine un jasper probar con versión 6.16.0 de eneboo-reports y actualizarla en el cliente si no la tiene actualizada
AUL Esquema de documentación:
  - https://github.com/yeboyebo/manuales_publicos/tree/master/extensiones/igic_canarias)
```

## Para pasar a *Por Instalar*
* Revisión de código
* Verificamos los puntos de tests, documentación, etc. 

Añadimos los siguientes puntos:

```txt
- Funcionalidad probada en producción o bloqueada si debe ser probada por el cliente
- Correo de instalación enviado (plantilla)
```
## Para pasar a *Completada*
Checklist totalmente completada