# Script restaurar base de datos.

## 1. Información
Script para restaurar la base de datos y hacer las modificaciones necesarias para funcionar en local.
Es necesario tener la copia de la base de datos que se va a restaurar en la ruta donde se encuentre el script.

## 2. Parámetros obligatorios

Base de datos a importar --filename="wallmok04-10-23.sql"
Base de datos a la que se importa --database="wallmok"
Usuario de la base de datos  --user="magento"
Contraseña de la base de datos --password="magento";
Base url para update en core condig data --baseurl="http://dev.wallmok.com/";
Dominio de cookie --cookiedomain="dev.wallmok.com"
Índice de elasticsearch --elasticindex="wallmok.dev"

## 3. Parámetros opcionales

Host de la base de datos --host="localhost" si se deja vacío por defecto pone localhost
Varnish --varnish="varnish" si se deja vacío por defecto pone localhost
Host elasticsearch --elastichost="141.95.28.6" si se deja vacío por defecto pone localhost
Puerto elasticsearch --elasticport="9200" si se deja vacío por defecto pone 9200
Para crear env.php se necesita el parámetro y el frontend para el admin --env="admin_gtalis". Es necesaria la ruta del proyecto en local
Ruta del directorio donde está el proyecto en local -rute="/var/www/html/wallmok"
Parámetro para upgrade y compilado --compile="true"

## 4. Ejemplos

Ejemplo completo sin env y compilado:

~~~
php restaurar_db.php --filename="wallmok04-10-23.sql" --database="pruebaImport" --user="magento" --password="magento" --baseurl="http://dev.wallmok.com/" --cookiedomain="dev.wallmok.com" --elasticindex="wallmok.dev" --elastichost="141.95.28.6" --elasticport="9200" --varnish="localhost" --host="localhost" 
~~~

Ejemplo crear env y compilado:

~~~
php restaurar_db.php --filename="wallmok04-10-23.sql" --database="pruebaImport" --user="magento" --password="magento" --baseurl="http://dev.wallmok.com/" --cookiedomain="dev.wallmok.com" --elasticindex="wallmok.dev" --elastichost="141.95.28.6" --elasticport="9200" --env="prueba" --rute="/var/www/html/wallmok" --compile="true"
~~~
