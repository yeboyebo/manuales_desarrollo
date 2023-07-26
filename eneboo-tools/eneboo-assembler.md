# Eneboo tools / eneboo-assembler

### eneboo-assembler

#### build ( **Mezclado** )

Para mezclar un proyecto o extensión ejecutamos, por ejemplo ext0305-servcli_dtoesp:
```
eneboo-assembler build servcli_dtoesp src
```

Suponiendo que tenemos la extension en ~/extensiones/ , nos vamos a ~/extensiones/ext0305-servcli_dtoesp/ y vemos que nos ha generado una carpeta **build** , que contiene 3 carpetas **base, final y src**. Si queremos hacer cambios vamos a trabajar sobre la carpeta **src**

**OJO !!. (Versión 1.4 o sup.) PARA QUE SE MEZCLE EL QS SIMULANDO EL COMPORTAMIENTO DE LA HERRAMIENTA DESARROLLO DE YEBOYEBO, HAY QUE AÑADIR LA LINEA 'qs_extend_mode=yeboyebo', EN EL FICHERO servcli_dtoesp.feature.ini EN LA CARPETA DEL PARCHE. ESTO HAY QUE HACERLO EN EL PARCHE QUE SOLICITAMOS HACER BUILD. LAS DEPENDENCIAS DE ESTE ADQUIEREN ESTE MODO DE MEZCLADO.**


#### save-fullpatch ( **Guardar Cambios** )

Cuando hemos terminado de hacer cambios en la carpeta **~/extensiones/ext0305-servcli_dtoesp/build/src** ejecutamos:
```
eneboo-assembler save-fullpatch servcli_dtoesp
```

Este comando que hemos ejecutado, nos guardará los cambios de ~/extensiones/ext0305-servcli_dtoesp/build/src en ~/extensiones/ext0305-servcli_dtoesp/patches/servcli_dtoesp, que es donde se guarda el contenido de los parches que aportará la extensión cuando es usada en una mezcla.

#### Modificar extensión y mezclar con funcionalidad en local

Podemos realizar cambios en una extensión y probarla en nuestra funcionalidad sin tener que subir la extensión y bajar de nuevo la funcionalidad.
Para ello haremos lo siguiente:
1. Modificar la extensión. Para ello previamente hemos realizado el build y luego el save-fullpatch
2. Hacer un save-fullpatch de nuestra funcionalidad
3. Borrar la carpeta build de nuestra funcionalidad (Por ahora hay que hacer este paso a mano ya que el build si ya está creada la carpeta build no la elimina y crea.)
4. Realizar un build de nuestra funcionalidad 

#### dump ( **Genera un fichero sqlite con el contenido de final cargado.** )

Podemos generar un fichero sqlite con el contenido de build/final (si no existe se creará), con el siguiete comando:
```
eneboo-assembler dump nombre_funcionalidad ruta_fichero_sql ruta_ejecutable
```

Si no se especifica ruta_fichero_sql , se usará la carpera build/nombre_funcionalidad.sqlite3.
Si no especificamos ruta_ejecutable, se usará el "eneboo" (dará error si no está en el PATH del sistema).


### new ( **Nuevo proyecto/extensión** )

Cuando queremos crear un nuevo proyecto/extensión ejecutamos:
```
eneboo-assembler new --sort
```

Esto iniciará el asistente que irá preguntado:
```

Qué tipo de funcionalidad va a crear?
    ext) extensión
    prj) proyecto
    set) conjunto de extensiones
Seleccione una opción: ext

Código para la nueva funcionalidad: 9999

Nombre corto de funcionalidad: prueba_fun

Descripción de la funcionalidad: Descripción corta de la funcionalidad

**** Asistente de creación de nueva funcionalidad ****

 : Carpeta destino : /home/aulla/repos/gitlab/desarrollos/features/ext9999-prueba_fun
 : Nombre          : extensión - 9999 - prueba_fun 
 : Descripción     : Descripción corta de la funcionalidad 

 : Dependencias    : 0 módulos, 0 funcionalidades
 : Importar Parche : None

--  Menú de opciones generales --
    c) Cambiar datos básicos
    d) Dependencias
    i) Importar parche
    e) Eliminar parche
    a) Aceptar y crear
    q) Cancelar y Salir
Seleccione una opción: d

**** Dependencias ****

 : Módulos :

 : Funcionalidades :

--  Menú de dependencias --
    +m) Agregar módulo
    -m) Eliminar módulo
    +f) Agregar funcionalidad
    -f) Eliminar funcionalidad
    q) Finalizar edición
Seleccione una opción: +m
--  Agregar dependencia de módulo --
    flrrhhppal) recursoshumanos/principal
    fldireinne) direccion/analisis
    flforma) formacion/Principal
    flcontmode) contabilidad/modelos
    flcontppal) contabilidad/principal
    flcontinfo) contabilidad/informes
    flcrm_mark) crm/marketing
    flcrm_ppal) crm/principal
    flcrm_info) crm/informes
    flimpdatos) sistema/impdatos
    flfastcgi) sistema/flfastcgi
    flgraficos) sistema/graficos
    flar2kut) sistema/ar2kut
    flcontacce) sistema/controlacceso
    flcolaproc) colaboracion/procesos
    flprodppal) colaboracion/produccion/principal
    flprodinfo) colaboracion/produccion/informes
    flcolagedo) colaboracion/gesdoc
    flcolaproy) colaboracion/proyectos
    flfactteso) facturacion/tesoreria
    flfactalma) facturacion/almacen
    flfactppal) facturacion/principal
    flfactinfo) facturacion/informes
    flfacthora) facturacion/controlhoras
    flfact_tpv) facturacion/tpv
    flfacturac) facturacion/facturacion
    vivppal) viveros/principal
    auvivinf) viveros/informes
    auvivcc) viveros/carry'scc
    obrasinfo) obras/obrasinfo
    obrasppal) obras/obrasppal
    flcontsii) contabilidad/sii
    flsatprincipal) sat/principal
    flsatinformes) sat/informes
    intertiendas) intertiendas/Principal
    auligappal) ligas/principal
    flfactcomis) facturacion/flfactcomis
Seleccione un módulo: flfactppal

**** Dependencias ****

 : Módulos :
    - facturacion/principal

 : Funcionalidades :

--  Menú de dependencias --
    +m) Agregar módulo
    -m) Eliminar módulo
    +f) Agregar funcionalidad
    -f) Eliminar funcionalidad
    q) Finalizar edición
Seleccione una opción: q

**** Asistente de creación de nueva funcionalidad ****

 : Carpeta destino : /home/aulla/repos/gitlab/desarrollos/features/ext9999-prueba_fun
 : Nombre          : extensión - 9999 - prueba_fun 
 : Descripción     : Descripción corta de la funcionalidad 

 : Dependencias    : 1 módulos, 0 funcionalidades
 : Importar Parche : None

--  Menú de opciones generales --
    c) Cambiar datos básicos
    d) Dependencias
    i) Importar parche
    e) Eliminar parche
    a) Aceptar y crear
    q) Cancelar y Salir
Seleccione una opción: a

Guardando ... 
```

**OJO!** Siempre acabamos el assistente con la opción  **a Aceptar y crear**. Seguidamente, para actualizar las extensiones disponibles ejecutamos:
```
eneboo-assembler dbupdate
```


### Más

  * [Volver al Índice](./index.md)
