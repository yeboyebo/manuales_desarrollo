# Eneboo
---------------------------
## Cómo mostrar el icono de eneboo en el dock del escritorio

Para mostrar el icono en ubuntu 20.04 de eneboo (o cualquiera que no aparezca) hay que crear un fichero dentro de la carpeta *.local/share/applications/* de tu home.

Este fichero debe de contener lo siguiente (cambiar la ruta del instalable y del icono)

El nombre del fichero tiene que ser *nombre_app.desktop*, para el caso de eneboo sería *eneboo.desktop*.
```txt
[Desktop Entry]
Type=Application
Name=Eneboo
GenericName=Eneboo
X-GNOME-FullName=Eneboo
Exec=/opt/eneboo-v2.5.7-dba/bin/eneboo
Icon=/usr/share/icons/eneboo.png
StartupWMClass=eneboo
```
  
### Más

  * [Volver al índice de manuales](../README.md)
