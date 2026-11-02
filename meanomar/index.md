# Migración de Meanomar a fun_meanomar

Meanomar son 5 empresas con su propia base de datos (Eneboo, en 3 servidores Windows con PostgreSQL 9.x):

| Base | Empresa |
|---|---|
| `bateamar_gest` | BATEAMAR S.L. |
| `invergeal_gest` | INVERSIONES Y GESTIÓN ALIMENTICIA S.L. |
| `lym_gest` | CARNICAS LYM, S.L. |
| `marabal_gest` | CONGELADOS Y CONSERVAS MARABAL, S.L. |
| `meanomar_gest` | MEAÑOMAR, S.L. |

Cada base tenía módulos antiguos (base 2.4, código de proveedores anteriores: kabila, isanimar, sinfomac...)
con diferencias entre ellas. Ahora las 5 usan una única extensión, **`extensiones_2.5.0/fun_meanomar`**
(rama `#MEM-#H4709-Meanomar`).

---

## 1. Qué incluye fun_meanomar

- Árbol de extensiones en `conf/required_features` (pgc2008, modelos, punteo_cont, jasper_plugin,
  textos_pdatos, persona_fisica...). **No se añaden extensiones fuera del árbol**: lo que había en
  producción de extensiones ajenas se ha descartado o, si era código propio del cliente, se ha portado
  a la clase `meanomar` del parche.
- Código propio de producción portado (clase `meanomar`): código de barras en líneas, incrementos de
  precio por cliente y familia, observaciones como concepto de asiento, liberar asiento, regenerar
  cifnif, pestañas de ensayos y orden de validación, ficheros asociados en compras, filtro asegurado,
  transporte con contenedor y sello, almacén por defecto de compras, trazabilidad con IVA y bruto...
- **Informes Jasper** en `aqjasper` (plantillas comunes para las 5 empresas). El parche `flfactinfo.qs`:
  - Muestra el diálogo de modelos según el campo "Tipo informe" de `i_jasper_info` para trazabilidad,
    resumen de facturas y resúmenes de recibos (antes lo hacía `jplugin_plus`, que ya no se usa).
  - Lanza directamente por Jasper los informes sin `.kut` (botones Excel) y convierte la llamada
    antigua `lanzarInforme(..., ruta, true)` al formato del jasper_plugin actual.
  - `pub_esperarFichero(ruta)`: espera a que Jasper (otro proceso) termine de escribir el Excel.
  - `pub_nombreFicheroValido(texto)`: quita caracteres no válidos (`/` de "S/IVA"...) del nombre del fichero.
- Textos de empresa en la ficha: `empresa.textopdatos` (protección de datos, RGPD/LOPDGDD) y
  `empresa.regmercantil`. Los usan los Jasper (`$F{textopdatos}`, `$F{regmercantil}`) y los Kugar
  de documentos (`CalculatedField` con `flfactinfo.dameTextoPdatos`).

---

## 2. Migración de una base

Scripts generados por base (carpeta `migracion_fun_meanomar/<base>/`):

| Script | Cuándo | Qué hace |
|---|---|---|
| `1_pre_carga.sql` | antes de cargar módulos | crea `flfiles.binario` (bytea); copia en `mig_fun_meanomar.copia_<tabla>` todas las columnas que fun_meanomar va a borrar |
| `3_post_carga_migracion.sql` | después de cargar | punteo `co_punteo` → `co_partidas.punteado/casado`; 347 histórico `importe1t…` → `importet1…`; transporte de lym (columnas del albarán → tabla `transportes`). Repetible |
| `4_datos_post_carga.sql` | al final | 14 plantillas Jasper con su tipo en `i_jasper_info`, subinforme `i_facturascli_ivas`, textos de empresa. Repetible |

Los scripts son compatibles con PostgreSQL 9.1+ (nada de `IF NOT EXISTS` en `ALTER TABLE`,
`ON CONFLICT`, `to_regclass`, `FILTER`) y empiezan con `SET client_encoding = 'UTF8';` para que el
`psql` de Windows no estropee tildes y eñes.

### Procedimiento (la base original no se toca)

1. **Validación** (solo `bateamar_gest`): `pg_dump` + `pg_restore` en `bateamar_gest_nueva`, pasos
   1 a 4 sobre la copia, el cliente la prueba mientras trabaja en la original.
2. **Paso definitivo** (las 5, con los usuarios fuera):

