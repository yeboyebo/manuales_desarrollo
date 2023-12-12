## Mapeo de domain a db record con campos calculados / estructuras anidadas
Ver _src/packages/olula/ventas/ventatpv_sm/infrastructure/SupaTsLineaVentaTpvMapper.ts_
como ejemplo de mapper completo a pasar a usar con Entity o con lo que decidamos que usamos para cargar / volcar datos.

## Repositorios o queries cacheados
Para valores de configuración que cambian muy poco (código de serie del punto de venta, ejercicio actual)

## Transaccionalidad (unit of work?)

## Concurrencia (optimista o pesimista)


## Continuar TPV
+ Repositorios obtienen la secuencia (next id)
+ Stock
+ Pagos deben asociarse a un arqueo
+ No puedo borrar un pago de un arqueo cerrado
+ Vales, emisión y uso





