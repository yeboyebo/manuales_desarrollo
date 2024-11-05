# Resumen Disposición 

## Artículo 6. Integridad e inalterabilidad de los registros de facturación

a) Para cada registro de facturación que genere, el sistema informático deberá
calcular, de acuerdo con lo especificado en el artículo 13 de esta orden, su
correspondiente huella o «hash» a que se refiere el artículo 12 del Reglamento.

b) El sistema informático deberá ser capaz de comprobar si es correcta la huella o
«hash» de cualquier registro de facturación individual generado, permitiendo realizar esta
comprobación, bajo demanda, de forma rápida, fácil e intuitiva.

c) El sistema informático deberá firmar electrónicamente, de acuerdo con lo
especificado en el artículo 14, todos los registros de facturación que genere.

d) El sistema informático deberá ser capaz de comprobar si es correcta la firma
electrónica de cualquier registro de facturación individual generado, permitiendo realizar
esta comprobación, bajo demanda, de forma rápida, fácil e intuitiva.

e) El sistema informático deberá ser capaz de comprobar si es correcta toda o una
determinada parte de la cadena de registros de facturación a que se refiere el primer
párrafo del artículo 7, al menos cuando se conserve en el propio sistema informático,
permitiendo realizar esta comprobación, bajo demanda, de forma rápida, fácil e intuitiva.

f) Cuando el sistema informático detecte cualquier tipo de circunstancia que impida
garantizar o que vulnere o pueda vulnerar la integridad e inalterabilidad de los registros
de facturación generados, o de su encadenamiento, deberá:
1.º Mostrar una alarma que indique claramente este hecho. Dicha alarma no deberá
desactivarse hasta que no se pueda volver a garantizar la integridad e inalterabilidad de
los siguientes registros de facturación y su encadenamiento.
2.º Generar el correspondiente registro de evento que informe sobre el hecho
detectado, de acuerdo con lo especificado en el artículo 9.

## Artículo 7. Trazabilidad de los registros de facturación

La trazabilidad de los registros de facturación generados por el sistema informático, a
que se refiere el artículo 8.2.b) del Reglamento, se garantizará cumpliendo los siguientes
requisitos:
a) Cada registro de facturación, de alta o de anulación, contendrá el siguiente
conjunto de datos referido al registro de facturación, de alta o de anulación,
inmediatamente anterior por orden cronológico de fecha de generación:
1.º NIF del obligado a expedir la factura a que se refiere el registro de facturación
inmediatamente anterior.
2.º Número de serie y número de la factura a que se refiere el registro de
facturación inmediatamente anterior.
3.º Fecha de expedición de la factura a que se refiere el registro de facturación
inmediatamente anterior.
4.º Los primeros 64 caracteres de la huella o «hash» del registro de facturación
inmediatamente anterior.

