# Configuración

## Archivo qsa.config.json 
Este archivo contendrá la ruta a los ejecutables locales, así como las cadenas de conexión a las bases de datos de test y desarrollo.

/home/antonio/qsa.config.json 
```json
{
  "bin": {
    "eneboo": "/opt/eneboo-v2.6.0.1-dba/bin/eneboo",
    "pineboo": "pineboo-core"
  },
  "conn": {
    "test": "test:yeboyebo:SQLite3:nogui",
    "testPy": "test:antonio:SQLite3:nogui",
    "monterelax": "fun_monterelax:antonio:PostgreSQL:localhost:5432:epdsrntr:nogui",
    "oficial": "oficial:antonio:PostgreSQL:localhost:5432:epdsrntr:nogui"
  }
}
```

En codebase/modulos_2.5.0/qs_modules/bin ejecutar el siguiente comando
npm install -g .current 0x931af40


Lanzar el siguiente comando cambiando la ruta por la de nuestro equipo
/opt/eneboo-v2.6.0.3-dba/bin/eneboo -silentconn test:yeboyebo:SQLite3:nogui


Hay que notar que las bases de datos de test en qs y Python son distintas, y hay que cargar en ambas los módulos:
* qs_modules
* sistema/libreria


## Tests en Python
Debemos indicar la ruta a la carpeta contexts para cada base de datos

TO DO: Usar una única ruta y recargar siempre de codebase (y no de final) para los módulos comunes

En $HOME/.config/Eneboo/PinebooConfig.ini

```ini
[application]
codepath\fun_monterelax=/home/antonio/codebase/modulos_2.5.0
codepath\oficial=/home/antonio/codebase/modulos_2.5.0
codepath\test=/home/antonio/codebase/modulos_2.5.0
```

## Tests en Qs
En $HOME/.qt/eneboorc añadir las siguientes lineas

```ini
[application]
codepath/home/antonio/.eneboocache/ISO-8859-15/test=/home/antonio/codebase/modulos_2.5.0
codepath/home/antonio/.eneboocache/UTF-8/test=/home/antonio/codebase/modulos_2.5.0
```

Después ejecutar en codebase/modulos_2.5.0 lo siguiente
qs-task myp:test contexts/