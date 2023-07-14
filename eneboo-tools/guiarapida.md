# Gestión de funcionalidades y proyectos en git

## Instalar y configrurar eneboo-tools

Antes de empezar debemos tener instalado y configurado correctamente [eneboo-tools](./index.md)

## Después de crear o bajar nuevas extensiones actualizar

```
eneboo-assembler dbupdate
```
Esto hay que repetirlo cuando creamos una nueva extensión o bajamos una extensión que hasta ahora no teníamos en local.

## Preparar extensión para hacer cambios
    
    - Borramos el directorio build de la extensión
    - eneboo-assembler build extension src

## Generar parche y aplicarlo a final sin escuchador

    - Hacemos cambios
    - eneboo-assembler save extension

## Generar parche y aplicarlo a final con escuchador

    - eneboo-assembler save-auto extension
    - vamos haciendo cambios y se van aplicando sin ejecutar nada más

En la consola del escuchador iremos viendo los cambios detectados y aplicados.

## Mezclar cambios con funcionalidadPadre

    - Borramos build de funcionalidadPadre
    - eneboo-assembler build funcionalidadPadre src
    - eneboo-assembler save-fullpatch funcionalidadPadre

## Crear nuevo proyecto o extensión

Para crear una nueva funcionalidad utilizaremos en comando
```
eneboo-assembler new
```

La documentación completa sobre este comando podemos encontrarla [aquí](./eneboo-assembler.md)

## Generar parche por primera vez

Una vez creada la nueva funcionalidad y hechos los cambos necesarios. Para crear el parche por primera vez ejecutaremos:
```
  eneboo-assembler save-fullpatch extension
```

## Subir a git

Subiremos los cambios a git en nuestra extensión y mezclaremos con master de la forma normal ([ver política de ramas](./politicaramas.md)).

Hay que notar que las carpetas _build_ no suben al repositorio, pero todo lo demás sí, por lo que hay que evitar crear carpetas o ficheros no relacionados con el desarrollo en la carpeta local.


## Buscar dependencia inversa

Pasos para buscar en qué funcionalidades está incluida una extensión. (Es decir la Dep. inversa que teníamos en desarrollo)

- Abrimos la carpeta codebase entera en Visual Studio 
- Le damos a buscar en ficheros.
- En Buscar ponemos la extensión que queremos buscar
- En ficheros a excluir ponemos lo siguiente: *.qs,*.csv,*.xml,*.ui,Changelog,*.jrxml,*.qry,*.mtd

De esta forma buscará en los ficheros de configuración

### Más

  * [Volver al Índice](./index.md)