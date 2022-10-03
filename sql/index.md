# SQL
---------------------------

## Volcar datos a fichero csv (Postgres)
Usamos *\copy* de la siguiente forma:
```sql
\copy (select) TO 'ruta al fichero' WITH DELIMITER '|' CSV HEADER;
```
Ejemplo:
```sql
\copy (select f.codigo, f.fecha, l.descripcion, l.pvptotal from facturascli f inner join lineasfacturascli l on f.idfactura = l.idfactura where f.codcliente = '000491' and f.fecha >= '2022-01-01') TO '/home/antonio/dumps/facturas_ganso.csv'  WITH DELIMITER '|' CSV HEADER;
```
[Más aquí](https://hevodata.com/learn/postgres-export-to-csv/)

## Reemplazar (Postgres)
Usamos *replace*
```sql
replace(campo, cadena_a_sustituir, cadena_nueva)
```

### Remplazar intros

```sql
replace(l.descripcion, E'\n', '-')
```

## Cambiar la codificación del cliente (Postgres)
```sql
set client_encoding=utf8
```

### Más

  * [Volver al índice de manuales](../README.md)
