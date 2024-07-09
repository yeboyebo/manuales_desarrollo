# Acceso a Olula

Asegúrate de tener la última versión de git de _pinebooapi_.

Indicar la ruta local a la carpeta _codebase/olula_ en el fichero _.env_ de _pinebooapi_:

```sh
EXTERNAL_MODULES=/home/antonio/codebase/olula
```

En el script donde queramos usar el código:
```py
import familias.familias as familia
```
Y luego podemos usarlo normalmente:
```py
def post(self, params, username):
    familia.crear_api(params, username)
```


Suponiendo que existe la ruta _.../codebase/olula/familias/familias.py_