En los artículos 10 y 11 constan los detalles sobre estos campos.
b) La única excepción al contenido de la letra a) se dará cuando no haya registro de
facturación anterior por tratarse del primer registro de facturación generado en el sistema
informático desde su instalación o puesta en marcha inicial, en cuyo caso no será
necesario incluir los datos de la letra a) pero se deberá identificar dicho registro como el
primer registro de la cadena.
c) __Para un determinado obligado tributario, cada sistema informático producirá una única cadena de registros de facturación, es decir, todos los registros de facturación de un mismo obligado tributario generados por un mismo sistema informático deberán formar parte de la misma cadena.__ (no por serie)
d) La cadena de registros de facturación generada contendrá tanto los registros de
facturación de alta como los registros de facturación de anulación.
e) El sistema informático deberá incorporar a los registros de facturación la fecha y
hora exactas del momento en que son generados, de acuerdo al territorio desde donde
se expide la correspondiente factura. Si el sistema informático no cuenta con la
capacidad de proporcionar esos datos por sus propios medios, podrá tomarlos de otros
sistemas que incorporen reloj.
f) En cualquier caso, el obligado tributario usuario del sistema informático deberá
asegurarse de que la fecha y hora empleadas por dicho sistema informático para fechar
los registros de facturación son exactas, con un margen máximo de error admitido de un
minuto.
g) La fecha y hora de generación de cada registro de facturación deberá incluir el
huso horario aplicado en el momento de la generación del registro, todo ello de acuerdo
con lo especificado en los artículos 10.c) y 11.c).
BOLETÍN OFICIAL DEL ESTADO
Núm. 260 Lunes 28 de octubre de 2024 Sec. I. Pág. 137534cve: BOE-A-2024-22138
Verificable en https://www.boe.es
h) El sistema informático deberá permitir realizar el seguimiento de la secuencia de
la cadena de registros de facturación, tanto hacia delante como hacia atrás, de forma
rápida, fácil e intuitiva.
A tal efecto, al menos deberá permitir que, a partir de cualquier registro de
facturación existente en el sistema informático, se pueda saltar al anterior (siempre que
este se encuentre disponible en el sistema informático) o al posterior (excepto si el
registro de partida fuera el último generado) dentro de la cadena de registros de
facturación, indicando de forma clara y visible si para ese salto dado el encadenamiento
de la huella o «hash» es correcto o no y si las respectivas fechas y horas de generación
respetan el orden temporal entre sí y con respecto a la fecha actual del sistema.
Adicionalmente, el sistema informático podrá ofrecer el lanzamiento, periódico o bajo
demanda, de un proceso de comprobación de toda o de parte de la cadena de registros
de facturación. En caso de que se trate de una comprobación parcial, se deberá permitir
especificar de alguna manera qué parte de la cadena se comprobará.
i) Salvo cuando se trate del primer registro de facturación, cada vez que el sistema
informático vaya a generar un nuevo registro de facturación, de alta o de anulación,
antes deberá comprobar que se cumplen los siguientes requisitos:
1.º El último registro de facturación generado está correctamente encadenado.
2.º La fecha y hora de generación del último registro de facturación generado no es
superior en más de un minuto a la fecha y hora actuales que se utilizarán para fechar el
registro de facturación a generar.
j) Cuando el sistema informático detecte cualquier tipo de circunstancia que impida
garantizar o que vulnere o pueda vulnerar la trazabilidad y el encadenamiento de los
registros de facturación generados, deberá avisar de ello, procediendo de la misma
forma que se indica en el artículo 6.f)

## Artículo 8. Conservación, accesibilidad y legibilidad de los registros de facturación.
1. El sistema informático deberá garantizar la conservación de todos los registros
de facturación generados por él que se encuentren dentro del propio sistema informático,
independientemente del método o lugar empleado para hacerlo, y deberá permitir el
acceso a donde estos se conserven, así como su recuperación y consulta en formato
electrónico legible por parte de la Administración tributaria.
2. Los registros de facturación podrán ser conservados fuera del sistema
informático que los generó. Para ello, este deberá permitir descargar, volcar o copiar y
archivar de forma segura, mediante su exportación a un soporte de almacenamiento
externo en formato electrónico legible, los registros de facturación generados en él. El
resultado de la exportación deberá contener la copia fidedigna de todos los registros de
facturación exportados.
A este respecto, deberá ofrecer, al menos, la posibilidad de exportar todos los
registros de facturación generados en un periodo.
Únicamente formando parte de un proceso de exportación correcto, los registros de
facturación exportados podrán dejar de ser conservados por el sistema informático, en
cuyo caso deberá avisar claramente de esta circunstancia, siempre y cuando ello no
suponga el incumplimiento por este de ningún requisito del Reglamento y de esta orden.
Además, para evitar la aparición de huecos entre los registros de facturación
conservados en el sistema informático, esta posibilidad de dejar de conservarlos solo
podrá aplicarse a registros de facturación consecutivos empezando siempre por los más
antiguos que aún se conserven en el sistema informático.
El proceso de exportación deberá ser independiente de la política de copias de
seguridad de los datos que pudieran establecerse para el sistema informático.
3. En cualquier caso, el obligado tributario usuario del sistema informático deberá
garantizar, durante el mismo plazo previsto para la conservación de las copias o matrices
de las facturas expedidas según el artículo 19.1 del Reglamento por el que se regulan
BOLETÍN OFICIAL DEL ESTADO
Núm. 260 Lunes 28 de octubre de 2024 Sec. I. Pág. 137535cve: BOE-A-2024-22138
Verificable en https://www.boe.es
las obligaciones de facturación, aprobado por el Real Decreto 1619/2012, de 30 de
noviembre, la conservación, accesibilidad y legibilidad de todos los registros de
facturación generados correspondientes a las facturas por él expedidas a lo largo del
tiempo, se encuentren o no en el sistema informático que los generó, e incluso cuando
se haya cambiado de sistema informático.
4. El acceso a las funcionalidades del sistema informático necesarias para llevar a
cabo las acciones mencionadas en los apartados 1 y 2 sobre los datos que obren en él
deberá poderse realizar por el usuario del mismo de forma rápida, fácil e intuitiva.
Asimismo, el resultado de aplicar esas funcionalidades sobre dichos datos,
especialmente en el caso del acceso para su consulta, deberá ser efectivo con prontitud
desde el momento del lanzamiento de su ejecución. Todo ello con independencia de
dónde se encuentren conservados los datos del sistema informático.
5. A los efectos de legibilidad, la información conservada, o en su caso exportada,
deberá mantener la estructura y formato indicados en los artículos 10 y 11, de acuerdo
con el tipo de registro de facturación de que se trate

