# Calculate Counter

Por lo general hay que ir elminando configuraciones que provocan consultas a la base de datos o llamadas a los scripts que están fuera de los propios scrips de QSA

Calculate Counter
1. Quitar el nodo **\<counter\>true\</counter\>** del fichero mtd
2. Hacerlo desde el fichero .qs de la siguiente forma:

    - En la función init, si estamos en modo insert, llamamos a **iniciaValoresCursor** pasándole el cursor:
    ```js
    if(cursor.modeAccess() == cursor.Insert) {
            _i.iniciaValoresCursor(cursor);
    }
    ```
    - En **iniciaValoresCursor** calculamos el código que corresponda llamando a la función **calculateCounter**, pasándole el cursor como parámetro:
    ```js
    cursor.setValueBuffer("codcuenta", _i.calculateCounter(cursor));
    ```
    - La función **calculateCounter** debería informar el cursor si no está informado y llamar a **nextCounter**:
    ```js
    if (!cursor) {
        cursor = this.cursor();
    }
	return AQUtil.nextCounter("codcuenta", cursor);
    ```
### Más

- [Volver al Índice](./index.md)
