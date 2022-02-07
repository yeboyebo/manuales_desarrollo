# Pineboo Server desde Eneboo / Programar llamadas

## Clase HTTP
Hemos creado una nueva clase en Sistema > Libreria, llamada *HTTP*, que servirá para realizar llamadas a urls, entre ellas, la API de *Pineboo Server*.

> **NOTA**: Esta clase, al contrario que el resto de las de la librería, es sobrecargable, por lo que debemos llamarla con **formHTTP.iface.[funcion]** y no con formHTTP[funcion]

La clase *HTTP* permite hacer cuatro tipos de llamadas o requests:
* **get**: Para leer
* **post**: Para crear
* **patch**: Para modificar
* **del**: Para borrar

Los parámetros de todas estas llamadas son los mismos:
* **path de la llamada**. Parte de la URL que identifica la llamada (p.e. "*presupuestos/4/aprobar*")
* **Objeto de datos**. Son los datos que se enviarán al servidor, deben estar estructurados tal y como la API los necesite.
* **Objeto de parámetros** (opcional): Se usará para indicar opciones de la llamada, como por ejemplo para usar una API alternativa a la de *Pineboo Server*

La función devuelve un objeto:
  ```js
  {
    ok: true / false // que indica si la llamada a funcionado o no
    salida: {} // que contiene los datos de respuesta en caso de ok = true
  }
  ```

  Ejemplo de uso:

  ```js
  if (flfactppal.iface.usarServidorPineboo()) {
		var respuesta = formHTTP.iface.post("pedidoscli/" + idPedido + "/generar_albaran", {})
		if (respuesta.ok) {
			idAlbaran = respuesta.salida["idalbaran"];
		} else {
			formUI.ponMsgError(sys.translate("Hubo un error en la generación del albarán"), this);
		}
	}
  ```

### Más

  * [Volver al Índice](./index.md)
