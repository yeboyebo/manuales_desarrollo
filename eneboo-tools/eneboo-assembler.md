# Eneboo tools / eneboo-assembler

### eneboo-assembler

#### build ( **Mezclado** )

Para mezclar un proyecto o extensión ejecutamos, por ejemplo ext0305-servcli_dtoesp:
```
eneboo-assembler build servcli_dtoesp src
```

Suponiendo que tenemos la extension en ~/extensiones/ , nos vamos a ~/extensiones/ext0305-servcli_dtoesp/ y vemos que nos ha generado una carpeta (* buidl *) , que contiene 3 carpetas (* base, final y src*). Si queremos hacer cambios vamos a trabajar sobre la carpeta src


#### save-fullpatch ( **Guardar Cambios** )

Cuando hemos terminado de hacer cambios en la carpeta (* ~/extensiones/ext0305-servcli_dtoesp/build/src *) ejecutamos:
```
eneboo-assembler save-fullpatch servcli_dtoesp
```

Este comando que hemos ejecutado, nos guardará los cambios de ~/extensiones/ext0305-servcli_dtoesp/build/src en ~/extensiones/ext0305-servcli_dtoesp/patches/servcli_dtoesp, que es donde se guarda el contenido de los parches que aportará la extensión cuando es usada en una mezcla.

### new ( **Nuevo proyecto/extensión** )

Cuando queremos crear un nuevo proyecto/extensión ejecutamos:
```
eneboo-assembler new
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
