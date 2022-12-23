# Buscar diferencia entre resumen de facturas y total ventas en informe pyg


Consulta para buscar facturas de ventas sin subcuenta 700

```
select f.codigo from co_partidas p inner join facturascli f on f.idasiento = p.idasiento AND p.codsubcuenta not like '7%' and p.idasiento not in (select idasiento from co_partidas where codsubcuenta like '7%' group by idasiento) where f.codejercicio = 'UB22' and f.fecha >='2022-12-01' and f.fecha <='2022-12-31' group by f.codigo;
```