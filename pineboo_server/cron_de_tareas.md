# Cron de tareas y servicios

Los objetivos de este proyecto son:

- Disponer de una herramienta para programar ejecuciones de Eneboo tanto de forma contínua como programada.

## Estructura

### Precondiciones

- Usar un equipo que actue como servidor y hacer estas tareas en este:

  - Instalar extensión _tareas_programadas_.
  - Instalar moreutls:
    + sudo apt install moreutils
  - Instalar eneboo.
  - Añadir en el crontab del usuario root del S.O. la siguiente linea:

    ```
    @reboot sleep 60 && xvfb-run -a /home/aulla/Eneboo/bin/eneboo -silentconn monterelax:postgres:PostgreSQL:192.168.0.108:5432:password:nogui -c flmantppal.supervisor_init -q 2>&1 | ts "[SUPERVISOR]" | ts >> /var/log/eneboo.log
    ```

Esto iniciará el supervisor a los 60 segundos de iniciar el S.O. en el servidor.

### Incluir una tarea contínua

En Area Sistema->Mantenimiento->Tareas programadas añadimos un nuevo registro de tipo Servicio.

En el campo Función especificamos la llamada que queremos realizar y la marcamos como activa.

Si hay que añadir parámetros a la llamada de la tarea, se añadirán con :parámetro:
Por ejemplo:

```
formmx_stockdiferido.activarBackground:3000
```

### Incluir una tarea programada

En Area Sistema->Mantenimiento->Tareas programadas añadimos un nuevo registro de tipo Programada.

En el campo Función especificamos la llamda que queremos realizar y la marcamos como activa.

Si hay que añadir parámetros a la llamada de la tarea, se añadirán con :parámetro:
Por ejemplo:

```
formmx_stockdiferido.activarBackground:3000
```

En los campos del formulario especificamos con valores válidos para crontab el intervalo.

### Cómo funciona

El supervisor revisa cada 60 segundos las tareas registradas. Si es de tipo "Programada", añade una nueva linea en el crontab del usuario root en el servidor, con la información facilitada en el registro. Ejemplo:

```
*/2 * * * * xvfb-run -a /home/aulla/Eneboo/bin/eneboo -silentconn "tareas:postgres:PostgreSQL:192.168.0.108:5432:dkn42m" -c "flmantppal.launch_command" -a "2" -q 2>&1  | ts "[nombrebd_funcion]" | ts >> /var/log/eneboo.log

```

Al lanzar la tarea, se crea un fichero en /tmp/eneboo_nombrebd_nombrefuncion_id.flag. Este fichero existe mientras la tarea se ejecuta.

### Politica procesos zombies

Si se vuelve a lanzar el cron y una tarea previa ha superado el tiempo de 10 minutos, se hace kill a la tarea previa y eliminamos flag. En esta llamada no lanzamos la función. En la proxima si.

Si la tarea es de tipo "Servicio", se genera un servicio de systemctl para esa tarea en /etc/systemd/system/eneboo**\*nombrebd\*\*\***nombre_script\*\*.service. Ejemplo:

```
[Unit]
Description=ENEBOO service 8 (flmantppal.test)

[Service]
Type=simple
ExecStart=xvfb-run -a /home/aulla/Eneboo/bin/eneboo -silentconn dbname:usuario:PostgreSQL:215.222.222.1:5432:password:nogui -c "flmantppal.launch_command" -a "8" -q
ExecStartPre=/bin/sleep 30
Restart=always
RestartSec=1

```

### Cómo saber si un proceso se ha lanzado

Para un proceso de tipo "Servicio" podemos ejecutar:

systemctl status eneboo_nombrebd_flfactppal.nombre_funcion_id
Si se está ejecutando , nos mostrará algo así:

```
$ systemctl status eneboo_nombrebd_flfactppal.nombre_funcion_id
● eneboo_service_8.service - ENEBOO eneboo_nombrebd_flfactppal.nombre_funcion_id
     Loaded: loaded (/etc/systemd/system/eneboo_nombrebd_flfactppal.nombre_funcion_id.service; enabled; preset: enabled)
     Active: active (running) since Tue 2023-07-04 11:36:04 CEST; 6min ago
   Main PID: 48928 (xvfb-run)
      Tasks: 3 (limit: 18348)
     Memory: 34.9M
        CPU: 299ms
     CGroup: /system.slice/eneboo_nombrebd_flfactppal.nombre_funcion_id.service
             ├─48928 /bin/sh /usr/bin/xvfb-run -a /home/aulla/Eneboo/bin/eneboo -silentconn dbname:usuario:PostgreSQL:215.222.222.1:5432:password:nogui -c flmantppal.launch_command -a 8
             ├─48938 Xvfb :100 -screen 0 1280x1024x24 -nolisten tcp -auth /tmp/xvfb-run.K74N5y/Xauthority
             └─48941 /home/aulla/Eneboo/bin/eneboo -silentconn dbname:usuario:PostgreSQL:215.222.222.1:5432:password:nogui -c flmantppal.launch_command -a 8

```

### Cómo saber si un proceso sigue activo

Podemos usar en comando "**ps aux**" , para verlo de manera general.

### Comprobación de logs

Si el tipo es "Programada" podemos ver el log en _/var/log/eneboo.log_.
Si el tipo es "Servicio" podemos ver el log en _/var/log/syslog_.

#### Enviar mensajes al log

Todos los mensajes de debug, print en qsa van a parar al log.

### Política de limpieza del log

El log de /var/log/eneboo.log crea una copia cada 50 megas en _/var/log/eneboo.log.1_ y descarta la copia vieja.

### Como parar un servicio constante

Aunque desactives el servicio en el formulario de tareas programadas el servicio se seguira ejecutando, si es un servicio que se ejecuta constantemente se deberá lanzar el siguien comando para pararlo de forma definitiva.

```

systemctl stop eneboo_nombrebd_nombrefuncion_id

```