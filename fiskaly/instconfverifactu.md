## Integraci�n con Fiskaly

- En la siguiente direcci�n podemos ver todo el proceso de integraci�n https://developer.fiskaly.com/es/sign-es/integration_process

- En la siguiente imagen podemos ver el diagrama de flujo para realiazar la integraci�n y que herramientas hay que utilizar en cada paso.

![Diagrama](img/diagrama.png)

- Los pasos a seguir ser�an:
1. Registrarse en Dashboard de Fiskaly.

2. Crear organizaci�n principal gestionadora, esta organizaci�n no emite facturas, lo que hace es ser la que da de alta y gestiona a las dem�s empresas.

3. Crear organizaci�n(s) gestionada(s). Estas organizaciones si que emiten facturas y ser�n las distintas empresas que tengamos en el ERP.

4. Para cada organizaci�n gestionada hay que crear la Clave API, la Clave API Secret y el token.

5. A�adir informaci�n del contribuyente a la organizaci�n gestionada.

6. Crear firmante a la organizaci�n gestionada.

7. Crear cliente a la organizaci�n gestionada.

8. Configuraci�n en el ERP

### 1. Registrar en Dashboard
- Lo primero es registrarte en el Dashboard. Crearemos la cuenta y a partir de ah� se crear� la estructura organizativa de la empresa.

    https://dashboard.fiskaly.com/

### 2. Crear organizaci�n principal gestionadora

- Entraremos en el Dashboard con las credenciales facilitadas y lo primero que se muestra es la lista de organizaciones que hay y la opci�n de crear una nueva, pulsaremos en **Crear nueva organizaci�n**

    ![Dashboard1](img/fiskaly_verifactu1.png)

    1. Seleccionamos Espa�a

    ![Dashboard2](img/fiskaly0-1.png)


    2. Informamos los datos generales

    ![Dashboard3](img/fiskaly_verifactu2.png)

    3. Informamos la direcci�n

    ![Dashboard4](img/fiskaly_verifactu3.png)

    4. Creamos si es necesario la direcci�n de facturaci�n.

    ![Dashboard1](img/fiskaly0-4.png)

    5. Pulsamos en **CREAR** y se crear� la organizaci�n principal.

    6. Si pulsamos en el icono de info podemos ver los datos de la organizaci�n.

    En este caso est� en **test** y el id de organizaci�n que nos ha dado ya ser� el mismo aunque pasemos la organizaci�n a **live**. (Para pasar una organizaci�n principal gestionadora a **live** hay que contactar con soporte de fiskaly, para pasar una organizaci�n gestionada no har� falta contactar con ellos.)

    ![Dashboard4](img/fiskaly_verifactu4.png)


### 3. Crear organizaci�n gestionada

- Teniendo seleccionada nuestra organizaci�n principal, pulsaremos en **Crear nueva organizaci�n** 

![Dashboard5](img/fiskaly_verifactu5.png)

Los pasos son los mismos que al crear una organizaci�n pero en el paso de informar los datos generales marcaremos el check de **Crear organizaci�n gestionada** y podremos ver que nos aparece la organizaci�n que la gestiona, en nuestro ejemplo *Organizaci�n principal gestionadora 2*

![Dashboard6](img/fiskaly_verifactu6.png)

- Una vez creados los datos de la organizaci�n gestionada (Org. Gestionada1) nos aparecer�n las distintas opciones que tenemos, en nuestro caso **ESPA�A - SIGN ES** y al pulsar sobre el vemos en la parte de la derecha las distintas opciones

![Dashboard7](img/fiskaly_verifactu7.png)


### 4. Crear claves API

- En el apartado de General, tenemos la opci�n de creear la clave API, pulsaremos y daremos un nombre, en nuestro caso le hemos dado como nombre el cif de la empresa con la letra en min�scula.

![Dashboard8](img/fiskaly_verifactu8.png)

- Al aceptar se mostrar� la *clave API* generada (podremos verla en cualquier momento) y la *clave API secret*, **ESTA DEBE SER COPIADA Y GUARDADA PORQUE LUEGO NO SE PUEDE ACCEDER A ELLA**


![Dashboard8](img/fiskaly_verifactu9.png)

- Inserta tu Clave API y Secreto API para descargar el entorno de Postman de fiskaly SIGN ES como archivo personalizado de configuraci�n basado en JSON, esto lo haremos en el punto 3 de la gu�a r�pida:

