# Cron de tareas y servicios
Los objetivos de este proyecto son:

- Disponer de una herramienta para programar ejecuciones de Eneboo tanto de forma contínua como programada.

## Estructura

### Precondiciones

- Usar un equipo que actue como servidor y hacer estas tareas en este:

  - Instalar extensión _tareas_programadas_.
  - Instalar eneboo.
  - Añadir en el crontab del usuario root del S.O. la siguiente linea:

    ```
    @reboot sleep 60 && xvfb-run -a /home/aulla/Eneboo/bin/eneboo -silentconn monterelax:postgres:PostgreSQL:192.168.0.108:5432:dkn42m:nogui -c flmantppal.supervisor_init -q 2>&1 | ts "[SUPERVISOR]" | ts >> /var/log/eneboo.log
    ```

Esto iniciará el supervisor a los 60 segundos de iniciar el S.O. en el servidor.

### Incluir una tarea contínua

En Area Sistema->Mantenimiento->Tareas programadas añadimos un nuevo registro de tipo Servicio.

En el campo Función especificamos la llamda que queremos realizar y la marcamos como activa.

### Incluir una tarea programada

En Area Sistema->Mantenimiento->Tareas programadas añadimos un nuevo registro de tipo Programada.

En el campo Función especificamos la llamda que queremos realizar y la marcamos como activa.

En los campos del formulario especificamos con valores válidos para crontab el intervalo.

### Cómo funciona

El supervisor revisa cada 60 segundos las tareas registradas. Si es de tipo "Programada", añade una nueva linea en el crontab del usuario root en el servidor, con la información facilitada en el registro. Ejemplo:

```
*/2 * * * * xvfb-run -a /home/aulla/Eneboo/bin/eneboo -silentconn "tareas:postgres:PostgreSQL:192.168.0.108:5432:dkn42m" -c "flmantppal.launch_command" -a "2" -q 2>&1 | ts >> /var/log/eneboo.log

```

Si la tarea es de tipo "Servicio", se genera un servicio de systemctl para esa tarea en /etc/systemd/system/eneboo*service* **id_tarea** .service. Ejemplo:

```
[Unit]
Description=ENEBOO service 8

[Service]
Type=simple
ExecStart=xvfb-run -a /home/aulla/Eneboo/bin/eneboo -silentconn "tareas:postgres:PostgreSQL:192.168.0.108:5432:dkn42m" -c "flmantppal.launch_command" -a "8" -q 2>&1 | ts >> /var/log/eneboo.log
Restart=always
RestartSec=1

[Install]

```

### Cómo saber si un proceso se ha lanzado

Para un proceso de tipo "Servicio" podemos ejecutar:

systemctl status eneboo_service_8
Si se está ejecutando , nos mostrará algo así:

```
$ systemctl status eneboo_service_8
● eneboo_service_8.service - ENEBOO service 8
     Loaded: loaded (/etc/systemd/system/eneboo_service_8.service; enabled; preset: enabled)
     Active: active (running) since Tue 2023-07-04 11:36:04 CEST; 6min ago
   Main PID: 48928 (xvfb-run)
      Tasks: 3 (limit: 18348)
     Memory: 34.9M
        CPU: 299ms
     CGroup: /system.slice/eneboo_service_8.service
             ├─48928 /bin/sh /usr/bin/xvfb-run -a /home/aulla/Eneboo/bin/eneboo -silentconn tareas:postgres:PostgreSQL:192.168.0.108:5432:dkn42m -c flmantppal.launch_command -a 8
             ├─48938 Xvfb :100 -screen 0 1280x1024x24 -nolisten tcp -auth /tmp/xvfb-run.K74N5y/Xauthority
             └─48941 /home/aulla/Eneboo/bin/eneboo -silentconn tareas:postgres:PostgreSQL:192.168.0.108:5432:dkn42m -c flmantppal.launch_command -a 8

```

### Cómo saber si un proceso sigue activo

Podemos usar en comando "**ps aux**" , para verlo de manera general.

### Comprobación de logs

Si el tipo es "Programada" podemos ver el log en _/var/log/eneboo.log_.
Si el tipo es "Servicio" podemos ver el log en _/var/log/syslog_.

#### Enviar mensajes al log

Todos los mensajes de debug, print en qsa van a parar al log.

### Política de limpieza del log
