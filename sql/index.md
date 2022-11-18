# SQL
---------------------------

## Detectar bloqueos (Postgres)

```sql
SELECT bl.pid     AS blocked_pid,
         a.usename  AS blocked_user,
         kl.pid     AS blocking_pid,
         ka.usename AS blocking_user,
         a.query    AS blocked_statement
   FROM  pg_catalog.pg_locks         bl
    JOIN pg_catalog.pg_stat_activity a  ON a.pid = bl.pid
    JOIN pg_catalog.pg_locks         kl ON kl.transactionid = bl.transactionid AND kl.pid != bl.pid
    JOIN pg_catalog.pg_stat_activity ka ON ka.pid = kl.pid
   WHERE NOT bl.granted;
```

### Matar un proceso (pid)

```sql
SELECT pg_terminate_backend(pid);
```

### Matar procesos antiguos
```sql
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE backend_start < CURRENT_DATE - 2;
```

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

### Expresión regular no cumplida (emails)
```sql
select codcliente, nombre, email from clientes where email !~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' order by codcliente
```
## Cambiar la codificación del cliente (Postgres)
```sql
set client_encoding=utf8
```

### Más

  * [Volver al índice de manuales](../README.md)