https://developer.fiskaly.com/es/api/sign-es/v1#section/Guia-Rapida

![Dashboard10](img/fiskaly_verifactu10.png)

- Al introducirlo y pulsar el bot�n de descargar, se descargar� un fichero **environment.json** el cual reservaremos


- Realizaremos el punto 4, descargaremos la colecci�n **Postman de fiskaly SIGN ES**

![Dashboard1](img/fiskaly8.png)


- Al pulsar el bot�n de Descargar se descargar� un fichero **collection.json** el cual reservaremos.

- Una vez que tengamos el fichero de environment y el de collection, iniciaremos Postman e importaremos los archivos del entorno y la colecci�n de Postman.


![Dashboard1](img/fiskaly9.png)

- Seleccionamos los dos ficheros en la ruta donde los hayamos guardado


![Dashboard1](img/fiskaly10.png)

- Pulsamos en Importar y por un lado tenemos que tener la colecci�n **fiskaly SIGN ES Postman Collection** y por otro lado el environment **fiskaly SIGN ES Postman Environment**

![Dashboard1](img/fiskaly12.png)

![Dashboard1](img/fiskaly13.png)


- Una vez tenemos las importaciones, teniendo seleccionado la colecci�n de fiskaly, seleccionaremos el enviromente de fiskaly.

![Dashboard1](img/fiskaly14.png)

- Si desplegamos la colecci�n, podemos ver las distintas llamadas que podemos hacer, la primera que tendremos que realizar es la de **Retrieve access token** para obtener el token.

![Dashboard10](img/fiskaly_verifactu11.png)

![Dashboard10](img/fiskaly_verifactu12.png)


### 5. A�adir informaci�n del contribuyente a la organizaci�n gestionada

- El siguiente paso es a�adir la informaci�n del contribuyente al sistema, para ello lo haremos con al sistema a trav�s del endpoint **Set taxpayer information** de la API de SIGN ES.

Aseg�rate de indicar correctamente el campo territory de acuerdo con el domicilio fiscal del contribuyente. La API SIGN ES aplicar� la legislaci�n correspondiente basada en esto:

Verifactu para SPAIN_OTHER (Espa�a Peninsular), CANARY_ISLANDS, CEUTA y MELILLA
TicketBAI para ARABA, BIZKAIA y GIPUZKOA
Actualmente, no se aplica ninguna normativa fiscal a NAVARRA
Este es un paso obligatorio para garantizar que todas las facturas generadas cumplan con la normativa fiscal e incluyan todos los datos necesarios del contribuyente.

![Dashboard10](img/fiskaly_verifactu13.png)

![Dashboard10](img/fiskaly_verifactu14.png)

### 6. Crear firmante a la organizaci�n gestionada

- A continuaci�n, se debe de crear un Firmante a trav�s del endpoint **Create a first signer** para cada organizaci�n gestionada. El firmante es responsable de la firma digital de las facturas.

Cada dispositivo de firma requiere un certificado:

Para el cumplimiento de Verifactu, un certificado electr�nico gestionado por fiskaly se asigna autom�ticamente durante la creaci�n de un firmante. fiskaly est� registrado como colaborador social con la AEAT para Verifactu, por lo que el contribuyente necesita firmar un acuerdo de colaboraci�n social con fiskaly. Puedes encontrar m�s informaci�n en la secci�n Colaboraci�n social.
Para el cumplimiento de TicketBAI, un certificado de dispositivo se asigna autom�ticamente durante la creaci�n de un firmante, a menos que desees proporcionar tu propio certificado de dispositivo externo. Este certificado se puede obtener de la respuesta de la llamada a la API. Si tus clientes est�n ubicados en el Pa�s Vasco, aseg�rate de enviarles la gu�a de registro que proporcionamos desde fiskaly. Esto les ayudar� a registrar correctamente los certificados de dispositivo con la autoridad fiscal correspondiente.


![Dashboard10](img/fiskaly_verifactu15.png)


![Dashboard10](img/fiskaly_verifactu16.png)

### 7. Crear cliente a la organizaci�n gestionada.

- El siguiente paso es crear clientes, el flujo de trabajo incluye la creaci�n de createClient a trav�s del endpoint **create a first Client**. Debes crear un Cliente para cada dispositivo POS u otros dispositivos de facturaci�n utilizados en tu organizaci�n.


![Dashboard10](img/fiskaly_verifactu17.png)


- En la respuesta, obtenemos el idcliente el cual tendremos que reservar junto a la api y la api secret para introducirlos en el ERP.

