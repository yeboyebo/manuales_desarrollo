# Despliegue en Kubernetes
[Kubernetes](https://www.youtube.com/watch?v=oTf0KxK1QNo&t=151s) es una infraestructura que nos permite el despliegue completo de aplicaciones WEB.

Para desplegar un proyecto en Kubernetes, tenemos que crear un fichero de configuración YAML que generará toda la infraestructura necesaria.

Para administrar las aplicaciones y servicios de Kubernetes, es necesario tener instalado [kubectl](https://kubernetes.io/es/docs/tasks/tools/included/install-kubectl-linux/) y muy recomendable la aplicación [Lens](https://k8slens.dev/download) que facilita algunas tareas de forma gráfica.

## Ejemplo Egicar

Fichero de despliegue de Egicar a modo de ejemplo
**kubernetes_deploy.yaml**
```
  apiVersion: apps/v1
kind: Deployment
metadata:
  name: egicar-deployment

  labels:
    app: egicar
spec:
  replicas: 1
  selector:
    matchLabels:
      app: egicar
  template:
    metadata:
      labels:
        app: egicar
    spec:
      hostname: egicar
      subdomain: api
      containers:
      - image: yeboyebohub/pinebooapi:latest
        imagePullPolicy: Always
        name: pineboo
        command: ["bash", "-c","python3 app/manage.py runserver 0.0.0.0:8080 --noreload"]
        env:
          - name: WEBHOST
            value: "api.egicar.com"
          - name: DBHOST
            value: ********
          - name: DBNAME
            value: "egicar"
          - name: DBPASSWORD
            value: "******"
          - name: DBPORT
            value: "5432"
          - name: DBUSER
            value: "*****"
          - name: WEBSOCKET
            value: "False"
          - name: "USE_ATOMIC_LIST"
            value: "True"
          - name: PROJECT_NAME
            value: "egicar"
          - name: EMAIL_SERVER
            value: "egicar.com"
          - name: EMAIL_USER
            value: "admin@egicar.com"
          - name: EMAIL_PASSWORD
            value: "*********"
          - name: EMAIL_PORT
            value: "465"
          - name: EMAIL_PROTOCOL
            value: "SSL"
---
apiVersion: v1
kind: Service
metadata:
  name: egicar
  labels:
    app: egicar
spec:
  ports:
  - port: 80
    name: http
    targetPort: 8080
  selector:
    app: egicar
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: 16m
    cert-manager.io/cluster-issuer: letsencrypt-prod
    kubernetes.io/ingress.class: nginx
    kubernetes.io/tls-acme: "true"
    nginx.ingress.kubernetes.io/cors-allow-headers: Content-Type
    nginx.ingress.kubernetes.io/cors-allow-methods: POST, GET, OPTIONS
    nginx.ingress.kubernetes.io/cors-allow-origin: https://app.atalayaexperiences.com
    nginx.ingress.kubernetes.io/cors-expose-headers: X-Custom-Header
    nginx.ingress.kubernetes.io/cors-max-age: "86400"
    nginx.ingress.kubernetes.io/enable-cors: "true"
  name: ingress-egicar
  namespace: default
spec:
  ingressClassName: nginx
  tls:
    - hosts:
      - api.egicar.com 
      secretName: egicar-tls # < cert-manager will store the created certificate in this secret.
  rules:
  - host: api.egicar.com
    http:
      paths:
      - backend:
          service:
            name: egicar
            port:
              number: 80
        path: /
        pathType: Prefix
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: egicar-ssl-secret
spec:
  secretName: egicar-ssl-secret
  renewBefore: 240h
  duration: 2160h
  commonName: api.egicar.com
  dnsNames:
  - api.egicar.com
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer

```


### Más

  * [Volver al Índice](./index.md)