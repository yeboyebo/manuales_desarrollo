# Compartir settings con pineboo-core

## Objetivo

Poder compartir variables de entorno entre _pineboo-core_ y _pineboo-api_. En pineboo-api podemos acceder al fichero .env, y en ambos podemos hacerlo mediante base de datos. Sin embargo, el único método local accesible por ambos sería el fichero _PinebooSettings.ini_. Gracias a esta configuración podremos utilizar las funciones _qsa.FLUtil.readSettingEntry_ y _qsa.FLUtil.writeSettingEntry_ en ambos servidores y mantener sus valores conectados.

## Cómo mantener entornos conectados

### Comprobar el fichero docker-compose de pineboo-api

El fichero docker-compose.yml de pineboo-api ya está actualizado en el repositorio para incluir la siguiente línea:

```yaml
services:
  django:
    {...}
    volumes:
      {...}
      - ~/.config/Eneboo/PinebooSettings.ini:/home/yeboyebo/.config/Eneboo/PinebooSettings.ini
```

En caso de no encontrar esta línea en el docker-compose, asegúrate de actualizar el repositorio

### Comprobar el fichero PinebooSettings.ini de tu HOME

Para poder compartir las variables con el docker, el fichero que las guarda debe existir y tener los permisos necesarios.
Si hemos utilizado Pineboo en el equipo, ya tendremos el PinebooSettings.ini.
Como no es un fichero crítico, le vamos a dar todos los permisos:

```sh
$: sudo chmod 777 ~/.config/Eneboo/PinebooSettings.ini
```

## Uso

Ahora podemos utilizar las siguientes funciones tanto en _pineboo-api_ como en _pineboo-core_:

```py
url = "https://www.yeboyebo.es"
qsa.FLUtil.writeSettingEntry("scripts/yeboyebo/url", url)
```

o

```py
url = qsa.FLUtil.writeSettingEntry("scripts/yeboyebo/url")
print(url)
```

### Más

- [Volver al Índice](./index.md)