![Dashboard10](img/fiskaly_verifactu18.png)


### 8. Configuraci�n en el ERP

- En el ERP hay que configurar: 

    1. Datos obtenidos de Fiskaly al realizar la creaci�n de la empresa gestionada.

    2. Claves que son espec�ficas de Veri*factu.

    3. Declaraci�n Responsable del programa

    4. Versi�n SIF

    5. Descargar, Firmar y Subir acuerdo de Fiskaly
 
 #### 8.1. Configuraci�n de los datos obtenidos en Fiskaly

- En la pesta�a VERI*FACTU del formulario de empresa informaremos los siguientes campos:

* API Identificador --> Informamos el valor obtenido en el punto 4 **clave API**.

* API Secret --> Informamos el valor obtenido en el punto 4 clave **API secret**.

* URL --> Valor fijo: ![Dashboard10](img/fiskaly_verifactu20.png)

* Id.Cliente --> Valor obtenido en el punto 7 en el campo **id**.

![Dashboard10](img/fiskaly_verifactu19.png)

#### 8.2. Claves que son espec�ficas de Veri*factu.

##### 8.2.1. Reg�menes de IVA espec�ficos de Veri*Factu

En el **�rea de Facturaci�n -> Principal -> M�s -> Fiscalidad -> Reg�menes IVA Veri*Factu** hay que crear los distintos reg�menes de iva que puede utilizar Verifactu:

![Dashboard10](img/fiskaly_verifactu21.png)

![Dashboard10](img/fiskaly_verifactu22.png)


##### 8.2.2. Reg�menes de IVA espec�ficos de Veri*Factu

En el **�rea de Facturaci�n -> Principal -> M�s -> Fiscalidad -> Causas Excepci�n IVA Veri*Factu** crearemos las distintas causas por las que ser� exento o no sujeto el iva de una factura seg�n la nomenclatura de Verifactu:

![Dashboard10](img/fiskaly_verifactu23.png)

![Dashboard10](img/fiskaly_verifactu24.png)

##### 8.2.3. Actualizar paises

- Todos los pa�ses deben de tener el codigo ISO informado
- Es necesario poder saber si un pa�s es Europeo o no por lo que hay que marcar el check de Pertenece a U.E. en los paises que corresponda

![Paises](img/fiskaly_verifactu33.png)

##### 8.2.4. Grupos contables Veri*Factu

En este apartado se configurar�n grupos de iva de negocio para cada tipo de factura que se pueda tener.

Estos grupo de iva de negocio viene de la extensi�n **IVA_NAV** por lo que si la mezcla ya ten�a dicha extensi�n solo habr� que configurar los campos nuevos de Verifactu que se han a�adido, si no se tiene la extensi�n de **IVA_NAV**, habr� que crear distinos grupos de iva de negocio como si se tuviera la extensi�n, configurar los campos de Verifactu y asign�rselos a los clientes seg�n su naturaleza.

En el **�rea de Facturaci�n -> Principal -> M�s -> Fiscalidad -> Grupos Contables Veri*Factu** crearemos/configuraremos dichos grupos:

![Dashboard10](img/fiskaly_verifactu25.png)

Los campos que hay que configurar de Verifactu son:

- R�gimen IVA Veri*Factu --> Se informar� un r�gimen de IVA especifico de Verifactu acorde a la naturaleza del grupo de iva de negocio

- Causa Exenci�n IVA Veri*Factu --> Cuando proceda, se informar� una la causa de exenci�n de iva Verifactu acorde al r�gimen de iva de Verifactu que se haya informado

- R�gimen IVA --> Si no se tiene la extensi�n de IVA_NAV, se informar� tambi�n el ?egimen de IVA.

**Configuraci�n B�sica de grupos de Iva de Negocio**

- Dejamos unos ejemplo de como podr�an ser los 4 grupos b�sicos de iva de negocio:

1. Clientes Nacionales en R�gimen General:

![Dashboard10](img/fiskaly_verifactu26.png)

2. Clientes Exentos:

![Dashboard10](img/fiskaly_verifactu27.png)

3. Clientes Exportaci�n:

![Dashboard10](img/fiskaly_verifactu28.png)

4. Clientes Intracomunitarios:

![Dashboard10](img/fiskaly_verifactu29.png)


#### 8.3. Declaraci�n Responsable del programa (Eneboo)

Es obligatorio que la declaraci�n responsable del programa sea accesible desde el ERP.

