# APP OLULA

## Crear acceso directo a olula en modo app

### Windows

- Hacer clic derecho en un espacio vacío del escritorio y selecciona Nuevo > Acceso directo.
- En el cuadro de texto que aparece, pegar la ruta de Chrome seguida de algunos parametros parámetro y la URL.

	"C:\Program Files\Google\Chrome\Application\chrome.exe" --kiosk-printing --app=https://tu-sistema-tpv.com --user-data-dir="C:\ChromePerfilTPV"
	
	--app para indicar la url
	--user-data-dir para que use un usuario diferente al de chrome y así poder usar simpre la impresora de tiquets por ejemplo
	--kiosk-printing para no mostrar la previsualización al imprimir
    --kiosk para abrirlo en pantalla completa

- Hacer clic en Siguiente asignandole el nombre que corresponda y pulsar Finalizar.
- Para cambiar el icono pulsar el botón derecho Cambiar icono y selecinar un fichero .ico