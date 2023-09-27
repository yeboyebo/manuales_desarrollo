# Migración a docker Postgres

## Requisitos
 * Versión S.O: Como sistema mínimo se establece:
    *  Ubuntu (20.04 o LTS sup.) Linux x86-64.
    *  Mac OSX 11 (Big sur) o sup.
    *  Windows 10/11 Pro 21H2 (Build 1944).

 * Ram: 4GB o más.
 * Soporte virutalización habiltiado en BIOS.


## Migración datos previos.
* Traspaso de datos:
    
    Para recoger la información previa y pasarla al nuevo servidor, realizaremos pg_dumpall ( schema y data ), con algún usuario con privilegios:
    ```
    pg_dumpall -U usuario -h localhost -p 5432 --clean --schema-only --file=dump_schema.sql

    pg_dumpall -U usuario -h localhost -p 5432 --clean --data-only --file=dump_data.sql
    ```
    Para restaurar. ¡OJO! Si SGDB viejo es un posgres inferior a 11, NO debemos pasar el schema (usuarios) .
    ```
    psql -U usuario -h localhost -p 5433 < dump_fichero.sql
      ```
## Convivencia con instalación previa de postgres.
Servidor postgres viejo en puerto 5432 (por defecto), en misma máquina que docker postgres, existen varias opciones:

* Desactivar el servicio ( no seran accesibles los datos viejos en el futuro ):
        
    Para Ubuntu:
        
        ```
            systemctl stop postgresql # Para el servicio
            systemctl status postgresql # Comprueba que el servicio está parado
            systemctl disable postgresql # Desactiva el auto arranque
        ```

* Cambio de puerto ( Seguir accediendo al servidor de datos viejo):

    No podemos cambiar inicialmente el puerto del docker de postgres. Por eso, tenemos que cambiar el puerto del servidio viejo , por otro puerto que no sea 5432. Si no lo hacemos el nuevo servidor postgres no se levantará.

    Para Ubuntu:
        
    * Editamos el fichero /etc/postgresql/XX/main/postgresql.conf 
    * Modificamos la linea , para especificar otro puerto diferente.
    ```
    port = 5432 # cambiamos el numero de puerto por otro diferente a 5432 y descomentamos linea si procede.
    ```
    * guardamos cambios.
    * reiniciamos equipo para que recoja correctamente el cambio (puerto, pipes en temporal, etc...).

## Instalación docker:
La informació se puede encontrar aquí:
https://docs.docker.com/engine/install/
En el caso de Ubuntu:
* Añadir repositorios oficiales: 
 ```
 # Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```
* Instalar paquetería
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
Para comprobar que se ha instalado correctamente podemos ejecutar:
```
sudo docker run hello-world
```

### Más

- [Volver al Índice](./index.md)

