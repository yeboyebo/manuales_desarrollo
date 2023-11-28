# SpreadSheetReport.qs

La clase _SpreadSheetReport.qs_ permite la creación de hojas de cálculo y la generación de informes tabulados de varios niveles.

## Generación de informes tipo Report (con niveles)

### Prerrequisitos

- Tener los datos o la consulta que recoge los datos del informe.
- Saber el nombre del informe y el nombre del fichero generado.
- Si el informe tiene campos calculados, saber cuáles son.
- Analizar los niveles que tendrá el informe y sus campos de ruptura.

### Parámetros opcionales

- Estilos
- Opciones

Podemos usar la clase SpreadSheetReport para generar un informe que incluya varios niveles, así como cabeceras y pies de nivel.

Un ejemplo simple de cómo se utilizaría esta clase sería el siguiente.

Función de lanzamiento

```js
function oficial_tbnExcel_clicked() {
    const _i = this.iface;
    const cursor = this.cursor();

    //  Prerrequisitos
    const nombreInforme = "nombre del informe";
    const nombreFichero = "nombre del fichero generado";
    const camposCalculados = _i.dameCamposCalculados();

    //Para obtener los datos que se imprimirán en el informe tenemos 2 opciones:

    //OPCIÓN 1: Usamos una query que tengamos definida de la que obtener los datos
    const query = _i.estableceConsulta("nombreConsulta","tabla.id = 1", "");

    //OPCIÓN 2: Podemos guardar los datos con la estructura que necesitemos dentro de un array que hayamos procesado manualmente
    const data = _i.dameDatos()

    /*Llamamos a la función donde definimos la estructura de niveles del informe.
    Esta nos debe devolver un objeto de la clase SpreadSheetReport con los niveles definidos*/
    const spreadSheetReport = _i.dameReport(nombreInforme);

    //Depende de la opción que estemos usando para recoger los datos tendremos que usar los siguientes métodos de la clase:

    //Si los recogemos por Query
    spreadSheetReport.setQuery(query);

    //Si los recogemos manualmente
    spreadSheetReport.setData(data);

    spreadSheetReport.setCamposCalculados(camposCalculados);

    //PARÁMETROS OPCIONALES

    /*ESTILOS:
    Podemos crear un diccionario para guardar cómodamente los estilos de nuestro informe.

    Estilos disponibles:
        - "italic"
        - "tSep"
        - "bSep"
        - "rSep"
        - "lSep"
        - "lAlig"
        - "rAlig"
        - "none"
        - "undeline"
        - "bold"
        - "border" -> aplica los 4 Sep
        - "bx" -> aplica los Sep horizontales
        - "by" -> aplica los Sep verticales
    */

    spreadSheetReport.setEstilos({
        // Cada estilo debe tener asignado un array con los diferentes estilos a aplicar.
        "normal":["lAlig", "border"]
        "titulo":["lAlig", "border", "bold"]
    })

    /*OPCIONES:
    Se le puede asignar cualquier estructura de datos.
    Pero por conveniencia deberíamos asignarle siempre un diccionario.

    Por ejemplo si quisiéramos que el usuario pueda decidir si quiere o no los pies en el informe,
    se añadiría la opción de la siguiente manera.
    */

    var res = formUI.preguntaMsg(sys.translate("¿quieres imprimir los pies?"), "info", this, MessageBox.Yes, MessageBox.No);

    spreadSheetReport.setOpciones({
         "imprimirPies": (res == Message.Yes)
    })

    /*renderizamos la estructura de niveles.
    Esta funcion devuelve un objeto spreadsheet, que contiene los datos dispuestos en filas.*/
    const spreadsheet = spreadSheetReport.render();

    //Con la funcion toODS transformamos el objeto a una  hoja de cálculo EXCEL. Le pasamos el nombre que queramos asignar al fichero generado
    spreadsheet.toODS(nombreFichero);
}
```

Función que extrae los campos calculados

```js
function oficial_dameCamposCalculados() {
  const cc = [];
  //para cada campo que queramos añadir, tendremos que asignarle un titulo y una función que devuelve el valor del campo
  cc.push({
    titulo: "nombreDelCampo",
    funcion: function (valores) {
      var valor;
      //código que calcula el valor del campo
      return valor;
    },
  });
  return cc;
}
```

Función que establece la query

```js
function oficial_estableceConsulta(nombreConsulta, where, orderBy) {
  var query: FLSqlQuery = new FLSqlQuery(nombreConsulta);

  if (where) query.setWhere(where);

  if (orderBy) query.setOrderBy(orderBy);

  return query;
}
```

Función con la estructura de niveles del informe

