# Abanq

IMPORTANTE: Abanq no funciona con la version de postgres 10 o superior. Si tenemos esa versión debemos utilizar [eneboo](./eneboo.md)

Desde el [siguiente enlace](https://drive.google.com/drive/folders/0B17Bz-bFR5UtMVpEV1NqVmliNWs?resourcekey=0-_iadHwU72CkRYkKmyiMJdA) descargamos el archivo comprimido para el sistema que necesitemos

Descomprimimos el archivo en **/opt/** con
```
tar -xzvf archivo.tar.gz
```

Creamos un enlace simbólico al ejecutable en nuestro home
```
ln -s /opt/developer/abanq-build/bin/abanq abanq
```

Para mostrar el icono en ubuntu si no aparece, creamos un fichero dentro de la carpeta **.local/share/applications/** del home.
El nombre del fichero tiene que ser **nombre_app.desktop**, para el caso de eneboo sería **abanq.desktop**
Este fichero debe de contener lo siguiente (cambiar la ruta del instalable y del icono)

```
[Desktop Entry]
Type=Application
Name=Abanq
GenericName=Abanq
X-GNOME-FullName=Abanq
Exec=/opt/AbanQ-2.5.0.38843/bin/abanq
Icon=/usr/share/icons/abanq.png
StartupWMClass=abanq
```


  * [Volver al Índice](./index.md)