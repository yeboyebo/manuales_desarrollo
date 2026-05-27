# Herramienta backup_tools

Paquete Python instalable para copias de seguridad PostgreSQL, replicación, test de integridad y alertas por email. Compatible con Linux y Windows (v1.1+).

## Instalación

```bash
pip install yeboyebo-backup-tools
```

O desde fuente:

```bash
git clone https://github.com/yeboyebo/utils
cd utils
pip install .
```

Las dependencias Python (`fernet`) se instalan automáticamente. Para soporte Loki:

```bash
pip install yeboyebo-backup-tools[loki]
```

Dependencias del sistema: `pg_dump`, `psql`. En Linux: `mount`/`mount.cifs` (solo si se usa montaje de dispositivos). El resto de operaciones se gestionan vía stdlib de Python sin dependencias externas.

Tras la instalación el comando `backup-tools` está disponible globalmente.

## Compatibilidad Windows

Desde v1.1, backup_tools funciona en Windows con las siguientes particularidades:

- **Montaje de dispositivos**: `mount`/`mount.cifs` (Linux) se reemplazan por `net use` (Windows). La ruta de montaje en Windows es una letra de unidad (ej. `Z:`) o ruta UNC.
- **Prioridad de procesos**: `nice` no tiene equivalente en Windows; se ejecuta el comando sin modificar prioridad.
- **Ping**: flag `-c` (Linux) → `-n` (Windows), gestionado automáticamente.
- **Compresión**: se usa `tarfile` (stdlib Python) en vez del comando `tar`. No requiere instalar `tar` en Windows.
- **Ruta de config**: usar variable de entorno `BACKUP_TOOLS_CONFIG` para especificar ruta de `config.ini` en entornos restringidos.
- **Tareas programadas**: usar Task Scheduler en vez de cron (ver sección Windows más abajo).

## Configuración

El fichero `config.ini` se auto-inicializa en el primer arranque con valores por defecto. La búsqueda del fichero sigue este orden:

1. Variable de entorno `BACKUP_TOOLS_CONFIG` (prioridad máxima)
2. `~/.config/backup_tools/config.ini` (estándar XDG, recomendado para instalaciones vía pip)
3. `config.ini` junto al módulo (legado, desarrollo)

Si no existe ninguno, se crea en `~/.config/backup_tools/config.ini`.

Todos los parámetros se gestionan con la acción `config`.

### Parámetros

| Parámetro | Default | Ofuscado | Descripción |
|---|---|---|---|
| `days_alive` | `20` | no | Días de retención de backups antiguos |
| `token` | auto (UUID4) | — | Clave de cifrado para ofuscar credenciales (no se setea manualmente) |
| `local_folder_backups` | `/backups` | no | Ruta local donde se almacenan/leen los backups |
| `local_folder_backups_device` | `0` | no | Dispositivo a montar en `local_folder_backups`. `0` = no montar (directorio local) |
| `user_db` | — | **sí** | Usuario PostgreSQL |
| `pass_db` | — | **sí** | Contraseña PostgreSQL |
| `port_db` | `5432` | no | Puerto PostgreSQL |
| `host_db` | `127.0.0.1` | no | Host PostgreSQL |
| `replicate_host_db` | — | no | Host destino para replicación (solo necesario con `db replicate`) |
| `user_email` | — | no | Cuenta Gmail para envío de alertas |
| `pass_email` | — | **sí** | Contraseña Gmail |
| `server_name` | `unbutu-server` | no | Nombre del servidor en asuntos de email |
| `list_mails` | — | no | Destinatarios de alertas (separados por coma) |
| `current_copies` | `1` | no | Nº de backups recientes a mantener en carpeta `currents/` |
| `current_folder` | `currents` | no | Subcarpeta donde se guardan las copias recientes |
| `min_size` | `5000` | no | Tamaño mínimo en bytes de un backup; si es menor, envía alerta |
| `loki_url` | — | no | URL del endpoint Loki (ej. `https://monitor.yeboyebo.es/loki/api/v1/push`). Vacío = Loki desactivado |
| `loki_user` | — | **sí** | Usuario autenticación básica Loki (opcional) |
| `loki_pass` | — | **sí** | Contraseña autenticación básica Loki (opcional) |
| `loki_app` | `backup_tools` | no | Etiqueta `app` enviada a Loki |
| `loki_env` | `produccion` | no | Etiqueta `env` enviada a Loki |

Solo 5 parámetros usan ofuscación: `user_db`, `pass_db`, `pass_email`, `loki_user` y `loki_pass`. El `token` se genera automáticamente y actúa como clave de cifrado; no debe setearse a mano.

### Establecer parámetros

