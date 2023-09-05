# Medidas dínamicas en cubos de análisis

Una medida dinámica es la que se calcula conforme se van mostrando datos en lugar de hacerse al recargar el cubo. Para crearla debemos seguir los siguientes pasos:

- En el fichero **.mtd** del cubo creamos la nueva medida, pero no creamos un campo asociado. Dejamos el valor de **column** vacío.
Ej.
```
<Measure name="margen" alias="QT_TRANSLATE_NOOP('MetaData', '% Margen')" measureName="QT_TRANSLATE_NOOP('MetaData', 'Margen')" column="" aggregator="margen" formatString="#.###,00"/>
```

- En la función **dameSqlAgregacion** del fichero **in_navegador.qs** añadimos un case para indicar qué función de agregación corresponde a nuestra nueva medida.
Ej. Para la medida **margen** la función de agregación será **MARGEN**
```
 if (funElemento == "margen") {
        valor = "MARGEN";
    }
```

- En la función **dameCampoAgregado** del fichero **in_navegador.qs** añadimos un case para indicar la fórmula con la que se calculará nuestra función de agregación.
Ej.
```
case "MARGEN": {
    const ventas = this.iface.medidas_["ventas"]["element"].attribute("column")
    const coste = this.iface.medidas_["coste"]["element"].attribute("column")

    miSelect += "CASE WHEN SUM(" + ventas + ") <> 0 THEN ((SUM(" + ventas + ") - SUM(" + coste + "))*100)/SUM(" + ventas + ") ELSE 0 END AS margen";
    break;
}
```

- En la función **dameColumnaAgregadaSql** del fichero **in_navegador.qs** añadimos otro case para indicar qué columna de la consulta es la referente a nuestro campo.
Ej.
```
if (funAgregacion == "MARGEN") {
    valor = "CASE WHEN SUM(m_venta) <> 0 THEN ((SUM(m_venta) - SUM(m_coste))*100)/SUM(m_venta) ELSE 0 END AS margen";
}
```

Ejemplo obtenido de fun_jsenar_bi para el cubo ventas_sh

[Volver al Índice](./index.md)
