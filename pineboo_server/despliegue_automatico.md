# Despliegue automático

Para automatizar el despliegue de los cambios en el servidor de Pineboo, utilizamos la tecnología de [Github Actions](https://www.youtube.com/watch?v=sIhm4YOMK6Q&t=5873s). Esta tecnología nos permite realizar acciones en diferentes puntos del ciclo de control de versiones con GIT.

Por lo general, lanzaremos acciones al realizar un PUSH en una rama, para ejecutar los pasos necesarios para desplegar la nueva version en pre-producción o producción. Estas acciones pueden ser:
- Compilar código
- Ejecutar tests
- Ejecutar analísis del código
- Preparar paquete / imagen de docker
- Copiar en producción
- Reemplazar imagen / instalar versión


## Configuración

Crearemos una rama especifica para los despliegues de un proyecto, de forma que cada vez que realicemos un PUSH en esa rama, automáticamente se desplegará la última versión de esa rama. Debemos crear la rama dentro del proyecto de **CODEBASE** Para configurar el despliegue necesitamos:

- .github/workflows/Deploy_miProyecto.yml  (Aqui se configuran las acciones que ejecutará GitHub)
- despliegue/Dockerfile_MiProyecto  (Configuración de la imagen de docker para este proyecto)


## Configurar GitHub Action

La configuración depende del proyecto en concreto y de dónde se quiera desplegar. A modo de ejemplo, esto es un despliegue en Kubernetes de Egicar
**.github/workflows/Deploy_Egicar.yml**
```
	name: Egicar

# Aqui indicaremos el nombre de la rama sobre la cual al hacer push se iniciara el proceso de despliegue automatico
on:
  push:
    branches:
      - Egicar_Produccion

jobs:
  Download-and-Build:
    if: ${{ github.ref_name == 'Egicar_Produccion' }}
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          repository: "yeboyebo/codebase"
          path: codebase
      - uses: actions/checkout@v3
        with:
          repository: "yeboyebo/pinebooapi"
          path: pinebooapi
          branch: "master"
      
      - name: Make envfile
        uses: SpicyPizza/create-envfile@v2.0
        with:
          envkey_PORT: 8005
          envkey_DOCKER_IP: 55
          envkey_PINEBOODIR: "/src/pineboo/"
          envkey_MODULESDIR: /src/codebase/extensiones_2.5.0/fun_egicar/build/final
          envkey_FLFILES_FOLDER: /src/codebase/extensiones_2.5.0/fun_egicar/build/final
          envkey_TEMPDIR: /src/pineboo/pineboo/tempdata
          envkey_WEBSOCKET: true
          envkey_USE_ATOMIC_LIST: true
          envkey_PROJECT_NAME: fun_egicar
          directory: pinebooapi
          file_name: .env
          fail_on_empty: false
          sort_keys: false

      - name: Set up QEMU
        uses: docker/setup-qemu-action@v3
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: ./
          file: codebase/despliegue/Dockerfile_Egicar
          push: true
          tags: yeboyebohub/pinebooapi_egicar:${{ github.sha }}
  
  deploy-to-cluster:
    name: deploy to cluster
    if: ${{ github.ref_name == 'Egicar_Produccion' }}
    runs-on: ubuntu-latest
    needs: Download-and-Build
    steps:
    
    - name: deploy to cluster
      uses: steebchen/kubectl@v2.0.0
      with:
        config: ${{ secrets.KUBE_CONFIG_DATA }}
        command: -n default set image --record deployment/egicar-deployment pineboo=yeboyebohub/pinebooapi_egicar:${{ github.sha }}
    
    - name: verify deployment
      uses: steebchen/kubectl@v2.0.0
      env:
        KUBE_CONFIG_DATA: ${{ secrets.KUBE_CONFIG_DATA }}
        KUBECTL_VERSION: "1.28"
      with:
        config: ${{ secrets.KUBE_CONFIG_DATA }}
        command: -n default rollout status deployment/egicar-deployment    
```

## Configurar imagen Pineboo
La configuración depende del proyecto en concreto y de **como** se quiera desplegar. A modo de ejemplo, esto es un despliegue en Kubernetes de Egicar
**despliegue/Dockerfile_Egicar**

```py
    FROM python:3.12.4-slim

MAINTAINER Javier Cortés <javier@yeboyebo.es>

ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y apt-utils build-essential vim tzdata libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev freetds-dev libgl1 libegl1 libxkbcommon-x11-0 libjpeg-dev libdbus-1-3 xcb libxcb-cursor0 libpq-dev libglib2.0-0 locales nano git
RUN apt-get install -y python3-anyjson

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir /src/
RUN mkdir /src/app/
RUN mkdir /src/app/logs
RUN mkdir /static/
RUN mkdir /static/images/
RUN mkdir /static/images/eventos
RUN mkdir /static/images/roadbooks
RUN mkdir /static/images/justificantes
RUN touch /src/app/logs/yebo.log
RUN touch /src/app/logs/django.log
RUN chmod -R a+rw /src
RUN echo "COMPROBANDO PERMISOS /src"
RUN ls -la -R /src
RUN chmod -R a+rw /static
ADD pinebooapi/requirements.txt /src/
COPY pinebooapi/app /src/app
COPY pinebooapi/motor /src/motor
COPY pinebooapi/.env /src/.env
RUN mkdir /pineboo
RUN mkdir /pineboo/log
RUN mkdir /src/pineboo
RUN mkdir /src/pineboo/modules
RUN mkdir /src/pineboo/pineboo
RUN mkdir /src/pineboo/tempdata
COPY codebase /src/codebase
WORKDIR /src/
RUN /usr/local/bin/python3 -m pip install --upgrade pip
RUN pip3 install --upgrade setuptools==57.5.0
RUN pip3 install -r requirements.txt --use-deprecated=legacy-resolver
RUN pip3 install pineboo==0.99.87.5
RUN pip3 install gpxpy
RUN pip3 install unidecode
RUN pip3 install enebootools
RUN chmod 777 -R /src/
RUN chmod 777 -R /static/images
RUN localedef -i es_ES -f UTF-8 es_ES.UTF-8
RUN echo "LANG=\"es_ES.UTF-8\"" > /etc/locale.conf
RUN ln -s -f /usr/share/zoneinfo/CET /etc/localtime
RUN echo "CREANDO USUARIO 'yeboyebo'"
RUN adduser --quiet --disabled-password --gecos '' yeboyebo 
RUN echo "yeboyebo:yeboyebo" | chpasswd 
RUN adduser yeboyebo sudo
RUN echo "COMPROBANDO EXISTENCIA USUARIO 'yeboyebo' y permisos"
RUN chown -R yeboyebo:yeboyebo /src
RUN chown -R yeboyebo:yeboyebo /pineboo
USER yeboyebo
RUN rm -rf /home/yeboyebo/Pineboo/tempdata/cache/*
RUN mkdir /home/yeboyebo/.eneboo-tools
COPY codebase/despliegue/assembler-config.ini /home/yeboyebo/.eneboo-tools/assembler-config.ini
RUN eneboo-assembler dbupdate
RUN eneboo-assembler build fun_egicar src
ENV LANG es_ES.UTF-8
ENV LANGUAGE es_ES.UTF-8
ENV LC_ALL es_ES.UTF-8
RUN whoami

```

### Más

  * [Volver al Índice](./index.md)