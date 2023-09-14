# Docker Jasper Server / Instalación

## Descarga de Github

El servidor de JasperServer es un proyecto de docker. Clonamos el proyecto con:

```console
git clone git@github.com:yeboyebo/docker_jasperserver.git
```

## Primer entorno

Para funcionar, el servidor debe detectar un fichero _.env_ en el directorio principal. La estructura de este fichero debe ser:

```sh
# ALLOW_EMPTY_PASSWORD is recommended only for development
ALLOW_EMPTY_PASSWORD=no
MARIADB_USER=jasperadmin
MARIADB_DATABASE=jasperserver
WEB_PORT=8080
# RUTA A CARPETA EN EL SISTEMA CON PERMISOS PARA GUARDAR DATOS 
JASPERSERVER_VOLUME=/RUTA/bitnami/jasperreports
MARIADB_VOLUME=/RUTA/bitnami/mariadb
JASPERREPORTS_DATABASE_PORT_NUMBER=3306
MARIADB_IMAGE_VERSION=10.6
JASPERREPORTS_IMAGE_VERSION=8
```

## Instalacion

Una vez tengamos el fichero .env correcto podemos lanzar:

```console
docker-compose up
```

En caso que necesitemos para o reiniciar el docker utilizar start o stop:

```console
docker-compose start/stop
```


## Instalar docker y compose

Pasos para instalar docker en caso que no esté en el sistema:

```sh
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo LC_ALL=C.UTF-8 add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo chmod 777 /var/run/docker.sock
```

Pasos para instalar docker-compose en caso que no esté en el sistema(Puede diferir en sistemas no ubuntu):

```sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### Más

- [Volver al Índice](./index.md)