## Artículo 9. Registro de eventos.
1. El sistema informático deberá ser capaz de detectar y registrar cuando se
produzcan, al menos, los siguientes eventos:
a) Inicio del funcionamiento del sistema informático como «NO VERI*FACTU».
b) Fin del funcionamiento del sistema informático como «NO VERI*FACTU».
c) Lanzamiento del proceso de detección de anomalías en los registros de
facturación.
d) Detección de anomalías en la integridad, inalterabilidad y trazabilidad de
registros de facturación.
e) Lanzamiento del proceso de detección de anomalías en los registros de evento.
f) Detección de anomalías en la integridad, inalterabilidad y trazabilidad de registros
de evento.
g) Restauración de copia de seguridad, cuando esta se gestione desde el propio
sistema informático de facturación.
h) Exportación de registros de facturación generados en un periodo.
i) Exportación de registros de evento generados en un periodo.
2. Adicionalmente, el sistema informático deberá generar, por cada 6 horas que
haya estado operativo y disponible para su uso, al menos, un registro resumen de los
eventos sucedidos desde que se generó el registro resumen de eventos anterior, o bien
desde el inicio de funcionamiento del sistema informático de acuerdo al Reglamento si
no se hubiera generado aún ningún registro resumen de eventos anterior.
En caso de que en ese espacio de tiempo no se hubiera dado ningún evento de los
señalados en el apartado 1, el registro resumen de eventos se generará igualmente y
reflejará de manera adecuada dicha circunstancia, de acuerdo con lo especificado al
respecto en el apartado 4.
El sistema informático también deberá generar un registro resumen de eventos antes
de cerrarse o apagarse.
Este registro resumen de eventos tendrá el mismo tratamiento que los registros de
evento señalados en el apartado 1, por lo que puede considerarse un evento registrado
más.
3. Los registros de evento deberán realizarse de tal forma que queden garantizadas
sus características de integridad, inalterabilidad, trazabilidad, conservación, accesibilidad
y legibilidad, tal y como se exige para los registros de facturación. Para ello deberán
cumplir de forma análoga las especificaciones contenidas en los artículos 6, 7 y 8, donde
todas las referencias a los registros de facturación y sus datos deberán entenderse
BOLETÍN OFICIAL DEL ESTADO
Núm. 260 Lunes 28 de octubre de 2024 Sec. I. Pág. 137536cve: BOE-A-2024-22138
Verificable en https://www.boe.es
hechas a los registros de evento y sus datos, que son los indicados en el artículo 9.4. En
particular, los datos de los registros de evento equivalentes a los mencionados en el
artículo 7.a) son los que conforman la agrupación «EventoAnterior» del diseño del
registro de evento del apartado 5 del anexo. Asimismo, la responsabilidad y el plazo de
conservación establecidos en el artículo 8.3 también se aplican a los registros de evento
generados por cada sistema informático del obligado tributario. Por último, el artículo 7.d)
no es de aplicación en el caso de los registros de evento.
4. Los sistemas informáticos deberán generar los registros de evento de acuerdo a
los siguientes requisitos:
a) Formato XML.
b) Codificación UTF-8.
c) Estructura, contenido y formato según se describen en el apartado 5 del anexo

## Artículo 10. Registro de facturación de alta.
Los sistemas informáticos deberán generar el registro de facturación de alta de
acuerdo a los siguientes requisitos:
a) Formato XML.
b) Codificación UTF-8.
c) Estructura, contenido y formato según se describe en el apartado 3 del anexo.
Artículo 11. Registro de facturación de anulación.
Los sistemas informáticos deberán generar el registro de facturación de anulación de
acuerdo a los siguientes requisitos:
a) Formato XML.
b) Codificación UTF-8.
c) Estructura, contenido y formato según se describe en el apartado 3 del anexo

