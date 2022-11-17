# Cuadrar saldos

Cuando tenemos subcuentas donde no cuadra el saldo de la subcuenta con el informe del mayor lanzaremos los siguientes updates cambiando el ejercicio en el que queremos cuadrar.

```
update co_subcuentas set debe =coalesce((select sum(co_partidas.debe) from co_partidas where co_partidas.idsubcuenta = co_subcuentas.idsubcuenta),0), haber = coalesce((select sum(co_partidas.haber) from co_partidas where co_partidas.idsubcuenta = co_subcuentas.idsubcuenta),0) where codejercicio = '2022';

update co_subcuentas set saldo = debe - haber where codejercicio = '2022';
  
```
