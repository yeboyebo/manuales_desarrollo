# Paso de mysql a postgresql


## Copia de base de datos de mysql incluyendo únicamente inserts

```
mysqldump  --compact --complete-insert -t -u root -p mayton empresa  > empresa.sql
```

## Sustituir ` por "

```
sed -i 's/`/"/g' respaldo.sql
```
https://www.youtube.com/watch?v=u5Astn1BMAk

## Usando pgload

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Regalavida2018.-';

pozuelo@ptpozuelo:/etc/mysql/mysql.conf.d$ sudo nano mysql.cnf
Añadir default-authentication-plugin=mysql_native_password

# default-authentication-plugin=mysql_native_password

reiniciar maysql --> /etc/init.d/mysql restart



## Más

- [Volver al índice de manuales](../README.md)
