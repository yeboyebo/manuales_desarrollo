# Movimientos duplicados

## Pasos a seguir:

* Lanzamos la consulta para ver los movimientos duplicados:
```
Select movistock.idstock,movistock.fechareal,lineaspedidosprov.cantidad,lineasalbaranesprov.cantidad,movistock.cantidad,movistock.referencia, concepto, codalmacen from movistock inner join stocks on movistock.idstock = stocks.idstock inner join lineasalbaranesprov on movistock.idlineapp = lineasalbaranesprov.idlineapedido inner join lineaspedidosprov on lineasalbaranesprov.idlineapedido = lineaspedidosprov.idlinea and lineaspedidosprov.cantidad <= lineasalbaranesprov.cantidad where horareal = '00:00:00' and fechareal >= '2022-11-01' and estado = 'HECHO' and idlineapp is not null;
```

* Guardamos los idstocks de estos movimientos en un fichero:
```
\copy (select movistock.istock from movistock inner join stocks on movistock.idstock = stocks.idstock inner join lineasalbaranesprov on movistock.idlineapp = lineasalbaranesprov.idlineapedido inner join lineaspedidosprov on lineasalbaranesprov.idlineapedido = lineaspedidosprov.idlinea and lineaspedidosprov.cantidad <= lineasalbaranesprov.cantidad where horareal = '00:00:00' and fechareal >= '2022-11-01' and estado = 'HECHO' and idlineapp is not null) To '/home/yeboyebo/Documentos/idstocks';
```

* Eliminamos los movimientos duplicados:
```
delete from movistock where idmovimiento IN (SELect movistock.idmovimiento from movistock inner join stocks on movistock.idstock = stocks.idstock inner join lineasalbaranesprov on movistock.idlineapp = lineasalbaranesprov.idlineapedido inner join lineaspedidosprov on lineasalbaranesprov.idlineapedido = lineaspedidosprov.idlinea and lineaspedidosprov.cantidad <= lineasalbaranesprov.cantidad where horareal = '00:00:00' and fechareal >= '2022-11-01' and estado = 'HECHO' and idlineapp is not null);
```

* Por último insertamos los idstocks de los movimientos duplicados (que ya tenemos en el fichero '/home/yeboyebo/Documentos/idstocks') en stocksptes:
```
INSERT INTO stocksptes (idstock, idusuario, tipoactualizacion, fecha, timestamp) SELECT  idstock, 'stockdiferido', 'STOCK_FISICO', CURRENT_DATE, CURRENT_TIMESTAMP FROM stocks WHERE idstock IN (857234,4878529,5095560,5154783,5168901,5167842,5168461,5168...)
```