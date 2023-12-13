# Despliegue Ganso Android
# Crear bundle(fichero .abb) subida a Google Play
Una vez que tengamos los cambios de nuestra aplicación NativeScript debemos realizar los siguientes pasos para poder publicar nuestra app.

## 1. Comprobación errores APP
Primero lanzaremos el siguiente comando para comprobar que no tenemos ningun problema con la app.

    ~~~
    ns doctor android
    ~~~

![Comporbacion errores App](./img/ns_doctor.png)

## 2. Instalar app en simulador o dispositivo real
Podemos probar que la app va a funcionar instalandola en un simulador o dispositivo de pruebas. Debemos tener el simulador arrancado o nuestro dispositivo conectado correctamente a nuestro PC.
Para ello ejecutaremos:

    ~~~
    ns run android
    ~~~

## 2. Creación fichero aplicación .abb (fichero bundle)
Una vez que hayamos comprobado que la app funciona correctamente y se instala en nuestro dispositivo podremos generar el fichero que publicaremos.

    ~~~
    ns build android --release --key-store-path ./keystore/keystore.jks --key-store-password ******** --key-store-alias elganso --key-store-alias-password ********  --aab --copy-to ./apk_android.aab
    ~~~

Este fichero se genera con un fichero de claves, pondremos la contraseña donde vemos los asteriscos. Este fichero de firma normalmente se encuentra dentro del proyecto en la carpeta **keystore**

Con el fichero generado ya podremos publicar nuestra app creando una nueva versión desde la console de Google Play (Google Play Console)
