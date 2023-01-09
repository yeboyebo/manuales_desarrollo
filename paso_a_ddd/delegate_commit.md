# Delegate commit
---------------------------

## Activación
Activamos esta opción incliuyendo un setting local de *.qt/eneboorc*:
```sh
[application]
...
delegateCommit=true
```

Una vez activado, si cuando se hace un commit automático (se modifica, crea o borra un registro desde un FLFormRecord / FLTableDB), Eneboo buscará una función *_delegateCommit(cursor)* en el mismo script donde ahora creamos los *before/afterCommit*.

Si la función existe, el commitBuffer normal no se ejecuta, y se llama a la función.

La función por defecto a la que se llamará desde cada *_delegateCommit* es *formHTTP.iface.saveCursor(cursor)*

```js
function oficial_delegateCommit(cursor)
{
	var accion = null
	const tabla = cursor.table()
	switch(tabla) {
		case "x": {
			...
			break;
		}
        default: {
            return formHTTP.iface.saveCursor(cursor, accion)
        }
	}
}
```
En el caso de acceso a *aggregates* de DDD, modificaremos estas funciones para acceder a la API del agregado (ver función para líneas de documento de facturación en *flfacturac.qs*)