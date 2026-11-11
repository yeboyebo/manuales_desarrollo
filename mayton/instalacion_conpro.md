# Instalación en Conpro paso a paso

Este manual explica cómo instalar una versión nueva de Eneboo en **Conpro**, una de las empresas del
grupo **Mayton**. Está pensado para hacerlo aunque sea la primera vez: sigue los pasos en orden, sin
saltarte ninguno, y en cada uno comprueba que te sale lo que dice el manual.

Si algo no sale como se explica, **para** y mira el apartado [Si algo sale mal](#si-algo-sale-mal).
No improvises: casi todos los problemas de Conpro ya están descritos ahí.

---

## Resumen: qué vas a hacer

| Paso | Qué haces | Dónde |
|---|---|---|
| 1 | Conectarte al servidor de Conpro | Remmina |
| 2 | Hacer una copia de seguridad de la base de datos | Tu equipo Linux o Workbench |
| 3 | Preparar Workbench (solo la primera vez) | Workbench |
| 4 | Cargar el paquete nuevo | Eneboo |
| 5 | Regenerar la base de datos | Eneboo |
| 6 | Arreglar las tablas con el procedimiento `yb_post_instalacion` | Workbench |
| 7 | Crear las vistas | Eneboo |
| 8 | Comprobar que todo funciona | Eneboo (en Windows) y Workbench |

> **Lo más importante:** el paso 6 va **siempre después** del paso 5. Si lo haces antes, la
> regeneración deshace el arreglo.

---

## Palabras que vas a ver

| Palabra | Qué es |
|---|---|
| **Conpro** | Empresa del grupo Mayton. Su base de datos se llama `conpro`. |
| **fun_prifer** | La extensión de Eneboo que usan todas las empresas del grupo Mayton (Prifer, Prinver, Inmoprinver, Conpro, Sampiro, Boxplace, Mirissa, Oalma, Tecurso). Incluye `fun_mayton`. |
| **MySQL** | El programa que guarda la base de datos de Conpro. Casi todos los demás clientes usan PostgreSQL; Conpro usa MySQL, y por eso su instalación tiene pasos extra. |
| **MySQL Workbench** | Programa para conectarse a MySQL y ejecutar consultas SQL. |
| **Remmina** | Programa de Linux para entrar en el escritorio de otro ordenador. Con él entramos en el servidor de Conpro. |
| **Paquete (`.eneboopkg`)** | El fichero con la versión nueva de los módulos que se carga en Eneboo. |
| **Regenerar la base de datos** | Opción de Eneboo que adapta las tablas a la versión nueva de los módulos. |
| **Collation** | La regla que usa MySQL para comparar textos (por ejemplo, si `a` y `A` son iguales). Si dos tablas tienen collations distintas, MySQL no deja compararlas y da error. |
| **Procedimiento (`yb_post_instalacion`)** | Un pequeño programa guardado dentro de la base de datos de MySQL. Lo hemos hecho nosotros para arreglar las collations después de instalar. |
| **Vista** | Una "tabla virtual" que MySQL calcula a partir de otras tablas. En Conpro hay una que importa: `v_accesomodulos`. |

---

## Antes de empezar: qué necesitas

- [ ] Acceso al equipo Linux que tiene en Remmina la conexión **`Conpro-servidor`**
      (servidor `192.168.100.135`, protocolo RDP). Es una IP de la red interna de Conpro: solo se llega
      desde ese equipo.
- [ ] Los datos de acceso a MySQL. Son los mismos con los que entra Eneboo:

      | Dato | Valor |
      |---|---|
      | Servidor | `192.168.100.135` (el mismo servidor de Remmina) |
      | Puerto | `3306` |
      | Usuario | `infosial` |
      | Base de datos | `conpro` |
      | Contraseña | la del usuario `infosial` (pídela si no la tienes) |
- [ ] El paquete nuevo de `fun_prifer`, generado desde `main` actualizado
      (ver [Eneboo tools / Crear paquetes](../eneboo-tools/paquetes.md)):
      ```sh
      eneboo-packager create <codebase>/extensiones_2.5.0/fun_prifer/build/final fun_prifer.eneboopkg
      ```
- [ ] El perfil de conexión de Eneboo a `conpro` con el controlador **MySQL** (no `MySQL_NO_INNODB`).
      Se ve en la pantalla de entrada de Eneboo, en el desplegable **Controlador**. Aunque el perfil se
      llame `...MySQL_NO_INNODB...`, lo que cuenta es el controlador elegido. Más detalles en
      [Controlador de Eneboo: MySQL](#controlador-de-eneboo-mysql).
- [ ] Un momento con poco uso del ERP. Avisa a los usuarios de que vas a instalar: durante unos minutos
      algunas pantallas pueden ir lentas.
- [ ] Unos 30–45 minutos sin interrupciones.

---

## Paso 1. Conectarte al servidor

1. En el equipo Linux, abre **Remmina** (búscalo en el menú de aplicaciones como
   *Cliente de escritorio remoto Remmina*).
2. En la lista aparece esta conexión:

   | Nombre | Servidor | Complemento |
   |---|---|---|
   | **Conpro-servidor** | `192.168.100.135` | RDP |

   Haz **doble clic** sobre **Conpro-servidor**.
3. Si te pide usuario o contraseña, son los del usuario de Windows del servidor.
4. Se abre el escritorio del servidor de Conpro (Windows). Lo que hagas dentro de esa ventana pasa en el
   servidor, no en el equipo Linux.

Si **Conpro-servidor** no aparece en la lista, estás en un equipo que no tiene la conexión. Pide acceso
antes de seguir.

### Cómo abrir Workbench

MySQL Workbench está instalado **en el propio servidor**, así que se usa siempre dentro de Remmina.

1. Dentro del escritorio del servidor, abre **MySQL Workbench**.
2. En la pantalla de inicio, debajo de **MySQL Connections**, salen tres recuadros:

   | Conexión | Usuario | Servidor | ¿Cuál usar? |
   |---|---|---|---|
   | Local instance MySQL80 | `root` | `localhost:3306` | No |
   | **yeboyebo** | `infosial` | `127.0.0.1:3306` | **Sí, esta** |
   | yeboyebo_29012024 | `infosial` | `127.0.0.1:3306` | No (es una copia antigua de la misma) |

3. Haz clic en **yeboyebo**. Si pide contraseña, es la del usuario `infosial`.
4. Se abre el editor. A la izquierda, en **Navigator → Schemas**, verás la base de datos **`conpro`**.

`127.0.0.1` quiere decir "este mismo ordenador": MySQL está en el servidor `192.168.100.135`, el mismo al
que entras con Remmina.

---

## Paso 2. Copia de seguridad (obligatoria)

**No sigas sin copia de seguridad.** Si algo sale mal, es lo único que permite volver atrás.

La copia tiene que incluir:
- las **tablas con sus datos**;
- los **procedimientos** de MySQL (en inglés, *routines*). Si no, el procedimiento `yb_post_instalacion`
  no se guarda en la copia.

Hay dos formas de hacerla. **Elige una**: la A si puedes, y si no, la B.

### Opción A: desde tu equipo Linux (recomendada)

La copia se guarda directamente en tu equipo. Abre un terminal **en tu equipo**, no en Remmina.

1. Comprueba que tienes instalado el programa de copias de MySQL:
   ```sh
   mysqldump --version
   ```
   - Si sale una versión, sigue con el paso 2.
   - Si sale *orden no encontrada*, instálalo con `sudo apt install mysql-client` y repite.

2. Comprueba que tu equipo llega al MySQL de Conpro:
   ```sh
   mysql -h 192.168.100.135 -P 3306 -u infosial -p -e "SELECT VERSION();"
   ```
   Te pedirá la contraseña del usuario `infosial`. Al escribirla no se ve nada en pantalla: es normal.
   - Si sale `8.0.18`, sigue con el paso 3.
   - Si sale un error de conexión (*Can't connect*), tu equipo no tiene acceso. Usa la **opción B**.

3. Haz la copia. Cambia `AAAAMMDD` por la fecha de hoy, por ejemplo `20261111`:
   ```sh
   mkdir -p ~/copias
   mysqldump -h 192.168.100.135 -P 3306 -u infosial -p \
     --single-transaction --routines --triggers --no-tablespaces \
     conpro | gzip > ~/copias/conpro_AAAAMMDD.sql.gz
   ```
   Pedirá otra vez la contraseña. Tarda unos minutos y, mientras tanto, no se ve nada en pantalla. Espera a
   que vuelva a aparecer el símbolo del terminal.

   Qué significa cada opción:
   | Opción | Para qué sirve |
   |---|---|
   | `--single-transaction` | Hace la copia sin bloquear las tablas. Los usuarios pueden seguir trabajando. |
   | `--routines` | Guarda los procedimientos, como `yb_post_instalacion`. **Sin esta opción no se guardan.** |
   | `--triggers` | Guarda los *triggers* (acciones automáticas de las tablas). |
   | `--no-tablespaces` | Evita el error *Access denied; you need the PROCESS privilege* con el usuario `infosial`. No quita nada de la copia. |
   | `\| gzip` | Comprime la copia para que ocupe menos. |

4. Comprueba que la copia está bien. Lanza estos tres comandos, uno a uno:
   ```sh
   ls -lh ~/copias/conpro_AAAAMMDD.sql.gz
   zcat ~/copias/conpro_AAAAMMDD.sql.gz | tail -1
   zcat ~/copias/conpro_AAAAMMDD.sql.gz | grep -c 'PROCEDURE .yb_post_instalacion.'
   ```
   | Comando | Qué debe salir | Si no sale |
   |---|---|---|
   | `ls -lh` | Un tamaño de varios MB | Si sale 0 o pocos KB, la copia ha fallado: repítela. |
   | `tail -1` | `-- Dump completed on ...` | La copia se ha cortado: repítela. |
   | `grep -c` | `1` (o más) | El procedimiento no está en la copia: revisa que el comando lleve `--routines`. |

### Opción B: desde MySQL Workbench (dentro de Remmina)

1. Dentro de Remmina, abre **MySQL Workbench** (ver [Cómo abrir Workbench](#cómo-abrir-workbench)).
2. En el menú de arriba, pulsa **Server → Data Export**.
3. En el cuadro **Tables to Export**, marca la casilla del esquema **`conpro`**. Se marcan todas sus
   tablas.
4. En el desplegable que hay debajo, elige **Dump Structure and Data** (estructura y datos).
5. En **Objects to Export**, marca **las tres** casillas:
   - **Dump Stored Procedures and Functions**. **Imprescindible**: es la que guarda
     `yb_post_instalacion`.
   - **Dump Events**.
   - **Dump Triggers**.
6. En **Export Options**:
   - Elige **Export to Self-Contained File** y escribe dónde guardar la copia, por ejemplo
     `...\conpro_AAAAMMDD.sql`.
   - Marca **Create Dump in a Single Transaction (self-contained file only)**.
7. Pulsa **Start Export** y espera. Cuando termine, en el registro de abajo saldrá
   *Export of ... has finished*.
8. Busca el fichero en la carpeta que elegiste y comprueba que ocupa varios MB.

---

## Paso 3. Preparar Workbench (solo la primera vez)

Workbench corta por defecto cualquier consulta que tarde más de **30 segundos**, y el paso 6 puede
tardar más. Si no cambias esto, a mitad del paso 6 te saldrá
`Error Code: 2013. Lost connection to MySQL server during query`.

1. En Workbench: **Edit → Preferences**.
2. A la izquierda, **SQL Editor**.
3. Busca **DBMS connection read timeout interval (in seconds)** y pon **3600**.
4. Pulsa **OK**.
5. Cierra la pestaña de la conexión y vuelve a abrirla. El cambio solo se aplica a conexiones nuevas.

En ese ordenador ya no tendrás que volver a hacerlo.

---

## Paso 4. Cargar el paquete

1. Abre **Eneboo** y entra en la base de datos `conpro`.
2. Menú **Sistema → Cargar Paquete de Módulos**.
3. Elige el fichero `.eneboopkg` que has preparado.
4. Espera a que termine y acepta los mensajes.

---

## Paso 5. Regenerar la base de datos

Regenera la base de datos desde Eneboo, como en cualquier otra instalación.

**Qué pasa por dentro:** Eneboo rehace las tablas que han cambiado con la versión nueva. En MySQL, esas
tablas quedan con una collation distinta a la del resto, y Eneboo además crea `v_accesomodulos` como tabla
cuando debería ser una vista. **Es normal y no tiene que preocuparte:** lo arreglas en el paso 6. Si lo
has hecho todo bien hasta aquí, de momento no verás ningún error.

---

## Paso 6. Arreglar las tablas: procedimiento `yb_post_instalacion`

### Para qué sirve

Después de regenerar, algunas tablas quedan con la collation `utf8_general_ci` y el resto con
`utf8_unicode_ci`. Si se dejan así, al comparar textos de unas con otras MySQL da error, y fallan
pantallas, informes y el paso 7.

El procedimiento `yb_post_instalacion` lo arregla automáticamente. Hace tres cosas:
1. **Busca las tablas con `utf8_general_ci` y las pasa a `utf8_unicode_ci`**, igual que el resto. No hay
   que decirle cuáles: las busca él cada vez.
2. **Borra `v_accesomodulos` si Eneboo la ha creado como tabla vacía**, para que en el paso 7 se pueda
   crear como vista. Si tiene datos, no la borra y avisa.
3. **Te enseña qué ha hecho**, tabla por tabla.

No borra datos de ninguna tabla. Ya está guardado dentro de la base de datos `conpro`, así que **no
tienes que crearlo**: solo llamarlo. Si alguna vez te dice que no existe, mira
[Si el procedimiento no existe](#si-el-procedimiento-no-existe).

Se puede llamar de dos maneras:

| Lo que escribes | Qué hace |
|---|---|
| `CALL yb_post_instalacion(0);` | **Prueba.** Te enseña lo que haría, **sin cambiar nada**. |
| `CALL yb_post_instalacion(1);` | **De verdad.** Hace los cambios. |

### Cómo se ejecuta

1. En Workbench, en el panel de la izquierda (**Navigator**, pestaña **Schemas**), haz **doble clic**
   sobre **`conpro`**. Tiene que quedar en **negrita**: así Workbench sabe en qué base de datos trabajar.
2. Abre una pestaña de consulta nueva: **File → New Query Tab** (o Ctrl+T).
3. **Primero la prueba.** Escribe (o copia y pega):
   ```sql
   CALL yb_post_instalacion(0);
   ```
   y pulsa **Ctrl+Enter** (o el icono del rayo **con el cursor**, el segundo rayo de la barra).
4. Abajo aparecen dos pestañas de resultados, **Result 1** y **Result 2**:
   - **Result 1**: una línea por cada tabla que va a arreglar (`CONVERT ... SIMULADO`) y una línea para
     `v_accesomodulos`. Es normal que salgan varias tablas después de regenerar.
   - **Result 2**: cuántas tablas hay de cada collation.
5. **Ahora de verdad.** Cambia el `0` por un `1`:
   ```sql
   CALL yb_post_instalacion(1);
   ```
   y pulsa **Ctrl+Enter**. Espera a que termine: puede tardar desde unos segundos hasta un par de
   minutos.
6. Comprueba el resultado:
   - En **Result 1**, todas las líneas deben poner **`OK`**.
   - En **Result 2** deben salir **solo** estas collations:

     | TABLE_COLLATION | Aprox. |
     |---|---|
     | `utf8_unicode_ci` | ~515 |
     | `utf8_bin` | 22 |
     | `latin1_swedish_ci` | 1 |

     Si sigue saliendo `utf8_general_ci`, vuelve a ejecutar `CALL yb_post_instalacion(1);`.
   - Si alguna línea pone **`ERROR`**, esa tabla se ha quedado como estaba. Copia el texto de la
     columna *mensaje* y consúltalo (ver [Si algo sale mal](#si-algo-sale-mal)).

> **Si te sale `Error Code: 2013. Lost connection`:** no lo vuelvas a lanzar enseguida. El servidor
> **sigue trabajando** aunque Workbench se haya desconectado. Mira
> [Si algo sale mal](#si-algo-sale-mal).

---

## Paso 7. Crear las vistas

1. En Eneboo, ve a **Mantenimiento → Procesos**.
2. Busca la función **`creaVistas`** (descripción *Crear vistas*).
3. Selecciónala y ejecútala.
4. No debe salir ningún error.

Para comprobarlo, en Workbench:
```sql
SELECT table_type FROM information_schema.tables
WHERE table_schema = DATABASE() AND table_name = 'v_accesomodulos';
```
Tiene que salir **`VIEW`**.

---

## Paso 8. Comprobar que todo funciona

1. En Workbench, ejecuta otra vez la prueba:
   ```sql
   CALL yb_post_instalacion(0);
   ```
   En **Result 1** solo debe salir una línea: `v_accesomodulos | NADA | Ya es vista`.
2. Desde un **puesto Windows** de Conpro, abre Eneboo, entra en un formulario (por ejemplo,
   **Usuarios**), cambia algo sin importancia y **guarda**. No debe salir ningún error.
3. Prueba lo que se haya instalado en esta versión.
4. Avisa a los usuarios de que ya pueden trabajar con normalidad.

¡Listo!

---

## Si algo sale mal

| Qué ves | Qué significa | Qué hacer |
|---|---|---|
| `Illegal mix of collations (utf8_general_ci,IMPLICIT) and (utf8_unicode_ci,IMPLICIT) for operation '='` (por ejemplo, al crear las vistas) | Quedan tablas con la collation antigua | Ejecuta `CALL yb_post_instalacion(1);` (paso 6) y repite lo que fallaba |
| Al crear las vistas: `Table 'v_accesomodulos' already exists` | La regeneración la ha creado como tabla | Ejecuta `CALL yb_post_instalacion(1);` y vuelve a lanzar `creaVistas` |
| Al guardar cualquier formulario, **solo en Windows**: *La estructura de los metadatos de la tabla 'fldatatables_cache' y su estructura interna en la base de datos no coinciden. Debe regenerar la base de datos.* | La tabla `fldatatables_cache` no coincide con lo que espera el Eneboo de Windows | Regenera la base de datos (paso 5) y repite los pasos 6 y 7 |
| `Error Code: 2013. Lost connection to MySQL server during query` en Workbench | Workbench se ha cansado de esperar, pero el servidor **sigue trabajando** | 1) Ejecuta `SHOW PROCESSLIST;` cada 20–30 s hasta que no quede ninguna fila con `ALTER` o `CALL` en la columna *Info*. 2) Ejecuta `CALL yb_post_instalacion(0);` para ver si falta algo. 3) Haz el paso 3 para que no vuelva a pasar |
| `Error Code: 1305. PROCEDURE conpro.yb_post_instalacion does not exist` | El procedimiento no está en la base de datos | Mira [Si el procedimiento no existe](#si-el-procedimiento-no-existe) |
| En el paso 6, una línea con `ERROR ... Duplicate entry` | Esa tabla tiene datos que, con la collation nueva, cuentan como repetidos | La tabla se ha quedado como estaba y no se pierde nada. **No toques nada más** y consúltalo con un compañero con experiencia |
| Después del paso 6 sigue saliendo `utf8_general_ci` | Eneboo ha vuelto a crear tablas (por ejemplo, porque se ha regenerado otra vez) | Vuelve a ejecutar `CALL yb_post_instalacion(1);` |

Si te sale algo que no está en esta tabla: **para**, haz una captura de pantalla y consúltalo antes de
seguir.

---

## Si el procedimiento no existe

### ¿Qué pasa si se borra?

Si alguien borra el procedimiento, o se restaura una copia hecha sin procedimientos, al ejecutar el `CALL`
saldrá:
```
Error Code: 1305. PROCEDURE conpro.yb_post_instalacion does not exist
```

**No pasa nada grave.** Eneboo no lo usa para nada y el ERP sigue funcionando igual. Solo pierdes la
herramienta del paso 6, y se recupera en un minuto.

### Cómo volver a crearlo

El procedimiento está guardado en este mismo repositorio, en el fichero
[`post_instalacion_collations.sql`](./post_instalacion_collations.sql).

1. Copia ese fichero al servidor (o abre su contenido y cópialo).
2. En Workbench, haz doble clic en **`conpro`** para que quede en negrita.
3. **File → Open SQL Script…** y abre `post_instalacion_collations.sql`. Si lo has copiado como texto,
   pégalo en una pestaña de consulta nueva.
4. Sin seleccionar nada, pulsa el **primer rayo** de la barra (**Execute**, sin cursor) o
   **Ctrl+Shift+Enter**. Así se ejecuta el fichero **entero**.
   No uses Ctrl+Enter aquí: ejecutaría solo una parte y daría error.
5. En el panel **Output** de abajo deben salir:
   - `DROP PROCEDURE IF EXISTS yb_post_instalacion`, en amarillo (aviso). Es normal: solo dice que no
     existía.
   - `CREATE PROCEDURE yb_post_instalacion ...`, en verde.

Ejecutar este fichero **solo crea el procedimiento**: no cambia ninguna tabla. Lo puedes ejecutar todas
las veces que quieras, porque si ya existía lo sustituye.

Para comprobar si existe:
```sql
SHOW PROCEDURE STATUS WHERE Db = 'conpro' AND Name = 'yb_post_instalacion';
```
Si sale una fila, existe.

---

## Para saber más (opcional)

### ¿Por qué pasa todo esto en Conpro?

| Dato | Valor |
|---|---|
| Servidor de base de datos | MySQL 8.0.18 |
| Base de datos | `conpro` |
| Collation por defecto de la base de datos | `utf8_unicode_ci` |
| Puestos | Linux (`pc-tienda2`, Eneboo 2.6.1) y Windows (Eneboo 2.6.7.1-dba) |

Al crear una tabla en MySQL, Eneboo dice qué juego de caracteres usar (`utf8`) pero no la collation.
Cuando no se dice, MySQL usa la collation por defecto de ese juego de caracteres, que es
`utf8_general_ci`, y no la de la base de datos. Por eso cada tabla que Eneboo crea o rehace sale distinta
del resto, y hay que igualarla después de cada instalación.

Las 22 tablas en `utf8_bin` y la de `latin1_swedish_ci` se dejan como están a propósito.

### Controlador de Eneboo: MySQL

En la pantalla de entrada de Eneboo hay dos controladores para MySQL:

| Controlador | Tipo de tabla que crea | ¿Usar? |
|---|---|---|
| **MySQL** | InnoDB: con transacciones. Si un proceso falla a medias (por ejemplo, al generar una factura con su asiento), se deshace entero | **Sí** |
| MySQL_NO_INNODB | MyISAM: sin transacciones. Si un proceso falla, lo grabado antes del fallo se queda (por ejemplo, una factura sin asiento) | **No** |

Todos los puestos (Linux y Windows) deben usar **MySQL**. Si un puesto usa `MySQL_NO_INNODB`, las tablas
que cree o reconstruya ese puesto al regenerar quedarán en MyISAM.

A 11-11-2026, todas las tablas de `conpro` son InnoDB salvo **`flserial`**, que es MyISAM. **Es normal y no
hay que tocarla**: es una tabla interna de Eneboo, vacía, y sigue siendo MyISAM aunque se regenere la base
de datos.

Para comprobar los tipos de tabla:
```sql
SELECT engine, COUNT(*) FROM information_schema.tables
WHERE table_schema = 'conpro' AND table_type = 'BASE TABLE'
GROUP BY engine;
```
Debe salir InnoDB con casi todas y MyISAM con 1 (`flserial`). Si salen más tablas MyISAM, algún puesto está
usando `MySQL_NO_INNODB`: revisa los perfiles de los puestos y consúltalo antes de convertir nada.

### El script antiguo `collatesindices.sql`: no usarlo

Antes se usaba un script con una lista fija de tablas y de índices. **Ya no se usa**, porque:
- su lista no incluía las tablas nuevas, como `accesomodulos`, que era justo la que rompía `creaVistas`;
- creaba índices con una forma (`TYPE BTREE`) que MySQL 8 puede no aceptar;
- incluía índices sobre campos que en Conpro no existen (`Error 1072`) y otros que ya existían
  (`Error 1061`).

El procedimiento `yb_post_instalacion` lo sustituye. Los índices no hace falta crearlos: al convertir una
tabla se conservan los que ya tenía.

### Consultas útiles

```sql
-- Versión de MySQL y collation por defecto
SELECT VERSION(), @@collation_database;

-- Cuántas tablas hay de cada collation
SELECT table_collation, COUNT(*) FROM information_schema.tables
WHERE table_schema = DATABASE() AND table_type = 'BASE TABLE'
GROUP BY table_collation;

-- Qué tablas no están en utf8_unicode_ci
SELECT table_collation, table_name FROM information_schema.tables
WHERE table_schema = DATABASE() AND table_type = 'BASE TABLE'
  AND table_collation <> 'utf8_unicode_ci'
ORDER BY table_collation, table_name;

-- Qué se está ejecutando ahora mismo en el servidor
SHOW PROCESSLIST;
```

---

### Más

- [Mayton](./index.md)
- [FAQ Mayton](../faq/mayton/index.md)
- [Volver al Índice](../README.md)
