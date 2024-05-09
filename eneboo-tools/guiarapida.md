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

## Incluir en funcionalidad padre cambios que acabamos de hacer en una funcionalidad hija

Teniendo ya el build generado de ambas funcionalidades y posicionados en la rama correcta:

    - Hacemos cambios en funcionalidadHija
    - eneboo-assembler save funcionalidadHija
    - eneboo-assembler build funcionalidadPadre src funcionalidadHija

De esta forma solo hace el build de los ficheros que hayan cambiado en la funcionalidadHija

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

## Ficheros .sh para agilizar build y save

### build.sh

Al ejecutar este fichero se realizan 2 acciones:
1. Realiza un **eneboo-assembler dbupdate**  así no hay que hacerlo manualmente evitando problemas de que se nos olvide y no se nos carguen funcionalidades y extensiones nuevas que pueda haber realizado un compañero.
2. Realiza un **eneboo-assembler build** sobre el primer parámetro que se le pase, si se le pasa un segundo parámetro realziara el build del primer parámetro pero solo cargando lo que "influya" el segundo parámetro.

Ejemplos:
1. Realizar el build de fun_guanabana
```
./build.sh fun_guanabana
```
2. Realizar el build de fun_guanabana pero solo regenerando la parte de envios_gls
```
./build.sh fun_guanabana envios_gls
```



El fichero habría que crearlo con el nombre **build.sh** con el siguiente contenido

```
#!/bin/bash
eneboo-assembler dbupdate
eneboo-assembler build $1 src $2

```
### save.sh

Al ejecutar este fichero nos realizará un **eneboo-assembler save** sobre el primer parámetro

Ejemplo: Realizar un save de fun_guanabana

```
./save.sh fun_guanabana
```

El fichero habría que crearlo con el nombre **save.sh** con el siguiente contenido

```
#!/bin/bash

eneboo-assembler save $1

```

## Ficheros paquete.sh para generar paquetes de forma ágil

Para crear un paquete de eneboo hay que realizarlo de la siguiente forma:

eneboo-packager create ruta_funcionalidad_final ruta_destino/nombre.eneboopkg

Ejemplo: Realizar un paquete de fun_guanabana y guardarlo en la carpeta subcarpeta *guanabana* de la carpeta *paquetes*

eneboo-packager create /home/usuario/git/codebase/extensiones_2.5.0/fun_guanabana/build/final /home/usuario/paquetes/guanabana/guanabana_20240509T1330.eneboopkg

Con el siguiente fichero .sh podemos acortar la síntaxis de forma que para el ejemplo anterior solamente haríamos:

./paquete.sh fun_guanabana guanabana/guanabana_20240509T1330

El primer parámetro es el nombre de la funcionalidad de la que queremos hacer el paquete
El segundo parámetro es donde se va a guardar y el nombre del paquete.

El fichero habría que crearlo con el nombre **paquete.sh** con el siguiente contenido.

```
#!/bin/bash

eneboo-packager create /home/pozuelo/git/codebase/extensiones_2.5.0/$1/build/final /home/pozuelo/paquetes/$2.eneboopkg
```
Nota: Cada usuario debe de adaptar las rutas a como las tenga en su equipo.

### Más

  * [Volver al Índice](./index.md)