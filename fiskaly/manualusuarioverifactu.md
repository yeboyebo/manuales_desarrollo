## Manual usuario con Fiskaly-Veri*Factu

### 1. Proceso crear/firmar facturas 
#### 1.1. Crear factura (borrador)

- Una vez resgistrados en Fisklay y se ha informado toda la configuraci�n en el ERP, podremos crear facturas y firmarlas con Fiskaly.

- El proceso de creaci�n de facturas es el estandard del ERP pero hasta que la factura no se emite a Fiskaly y queda firmada no estar� en firme.

- Al crear la factura, no tiene un c�digo est�ndard, nos da un c�digo de borrador y el estado ser� **Borrador**

- En este estado podemos:
    - Modificar o borrar las facturas
    - Enviarlas al cliente para su aprobaci�n, en un informe que indicar� claramente que se trata de un borrador y no de una factura emitida.

- Los borradores de factura no son facturas emitidas.

- Cuando se emite un borrador:
    - Se le da un c�digo definitivo y se actualiza su fecha y hora de emisi�n
    - Se registra su asiento contable de la factura y se crean sus recibos
    - Se llama a la API de Fiskaly para registrar la factura y obtener el QR

- Una vez emitida, la factura no puede modificarse ni borrarse

![Dashboard10](img/fiskaly_verifactu34.png)

#### 1.2. Emitir factura

- Con el borrador seleccionado, pulsamos en el bot�n **Emitir** 

![Dashboard10](img/fiskaly_verifactu35.png)

- Cuando pulsamos el bot�n de **Emitir** podemos tener los siguientes escenarios:

    - Aviso de Eneboo
        - Puede ser que Eneboo no nos deje continuar con la emisi�n si la factura tiene alg�n tipo de problema (factura simplificadas de m�s de 400�, CIF y nombre no coincidentes, etc).

    - Estado **Pte.Firma**
        - La factura ha sido recibida y validada por Fiskaly. Falta que Fiskaly la env�e a la AEAT. Esto sucede casi instant�neamente.

        ![Dashboard10](img/fiskaly_verifactu37.png)


    - Estado **Error comunicaci�n** (no hay conexi�n de red)
        - Cuando no hay conexi�n, Eneboo genera un QR que permite continuar la emisi�n de la factura.

        - Cuando se reestablece la conexi�n, el env�o de las facturas con este error lleva una etiqueta que las identifica de la forma que la AEAT exige en estos casos.

    - Estado **Error Firma**
        - Fiskaly no admite la factura por alguna validaci�n. Contactar con soporte.

- Una vez que hemos emitido la factura, ser� firmada por Fiskaly y la siguiente factura que se presente obtendr� la informaci�n del estado de las facturas en estado **Pte.Firma** y actualizar� el estado como **Firmada** si todo ha ido bien.

- Una forma alternativa de actualizar el estado sin tener que esperar a enviar otra factura es pulsando el bot�n de **Comprobar estado**. 

![Dashboard10](img/fiskaly_verifactu38.png)

![Dashboard10](img/fiskaly_verifactu39.png)

### 2. Proceso anular facturas 

- Las facturas que tengan el estado de **Firmada** o **Error firma** , pueden ser anuladas. 

- Con la factura seleccionada, pulsaremos el bot�n de **Anular**

![Dashboard10](img/fiskaly_verifactu40.png)

- Al anular:
    - Se genera un asiento de anulaci�n

    - Se borran los recibos asociados (una factura anulada no puede estar pagada)

    - Se informa a Fiskaly de su anulaci�n, pasando a estado Pte.Anular.

![Dashboard10](img/fiskaly_verifactu41.png)

- Al igual que las facturas Firmadas, para actualizar el estado de **Pte.anular** a **Anulada**, pulsaremos en el bot�n de **Comprobar estado** o en la siguiente factura que se env�e a F�skaly se actulaizar�.

![Dashboard10](img/fiskaly_verifactu42.png)


### 3. Errores

- Podemos tener 3 estados distintos de errores:

    - **Error comunicaci�n** --> Ocurre cuando no hay comunicaci�n con Fiskaly y no se ha podido enviar, este error se solucionar� cuando hay internet. Mientras tanto, eneboo genera un QR manual para que se pueda imprimnir.

    - **Error Firma** --> Ocurre cuando ha dado un error al firmar, estos errores ser�n los menos porque est�n controlados por el propio ERP y habr�a que contactar con soporte para poder solucionarlo.

    - **Error Anulaci�n** --> Similar al Error firma pero cuando se est� anulando.


- Cuando existe un error, se activa el bot�n de **Mostrar errores** el cual nos muestra un mensaje con el error que ha ocurrido.

![Dashboard10](img/fiskaly_verifactu43.png)


- En resumen, estos son los estados por los que puede pasar desde borrador a factura.

![Dashboard10](img/fiskaly_verifactu36.png)

### 4. Impresi�n de facturas

- En las facturas que se impriman, obligatoriamente debe de aparecer el QR generado al presentarse en la AEAT.


![ERP](img/fiskaly30.png)


### 5. Estado PRE_Verifactu

- Todas las facturas que est�n creadas antes de la implantaci�n de Fiskaly/Veri*Factu, ser�n marcadas con el estado **PRE_Verifactu**, este estado permite modificar y borrar las facturas pero no presentarlas.