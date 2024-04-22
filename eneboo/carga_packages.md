# Eneboo / Carga paquetería desde consola

### Configuración
Solo es necesario un eneboo 2.6.3 o sup.


#### Eneboopkg desde consola
El comando permite instalar un fichero tipo eneboopkg desde consola sin necesidad de levantar un eneboo en modo gráfico para este proceso. Mezcla una llamada silentconn con 
Este es el comando:

```
./bin/eneboo -silentconn "test:postgres:PostgreSQL:localhost:5432:dkn42m:nogui" -c "sys.loadAbanQPackage" -a "/home/aulla/temporal/eneboo/paqueteria/principal.eneboopkg:false" -q
```

### Más

- [Volver al Índice](./index.md)