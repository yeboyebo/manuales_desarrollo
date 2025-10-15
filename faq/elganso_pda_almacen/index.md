# Conectar servidor de aplicacion pda almacen de Elganso

Hay que conectar desde cualquier maquina de la red de Elganso como

```
ssh infosial@oerp.elganso.com
```

Si no se tiene acceso a oerp conectar primero a dev y desde ahi a oerp

```
ssh root@dev.elganso.com
```

Y finalmente hay que conectar desde la IP de la VPN

```
ssh elganso@172.26.15.13
```

Una vez conectado como elganso lo ideal es hacer un sudo su, que es donde estan todos los comandos en history

# Gestionar aplicacion

La aplicacion se encuentra en /var/www/web/ERPYB/:

Aqui tenemos dos carpetas importantes src donde esta la logica y log donde se guardan ciertos logs especificos.

Para arrancar/parar la aplicacion se hace con supervisorctl:

```
sudo supervisorctl status/start/stop django
```

Hay dos ficheros de log relacionados con este servicio que muestran la consola de la aplicacion estan ubicados en :

```
/var/log/django.out.log
/var/log/django.err.log
```

# Tener en cuenta

En esta maquina se despliega una copia de la central

```
psql pda_elganso -u elganso - W
```

Esto puede hacer que se llene la memoria de la maquina por eso si no funciona la aplicación hay que comprobar primero con df -h el estado del disco, si esta lleno se pueden intentar borrar los ficheros de log ya mencionados si son muy pesados o hablar con andres o ivan para ver que se puede borrar.
