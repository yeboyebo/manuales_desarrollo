# SSH

## Instalación
Ejecutamos en una consola:
  ```console
    sudo apt-get install openssh-server
  ```

PodemoS comprobar que se ha instalado ejecutando en consola:
```console
  sudo service ssh status
```

o entrando directamente desde el mismo servidor por ssh

```console
  ssh usuario@localhost -p 22
```

Desde un equipo conectado a la misma red local podremos entrar ejecutando

```console
  ssh usuario@ip_local_servidor -p 22
```

Desde un equipo fuera de la red local podremos entrar ejecutando

```console
  ssh usuario@ip_publica_servidor -p puerto_redireccionado_al_servidor
```

## Configuración para que se pueda entrar desde fuera de la red local
Para entrar desde un equipo fuera de la red, hay que redireccionar el puerto 22 (puerto por defecto ssh) o el puerto al que entren las peticiones ssh a la ip local del servidor para que al acceder con la ip pública al puerto configurado como ssh llegue al servidor.