```bat
set PGBIN="C:\Program Files\PostgreSQL\9.x\bin"
%PGBIN%\pg_dump -U postgres -Fc -f <base>_antes_fun_meanomar.dump <base>
%PGBIN%\createdb -U postgres -T <base> <base>_nueva
%PGBIN%\psql -U postgres -d <base>_nueva -v ON_ERROR_STOP=1 -f 1_pre_carga.sql
rem  Cargar el paquete de módulos de fun_meanomar en Eneboo conectado a <base>_nueva
%PGBIN%\psql -U postgres -d <base>_nueva -v ON_ERROR_STOP=1 -f 3_post_carga_migracion.sql
%PGBIN%\psql -U postgres -d <base>_nueva -v ON_ERROR_STOP=1 -f 4_datos_post_carga.sql
rem  Comprobar y, con nadie conectado:
%PGBIN%\psql -U postgres -d postgres -c "ALTER DATABASE <base> RENAME TO <base>_antigua"
%PGBIN%\psql -U postgres -d postgres -c "ALTER DATABASE <base>_nueva RENAME TO <base>"
```

Volver atrás: renombrar al revés.

### Comprobaciones

- Recuentos de `albaranescli`, `facturascli`, `co_partidas`, `clientes`... iguales antes y después.
- Punteo: `co_punteo` frente a `co_partidas.punteado` sin diferencias.
- `SELECT tipoinforme, count(*) FROM i_jasper_info GROUP BY 1;` → 14 plantillas en 9 tipos.
- lym: albaranes con `idtransporte` = albaranes que tenían datos de transporte.
- En Eneboo: imprimir factura y albarán (Jasper y Kugar), trazabilidad, botones Excel.

---

## 3. Trampas encontradas (válidas para otros clientes)

- **Copias de tablas en otro esquema con el mismo nombre rompen la carga de módulos.** Eneboo busca las
  tablas por nombre sin mirar el esquema: al regenerar `opcionestv` leyó la estructura de
  `mig_fun_meanomar.opcionestv` y falló con *"no existe la relación opcionestv"*. Las copias deben
  llevar un nombre distinto (`copia_<tabla>`).
- **Eneboo borra las columnas que no estén en el `.mtd` al cargar.** Antes de cargar una extensión en
  una base existente, comparar columnas de la base con los `.mtd` de `build/final` y guardar las que
  se pierden.
- **`flfiles.binario` (bytea)** es necesaria para cargar módulos con ficheros binarios (`.jasper`).
- **`flfiles` tiene como clave el nombre del fichero**: no puede haber dos ficheros con el mismo nombre
  en distintos módulos o subcarpetas (por eso las plantillas propias por empresa no van en `aqjasper`).
- **eneboo-assembler**:
  - Tras cambiar `conf/required_features` hay que ejecutar `build <feat> base` antes que `final`;
    `final` reutiliza la `build/base` anterior.
  - Un comentario XML (`<!-- -->`) suelto dentro de un bloque `xupdate:insert-after` hace que el bloque
    se descarte **sin avisar**. Verificar siempre en `build/final` que el cambio está.
- **Kugar no recibe campos de texto largo** (`stringlist`, p. ej. `empresa.textopdatos`) como `Field`:
  sale `[empresa.textopdatos]`. Usar un `CalculatedField` con una función (`flfactinfo.dameTextoPdatos`).
- **QSA**: leer `array["clave"]` de una clave que no existe lanza *"Trying to access undefined member"*
  (no devuelve `undefined`). Mejor traer el dato con un `JOIN` en la consulta.
- **QSA**: `pineboo-parse` no acepta expresiones regulares literales con comillas (`/'/g`); usar
  `texto.split("'").join("''")`.
- **Plugin Jasper**:
  - Usa primero el `contenido` de `i_jasper_info` y solo si está vacío el fichero de `flfiles`. Al
    cambiar una plantilla en la tabla hay que cambiar también el `sha`, o seguirá usando la copia en disco.
  - Las plantillas con `ORDER BY $P!{ORDERBY}` fallan si el informe se lanza sin orden: dar un orden por defecto.
  - El formato `WHEREFIJO\n...\nPARAMxxx\nvalor\n` solo lo entiende la vía Jasper; si acaba en Kugar
    hay que quedarse con la condición de `WHEREFIJO`.
  - Genera los ficheros en otro proceso: no abrir ni borrar el fichero justo después de lanzarlo.
- **Herramientas en este entorno**: `grep` puede ser un alias de `ugrep` que se salta ficheros latin1
  (los `.qs`) y rutas ignoradas por git (`build/`). Usar `command grep -a` o Python para buscar.

---

## Más

- [Eneboo tools](../eneboo-tools/index.md)
- [Volver al índice de manuales](../README.md)