## Artículo 13. Huella o «hash» de los registros de facturación y de evento.
1. La información con la que se generará la huella o «hash» se basará en un
subconjunto de datos del registro de facturación o de evento, según corresponda:
a) Para el registro de facturación de alta:
1.º NIF del emisor.
2.º Numero de factura y serie.
3.º Fecha de expedición de la factura.
4.º Tipo de factura.
5.º Cuota total.
6.º Importe total.
7.º Huella del registro de facturación anterior.
8.º Fecha, hora y huso horario de generación del registro.
b) Para el registro de facturación de anulación:
1.º NIF del emisor.
2.º Numero de factura y serie.
3.º Fecha de expedición de la factura.
4.º Huella del registro de facturación anterior.
5.º Fecha, hora y huso horario de generación del registro.
c) Para el registro de evento:
1.º Identificador del productor del sistema informático.
2.º Identificador del sistema informático.
3.º Versión del sistema informático.
4.º Numero de instalación del sistema informático.
5.º NIF del obligado a emisión.
6.º Tipo de evento.
7.º Huella del registro de evento anterior.
8.º Fecha, hora y huso horario de generación del registro.
2. Para el cálculo de la huella o «hash» se usarán el algoritmo y codificación
indicados en el documento técnico que se publicará en la sede electrónica de la Agencia
Estatal de Administración Tributaria.
3. La huella o «hash» generada deberá almacenarse en el registro de facturación o
de evento al que corresponde, de acuerdo con lo especificado respectivamente en los
artículos 10.c), 11.c) y 9.4.c)

## Artículo 14. Firma electrónica de los registros de facturación y de evento.
La firma electrónica de los registros de facturación y de evento se basará en el
estándar del Instituto Europeo de Normas de Telecomunicaciones ETSI EN 319 132 y
utilizará el tipo de firma «XAdES Enveloped Signature» con los detalles técnicos que
para su generación se recojan en la sede electrónica de la Agencia Estatal de
Administración Tributaria.
En todo caso, la firma electrónica deberá ser generada con una clave privada
asociada a un certificado electrónico cualificado de firma electrónica en vigor. Dicho
certificado debe haber sido emitido por un proveedor de servicios de confianza
cualificado que cumpla con los requisitos establecidos en el Reglamento (UE) N.º
910/2014 del Parlamento europeo y del Consejo, de 23 de julio de 2014, y esté incluido
en la lista de proveedores de confianza de la UE (EU/EEA Trusted List).
La firma electrónica generada deberá almacenarse en el registro de facturación o de
evento al que corresponde, de acuerdo con lo especificado en los artículos 9.4.c), 10.c)
y 11.c).

