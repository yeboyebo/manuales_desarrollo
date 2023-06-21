# Configuración QSModules

## Descripción

QSModules son una serie de ejecutables y librerías de utilidad que nos permiten extender la funcionalidad de qsa tal como si fueran paquetes de npm.

## Pasos previos

### Paso 1. Instalar los binarios de qs_modules

Si no tenemos instalados los binarios de qs_modules, vamos a la carpeta (a partir de la raíz de módulos) /qs_modules/bin/ y lanzamos

```sh
npm install -g .
```

Si tenemos problemas de permisos podemos lanzarlo con sudo.

### Paso 2. Configurar nuestro entorno

En nuestro directorio HOME creamos un fichero _qsa.config.json_ con un contenido similar a este:

```json
{
  "bin": {
    "eneboo": "/home/.../eneboo-v2.6.0.1-dba/bin/eneboo"
  },
  "conn": {
    "test": "test:yeboyebo:SQLite3:nogui"
  }
}
```

Donde deberemos indicar la ruta a nuestro binario de eneboo, y una serie de conexiones a base de datos. En este ejemplo, añado la conexión a la base de datos de test en sqlite.

### Paso 3. Cargar módulo qs_modules

Simplemente cargar el módulo como de costumbre. Podemos encontrarlo en la raíz de los módulos oficiales. Solamente será necesario ejecutar este paso una primera vez. (salvo actualizaciones que lo requieran)

- [Volver al índice](./index.md)
