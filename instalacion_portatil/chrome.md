  # Chrome

Primero actualizamos todos los paquetes existentes para evitar conflictos durante la instalación
```
sudo apt update
sudo apt upgrade -y
```

Antes de comenzar con la instalación debemos instalar los siguientes paquetes:

```
sudo apt install apt-transport-https ca-certificates curl software-properties-common wget -y
```

Ahora vamos a importar la clave GPC
```
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
```
Ahora debemos importar el repositorio de google chrome
```
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
```

Y por último instalamos google chrome
```
sudo apt install google-chrome-stable -y
```

  
  * [Volver al Índice](./index.md)