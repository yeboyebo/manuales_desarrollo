# Configurar Subversion

## Prerrequisitos
Para usar subversion necesitamos tener un usuario del subversion de Yeboyebo. Pedir al admin que lo cree en el servidor:
```sh
/usr/bin/htpasswd -m /etc/apache2/dav_svn.passwd
```

## Instalación
- Para instalar subversion ejecutamos:

    ```
    sudo apt install subversion
    ```

- La primera vez bajamos un módulo con:

    ```
    svn co url_del_módulo
    ```

- Ponemos la contraseña de subversion

- Desde abanq o eneboo, al abrir la primera vez, configurar lo siguiente:

    - Sistema -> Informes AR -> Opciones
	    Activar check Activar conversión de ficheros .ar
	    Opción de codificación ISO-8859-15

    - Servicios -> Mantenimiento de versiones -> Configuración
	    Establecer versión de desarrollo = tronco

  
  * [Volver al Índice](./index.md)