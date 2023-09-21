# Cloudflare (Tuneles para ver Apps en desarrollo desde internet)

## 1. Download and install cloudflared

Abrimos un terminal y nos posicionamos en una carpeta con permisos para almacenar ficheros. Descargamos e instalamos con el siguiente comando:
```
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && sudo dpkg -i cloudflared-linux-amd64.deb
```
## 2. Uso de Cloudflare
Para utilizarlo, en primer lugar arrancamos nuestra aplicación y lanzamos:
```
cloudflared tunnel --url http://localhost:5173
```
La url debe ser la url de tu aplicación en función de la configuración de  dominio y puerto que utilices.

Una vez ejecutado, verás un log en el terminal en el que te informa de la url que ha generado para el tunel desde la que se puede acceder a tu aplicación.

![alt text](./img/tunel_cloudflare.png)

Puedes encontrar más información en la [documentación oficial](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/install-and-setup/tunnel-guide/local/)


  * [Volver al Índice](./index.md)