```js
function oficial_dameReport(nombreInforme)
{
    //Importamos la clase de "contexts/shared/infrastructure/SpreadSheetReport.qs" y creamos una instancia de la clase
    const SpreadSheetReport = FormImport.from("contexts/shared/infrastructure/SpreadSheetReport.qs");
    const report = new SpreadSheetReport(nombreInforme)

    const _i = this.iface

     /*Para cada nivel, indicamos el campo de la consulta que marca su rotura
     Esta función crea internamente el array de aNiveles
     (con longitud igual a report.Niveles.length + 1)*/
    report.setNiveles(["almacenes.codalmacen"])

    // report: Indica las funciones de cabecera y pie de informe con setReportPie y setReportCabecera
    // El nivel de report no puede contener acumulados, para ello se utiliza el nivel 0
    report.setReportPie(function (valores, spreadsheet) {
        var fila = spreadsheet.addFila()
        fila.setFormato(estilos.titulo)
        fila.addCelda("TOTAL INFORME")
        fila.addEspacios(1)
        fila.addCelda(valores["total"])
    })

    // Para asignar los acumulados se pueden asignar a cada nivel por separado
    report.setAcumulados(0,{
        // Incluimos una clave por cada campo de la consulta (calculado o no) que queramos
        // usar en el acumulado. La única opción de acumulación por ahora es la suma (SUMA).
        "total": "SUMA"
    })
    report.setAcumulados(1,{
        "total": "SUMA"
    })

    /*En el caso de que todos los niveles tengan los mismos acumulados,
    se pueden añadir a todos los niveles de golpe.*/
    report.setAllAcumulados({
        "total": "SUMA"
    })

    /*Para cada nivel se llama a la funcion setCabecera, setDetalle, setPie del nivel correspondiente,
    aunque no es necesario definir todas las secciones en cada nivel.

    A cada una de estas funciones se les debe pasar por parámetro el nivel al que se está haciendo referencia,
    y la funcion que debe ejecutar para dibujar esa seccion en el informe

    La función de dibujado siempre tendrá 4 parámetros, o 5 si añadimos los acumulados

    Parámetros:

    -valores -> Diccionario con los valores a pintar en este nivel.
    -estilos -> Diccionario con los estilos que nosotros hayamos añadido al report.
    -opciones -> Diccionario con las opciones que le hayamos añadido al report.
    -spreadsheet -> Objeto donde añadiremos las filas de cada sección.
    -acumulados -> Diccionario con los valores de los campos acumulados de este nivel.
    Solo podemos usarlo si previamente hemos hecho un setAcumulados en el nivel que
    corresponda.
    */


    //NIVEL 0

    //Ejemplo sin acumulados
    report.setDetalle(0, function(valores, estilos, opciones, spreadsheet) {
        //añadimos filas al spreadsheet de esta manera
        var fila = spreadsheet.addFila()
        /*podemos darle estilo a todas las celdas que añadamos a esta fila con setFormato,
        pasandole un array con los estilos que deban aplicarse a las celdas.
        */
        fila.setFormato(estilos.titulo) //Debe hacerse antes de añadir las celdas.
        fila.addCelda(valores["almacenes.codalmacen"])
        fila.addCelda(valores["almacences.nombre"])
        fila = spreadsheet.addFila()
        fila.setFormato(estilos.titulo)
        //con addEspacios podemos añadir n celdas vacias en la fila actual
        fila.addEspacios(2)
        fila.addCelda("Referencia")
        fila.addCelda("Descripción")
        fila.addCelda("Cantidad")
        fila.addCelda("Coste")
        /*si quisiéramos que una celda tuviera un estilo distinto al de la fila,
        le podemos pasar su propio estilo al añadir la celda.
        (Estos estilos no se acumulan con los de la fila, sino que los sustituye)*/
        fila.addCelda("Total",estilos.normal)
    })
    /*Ejemplo con acumulados */
    report.setPie(0, function(valores, estilos, opciones, spreadsheet, acumulados) {
        // Podemos establecer una condición para no dibujar la sección, como la que añadimos previamente a la propiedad opciones
        if(!opciones.imprimirPies){
            return
        }
        var fila = spreadsheet.addFila()
        fila.setFormato(estilos.titulo)
        fila.addCelda("TOTAL " + valores["almacenes.codalmacen"])
        fila.addCelda(valores["almacenes.nombre"])
        fila.addCelda(acumulados["total"])
        //Para añadir una fila totalmente vacia basta con hacer un addFila
        spreadsheet.addFila()
    })

    //NIVEL 1

    report.setDetalle(1, function(valores, estilos, opciones, spreadsheet) {

        var fila = spreadsheet.addFila()
        fila.setFormato(estilos.normal)
        fila.addEspacios(2)
        fila.addCelda(valores["stocks.referencia"])
        fila.addCelda(valores["articulos.descripcion"])

        /*si el valor que queremos guardar en la celda es un número decimal,
        podemos cambiar la precision de la siguiente manera*/
        var celda = fila.add(valores["cantidad"])
        celda.setPrecision(2)
        celda = fila.add(valores["coste"])
        celda.setPrecision(2)
        celda = fila.add(valores["total"])
        celda.setPrecision(2)
        //Si quisieramos que el una determinada celda ocupara más de una columna, podemos hacerlo utilizando setTamCelda
        celda.setTamCelda(3) //esta celda ocuparia 3 columnas

    })
}

### Más

- [Volver al Índice](./index.md)
```
