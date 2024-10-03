# Despliegue en Kubernetes

## Prerrequisitos
Para administrar las aplicaciones y servicios de Kubernetes, es necesario tener instalado [kubectl](https://kubernetes.io/es/docs/tasks/tools/included/install-kubectl-linux/) y muy recomendable la aplicación [Lens](https://k8slens.dev/download) que facilita algunas tareas de forma gráfica.


## Pasos para una nueva instalación de Eneboo + Pinebooapi

### Crear la BD en Kubernetes
Una vez tenemos el dump con la base de datos preparado:

+ Abrimos filezilla
+ Creamos una ubicación con:
`sftp://root@nadia.server1.online`
+ Subimos la BD

`NOTA`: Esto a veces no funciona según la instalación. Pedir a Iván que lo haga él si no nos funciona.

+ En Lens, entramos en la consola desde el pod asociado a postgres (pods > postgres-deployment...) > Opción ">_"
  + Creamos la BD
    + `createdb [bd] -E UNICODE`
  + Restauramos la copia:
    + `psql [bd] < [fichero.dump]`

### Crear la aplicación
Preparamos un fichero yaml de aplicación. La plantilla está en:

codebase/despliegue/plantilla_deploy.yaml

Sustituimos [nombre_app] por el nombre de la aplicación a crear, teniendo en cuenta:

+ Si el subdominio es api.yeboyebo.es:
  + hostname: yeboyebo
  + subdomain: api

Desde Lens, abrimos una consola En la carpeta con el fichero yaml:
  `kubectl apply -f kubernetes_deploy.yaml`

Debemos obtener:
```sh
service/yeboyebo created
ingress.networking.k8s.io/ingress-yeboyebo created
certificate.cert-manager.io/yeboyebo-ssl-secret created
```

### Apuntar la API a Kubernetes
Desde la administración de subdominios, apuntar el subdominio indicado en las claves _host_ y _subdomain_ a la IP pública de Kubernetes. Podemos verla con Lens > Network > Ingresses (columna load balancers)

### Crear la rama y la Github Action
+ Creamos la rama en github a partir de master [Aplicacion]_Produccion. Ejemplo: *Sanhigia_Produccion*

__Fichero de github__
+ En codebase/.github/workflows/creamos un nuevo fichero Deploy_[Aplicacion].yml a partir del fichero Deploy_Plantilla.yml.
  + Modificamos los datos y ponemos la funcionalidad correcta
  + En las claves *deploy_to_cluster*, _command_ tiene que apuntar al nombre del deployment correto de Kubernetes, especificado en el fichero de despliegue de Kubernetes, en la clave _metadata_ > _name_.

__Fichero Dockerfile__
+ En codebase/.despligue creamos un nuevo fichero Dockerfile_[Aplicacion] a partir del fichero Dockerfile_Plantilla
  + Modificamos la línea `RUN eneboo-assembler build... ` indicando el nombre de la extensión
  + Comprobamos que el nombre del fichero Dockerfile_[Aplicacion] generado coincide con la clave `name: Build and push` > _file_ del fichero de github asociado Deploy_[Aplicacion].yml

+ En codebase/despliegue creamo un nuevo fichero Dockerfile_[Aplicacion]

### Comprobar el despliegue en github
Una vez configurado, el despliegue se lanza automáticamente al hacer un push a la rama [Aplicacion]_Produccion.

Podemos ver si el despliegue está en curso, hecho o con error en la web de Github > Proyecto _Codebase_ > Actions

## Más información sobre Kubernetes
[Kubernetes](https://www.youtube.com/watch?v=oTf0KxK1QNo&t=151s) es una infraestructura que nos permite el despliegue completo de aplicaciones WEB.

### Más

  * [Volver al Índice](./index.md)


