# Testing / Tests de código legacy

## Estrategia
La estrategia para que el código legacy pueda ser testeado y refactorizado consiste en realizar unos pocos tests funcionales que sirvan como red de seguridad, para luego refactorizar el contenido de cada funcionalidad usando muchos pequeños tests unitarios.

Los pasos para lograr esto son los siguientes:

### Localizar casos de uso a testear
Determinaremos funcionalidades completas que tienen sentido de negocio a testear, por ejemplo _Aprobar presupuesto_, _Crear factura_.

Ejemplo: _Albaranar pedido de cliente_

### Limpiar los accesos al UI
Refactorizaremos el caso de uso para separar las interacciones de la interfaz de la lógica de negocio pura.

Este es un paso delicado puesto que todavía no podemos probar automáticamente que esta refactorización es correcta.

Ejemplo: Ver refactorización masterpedidoscli.qs / _generarAlbaranTrans_ > 

### Crear un test funcional para _happy path_ del caso de uso
En el correspondiente archivo _test_loquesea_cursor.py_ crearemos al menos un test que compruebe que el código funciona correctamente a nivel global.

Ejemplo: _test_pedidoscli_cursor.py_ > _test_albaranar_pedido_genera_albaran_correcto_

### Localizar posibles tests unitarios que realizar dentro del caso de uso
Buscaremos lógica con un cierto nivel de complejidad que pueda ser extraida y probada por separado.

Ejemplo: _flfacturac.oficial_obtenerEstadoPedidoCliOld_

```js
function oficial_obtenerEstadoPedidoCliOld(idPedido)
{
	var _i = this.iface;
	var query = new FLSqlQuery();

	query.setTablesList("lineaspedidoscli");
	query.setSelect("cantidad, totalenalbaran, cerrada");
	query.setFrom("lineaspedidoscli");
	query.setWhere("idpedido = " + idPedido);
	if (!query.exec()) {
		return false;
	}

	var estado = "";
	var totalServidas = 0;
	var parcial = false;
	var totalLineas = 0;
	var totalCerradas = 0;

	var cantidad, cantidadServida;
	var cerrada;
	while (query.next()) {
		cantidad = parseFloat(query.value("cantidad"));
		if (cantidad == 0) {
			continue;
		}
		totalLineas++;
		cantidadServida = parseFloat(query.value("totalenalbaran"));
		cerrada = query.value("cerrada");
		if (cerrada) {
			totalCerradas++;
		} else if (cantidad > 0 && cantidad <= cantidadServida) {			
			totalServidas++;
		} else if (cantidad < 0 && cantidad >= cantidadServida) {			
			totalServidas++;
		} else {
			if(cantidad >= 0) {				
			if (cantidad > cantidadServida && cantidadServida != 0) {
				parcial = true;
			}
			} else {
				if (cantidad < cantidadServida && cantidadServida != 0) {				
					parcial = true;
				}
			}		
		}
	}
	if (totalLineas == 0) {
		return "No";
	}

	var totalAServir = totalLineas - totalCerradas;
	if (parcial) {
		estado = "Parcial";
	} else {
		if (totalServidas == 0 && totalCerradas == 0) {
			estado = "No";
		} else {
			if (totalServidas >= totalAServir) {
				estado = "Sí";
			} else {
				estado = "Parcial";
			}
		}
	}
	return estado;
}
```

### Separar en lo posible acceso a base de datos de lógica de negocio
De esta forma acabaremos con una función que no depende del UI ni de la BD, que únicamente recibe una entrada y produce una salida, que es lo ideal para testear.

Ejemplo:
```js
function oficial_obtenerEstadoPedidoCli(idPedido)
{
	const _i = this.iface;

	const query = new FLSqlQuery();

	query.setTablesList("lineaspedidoscli");
	query.setSelect("cantidad, totalenalbaran, cerrada");
	query.setFrom("lineaspedidoscli");
	query.setWhere("idpedido = " + idPedido);
	const lineas = formSQL.cargaConsulta(query)

	return _i.calculaEstadoServidoPedido(lineas)
}

function oficial_calculaEstadoServidoPedido(lineas)
{
	const _i = this.iface;
	if (lineas.length == 0) {
		return "No"
	}
	
	const f = function(acum, linea) {
		if (acum == "Parcial") {
			return acum
		}
		const estadoLinea = flfacturac.iface.calculaEstadoServidoLineaPedido(linea)
		if (estadoLinea == acum) {
			return acum
		}
		switch (estadoLinea) {
			case "Parcial": {
				return "Parcial"
			}
			case "Sí": {
				return acum
					? "Parcial"
					: "Sí"
			}
			case "No": {
				return acum
					? "Parcial"
					: "No"
			}
			default: {
				return acum
			}
		}
	}
	return formARRAY.reduce(lineas, f, null)
}

function oficial_calculaEstadoServidoLineaPedido(linea)
{
	const cerrada = linea["cerrada"]
	const cantidad = linea["cantidad"]
	const servida = linea["totalenalbaran"]
	if (cerrada) {
		return "Sí"
	}
	if (cantidad > 0) {
		if (cantidad <= servida) {
			return "Sí"
		} else if (servida > 0) {
			return "Parcial"
		} else {
			return "No"
		}
	} else if (cantidad < 0) {
		if (cantidad >= servida) {
			return "Sí"
		} else if (servida < 0) {
			return "Parcial"
		} else {
			return "No"
		}
	} else {
		return null
	}
}
```

### Crear tests unitarios
Crearemos tests unitarios en los ficheros _test_¿?.py_
```js
def test_calcula_estado_servido_pedido(self):
  flfacturac = script("flfacturac").iface
  lineas = [
  {"cantidad": 1, "totalenalbaran": 1, "cerrada": False},
  {"cantidad": 1, "totalenalbaran": 0, "cerrada": False}
  ]
  self.assertEqual(flfacturac.calculaEstadoServidoPedido(lineas), "Parcial")
```

### Probar de forma manual en Eneboo / Pineboo
Hay que tener en cuenta que los tests se realizan con código traducido qsa y en una BD SQLite, siempre debemos hacer una prueba final de la funcionalidad en un entorno con UI para comprobar que no nos hemos saltado ningún paso y que la cadena de funciones que hemos refactorizado es correcta.

### Más
  * [Volver al Índice](./index.md)