```bash
# Parámetros planos (sin ofuscar) — sin 3er argumento
backup-tools config server_name SERVIDOR1
backup-tools config port_db 5432
backup-tools config host_db 192.168.1.100
backup-tools config replicate_host_db 192.168.1.200
backup-tools config local_folder_backups /mnt/backups
backup-tools config local_folder_backups_device /dev/sdb1
backup-tools config days_alive 30
backup-tools config current_copies 3
backup-tools config min_size 10000
backup-tools config user_email vigilancia.yeboyebo@gmail.com
backup-tools config list_mails admin@example.com,otro@example.com

# Parámetros ofuscados — el 3er argumento true activa cifrado con el token
backup-tools config user_db postgres true
backup-tools config pass_db mi_contraseña true
backup-tools config pass_email CLAVE_GMAIL true
backup-tools config loki_user USUARIO_LOKI true
backup-tools config loki_pass CLAVE_LOKI true
```

### Ficheros de lista

Ficheros de texto con nombres de BBDD, uno por línea. Ejemplo (`lista.txt`):

```
naranjas
roles
```

La herramienta busca el fichero en este orden:
1. Ruta absoluta (`/home/user/mis_dbs.txt`)
2. Relativa al directorio del módulo instalado
3. Relativa al home del usuario (`~/mis_dbs.txt`)

Pueden usarse varios ficheros de lista para agrupar BBDD por frecuencia de backup (críticas vs grandes).

### Montaje de dispositivos

`local_folder_backups_device` controla si la carpeta de backups necesita montaje previo:
- `0`: la carpeta es un directorio local normal, no se monta nada
- Cualquier otro valor: se usa como dispositivo en `mount {device} {local_folder_backups}`

En la acción `file remote`, el destino siempre se monta vía CIFS (`mount.cifs`) con opciones `rw,guest,vers=2.0`. La herramienta usa un fichero centinela `no_tocar.txt` en la carpeta montada para verificar que el montaje fue exitoso.

## Acciones

### `db dump` — Crear backup

```bash
backup-tools db dump lista.txt [--exclude-tables=tabla1,tabla2]
```

Vuelca cada BBDD listada con `pg_dump`, comprime con `tarfile`, verifica tamaño mínimo y opcionalmente restaura en réplica. El fichero generado sigue el patrón `{db}_{YYYYMMDD}_{HHMMSS}.sql.tar.gz`.

La BBDD especial `roles` usa `pg_dumpall --globals-only` para capturar roles globales del cluster.

`--exclude-tables` (opcional) excluye las tablas indicadas del dump. Se traduce a flags `--exclude-table` de `pg_dump`. No aplica a `roles` (globals-only). Ejemplo:

```bash
backup-tools db dump lista.txt --exclude-tables=logs_cache,sesiones
```

### `db restore` — Restaurar backup más reciente

```bash
backup-tools db restore lista.txt
```

Para cada BBDD, localiza el `.tar.gz` más reciente, lo descomprime, dropea la BBDD, la recrea y restaura el dump con `psql`. Usa `nice -n -20` para prioridad alta durante el restore.

### `db replicate` — Dump + restore en servidor réplica

```bash
backup-tools db replicate lista.txt
```

Hace dump local y luego restaura en el host definido en `replicate_host_db`. Equivale a `db dump` + `db restore` contra otro servidor. Requiere `replicate_host_db` en config.

### `db test` — Verificar integridad de backups

```bash
backup-tools db test lista.txt
```

Para cada BBDD, coge el backup más reciente, lo restaura en una BBDD temporal (`{db}_test`), verifica que el tamaño de la BBDD restaurada > 0, la borra y envía email con el resultado. La BBDD `roles` solo comprueba que el fichero existe (no se restaura). **Necesita la parte de email configurada.**

### `file remote` — Sincronizar ficheros a dispositivo remoto

```bash
backup-tools file remote /mnt/destino //192.168.1.100/backup [horas]
```

Monta `local_folder_backups`, monta el dispositivo remoto (CIFS) en `local_folder`, copia los ficheros modificados en las últimas `horas` horas (default 12) y desmonta todo.

### `resume` — Informe diario de backups

```bash
backup-tools resume
```

Lista los `.tar.gz` creados en las últimas 24h en `local_folder_backups`, ordenados por tamaño descendente, y envía email con tabla resumen. **Necesita la parte de email configurada.**

### `alive` — Monitorización de conectividad

```bash
backup-tools alive 192.168.1.30
```

Hace ping al host. Si no responde, envía email de alerta con timestamp y nombre del servidor. **Necesita la parte de email configurada.**

### `version`

```bash
backup-tools version
```

Imprime la versión y sale.

## Logging

### Consola

- `-v`: nivel INFO
- `-vv`: nivel DEBUG
- Sin flag: nivel WARNING

### Loki (Grafana)

Opcionalmente, los logs pueden enviarse a un servidor Loki compatible. Para activarlo:

