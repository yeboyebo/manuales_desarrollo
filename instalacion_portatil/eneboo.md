# Eneboo

- Desde [aquí](https://eneboo.org/pub/contrib/releases/) descargamos el archivo comprimido.

- Descomprimimos el archivo en **/opt/**.

- Podemos crear un enlace simbólico en nuestro home con :
```
ln -s /opt/eneboo-build/bin/eneboo yeboyebo 
```

Para mostrar el icono en ubuntu 20.04 de eneboo (o cualquiera que no aparezca) creamos un fichero dentro de la carpeta **.local/share/applications/** del home.
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

  * [Volver al Índice](./index.md)