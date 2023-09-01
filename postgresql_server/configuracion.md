# Postgresql Server / Instalación y configuración

## Instalacion
Ejecutamos en una consola:
  ```console
  sudo apt-get update
  sudo apt-get install postgresql postgresql-contrib
  ```

## Configurar tipo de autenticacion (postgresql_server >= 13.0)
* Nos aseguramos que el tipo de autenticación es **md5**. Para ello editamos la siguiente linea en **postgresql.conf**:
  ```console
  password_encryption = md5     # scram-sha-256 or md5
  ```

  Para asegurarnos que esta correctamente seteado **md5**:
  ```console
  sudo service postgresql restart
  sudo -i -u postgres
  psql
  > SELECT pg_reload_conf();
  > SHOW password_encryption; 
  ```
  En pantalla debería mostrar 

  ```
  password_encryption
  ---------------------
  md5
  (1 row)
  ```

* En pg_hba.conf, cambiamos las referencias a **scam-sha-256** por **md5** 

## Cambio de password usuario postgres
  Para setear la contraseña de usuario postgres.
  ```console
  sudo -i -u postgres
  psql
  postgres=# \password
  Enter new password for use "postgres":
  Enter it again:
  postgres=# \quit
  ```

## Habilitar acceso remoto.
 Modificamos pg_hba.conf y añadimos la linea:
  ```console
  host    all     all     0.0.0.0/0     md5
  ``` 

### Más

  * [Volver al Índice](./index.md)
