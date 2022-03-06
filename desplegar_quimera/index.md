# Desplegar Quimera en producción
--------------------------------------

Ejemplo para el cliente *sanhigia*.

Generamos una carpeta con el build
```console
cd quimera-mono
npm run nx run sanhigia:build:production
```

Comprimimos el build:
```console
cd quimera-mono/dist/apps
tar -czvf sanhigia.tar.gz sanhigia
```

Movemos el fichero *.tar.gz* al servidor del cliente

En la carpeta de despliegue:
```console
rm -rf build_old
tar -xzvf sanhigia.tar.gz
mv build build_old
mv sanhigia build
```

## Más

  * [Volver al índice de manuales](../README.md)