1. Instalar con soporte Loki: `pip install yeboyebo-backup-tools[loki]`
2. Configurar la URL del endpoint:

   ```bash
   backup-tools config loki_url https://monitor.yeboyebo.es/loki/api/v1/push
   ```

3. (Opcional) Si el servidor Loki requiere autenticación básica:

   ```bash
   backup-tools config loki_user usuario_loki true
   backup-tools config loki_pass contraseña_loki true
   ```

4. (Opcional) Personalizar etiquetas:

   ```bash
   backup-tools config loki_app mi_app
   backup-tools config loki_env staging
   ```

   Las etiquetas `app` y `env` se envían con cada registro y permiten filtrar en Grafana.

La configuración de Loki es **opt-in**: si `loki_url` está vacío (default) solo funciona el log por consola.

## Crontab

Al estar instalado como paquete, el comando `backup-tools` está disponible globalmente. No es necesario `cd` al directorio de la herramienta. Los ficheros de lista deben referenciarse por ruta absoluta o relativa al home.

### Primer despliegue — configuración inicial

```bash
# Parámetros planos
backup-tools config user_email vigilancia.yeboyebo@gmail.com
backup-tools config list_mails admin@example.com
backup-tools config server_name PRODUCCION
backup-tools config local_folder_backups /mnt/backups
backup-tools config host_db 127.0.0.1
backup-tools config port_db 5432
backup-tools config days_alive 30

# Credenciales (ofuscadas — 3er argumento true)
backup-tools config user_db postgres true
backup-tools config pass_db SECRETO true
backup-tools config pass_email CLAVE_GMAIL true
```

### Backup diario — 3:17 AM

```
17 3 * * * backup-tools db dump ~/lista.txt
```

### Replicación diaria a servidor de contingencia — 5:17 AM

```
17 5 * * * backup-tools db replicate ~/lista.txt
```

Requiere `replicate_host_db` en config.

### Test semanal de integridad — domingo 7:17 AM

```
17 7 * * 0 backup-tools db test ~/lista.txt
```

### Informe diario de actividad — 8:17 AM

```
17 8 * * * backup-tools resume
```

### Monitorización de conectividad — cada 30 min

```
*/30 * * * * backup-tools alive 192.168.1.1
*/30 * * * * backup-tools alive 192.168.1.30
*/30 * * * * backup-tools alive backup-server.example.com
```

### Sincronización a NAS — cada 6 horas

```
17 */6 * * * backup-tools file remote /mnt/nas //192.168.1.200/backups 6
```

### Todo junto — crontab completo

```
# Backup PostgreSQL diario
17 3 * * * backup-tools db dump ~/lista.txt

# Replicación a contingencia
17 5 * * * backup-tools db replicate ~/lista.txt

# Test integridad (domingos)
17 7 * * 0 backup-tools db test ~/lista.txt

# Informe diario
17 8 * * * backup-tools resume

# Sincro a NAS cada 6h
17 */6 * * * backup-tools file remote /mnt/nas //192.168.1.200/backups 6

# Ping a servidores cada 30 min
*/30 * * * * backup-tools alive 192.168.1.1
*/30 * * * * backup-tools alive 192.168.1.30
```

### Volcado de logs

```
17 3 * * * backup-tools -v db dump ~/lista.txt >> /var/log/backup_tools.log 2>&1
```

### Varias listas de BBDD

```
# Diario: BBDD críticas
17 3 * * * backup-tools db dump ~/criticas.txt

# Solo domingos: BBDD grandes o poco cambiantes
17 4 * * 0 backup-tools db dump ~/grandes.txt
```

## Programación en Windows (Task Scheduler)

En Windows, usar Task Scheduler (`taskschd.msc`) en vez de cron. Ejemplo para backup diario:

```powershell
$action = New-ScheduledTaskAction -Execute "backup-tools" -Argument "db dump C:\backups\lista.txt"
$trigger = New-ScheduledTaskTrigger -Daily -At 3:17AM
Register-ScheduledTask -TaskName "Backup PostgreSQL" -Action $action -Trigger $trigger -Description "Backup diario BBDD"
```

Para volcar logs a fichero:

```powershell
$action = New-ScheduledTaskAction -Execute "powershell" -Argument "-Command `"backup-tools -v db dump C:\backups\lista.txt *> C:\backups\backup.log`""
```

## Notas

- Las contraseñas en `config.ini` se ofuscan con Fernet (AES-128-CBC) derivando clave vía PBKDF2-SHA256 + salt fijo. No es seguridad fuerte pero evita plaintext.
- El envío de email usa SMTP de Gmail con STARTTLS en puerto 587.
- `check_current_backups` mantiene las N copias más recientes en la subcarpeta `currents/` y borra las obsoletas automáticamente.
- La ruta de `config.ini` puede especificarse con la variable de entorno `BACKUP_TOOLS_CONFIG`.

## Más

- [Volver al índice de copias de seguridad](../index.md)
