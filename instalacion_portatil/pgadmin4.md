# Instalar pgAdmin4

pgAdmin4 no está disponible en los repositorios de Ubuntu. Necesitamos instalarlo desde el repositorio APT pgAdmin4. Primero configuramos el repositorio. Añadimos la clave pública para el repositorio y creamos el archivo de configuración del repositorio:
 
 ```
sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub
 
sudo apt-key add

sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
```

Instalamos pgAdmin4. Este comando instalará numerosos paquetes necesarios, incluido el servidor web Apache2, para servir la aplicación pgadmin4-web en modo web:

```
sudo apt install pgadmin4
```

Con este comando podemos configurar pgadmin4-web si fuera necesario:

```
sudo /usr/pgadmin4/bin/setup-web.sh
```

  * [Volver al Índice](./index.md)