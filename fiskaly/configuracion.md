## Integración con Fiskaly

- En la siguiente dirección podemos ver todo el proceso de integración https://developer.fiskaly.com/es/sign-es/integration_process

- En la siguiente imagen podemos ver el diagrama de flujo para realiazar la integración y que herramientas hay que utilizar en cada paso.

![Diagrama](img/diagrama.png)

### 1. Registrar en Dashboard
- Lo primero es registrarte en el Dashboard. Crearemos la cuenta y a partir de ahí se creará la estructura organizativa de la empresa.

    https://dashboard.fiskaly.com/
    

### 2. Crear organización principal

- Entraremos en el Dashboard con las credenciales facilitadas y lo primero que se muestra es la lista de organizaciones que hay y la opción de crear una nueva, pulsaremos en **Crear nueva organización**

![Dashboard1](img/fiskaly0.png)

    1. Seleccionamos España


![Dashboard1](img/fiskaly0-1.png)

    2. Informamos los datos generales

![Dashboard1](img/fiskaly0-2.png)

    3. Informamos la dirección

![Dashboard1](img/fiskaly0-3.png)

    4. Creamos si es necesario la dirección de facturación.

![Dashboard1](img/fiskaly0-4.png)

### 3. Modo manual.
#### 3.1 Crear organización gestionada
- Teniendo seleccionada nuestra organización principal, pulsaremos en **Crear nueva organización** 

![Dashboard1](img/fiskaly5.png)

Los pasos son los mismos que al crear una organización pero en el paso de informar los datos generales marcaremos el check de **Crear organización gestionada** y podremos ver que nos aparece la organización que la gestiona, en nuestro ejemplo *Pruebas YeboYebo*

![Dashboard1](img/fiskaly6.png)

- Una vez creados los datos de la organización gestionada (Mosaicos Serrano) nos aparecerán las distintas opciones que tenemos, en nuestro caso **ESPAÑA - SIGN ES**

![Dashboard1](img/fiskaly1.png)

- Al entrar en la opción de *ESPAÑA - SIGN ES* podemos ver en la parte de la izquierda un submenú con las distintas opciones.

![Dashboard1](img/fiskaly2.png)


#### 3.2 Crear clave API
- En el apartado de General, tenemos la opción de creear la clave API, pulsaremos y daremos un nombre.

![Dashboard1](img/fiskaly3.png)


- Al aceptar se mostrará la *clave API* generada (podremos verla en cualquier momento) y la *clave API secret*, **ESTA DEBE SER COPIADA Y GUARDADA PORQUE LUEGO NO SE PUEDE ACCEDER A ELLA**

![Dashboard1](img/fiskaly4.png)

- Inserta tu Clave API y Secreto API para descargar el entorno de Postman de fiskaly SIGN ES como archivo personalizado de configuración basado en JSON, esto lo haremos en el punto 3 de la guía rápida:

https://developer.fiskaly.com/es/api/sign-es/v1#section/Guia-Rapida


![Dashboard1](img/fiskaly7.png)


- Al introducirlo y pulsar el botón de descargar, se descargará un fichero **environment.json** el cual reservaremos


- Realizaremos el punto 4, descargaremos la colección **Postman de fiskaly SIGN ES**

![Dashboard1](img/fiskaly8.png)

- Al pulsar el botón de Descargar se descargará un fichero **collection.json** el cual reservaremos.

- Una vez que tengamos el fichero de environment y el de collection, iniciaremos Postman e importaremos los archivos del entorno y la colección de Postman.

![Dashboard1](img/fiskaly9.png)

- Seleccionamos los dos ficheros en la ruta donde los hayamos guardado


![Dashboard1](img/fiskaly10.png)

- Pulsamos en Importar y por un lado tenemos que tener la colección **fiskaly SIGN ES Postman Collection** y por otro lado el environment **fiskaly SIGN ES Postman Environment**

![Dashboard1](img/fiskaly12.png)

![Dashboard1](img/fiskaly13.png)


- Una vez tenemos las importaciones, teniendo seleccionado la colección de fiskaly, seleccionaremos el enviromente de fiskaly.

![Dashboard1](img/fiskaly14.png)

- Si desplegamos la colección, podemos ver las distintas llamadas que podemos hacer, la primera que tendremos que realizar es la de **Retrieve access token** para obtener el token

![Dashboard1](img/fiskaly17.png)

![Dashboard1](img/fiskaly18.png)

#### 3.3 Añadir información del contribuyente

