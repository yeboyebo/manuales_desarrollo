# Ampliar entidades

Modificamos las entidades para reflejar los nuevos datos a almacenar. Analizar dónde deben ir estos datos y no mapear a ciegas desde la base de datos.

Ejemplo: iva_nav
Campos en base de datos:
* clientes - codgrupoivaneg
* pedidoscli - codgrupoivaneg

El grupo de IVA de negocio se usa para determinar si un documento de venta o compra lleva IVA o no, las subcuentas de IVA que intervienen en su asiento, y el modo de crearlas (una, ninguna, dos canceladas por reversión, etc.). Este funcionamiento es realmente el mismo que el del campo Régimen IVA de los módulos oficiales, solo que permite crear más tipos que los regímenes oficiales de IVA en España.

Si una empresa usa iva_nav, no ve Régimen IVA. Decidimos entonces usar el campo _Régimen IVA_ para almacenar el valor de codgrupoivaneg tanto en la entidad cliente como en las de documentos de venta. Quizá debamos también cambiar el nombre de esta propiedad. El funcionamiento de las dos opciones será el mismo, con la diferencia de que en el caso de oficial, la tabla de cruce entre grupo IVA de negocio y grupo IVA de producto (impuestos) será una tabla fija interna.

### Refactorizar para estandarizar parámetros de entrada
Lo primero es identificar el actual uso de _Régimen IVA_ en los contextos. Vemos que el único lugar donde se usa para cálculos es _ImpuestosLineaVenta.qs_.
Localizamos el script de tests asociado:
```sh
qs-task myp:test:py contexts/ventas/shared/test/ImpuestosLineaVenta.test.qs
```
Refactorizamos _ImpuestosLineaVenta.qs_ para modificar la forma de calcular los IVAs de la línea de venta (ver _ImpuestosLineaVenta.qs_).

### Refactorizar para admitir opciones: patrón _Strategy_

Una vez refactorizada la lógica, nos quedaría crear los mappers correctos para recuperar y persistir los datos. Para el caso de los clientes,
ver _CursorClienteMapper.qs_ y _CursorClienteMapperIvaNav.qs_.

Hacer test _CursorPedidoCliente.itest.qs_
Hacer test _CursorPedidoClienteIvaNav.itest.qs_

Usar dependencias y construcción anidada

Modificar carga de contexto para IVA Nav
Crear estrategias de cálculo de IVA línea para oficial e IVA NAV (si hace falta)
