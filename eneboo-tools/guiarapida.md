# Gestión de funcionalidades y proyectos en git

## Instalar y configrurar eneboo-tools

Antes de empezar debemos tener instalado y configurado correctamente [eneboo-tools](./index.md)

## Preparar extensión para hacer cambios
    
    - Borramos el directorio build de la extensión
    - eneboo-assembler build extension src
    - eneboo-assembler save-fullpatch extension

## Generar parche y aplicarlo a final sin escuchador

    - Hacemos cambios
    - eneboo-assembler save extension

## Generar parche y aplicarlo a final con escuchador

    - eneboo-assembler save-auto extension
    - vamos haciendo cambios y se van aplicando sin ejecutar nada más

## Mezclar cambios con funcionalidadPadre

    - Borramos build de funcionalidadPadre
    - eneboo-assembler build funcionalidadPadre src
    - eneboo-assembler save-fullpatch funcionalidadPadre

## Subir a git

Antes de subir a git configurar .gitignore para no subir carpetas build
El fichero gitignore debe estar en la raiz de funcionalidades y debe incluir la lína **/build.


### Más

  * [Volver al Índice](./index.md)