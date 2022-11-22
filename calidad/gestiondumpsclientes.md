# Gestión dumps clientes

Para realizar las copias de seguridad antes de una instalación de forma uniforme y no sobrecargar los servidores vamos a seguir las siguientes pautas:

- Antes de instalar hacemos un dump de la bd. El nombre debería tener el siguiente formato
```
dump_nombrebd_AAAAMMDDTHHMMSS.sql

Ej. dump_pruebas_20221121T162617.sql
```

Este es el formato con el que se crean cuando hacemos la copia desde abanq/eneboo. Si lo hacemos manualmente deberiamos darle un nombre con el mismo formato

- Una vez hecho el dump, lo comprimimos con
```
bzip2 dump_pruebas_20221121T162617.sql
```
si necesitamos descomprimirlo
```
bunzip2 dump_pruebas_20221121T162617.bz2
```

- Borramos el dump más antiguo que haya.

    NOTA: Deberíamos tener como máximo 3 o 4 dumps en cada servidor, incluyendo el que acabamos de hacer

- Si necesitamos hacer un dump para traérnoslo a nuestro equipo y no hemos hecho una instalación, después de traernos el dump lo borramos en el servidor