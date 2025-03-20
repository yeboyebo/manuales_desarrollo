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

### Apuntar la API a Kubernetes
Desde la administración de subdominios, apuntar el subdominio indicado en las claves _host_ y _subdomain_ a la IP pública de Kubernetes. Podemos verla con Lens > Network > Ingresses (columna load balancers)

### Crear la aplicación
Preparamos un fichero yaml de aplicación. La plantilla está en:

codebase/despliegue/plantilla_deploy.yaml

copiamos la plantilla con [nombre_app]_deploy.yaml  (este es el fichero que se usará una unica vez para hacer la instalación)

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

### Crear la rama y la Github Action
Ver punto similar en [despliegue_automatico](./despliegue_automatico.md)


### Comprobar el despliegue en github
Una vez configurado, el despliegue se lanza automáticamente al hacer un push a la rama [Aplicacion]_Produccion.

Podemos ver si el despliegue está en curso, hecho o con error en la web de Github > Proyecto _Codebase_ > Actions

### Ver el log de pinebooapi en Kubernetes
Lens > Pods > (pod que queremos consultar) > botón (...) > log

### Modificar el fichero de environment (env) en Kubernetes
Editamos el deployment (lápiz) y lo editamos allí.

## Más información sobre Kubernetes
[Kubernetes](https://www.youtube.com/watch?v=oTf0KxK1QNo&t=151s) es una infraestructura que nos permite el despliegue completo de aplicaciones WEB.

### Más

  * [Volver al Índice](./index.md)



