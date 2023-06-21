# ANYDESK
Actualizamos repositorios:
```
sudo apt update

sudo apt upgrade
```

Añadimos la fuente a la lista de proveedores de confianza:
```
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -

echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list

sudo apt upgrade
```

Para instalar ejecutamos:
```
sudo apt install anydesk
```
Para versiones de Ubuntu posteriores a 22.04 esta incluida, puede que tengamos un problema para compartir la imagen, Comprobamos con el siguente comando:
```
echo $XDG_SESSION_TYPE
```
Si nos devuelve 'wayland', debemos descomentar una linea del fichero '/etc/gdm3/custom.conf'

```
WaylandEnable=false
```
Comprobamos de nuevo:
```
echo $XDG_SESSION_TYPE --> "La salida debe ser 'x11'"
```
Debemos reiniciar el sisatema para que los cambios sean efectivos.

  * [Volver al Índice](./index.md)

Si en Ubuntu 22.04 no arranca, hay que instalar una versión anterior de anydesk. Sigue estos pasos:

```sh
wget http://ftp.us.debian.org/debian/pool/main/p/pangox-compat/libpangox-1.0-0_0.0.2-5.1_amd64.deb
sudo apt install ./libpangox-1.0-0_0.0.2-5.1_amd64.deb
```