## Artículo 15. Contenido de la declaración responsable y ubicación de la misma.
1. La declaración responsable comenzará con el título «DECLARACIÓN
RESPONSABLE DEL SISTEMA INFORMÁTICO DE FACTURACIÓN» y, a continuación,
deberá contener, al menos, la siguiente información, en el mismo orden en que se indica.
Cada dato aportado deberá precederse del texto que lo describe, de acuerdo con lo
redactado en la letra con la cual se corresponde:
a) Nombre del sistema informático a que se refiere la declaración responsable. Con
carácter general será la denominación genérica dada al mismo para su distribución o
comercialización.
b) Código identificador del sistema informático a que se refiere el apartado 1.a), de
acuerdo con las especificaciones dadas en el apartado 2.6 del anexo. Se trata de una
codificación a establecer por la persona o entidad productora del sistema informático a
que se refiere la declaración responsable de manera que sirva para identificar
unívocamente al mismo de una forma breve, en lugar de hacerlo de una forma más
extensa mediante el nombre indicado en el apartado 1.a). Este código no podrá coincidir
con el de otro sistema informático distinto que pueda producir dicha persona o entidad.
c) Identificador completo de la versión concreta del sistema informático a que se
refiere la declaración responsable.
d) Componentes, hardware y software, de que consta el sistema informático a que
se refiere la declaración responsable, junto con una breve descripción de lo que hace
dicho sistema informático y de sus principales funcionalidades.
e) Indicación de si el sistema informático a que se refiere la declaración
responsable se ha producido de tal manera que, a los efectos de cumplir con el
Reglamento, solo pueda funcionar exclusivamente como «VERI*FACTU», de acuerdo
con las especificaciones dadas en el apartado 2.6 del anexo.
f) Indicación de si el sistema informático a que se refiere la declaración responsable
permite ser usado por varios obligados tributarios o por un mismo usuario para dar
soporte a la facturación de varios obligados tributarios, de acuerdo con las
especificaciones dadas en el apartado 2.6 del anexo.
g) Tipos de firma utilizados para firmar los registros de facturación y de evento en el
caso de que el sistema informático a que se refiere la declaración responsable no sea
utilizado como «VERI*FACTU».
h) Nombre y apellidos de la persona o razón social de la entidad productora del
sistema informático a que se refiere la declaración responsable.
i) Número de identificación fiscal (NIF) español de la persona o entidad productora
del sistema informático a que se refiere la declaración responsable. Si no dispone de NIF
español, deberá hacer constar otro número de identificación de que disponga, indicando
de qué tipo de identificación se trata y el país que lo ha emitido, todo ello de acuerdo con
las especificaciones dadas al respecto en el apartado 2.6 del anexo.
j) Dirección postal completa de contacto de la persona o entidad productora del
sistema informático a que se refiere la declaración responsable.
k) La persona o entidad productora del sistema informático a que se refiere la
declaración responsable deberá hacer constar que dicho sistema informático, en la versión
indicada en ella, cumple con lo dispuesto en el artículo 29.2.j) de la Ley 58/2003, de 17 de
diciembre, General Tributaria, en el Reglamento que establece los requisitos que deben
adoptar los sistemas y programas informáticos o electrónicos que soporten los procesos de
facturación de empresarios y profesionales, y la estandarización de formatos de los registros
de facturación, aprobado por el Real Decreto 1007/2023, de 5 de diciembre, en esta orden y
en la sede electrónica de la Agencia Estatal de Administración Tributaria para todo aquello
que complete las especificaciones de esta orden.
BOLETÍN OFICIAL DEL ESTADO
Núm. 260 Lunes 28 de octubre de 2024 Sec. I. Pág. 137539cve: BOE-A-2024-22138
Verificable en https://www.boe.es
l) Fecha y lugar en los que la persona o entidad productora del sistema informático
suscribe la declaración responsable del mismo. La fecha ha de ser completa, es decir,
deberá indicar día, mes y año, en ese orden. El lugar deberá contener, al menos, el
nombre de la localidad y el nombre del país, en ese orden.
2. Tras la información obligatoria, se recomienda que, a modo de anexo, la
declaración responsable contenga la siguiente información adicional:
a) Otras formas de contacto con la persona o entidad productora del sistema
informático a que se refiere la declaración responsable, distintas a la indicada en el
apartado 1.j).
b) En caso de que existan, direcciones de Internet de la persona o entidad
productora del sistema informático a que se refiere la declaración responsable,
especialmente aquellas con información sobre dicho sistema informático.
c) Explicación detallada de cómo cumple el sistema informático a que se refiere la
declaración responsable las diferentes especificaciones técnicas y funcionales
contenidas en esta orden.
d) Cualquier otra información adicional que la persona o entidad productora del
sistema informático a que se refiere la declaración responsable considere de interés al
respecto.
3. La declaración responsable deberá encontrarse disponible de manera legible e
individualizada dentro del propio sistema informático a que se refiere y ser accesible por
el usuario de forma rápida, fácil e intuitiva. Asimismo, deberá ponerse a disposición del
comercializador y del cliente, tanto en el momento de su adquisición como
posteriormente, en papel o electrónicamente en un formato de uso ampliamente
extendido y gratuito.
4. En caso de que el sistema informático sea ampliado con otros componentes,
hardware o software, producidos por otras personas o entidades distintas a quien ha
producido dicho sistema informático, estas deberán aportar las correspondientes
declaraciones responsables de todas y cada una de las ampliaciones realizadas, en sus
diferentes versiones.
Asimismo, cuando el propio sistema informático esté formado por varios
componentes, hardware o software, producidos por diferentes personas o entidades,
todas ellas deberán aportar las correspondientes declaraciones responsables de sus
componentes, en sus diferentes version