En el **�rea de Facturaci�n -> Facturaci�n -> M�s -> Principal -> Garante Sign** se encuentra el bot�n de **Declaraci�n Responsable Eneboo** el cual al pulsar debe de mostrar la declaraci�n responsable.

![Dashboard10](img/fiskaly_verifactu30.png)

Para que este bot�n funcione, en la mezcla habr�a que sobrecargar la funci�n **veriFactu_dameURLDeclaracionResponsable** de tal forma que devuelva una URL:

```
    function veriFactu_dameURLDeclaracionResponsable()
    {
	    return "(No definido)";
    }
```

```
    function mezclaCliente_dameURLDeclaracionResponsable()
    {
	    return "https://xxx.pdf";
    }
```

#### 8.4. Versi�n SIF

Otro elemento que es obligatiorio que se muestre en el ERP es la versi�n SIF.

La version SIF es la versi�n de la parte del ERP que se dedica a la facturaci�n y env�o de facturas a la AEAT. Este n�mero de versi�n es el que hay que indicar en la declaraci�n responsable que cada empresa debe colgar el su web y ser accesible desde Eneboo. Si tenemos varias instalaciones, cada una con un n�mero de versi�n, debemos tener publicadas otras tantas declaraciones responsables.

Si se cambia el software del SIF, habr�a que cambiar la versi�n y el documento. Esto lo debe hacer cada empresa para asegurarnos de que las declaraciones - versiones de cada uno de nosotros est�n bien publicadas y sean coherentes.

A medida que vayamos variando el software por incidencias o ajustes podemos ver si es mejor llevar una versi�n com�n todos o que cada uno lo haga por separado, pero el tema de la publicaci�n de la declaraci�n con el mismo c�digo de versi�n es una tarea individual de cada empresa.


En el **�rea de Facturaci�n -> Facturaci�n -> M�s -> Principal -> Garante Sign** est� visible la Versi�n SIF.

![Dashboard10](img/fiskaly_verifactu31.png)

Para que este bot�n funcione, en la mezcla habr�a que sobrecargar la funci�n **veriFactu_mostrarVersionSIF** de tal forma que devuelva una URL:

```
    function veriFactu_mostrarVersionSIF() {
	    return "(No definido)";
    }
```

```
    function mezclaCliente_mostrarVersionSIF() {
	    return "xx.xx";
    }
```


#### 8.5. Descargar, Firmar y Subir acuerdo de Fiskaly

Para que Fiskaly pueda realizar las presentaciones en nombre del cliente, hay que firmar un acuerdo de facturaci�n con Fiskaly.

En el **�rea de Facturaci�n -> Facturaci�n -> M�s -> Principal -> Garante Sign** hay un bot�n para descargar el acuerdo y un bot�n para subir el acuerdo una vez firmado con certificado digital.

![Dashboard10](img/fiskaly_verifactu32.png)

1. Descargar acuerdo: Habr�a que pulsar sobre el bot�n de **Descargar acuerdo para firmar**, este bot�n descargar� un fichero el cual habr� que firmar digitalmente.


2. Subir acuerdo: Habr�a que pulsar sobre el bot�n de **Subir acuerdo**, este bot�n nos pedir� que seleccionemos el acuerdo ya firmado y lo subir� a Fiskaly.

### 9. Impresi�n de facturas

- En las facturas que se impriman, tienen que tener el QR generado al presentarse, para ello nos ayudaremos de las siguientes funciones que est�n en *flfactinfo* para poder imprimir tanto en **.jasper** como en **.kut**.

```
    veriFactu_crearFicheroVeriFactu(curFactura : FLSqlCursor)
    veriFactu_qrVeriFactu(nodo : FLDomNode , campo : String)

```

- El QR debe de seguir las especificaciones que est�n incluidas en el siguiente documento:

https://www.agenciatributaria.es/static_files/AEAT_Desarrolladores/EEDD/IVA/VERI-FACTU/DetalleEspecificacTecnCodigoQRfactura.pdf

- Las m�s importantes son:

    - Se tiene que imprimir en la primera p�gina, arriba centrado.
    - El tama�o tiene que ser entre 3x3 y 4x4 cm.
    - El QR tiene que ir precedido por el texto **QR tributario:**
    - El QR tiene que ir sucedido por el texto **Factura verificable en la sede electr�nica de la AEAT** o **VERI*FACTU**


![ERP](img/fiskaly30.png)