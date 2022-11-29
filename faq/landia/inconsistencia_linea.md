# Incidencia de inconsistencia de línea

## Pasos para detectar el albarán de donde viene la inconsistencia de la linea:
- Primero consultamos el idpedido de proveedor lanzando la consulta:
```sql
    select idpedido from pedidosprov where codigo = '3822FC0001000132';
```
- Segundo lanzamos las 5 consultas para detectar las diferencias. La suma de los resultados debe de ser 0 en caso de albarán de abono y 0 en caso de albarán compensatorio.
```sql
    select sum(m.cantidad) from movistock m INNER JOIN lineaspedidosprov lpp ON m.idlineapp=lpp.idlinea where lpp.barcode='037000070885' and lpp.idpedido = 360575;

	select sum(m.cantidad) from movistock m INNER JOIN lineasalbaranesprov lap ON m.idlineaap=lap.idlinea INNER JOIN lineaspedidosprov lpp ON lpp.idlinea=lap.idlineapedido where lap.barcode='037000070885' and lpp.idpedido = 360575;

	select sum(m.cantidad) from movistock m INNER JOIN lineasalbaranescli lac ON m.idlineaac=lac.idlinea INNER JOIN albaranescli ac ON lac.idalbaran=ac.idalbaran where lac.barcode='037000070885' and ac.jg_idpedidoprov = 360575;

	select sum(m.cantidad) from movistock m INNER JOIN lineasalbaranescli lac ON m.idlineaac=lac.idlinea INNER JOIN albaranescli ac ON lac.idalbaran=ac.idalbaran INNER JOIN albaranescli ac2 ON ac.jg_idalbaranori=ac2.idalbaran where lac.barcode='037000070885' and ac2.jg_idpedidoprov = 360575 AND ac.compensatorio;

	select sum(m.cantidad) from movistock m INNER JOIN lineasalbaranescli lac ON m.idlineaac=lac.idlinea INNER JOIN albaranescli ac ON lac.idalbaran=ac.idalbaran INNER JOIN albaranescli ac2 ON ac.jg_idalbaranori=ac2.idalbaran where lac.barcode='037000070885' and ac2.jg_idpedidoprov = 360575 AND ac.deabono;
```
- Si la suma no es 0 buscamos el albarancli deabono.
- Si la suma es 0 buscamos el albarancli compensatorio.

- Buscamos el código de este albarancli y lo preparamos para eliminar.
```sql
	select ac.codigo from movistock m INNER JOIN lineasalbaranescli lac ON m.idlineaac=lac.idlinea INNER JOIN albaranescli ac ON lac.idalbaran=ac.idalbaran INNER JOIN albaranescli ac2 ON ac.jg_idalbaranori=ac2.idalbaran where lac.barcode='122000009563' and ac2.jg_idpedidoprov = 360575 AND ac.deabono;
	update albaranescli set ptefactura = true, deabono = false where codigo = '0122FN0001030834';
```
En este caso es uno deabono. Si fuera compensatorio en lugar de *deabono = false* ponemos *compensatorio = false*.
Eliminamos el albarán '0122FN0001030834' desde Eneboo.