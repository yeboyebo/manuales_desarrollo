# Paso de mysql a postgresql


## Copia de base de datos de mysql incluyendo únicamente inserts

De una tabla
```
mysqldump  --compact --complete-insert -t -u root -p mayton empresa  > empresa.sql
```


De una tabla con where

--where="codejercicio > 2014"
```
mysqldump  --compact --complete-insert -t -u root -p mayton albaranescli --where="codejercicio > '2014'" > albaranescli2014.sql
```

De todo
```
mysqldump  --compact --complete-insert -t -u root -p mayton  > mig_mayton.sql
```

## Sustituir ` por "

```
sed -i 's/`/"/g' mig_mayton.sql

tr -d "\n\r" < mig_mayton.sql > mig_mayton2.sql
```
https://www.youtube.com/watch?v=u5Astn1BMAk


sed -i 's/'\''S S.L./S S.L./g' albaranescli2.sql
sed -i 's/'\''OBJECTE S/OBJECTE S/g' albaranescli2.sql
sed -i 's/'\''18 S.L./18 S.L./g' albaranescli2.sql
sed -i 's/'\''EMPRESA I/EMPRESA I/g' albaranescli2.sql
sed -i 's/'\''TA COM/TA COM/g' albaranescli2.sql
sed -i 's/'\''ESGLÉSIA 3/ESGLÉSIA 3/g' albaranescli2.sql
sed -i 's/'\''EMPREINTE/EMPREINTE/g' albaranescli2.sql
sed -i 's/'\''OR S.L./OR S.L./g' albaranescli2.sql
sed -i 's/'\''OEST/OEST/g' albaranescli2.sql
sed -i 's/'\''ARCHE'\'',/ARCHE'\'',/g' albaranescli2.sql
sed -i 's/'\'' DHESIF/ DHESIF/g' albaranescli2.sql
sed -i 's/'\''DIS EUROPE/DIS EUROPE/g' albaranescli2.sql
sed -i 's/'\''EN SERRA/EN SERRA/g' albaranescli2.sql
sed -i 's/'\''S WORLD S/S WORLD S/g' albaranescli2.sql
sed -i 's/\\'\''ATELIER DE/\\ ATELIER DE/g' albaranescli2.sql


L\'A



## Usando pgload

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Regalavida2018.-';

pozuelo@ptpozuelo:/etc/mysql/mysql.conf.d$ sudo nano mysql.cnf
Añadir default-authentication-plugin=mysql_native_password

# default-authentication-plugin=mysql_native_password

reiniciar maysql --> /etc/init.d/mysql restart



## Más

- [Volver al índice de manuales](../README.md)
