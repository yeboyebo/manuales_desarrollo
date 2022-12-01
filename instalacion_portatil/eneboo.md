# Eneboo

- Desde [aquí](https://eneboo.org/pub/contrib/releases/) descargamos el archivo comprimido.

- Descomprimimos el archivo en **/opt/**.

## Acceso desde la interfaz gráfica
 
Para mostrar el icono en ubuntu si no aparece, creamos un fichero dentro de la carpeta **.local/share/applications/** del home.
El nombre del fichero tiene que ser **nombre_app.desktop**, para el caso de eneboo sería **eneboo.desktop**
Este fichero debe de contener lo siguiente (cambiar la ruta del instalable y del icono)

```
[Desktop Entry]
Type=Application
Name=Eneboo
GenericName=Eneboo
X-GNOME-FullName=Eneboo
Exec=/opt/eneboo-v2.5.7-dba/bin/eneboo
Icon=/usr/share/icons/eneboo.png
StartupWMClass=eneboo
```

## Acceso desde la consola

Creamos un script similar al siguiente adaptandolo a nuestra versión.

```
#! /bin/bash

export LC_ALL=es_ES@euro
export LC_CTYPE=es_ES@euro
export LC_TYPE=es_ES@euro
export LANG=es_ES@euro
export LANGUAGE=es_ES

/opt/eneboo-v2.5.8-dba/bin/eneboo
```

  * [Volver al Índice](./index.md)