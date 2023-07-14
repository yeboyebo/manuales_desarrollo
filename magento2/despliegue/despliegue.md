# Despliegue contínuo
Para desplegar una instancia de Magento 2 en el servidor de nuestro cliente utilizaremos [Github Actions](https://docs.github.com/es/actions). Las acciones definidas pueden ser complementadas con otras acciones del [marketplace de Github](https://github.com/marketplace?type=actions).

Todas las instalaciones contarán con un **servidor principal** (Servidor de Administración) en el que realizaremos el despliegue. Si el entorno contase con capacidad para **autoescalarse**, requerira un paso adicional para copiar los archivos en el servidor (docker) principal de autoescalado del fronpage.

## 1. Preparación
- Acceder al servidor de administración y crear la ruta de despliegue (/var/www/magento2 por ejemplo)
- Crear los directorios shared/magento/app/etc/ y shared/magento/pub/media
- Copiar fichero env.php a shared/magento/app/etc/
- Copiar imagenes en shared/magento/pub/media
- Generar clave SSH ssh-keygen -t rsa -b 4096 -N '' -f nombre_clave
- Mover las claves al directorio ~/.ssh/ y copiar el contenido de nombre_clave.pub en ~/.ssh/authorized_keys

## 2. Configurar Secrets y variables en Github

Las variables y secrets de Github son constantes que podemos configurar en el repositorio de Github para utilizarlas en sus acciones. Por tanto usaremos estamos constantes para configurar los parámetros del despliegue. Para crear o modificarlos, dentro del repositorio pulsamos sobre **Settings** (https://github.com/yeboyebo/nombre_repositorio/settings) y en el menú lateral izquierdo pulsamos sobre **Secrets and variables**. Los secrets son variables encriptadas. Crearemos las siguientes:

Secrets:
- COMPOSER_AUTH
    - Contenido del fichero auth.json con las claves del repositorio de magento
- PROD_HOST_DEPLOY_PATH
    - Ruta de despliegue en el servidor de producción (/var/www/magento2 por ejemplo.)
- PROD_SSH_CONFIG
    - Configuración SSH
    - 
        ~~~ 
        Host production 
        User root 
        IdentityFile ~/.ssh/id_rsa #o nombre de la clave ssh
        HostName ip o dominio
        Port 22
        ~~~
- PROD_SSH_PRIVATE_KEY
    - Clave Privada SSH
    -
        ~~~ 
            -----BEGIN OPENSSH PRIVATE KEY-----
            b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABlwAAAAdzc2gtcn
            ......................................................................
            QSJkt3VVqMO2YJAAAADnJvb3RAeWJTdGFnaW5nAQIDBA==
            -----END OPENSSH PRIVATE KEY-----
        ~~~
![Github Secrets](./img/secrets.png)

## 3. Configurar repositorio
Para el despliegue sin caida del servicio utilizamos la acción [Zero-downtime deployment magento](https://www.madit.fr/blog/our-blog-1/post/zero-downtime-deployment-magento-6) desarrollada por [MadIt](https://www.madit.fr/). Está acción realiza todas sus acciones sobre la carpeta magento en la raiz del proyecto, por tanto tendremos que realizar las siguientes acciones:

- Mover todos los ficheros al directorio "magento" en la raiz del proyecto. Revisar que los ficheros ocultos (.htacces, .user.ini, otros) se muevan correctamente.
- Modificar el gitIgnore para configurar las rutas con el directorio magento en la raiz
- Crear los directorios .github/workflows y el fichero .github/workflows/main.yml

## 4. Configurar main.yml
Copiamos la configuración básica para el despliegue de magento 2 en un solo servidor. Habrá que configurar cuando queremos que ejecute la acción (On push branch master) y podemos personalizar algunos parametros como los idiomas del tema o la versión de Php.
~~~
name: m2-guanabana-deploy

on:
  push:
    branches:
      - 'master_2_4_6'

jobs:
  magento2-build:
    runs-on: ubuntu-latest
    name: 'm2 tests & build'
    services:
      mysql:
        image: docker://mysql:8.0
        env:
          MYSQL_ROOT_PASSWORD: magento
          MYSQL_DATABASE: magento
        ports:
          - 3306:3306
        options: --health-cmd="mysqladmin ping" --health-interval=10s --health-timeout=5s --health-retries=3
      # elasticsearch:
      #   image: docker://elasticsearch:7.17.0
      #   ports:
      #     - 9200:9200
      #   options: -e="discovery.type=single-node" --health-cmd="curl http://localhost:9200/_cluster/health" --health-interval=10s --health-timeout=5s --health-retries=10
      opensearch:
       image: opensearchproject/opensearch:1.2.1
       ports:
         - 9200:9200
       options: -e="discovery.type=single-node" -e "plugins.security.disabled=true"  -e "plugins.security.ssl.http.enabled=false" --health-cmd="curl http://localhost:9200/_cluster/health" --health-interval=10s --health-timeout=5s --health-retries=10
      
    steps:
    - uses: actions/checkout@v3
      with:
        repository: '${{github.repository}}'  
    - name: 'launch magento2 build'
      if: always()
      id: build
      uses: MAD-I-T/magento-actions@v3.20
      env:
        COMPOSER_AUTH: ${{secrets.COMPOSER_AUTH}}
      with:
        process: 'build'
        langs: 'en_US,es_ES'
        php: 8.1
        composer_version: 2
        elasticsearch: 0
        opensearch: 1
        
        
    - name: 'launch security scanner files'
      if: always()
      uses: MAD-I-T/magento-actions@v3.20
      env:
        COMPOSER_AUTH: ${{secrets.COMPOSER_AUTH}}
      with:
        process: 'security-scan-files'
        php: 8.1
        composer_version: 2
        
        
    - name: 'launch security scanner modules'
      if: always()
      uses: MAD-I-T/magento-actions@v3.20
      env:
        COMPOSER_AUTH: ${{secrets.COMPOSER_AUTH}}
      with:
        process: 'security-scan-modules'
        php: 8.1
        composer_version: 2


   #### section to be activated, for zero downtime deployment on preprod and/or prod remove ${{false}}
    - name: 'launch magento2 zero downtime deploy with no permission check'
      if: steps.build.outcome == 'success'
      uses: MAD-I-T/magento-actions@v3.20
      env:
        COMPOSER_AUTH: ${{secrets.COMPOSER_AUTH}}
        BUCKET_COMMIT: bucket-commit-${{github.sha}}.tar.gz
        MYSQL_ROOT_PASSWORD: magento
        MYSQL_DATABASE: magento
        HOST_DEPLOY_PATH: ${{secrets.PROD_HOST_DEPLOY_PATH}}
        HOST_DEPLOY_PATH_BUCKET: ${{secrets.PROD_HOST_DEPLOY_PATH}}/bucket
        SSH_PRIVATE_KEY: ${{secrets.PROD_SSH_PRIVATE_KEY}}
        SSH_CONFIG: ${{secrets.PROD_SSH_CONFIG}}
        WRITE_USE_SUDO: true
      with:
        deployer: 'no-permission-check'
        process: 'deploy-production'
        
    - name: 'unlock deployer if fails'
      if: failure() || cancelled()
      uses: MAD-I-T/magento-actions@v3.20
      env:
        COMPOSER_AUTH: ${{secrets.COMPOSER_AUTH}}
        BUCKET_COMMIT: bucket-commit-${{github.sha}}.tar.gz
        MYSQL_ROOT_PASSWORD: magento
        MYSQL_DATABASE: magento
        HOST_DEPLOY_PATH: ${{secrets.PROD_HOST_DEPLOY_PATH}}
        HOST_DEPLOY_PATH_BUCKET: ${{secrets.PROD_HOST_DEPLOY_PATH}}/bucket
        SSH_PRIVATE_KEY: ${{secrets.PROD_SSH_PRIVATE_KEY}}
        SSH_CONFIG: ${{secrets.PROD_SSH_CONFIG}}
        WRITE_USE_SUDO: true
      with:
        process: 'cleanup-production'
    
~~~

## 5. Despliegue en servidores escalables (OPCIONAL)

Para realizar el despliegue en un sistema con autoescalado tendremos que copiar los ficheros al servidor principal de frontpage para el escalado. Para ello necesitamos añadir los siguientes secrets:

- FRONT_SSH_HOST
    - Ip o dominio del host del frontpage
- FRONT_SSH_PRIVATE_KEY
    - Clave Privada SSH
    -
        ~~~ 
            -----BEGIN OPENSSH PRIVATE KEY-----
            b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABlwAAAAdzc2gtcn
            ......................................................................
            QSJkt3VVqMO2YJAAAADnJvb3RAeWJTdGFnaW5nAQIDBA==
            -----END OPENSSH PRIVATE KEY-----
        ~~~

Tenemos que modificar el fichero main.yml y añadir nuevas acciones para que copien los ficheros:
~~~ 
- name: Install SSH Key
      if: ${{ success() }}
      uses: shimataro/ssh-key-action@v2
      with:
        key: ${{secrets.FRONT_SSH_PRIVATE_KEY}}
        known_hosts: 'just-a-placeholder-so-we-dont-get-errors'
    - name: Adding Known Hosts
      if: ${{ success() }}
      run: ssh-keyscan -H ${{secrets.FRONT_SSH_HOST}} >> ~/.ssh/known_hosts

    - name: Deploy with rsync
      if: ${{ success() }}
      run: rsync -avz ./ root@${{secrets.FRONT_SSH_HOST}}:${{secrets.PROD_HOST_DEPLOY_PATH}}
~~~ 

## 6. Ejecución

Al realizar un push sobre la rama configurada ("master_2_4_6" en el ejemplo) se ejecutará la acción de deploy. Puedes ver la ejecución de la misma desde la pestaña "Actions" del repositorio.

![Ejecución en Github](./img/github_1.png)
![Ejecución en Github](./img/github_2.png)