- El siguiente paso es añadir la información del contribuyente al sistema, para ello lo haremos con al sistema a través del endpoint **Set taxpayer information** de la API de SIGN ES.

Asegúrate de indicar correctamente el campo territory de acuerdo con el domicilio fiscal del contribuyente. La API SIGN ES aplicará la legislación correspondiente basada en esto:

Verifactu para SPAIN_OTHER (España Peninsular), CANARY_ISLANDS, CEUTA y MELILLA
TicketBAI para ARABA, BIZKAIA y GIPUZKOA
Actualmente, no se aplica ninguna normativa fiscal a NAVARRA
Este es un paso obligatorio para garantizar que todas las facturas generadas cumplan con la normativa fiscal e incluyan todos los datos necesarios del contribuyente.

![Dashboard1](img/fiskaly19.png)

#### 3.4 Crear un firmante

- A continuación, se debe de crear un Firmante a través del endpoint **Create a first signer** para cada organización gestionada. El firmante es responsable de la firma digital de las facturas.

Cada dispositivo de firma requiere un certificado:

Para el cumplimiento de Verifactu, un certificado electrónico gestionado por fiskaly se asigna automáticamente durante la creación de un firmante. fiskaly está registrado como colaborador social con la AEAT para Verifactu, por lo que el contribuyente necesita firmar un acuerdo de colaboración social con fiskaly. Puedes encontrar más información en la sección Colaboración social.
Para el cumplimiento de TicketBAI, un certificado de dispositivo se asigna automáticamente durante la creación de un firmante, a menos que desees proporcionar tu propio certificado de dispositivo externo. Este certificado se puede obtener de la respuesta de la llamada a la API. Si tus clientes están ubicados en el País Vasco, asegúrate de enviarles la guía de registro que proporcionamos desde fiskaly. Esto les ayudará a registrar correctamente los certificados de dispositivo con la autoridad fiscal correspondiente.


![Dashboard1](img/fiskaly20.png)

#### 3.5 Crear clientes

- El siguiente paso es crear clientes, el flujo de trabajo incluye la creación de createClient a través del endpoint **create a first Client**. Debes crear un Cliente para cada dispositivo POS u otros dispositivos de facturación utilizados en tu organización.


![Dashboard1](img/fiskaly21.png)


- En la respuesta, obtenemos el idcliente que tendremos que guardar en la configuración de verifactu en el campo id.

### 4. Modo auto con herramienta fiskaly_tools.py

Fiskaly_tools es una herramienta que facilita la creación de entidades intermedias que van desde dar de alta la organización (Empresa), tokens, keys, certificados, firmantes, contribuyente, hasta dar de alta la instalación. Todo en un solo paso.

La podemos encontrar en el repositorio de git **utils**

#### 4.1 Configuración

- Se crea el fichero fiskaly_config.json en la misma carpeta donde está el fichero fiskaly_tools.py con los siguientes datos:
``` json
{
    "key" : "test_2b25l4adaxxxr6u42tog21lwh_pruebasx",
    "secret" : "mJyC5VSTanjgl7rCsWiRDAOrFs2VFHFSLCbeIg8iuiT",
    "uuid" : "26f8c0d4-35e4-4bea-97f9-0b1d4a676731"
}
```
key: clave api_key de la empresa gestionadora.
secreat: clave api_secret de la empresa gestionadora.
uuid: uuid de la empresa gestionadora.

#### 4.3 Ejecución

- Lanzamos la herramienta con python3 ./fiskaly_tools.py

![Tool1](img/tool_1.png)

- Pulsamos la opción 1 y rellenamos los datos de la empresa a crear. La dirección a especificar es la dirección fiscal de la empresa.

![Tool2](img/tool_2.png)

- Pulsamos s y se generará automaticamente todo.

![Tool3](img/tool_3.png)

- La herramienta inforará del api_key, api_secret y client_id a usar por la empresa nueva.

![Tool4](img/tool_4.png)

### 5. Crear facturas

- El siguiente paso es crear facturas desde el ERP y firmalas, antes de eso vamos a configurar los datos en el ERP dentro de la pestaña **VERI*FACTU** del formulario de configuración de **Facturación**:

![Dashboard1](img/fiskaly22.png)

* API Identificador --> Informamos el valor obtenido en el punto 4 clave API.

* API Secret --> Informamos el valor obtenido en el punto 4 lave API secret.

* URL --> Valor fijo:

```
    https://{{entorno}}.es.sign.fiskaly.com/api/v1/

```


* Id.Cliente --> Valor obtenido en el punto 3.5 , 4.2 en el campo id.

