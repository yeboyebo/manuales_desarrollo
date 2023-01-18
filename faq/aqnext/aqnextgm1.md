# Aqnext en servidor Grupo Mixto 1

- Conectamos al servidor por ssh. Los datos están en passmanager como GrupoMixto1 (aqnext). Debemos conectar con -X para poder ejecutar el mantver

- Bajamos la funcionalidad de abanq con la que vayamos a trabajar. Para ello ejecutamos desde el home/lorena/ ./eneboo. Conectamos con la base de datos de desarrollo con el usuario lorena

- Para ejecutar mantver seguiremos los siguientes pasos:
```
cd /var/www/django/devinst
source bin/activate
cd aqnext/mantver/
python3 mantver.py
```
El token que debemos usar está en el passmanager del GrupoMixto1

- Buscamos y bajamos la funcionalidad que vayamos a utilizar

- Antes de ejecutarla debemos configurar la conexión con la base de datos que vayamos a utilizar. Puede ser una bd en nuestro equipo. 
Debemos configurar los datos de acceso en /var/www/django/devinst/locals/
Editamos el fichero que corresponda a nuestra funcionalidad y establecemos los datos

Si queremos utilizar una base de datos de nuestro equipo en host debemos establecer la IP de la VPN de yeboyebo.

- En nuestro equipo hacemos ifconfig y utlizamos la ip de la conexión tun0. Es posible que al desconectar y conectar la VPN esta IP cambie y tengamos que volver a configurarla en el fichero .local

- Una vez hecho esto en mantver pulsamos Arrancar Servidor

- Una vez arrancado en otra consola conectada a grupoMixto1 ejecutamos google-chrome y en el navegador ponemos http://127.0.0.1:8000/