## Artículo 16. Especificaciones técnicas de la remisión por parte de los sistemas
informáticos «VERI*FACTU».
1. Los sistemas informáticos que tengan la consideración de «Sistemas de emisión
de facturas verificables» o «VERI*FACTU», de acuerdo con el artículo 16 del
Reglamento, deberán hacer efectivas las facultades que implica la capacidad de
remisión, indicadas en el artículo 4 de esta orden, cumpliendo a su vez con el artículo 5
de esta orden.
La remisión de registros de facturación a la Administración tributaria se realizará
mediante mensajes en formato XML con los contenidos y estructura establecidos en el
apartado 4 del anexo de esta orden.
2. Los sistemas informáticos «VERI*FACTU» deberán implementar un mecanismo
de control de flujo basado en el tiempo de espera entre envíos, el cual tomará
inicialmente el valor de 60 segundos, y en el número máximo de registros admitidos en
cada envío.
BOLETÍN OFICIAL DEL ESTADO
Núm. 260 Lunes 28 de octubre de 2024 Sec. I. Pág. 137540cve: BOE-A-2024-22138
Verificable en https://www.boe.es
Los mensajes de respuesta de la Agencia Estatal de Administración Tributaria
informarán sobre el valor de este parámetro, el cual deberá ser tenido en cuenta para el
siguiente envío.
El número máximo de registros a remitir en cada envío queda determinado por el
diseño de registro incluido en el apartado 2.2 del anexo.
El funcionamiento será el siguiente:
a) El sistema informático realiza el envío del primer conjunto de registros de
facturación a la Agencia Estatal de Administración Tributaria.
b) La Agencia Estatal de Administración Tributaria devuelve, entre otros datos, un
valor actualizado del parámetro de tiempo de espera «t» entre envíos.
c) Para poder realizar el siguiente envío, el sistema informático deberá esperar a
que transcurran «t» segundos desde el anterior envío o deberá esperar a tener
acumulados un número de registros de facturación igual al límite establecido en el diseño
de registro para cada envío, la circunstancia que ocurra primero.
d) El sistema informático realiza un nuevo envío cumpliendo con lo establecido en
la letra c). En la respuesta puede recibir una nueva actualización del valor del parámetro
«t».
3. Los ficheros remitidos a la Agencia Estatal de Administración Tributaria serán
sometidos a diversas validaciones de calidad. La respuesta afirmativa por parte de la
Agencia Estatal de Administración Tributaria no implica que los registros de facturación
remitidos sean completamente válidos, ni impide posteriores validaciones por parte de la
Agencia Estatal de Administración Tributaria.
Si la remisión es rechazada por no cumplir las validaciones establecidas, se
informará del código de error que motiva el rechazo.
4. En caso de que alguna incidencia técnica impida la remisión voluntaria en las
condiciones indicadas se deberá proceder a la remisión de los registros de facturación
en cuanto sea posible, respetando el orden temporal de generación de los registros de
facturación. Además, deberá avisar de esta circunstancia indicándolo en los mensajes
donde se envíen los correspondientes registros de facturación afectados, dentro del
campo habilitado a tal efecto, de acuerdo con las especificaciones dadas en el
apartado 4 del anexo.
El sistema informático deberá reintentar periódicamente, al menos una vez cada
hora, el envío de los registros de facturación pendientes de remitir. Asimismo, el sistema
informático deberá avisar de que se ha producido una incidencia que ha impedido la
remisión de todos los registros de facturación generados, indicando cuántos faltan por
remitir. Este aviso deberá visualizarse a partir del momento en que se produzca la
incidencia que impida la remisión de los registros de facturación y mientras quede alguno
de estos por remitir.
Las incidencias en la remisión voluntaria de registros de facturación agrupados
deberán ser debidamente justificadas por el remitente si así se lo requiere la Agencia
Estatal de Administración Tributaria.
5. La remisión de registros de facturación a la Agencia Estatal de Administración
Tributaria recibirá como respuesta, entre otros datos, un código seguro de verificación
cuando al menos un registro de facturación contenido en el fichero remitido sea correcto
y, por tanto, se acepte su envío. El remitente podrá utilizar este código para verificar el
envío realizado. Asimismo, si hubiera algún registro de facturación erróneo en el fichero
remitido, en la respuesta también se informará de cuál es y del tipo de error que
presenta.

