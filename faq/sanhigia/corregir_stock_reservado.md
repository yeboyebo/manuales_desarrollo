# Pasos para corregir stock reservado

## 1. Monitorizar posibles fallos
```
select a.codigo, a.fecha, p.codigo, l.idlinea from lineaspedidoscli l inner join lineasalbaranescli la on l.idlinea = la.idlineapedido inner join albaranescli a on la.idalbaran = a.idalbaran inner join pedidoscli p on l.idpedido = p.idpedido inner join movistock ms on l.idlinea = ms.idlineapc where l.cantidad = l.totalenalbaran order by a.fecha desc;
```

Y si hay movimientos eliminarlos:
```
delete from movistock where idmovimiento in (select ms.idmovimiento from lineaspedidoscli l inner join lineasalbaranescli la on l.idlinea = la.idlineapedido inner join albaranescli a on la.idalbaran = a.idalbaran inner join pedidoscli p on l.idpedido = p.idpedido inner join movistock ms on l.idlinea = ms.idlineapc where l.cantidad = l.totalenalbaran order by a.fecha);
```

## 2. Actualizar la cantidad reservado de los stocks
```
update stocks set reservada = (select coalesce(SUM(cantidad), 0) FROM movistock where idstock = stocks.idstock  AND estado = 'PTE' AND cantidad < 0);
```

## 3. ctualizar la cantidad disponible
```
update stocks set disponible = (cantidad-reservada);
```
