# VPN

Para instalar 'openvpn' ejecutamos:
```
sudo apt-get update 
sudo apt-get install openvpn
```
Solicitar al responsable el fichero con las claves de acceso.

Accedemos a Configuración -> Red -> VPN -> botón +(Añadir VPN) -> 'Importar desde un archivo'. Seleccionamos el fichero .ovpn

Si no se puede importar desde archivo, la configuraremos manualmente clicando 'OpenVPN'.

En la pestaña 'Identidad':

```
Nombre: YeboYebo, 
Pasarela: Ip de la pasarela(IP:puerto:protocolo),
Tipo: Contraseña con certificados(TLS)
Nombre de usuario: tu usuario
Contraseña: la contraseña
certificado CA: selecciona el fichero .p12
certificado Usuario: selecciona el fichero .p12
clave privada Usuario: selecciona el fichero .key
contraseña clave usuario: la contraseña
```
Entramos en la configuración 'Avazado'.
En la pestaña 'General':
```
Marcamos 'Establecer tipo de dispositivo virtual "TUN" y nombre "tun".
```

En la pestaña 'Seguridad':
```
Cifrado "Predterminado",
Marcamos 'Usar tamaño personalizado para la clave de cifrado: "128",
Autenticación HMAC: "sha-256"
```
En la pestaña 'Autenticación TLS':
```
Comprobar el certificado del servidor "Verificar el nombre exactamente",
Coincidencia del asunto "FW_YEBOYEBO",
Marcamos 'Verificar el uso de la firma del certificado del par (servidor)',
'Tipo de certificado TLS del par remoto: "Servidor",

'Cifrado o autenticación TLS adicional':
Modo: "Autencicación TLS"
Archivo de clave: selecciona el fichero .key,
Dirección de la clave: "1",
Certificados adicionales: (ninguno)
```
Hacemos clic en "Aplicar" tanto para la configuración avanzada como la general e intentamos conectarnos. 