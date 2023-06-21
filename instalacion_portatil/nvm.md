# NVM

Para el funcionamiento de Quimera, la versión que se debe de ejecutar de node es la 16, es posible que se tenga una inferior por lo que deberíamos de instalar la 16 o tengamos una superior y deberíamos de utilizar la 16 aunque tengamos la 18.
Lo que haremos a parte de tener instalada la version 16  es utilizar un gestor de versiones de node para poder cambiarnos a la 16 si es necesario por tener otras versiones.

En el siguiente enlace podemos ver como se instala y se usa

https://github.com/nvm-sh/nvm

Luego:
```sh
Instalar npm
nvm install 16
rm package-lock.json
rm -rf node_modules
npm install
nvm use 16 && npm start X
```

  * [Volver al Índice](./index.md)