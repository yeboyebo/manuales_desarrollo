# Glosario

## API

Una API (del inglés, application programming interface, en español, interfaz de programación de aplicaciones)1 es una pieza de código que permite a diferentes aplicaciones comunicarse entre sí y compartir información y funcionalidades. Una API es un intermediario entre dos sistemas, que permite que una aplicación se comunique con otra y pida datos o acciones específicas.

Por ejemplo, si se tiene una app para móviles acerca de recetas y se hace una búsqueda de una determinada receta, se puede utilizar una API para que esta aplicación se comunique con el sitio web de recetas y pida las recetas que cumplen con los criterios de búsqueda. La API entonces se encarga de recibir la solicitud, buscar las recetas apropiadas y regresar los resultados a la aplicación. Una API es una forma de conectar diferentes aplicaciones y hacer que trabajen juntas de manera más eficiente y efectiva

En yeboyebo hemos desarrollado una API de acceso al ERP ([pinebooapi](../pineboo_server/index.md) 

Para más información consultar [quí](https://es.wikipedia.org/wiki/API)


## CMS

Un CMS (Content Management System) o sistema de gestión de contenidos es una aplicación de software que permite a los usuarios colaborar en la creación, edición y producción de contenido digital: páginas web, blogs, etc. Un CMS funciona con un panel de administración o back-end. Se accede a través del navegador y tiene una interfaz basada en formularios que permiten crear contenidos de forma sencilla.

Para más información consultar [quí](https://www.arimetrics.com/glosario-digital/cms)

## CRM

Un CRM (Customer Relationship Management) es un software que contiene toda la información de los clientes y partners de una empresa y que es capaz de compartirla con todas las áreas clave de la compañía como ventas, marketing o atención al cliente. Pero un CRM no solo permite el acceso a toda la información clave, también permite llevar un seguimiento de las interacciones y transacciones con ellos y analizar esta información para mejorar la satisfacción del cliente y aumentar la rentabilidad de la empresa.

En yeboyebo tenemos un módulo de CRM que permite realizar las acciones más comunes en un centro de atención al cliente. Control de las comunicaciones e incidencias de clientes, gestión de contactos, diseño, crear y monitorizar campañas de marketing a clientes, así como realizar mailings por disintos canales (correo convencional, e-mail, teléfono, etc.)

## ERP

Un ERP es un software que permite a las empresas controlar todos los flujos de información que se generan en cada ámbito de la organización. Sus siglas en inglés representan Enterprise Resource Planning o sistema de planificación de recursos empresariales en español. 

El objetivo de los sistemas ERP es integrar los departamentos. Donde antes teníamos un programa especializado para cada uno, ahora, podemos asegurar la existencia de una única base de datos centralizada donde se gestione la información en tiempo real y con eficiencia.

De este modo, los ERP suelen estar integrados por diferentes módulos, correspondientes a cada departamento. Los componentes más comunes son los de compras, ventas, inventario, logística, facturación, contabilidad, recursos humanos (RRHH) y CRM (Customer Relationship Management).

El objetivo de cualquier sistema ERP es el de ayudar a una empresa en sus tareas de administración y toma de decisiones, automatizando todos sus procesos. Gracias a ello podemos obtener datos en tiempo real, mejorar tareas de back office, controlar flujos de trabajo y minimizar errores. Por ejemplo, cuando se habla de llevar la contabilidad, el usuario solo tendrá que preocuparse por conseguir ventas. Del resto (crear facturas y contabilizar gastos) se encargará el programa.

En yeboyebo programamos y comercializamos el ERP Eneboo que se compone de distintos módulos y extensiones

## Postman

Postman es una plataforma que permite y hace más sencilla la creación y el uso de APIs. Esta herramienta es muy útil para programar porque da la posibilidad hacer pruebas y comprobar el correcto funcionamiento de los proyectos que realizan los desarrolladores web. ¡Todo en base a una extensión en Google Chrome! 

Postman es gratuito, si trabajas solo, o de pago, si quieres trabajar de manera colaborativa.  

Gracias a los avances en tecnología, Postman ha pasado de ser una extensión a ser una aplicación que cuenta con herramientas nativas para varios sistemas operativos, entre los que se encuentran los principales: Windows, Mac y Linux.

En yeboyebo utilizamos postman para hacer pruebas de los servicios web que programamos en nuestras APIs antes de realizar los desarrollos.

Para más información consultar [quí](https://assemblerinstitute.com/blog/que-es-postman/)

## RDP

El RDP o Remote Desktop Protocol es un protocolo de comunicación desarrollado por Microsoft que le permite a un usuario conectarse y controlar un ordenador remoto a través de una red. RDP se utiliza principalmente en entornos empresariales y de negocios, donde los usuarios necesitan acceder a recursos y aplicaciones en equipos remotos desde un dispositivo local

Para más información consultar [quí](https://keepcoding.io/blog/que-es-un-rdp-o-remote-desktop-protocol/)

## Request o petición HTTP

Una petición HTTP es una conexión entre un equipo que hace de cliente y el servidor a través de la cual el el cliente solicita o envia datos al servidor. Hay varios tipos de métodos de petición HTTP, que modifican completamente el tipo de respuesta que obtienes del servidor. Los más comunes son:

- __GET__. Es el método de petición HTTP más utilizado. Una petición GET solicita al servidor una información o recurso concreto. Cuando te conectas a un sitio web, tu navegador suele enviar varias peticiones GET para recibir los datos que necesita para cargar la página.
- __HEAD__. Con una petición HEAD, sólo recibes la información de la cabecera de la página que quieres cargar. Puedes utilizar este tipo de petición HTTP para conocer el tamaño de un documento antes de descargarlo mediante GET.
- __POST__. Tu navegador utiliza el método de petición HTTP POST cuando necesita enviar datos al servidor. Por ejemplo, si rellenas un formulario de contacto en un sitio web y lo envías, estás utilizando una petición POST para que el servidor reciba esa información.
- __PUT__. Las peticiones PUT tienen una funcionalidad similar a la del método POST. Sin embargo, en lugar de enviar datos, utilizas las peticiones PUT para actualizar información que ya existe en el servidor final.

En yeboyebo utilizamos este tipo de peticiones para hacer por ejemplo sincronizacines de datos entre el ERP y la página web.

Para más información consultar [quí](https://kinsta.com/es/base-de-conocimiento/que-es-una-peticion-http/#:~:text=Presentar%20una%20solicitud%20HTTP%20implica,o%20redirigirte%20a%20otra%20p%C3%A1gina)

## Remmina

Es un software completamente gratuito, que nos va a permitir conectarnos de forma remota a nuestro ordenador o servidor Linux, utilizando diferentes protocolos para ello, y sin la necesidad de instalar más software adicional en el ordenador cliente.

En yeboyebo utilizamos remina para conectar al servidor de nuestros clientes y poder realizar instlaciones o resolver posibles incidencias

## Sandbox

Un sandbox o un entorno de pruebas, es una máquina virtual aislada en la que se puede ejecutar código de software potencialmente inseguro sin afectar a los recursos de red o a las aplicaciones locales.

## SCP

Secure Copy Protocol (SCP), es un protocolo que garantiza la transferencia segura de datos entre un equipo local (host local) y un equipo remoto (host remoto) o, alternativamente, entre dos equipos remotos. Se basa en los comandos RCP, (remote copy), que se publicaron en 1982 como parte de los “comandos r” de la Universidad de California (Berkeley). Permiten el control de la transmisión de datos a través de la línea de comandos.

SCP ofrece un método de autenticación entre los dos equipos, así como un cifrado de la transmisión. Por lo tanto, el protocolo no solo garantiza la seguridad, sino también la autenticidad de los datos transferidos. En ambos mecanismos de seguridad el SCP protocol se basa en SSH (Secure Shell), que también se utiliza en protocolos alternativos de transmisión como FTP (o SFTP). El puerto TCP que utiliza para la transferencia a través de SCP es el puerto estándar SSH 22.

Para más información consultar [quí](https://www.ionos.es/digitalguide/servidores/know-how/scp-secure-copy/)

## SSH

SSH (o Secure SHell, en español: intérprete de órdenes seguro) es el nombre de un protocolo y del programa que lo implementa cuya principal función es el acceso remoto a un servidor por medio de un canal seguro en el que toda la información está cifrada. Además de la conexión a otros dispositivos, SSH permite copiar datos de forma segura (tanto archivos sueltos como simular sesiones FTP cifradas), gestionar claves RSA para no escribir contraseñas al conectar a los dispositivos y pasar los datos de cualquier otra aplicación por un canal seguro tunelizado mediante SSH y también puede redirigir el tráfico del (Sistema de Ventanas X) para poder ejecutar programas gráficos remotamente. El puerto TCP asignado es el 22.

En yeboyebo utilizamos ssh para conectar al servidor de nuestros clientes y poder realizar instlaciones o resolver posibles incidencias

Para más información consultar [quí](https://es.wikipedia.org/wiki/Secure_Shell)

## TPV

TPV hace referencia al “Terminal Punto de Venta”, un concepto esencial en el comercio electrónico,
El TPV es la tecnología o sistema informático que permite gestionar todo el proceso de venta de un negocio –los tickets, las facturas, las ventas, etc.–. Introducimos los productos con el código de referencia y a partir de él se realizarán las operaciones de gestión.

Un TPV eficaz organiza de manera rápida las funciones relacionadas con el proceso de venta, de forma que las operaciones comerciales se pueden hacer de manera mucho más ágil y eficiente que con las ya obsoletas cajas registradoras. Además permite hacer cobros por tarjeta bancaria, lo que lleva a aumentar la fluidez de las ventas.

En yeboyebo tenemos un módulo de tpv que permite la gestión de los tickets, comandas y, en general, los datos y funcionalidades clave de la venta directa

Para más información consultar [quí](https://www.tpvcenter.com/que-es-tpv/)

## Web Service

Un servicio web (en inglés, web service o web services) es una tecnología que utiliza un conjunto de protocolos y estándares que sirven para intercambiar datos entre aplicaciones. Distintas aplicaciones de software desarrolladas en lenguajes de programación diferentes, y ejecutadas sobre cualquier plataforma, pueden utilizar los servicios web para intercambiar datos en redes de ordenadores como Internet. La interoperabilidad se consigue mediante la adopción de estándares abiertos. 

Para más información consultar [aquí](https://es.wikipedia.org/wiki/Servicio_web)