#### 5.1. Proceso crear/firmar facturas 

- Una vez informados esta configuración podremos crear facturas y firmarlas con fiskaly.

- El proceso de creación de facturas es el estandard del ERP pero hasta que la factura no se emite a Fiskaly y queda firmada no estará en firme.

- Al crear la factura, no tiene un código estándard, nos da un código de borrador y el estado será **Borrador**

![ERP](img/fiskaly23.png)

- Con la factura seleccionada, pulsamos en el botón **Emitir** 

![ERP](img/fiskaly24.png)

- La factura pasará por los estados de **Pte.Comunicar** y **Pte.Firma**, cuando está **Pte.Comunicar** automáticamente se envía a Fiskaly y si no ha habido problema en el envío la factura se queda como **Pte.Firma**. Si se produce un error en la comunicación, la factura se quedará en estado  **Pte.Comunicar**, guardando el timestamp y el error resuelto, para marcar como incidente cuando finalmente sea enviada.

![ERP](img/fiskaly25.png)

- Una vez en este punto, la factura será firmada por Fiskaly y la siguiente factura que se presente obtendrá la información del estado de las facturas en estado **Pte.Firma** y actualizará el estado como **Firmada** si todo ha ido bien.

- Una forma alternativa de actualizar el estado sin tener que esperar a enviar otra factura es pulsando el botón de **Comprobar estado**. 

![ERP](img/fiskaly26.png)

![ERP](img/fiskaly27.png)


### 6. Ver facturas presentadas a Fiskaly desde el ERP

- En principio, todas las facturas en estado **Firmada** están firmadas pero es posible que haya habido errores y podemos verlos desde el **Área de Facturación --> Facturación --> Más --> Garante Sign**

![ERP](img/fiskaly28.png)

- En esta pantalla podemos ver las facturas firmadas en Fiskaly y podemos ver el id que le ha asignado Fiskaly con el que se pueden ver las facturas en el dashboard.

- En el atributo versión SIF, se optiene la versión de la lógica usada en este programa. Por defecto es **0.0 (No definido)**, pero tiene que sobrecargarse la siguiente función, para que especifique la versión correcta
**mastergarante_sign.resuelveTextoLicencia()**

![ERP](img/fiskaly29.png)

### 7. Anular factura

- En principio, todas las facturas en estado **Firmada** o **Error firma** , pueden ser anuladas. Si la factura no puede informarse a Fiskaly, continuará en el estado **Firmada**.

### 8. Incidencias en la comunicación

- Cuando una factura está en estado **Pte.Comunicar** y es la primera vez que intenta presentarse, y no consigue hacerlo, almacena datos del timestamp y la razón del error.
 Estos datos son necesarios para generar el QR de manera manual (y automática).
 También se usan para comunicar la factura con el campo issued_date y rellenar el atributo annotations, con la información de la causa de la incidencia.

### 9. Revisión de errores

- Cuando se produce un error, **Error Firma**, **Error Anulación**, se muestra un mensaje al usuario informando de este. En el caso de producirse un error al presentar la factura la primera vez, la factura no mostrará error y quedará en estado **Pte.Comunicación**.

- Las facturas en estado **Error Firma**, **Error Anulación** o **Pte.Comunicación**, habilitarán un botón **Mostrar errores** para mostrar el error que ha generado el estado de error.

![ERP](img/fiskaly31.png)

### 10. Impresión de facturas

- En las facturas que se impriman, tienen que tener el QR generado al presentarse, para ello nos ayudaremos de las siguientes funciones que están en *flfactinfo* para poder imprimir tanto en **.jasper** como en **.kut**.

```
    veriFactu_crearFicheroVeriFactu(curFactura : FLSqlCursor)
    veriFactu_qrVeriFactu(nodo : FLDomNode , campo : String)

```

- El QR debe de seguir las especificaciones que están incluidas en el siguiente documento:

https://www.agenciatributaria.es/static_files/AEAT_Desarrolladores/EEDD/IVA/VERI-FACTU/DetalleEspecificacTecnCodigoQRfactura.pdf

- Las más importantes son:

    - Se tiene que imprimir en la primera página, arriba centrado.
    - El tamaño tiene que ser entre 3x3 y 4x4 cm.
    - El QR tiene que ir precedido por el texto **QR tributario:**
    - El QR tiene que ir sucedido por el texto **Factura verificable en la sede electrónica de la AEAT** o **VERI*FACTU**


![ERP](img/fiskaly30.png)