## Artículo 17. Condiciones y plazos de inicio y de renuncia a la remisión voluntaria.
1. Un sistema informático podrá iniciar en cualquier momento su funcionamiento
como «VERI*FACTU», en los términos recogidos en el Reglamento y en esta orden.
BOLETÍN OFICIAL DEL ESTADO
Núm. 260 Lunes 28 de octubre de 2024 Sec. I. Pág. 137541cve: BOE-A-2024-22138
Verificable en https://www.boe.es
2. El funcionamiento como «VERI*FACTU» deberá mantenerse siempre al menos
hasta el final del último año en que haya funcionado como tal, es decir, hasta el 31 de
diciembre de dicho año.
3. La forma de renunciar a que el sistema informático funcione como
«VERI*FACTU» será cumplimentando el campo previsto a tal efecto en los mensajes de
remisión de registros de facturación a la Agencia Estatal de Administración Tributaria,
donde se indicará la última fecha en la que funcionará como «VERI*FACTU», de acuerdo
con las especificaciones dadas en el apartado 4 del anexo. El primer mensaje en el que
se rellene dicho campo informando de la fecha de fin de funcionamiento como
«VERI*FACTU» deberá remitirse antes del final del año natural en el que se quiera hacer
efectiva la renuncia.

## Artículo 18. Características y requisitos de la remisión de registros de facturación en
caso de respuesta a un requerimiento.
De acuerdo con el artículo 14.2 del Reglamento, a requerimiento de la Administración
tributaria, el obligado tributario podrá suministrar los registros de facturación conservados
mediante envío automático y seguro por medios electrónicos a la sede electrónica de
dicha Administración tributaria.
Las características y requisitos de dicho envío serán los mismos que los
especificados en esta orden para los sistemas informáticos «VERI*FACTU», pero
utilizando otro servicio específico, con la estructura y contenido adaptados de los
registros de facturación, según se describe en el apartado 4 del anexo de esta orden.

## Artículo 20. Representación gráfica a incluir en la factura.
1. Una factura, tanto si está impresa en soporte papel como si se trata de la imagen
de la misma en soporte digital, incluirá los siguientes elementos que, cumpliendo con los
requisitos que se determinen, deberán ser legibles y estar impresos con una resolución
apropiada:
a) Un código «QR», que deberá cumplir con las especificaciones del artículo 21.
b) En caso de facturas expedidas por «Sistemas de emisión de facturas
verificables» o «VERI*FACTU», según los artículos 15 y 16 del Reglamento, la frase
«Factura verificable en la sede electrónica de la AEAT» o «VERI*FACTU», que deberá
tener un tipo de letra y tamaño bien visibles, similares a los del resto de datos de la
factura.
2. En caso de tratarse de una factura electrónica, destinada al intercambio de su
información de forma estructurada entre sistemas informáticos por medios electrónicos,
se deberá incluir como un campo independiente la «URL» contenida en el código «QR»,
no siendo necesario incluir el propio código «QR».

## Artículo 21. Código «QR».
1. El código «QR» deberá tener un tamaño entre 30x30 y 40x40 milímetros y seguir
las especificaciones de la norma ISO/IEC 18004. Para la generación del código «QR» se
empleará el nivel M (medio) de corrección de errores. En la sede electrónica de la
Agencia Estatal de Administración Tributaria se publicarán la ubicación y presentación
del mismo dentro de la factura, pudiéndose completar con otras características a cumplir.
2. El contenido del código «QR» será el siguiente:
a) «URL» del servicio de cotejo o remisión de información por parte del receptor de
la factura, del cual se informará en la sede electrónica de la Agencia Estatal de
Administración Tributaria.
b) Información de la factura que formará parte de la «URL»:
1.º NIF del obligado a expedir la factura.
2.º Número de serie y número de la factura expedida.
3.º Fecha de expedición de la factura.
4.º Importe total de la factura.
Tanto el formato detallado de esta «URL», que podrá ser distinto dependiendo de si
el sistema informático que expide la factura y genera su correspondiente código «QR» es
o no un sistema informático «VERI*FACTU», como la codificación y formato de la
información requerida se especificarán en el correspondiente documento técnico que
será publicado en la sede electrónica de la Agencia Estatal de Administración Tributaria.

https://www.boe.es/boe/dias/2024/10/28/pdfs/BOE-A-2024-22138.pdf


Tipo de gestión de certificado:
+ Repositorio de certificados (custodia)*
+ Delegado
+ On Premise

*Kabilia Estudiar?: https://www.boe.es/buscar/act.php?id=BOE-A-2020-14046 Procedimiento para ser un servicio electrónico de confianza