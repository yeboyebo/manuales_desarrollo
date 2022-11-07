# EXCEL.qs

La librería *EXCEL.qs* permite la creación de hojas de cálculo y la generación de informes tabulados de varios niveles.

## Generación de informes tipo Report (con niveles)
Podemos usar las funciones el script EXCEL.qs para generar un informe que incluya varios niveles, así como cabeceras y pies de nivel.

Una estructura de funciones típica para implementar informes de este tipo es la siguiente.

Función de lanzamiento
```js
function oficial_tbnExcel_clicked()
{
	const _i = this.iface;	
	const cursor = this.cursor();
	const oParam = _i.obtenerParamExcel(cursor);

	formEXCEL.lanzaInformeExcel(oParam);	
}
```
Función de recopilación de parámetros del informe
```js
function oficial_obtenerParamExcel(cursor)
{
	var _i  = this.iface;
    // Función igual a las usadas para informes kut
	var oParam = _i.obtenerParamInforme();

    // Títulos opcionales
	oParam["titulo"] = "Inventario"
	oParam["titulo2"] = "";
	oParam["titulo3"] = "";
    // Columnas a unir para los títulos
	oParam["numCols"] = 6;
    // Nombre del fichero ods a crear
	oParam["nombreFichero"] = "inventario";
    // Consulta, lo mejor es usar la que ya use el kit, si lo hay, y creala con estableceConsulta de flfactinfo
	oParam["q"] = flfactinfo.iface.estableceConsulta(cursor, oParam);
    // Podemos añadir a los resultados de la consulta otras claves que se calculen a partir de los datos de cada registro de la consulta
	oParam["camposCalculados"] = _i.getCamposCalculados()
    // Estructura de niveles que tendrá el informe
	oParam["oNiveles"] = _i.dameNivelesInforme();
	return oParam;
}
```
Función de estructura de niveles del informe
```js
function oficial_dameNivelesInforme()
{
	const _i = this.iface
	const _x = formEXCEL

	return {
        // aNiveles: Array con tantos elementos como (niveles - 1) tengamos.
        // Para cada nivel, indicamos el campo de la consulta que marca su rotura
        // (pueden ser campos calculados)
        "aNiveles": ["almacenes.codalmacen"],
        // report: Indica las funciones de cabecera (header) y pie (footer) de informe, así como
        // sus variables de acumulados (acumulados) a nivel de informe
        "report": {
            "footer": function (valores, acumulados, sheet) {
            var row= new AQOdsRow(sheet);
            _x.cell(row, "TOTAL INFORME", ["border", "bold", "alignLeft"])
            _x.cell(row, "", [])
            _x.cell(row, report["acumulados"]["total"], ["border", "bold", "alignLeft"])
            row.close();
            },
            "acumulados": {
                "total": "SUMA"
            }
        }
        // niveles: Array con las cabeceras, detalle, pie y acumulados de cada nivel
        "niveles": [
            // Nivel 0
            {
                "acumulados": {
                    // Incluimos una clave por cada campo de la consulta (calculado o no) que queramos
                    // usar en el acumulado. La única opción de acumulación por ahora es la suma (SUMA).
                    "total": "SUMA"
                },
                "detalle": function (valores, sheet) {
                    var row = new AQOdsRow(sheet);
                    _x.cell(row, valores["almacenes.codalmacen"], ["border", "bold", "alignLeft"])
                    _x.cell(row, valores["almacenes.nombre"], ["border", "bold", "alignLeft"])
                    row.close();

                    var row = new AQOdsRow(sheet);
                    _x.cell(row, "", [])
                    _x.cell(row, "", [])
                    _x.cell(row, "Referencia", ["border", "bold", "alignLeft"])
                    _x.cell(row, "Descripción", ["border", "bold", "alignLeft"])
                    _x.cell(row, "Cantidad", ["border", "bold", "alignLeft"])
                    _x.cell(row, "Coste", ["border", "bold", "alignLeft"])
                    _x.cell(row, "Total", ["border", "bold", "alignLeft"])
                    row.close();
                },
                "pie": function (valores, acumulados, sheet) { 
                    var row= new AQOdsRow(sheet);
                    _x.cell(row, "TOTAL " + valores["almacenes.codalmacen"], ["border", "bold", "alignLeft"])
                    _x.cell(row, valores["almacenes.nombre"], ["border", "bold", "alignLeft"])
                    _x.cell(row, acumulados[0]["total"], ["border", "bold", "alignLeft"])
                    row.close();
                    var row= new AQOdsRow(sheet);
                    _x.cell(row, "", [])
                    row.close();
                }
            }
            // Nivel 1
            {
                "acumulados": {
                    // Incluimos una clave por cada campo de la consulta (calculado o no) que queramos
                    // usar en el acumulado. La única opción de acumulación por ahora es la suma (SUMA).
                    "total": "SUMA"
                },
                "detalle": function (valores, sheet) {
                    // Podemos establecer una condición para no dibujar el detalle
                    // (o cualquier otra sección)
                    if (!valores["cantidad"]) {
                        return
                    }
                    var row= new AQOdsRow(sheet);
                    _x.cell(row, "", [])
                    _x.cell(row, "", [])
                    _x.cell(row, valores["stocks.referencia"], ["border", "alignLeft"])
                    _x.cell(row, valores["articulos.descripcion"], ["border", "alignLeft"])
                    _i.valoresAtributosArticulos(row, valores)
                    _x.cell(row, valores["cantidad"], ["border", { "precision": 2 }])
                    _x.cell(row, valores["coste"], ["border", { "precision": 2 }])
                    _x.cell(row, valores["total"], ["border", { "precision": 2 }])
                    row.close();
                }
            }
        ]
    }
```
Función de campos calculados
```js
function oficial_getCamposCalculados(nombreInforme)
{
	const _i = this.iface

	const cc = [
		{ 
			"nombre": "cantidad",
            // La función recibirá un diccionario con los datos del registro
            // de la consulta
			"funcion": function (valores) {
				return _i.getCantidad(valores)
			}
		},
        {
			"nombre": "total",
            // Podemos usar campos calculados anteriormente
			"funcion": function (valores) {
				return valores["cantidad"] * valores["coste"]
			}
		}
    ]
	return cc
}
```
### Más

- [Volver al Índice](./index.md)
