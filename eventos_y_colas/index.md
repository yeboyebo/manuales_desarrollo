# Gestion de eventos y colas

## Publicar un evento

---

- Importamos el EventBus:

```python
from pineboolib.qsa import qsa

EventBus = qsa.class_.EventBus
```

- Y lanzamos lo siguiente:

```python
EventBus.publish(event_type, event_id, event_data)
```

`event_type` es el nombre del evento \
`event_id` es un string que representa el id del registro (ej: en factura_creada, pondríamos el id de la factura, o el código) \
`event_data` es un objeto que contiene los datos del registro (ej: en factura_creada, los datos de la factura)

- Aquí podemos ver un par de ejemplos:

```python
EventBus.publish("factura_creada", "20220A000010", { "id": 348, "codigo": "20220A000010", "nombrecliente": "Jose Antonio Martínez", "total": 145.30 })

EventBus.publish("contacto_email_actualizado", "0655642", { "codcontacto": "0655642", "nombre": "Julián", "edad": 54, "email": "julian@lopez.com" })
```

## Suscripción a un evento:

---

- Vamos a EventSubscribers.py en sistema/libreria/scripts.
- Encontramos la función `set_consumers` de nuestra extensión. Si no existe, la creamos. Debe ser estática y llamar en la primera línea a la misma del padre.

```python
super(ExtensionClass, ExtensionClass).set_consumers()
```

- Ejemplo. Para la extensión `IvaIncluido` habría que poner lo siguiente:

```python
super(IvaIncluido, IvaIncluido).set_consumers()
```

- Añadimos nuestra suscripción:

```python
EventSubscribers.subscribe(event_type, queue_name, fn)
```

`event_type` es el nombre del evento \
`queue_name` es el nombre de la cola y debe responder a la siguiente estructura: `subscriber_fn-on-event_type` \
(donde `subscriber_fn` es el nombre de la función a ejecutar y `event_type` el del evento, unidos por el `-on-` intermedio) \
`fn` es una función importada desde otro script

- Aquí podemos ver un par de ejemplos:

```python
EventSubscribers.subscribe("factura_creada", "calcular_iva-on-factura_creada", script("formfacturascli_api").calcular_iva)

EventSubscribers.subscribe("contacto_email_actualizado", "sincronizar_contacto-on-contacto_email_actualizado", script("formcontactos_api").sincronizar_contacto)
```

## La función de suscripción:

---

- La función de suscripción debe aceptar dos/tres parámetros:

  - El primero, seguramente sea `self`, salvo que tengamos una función estática
  - El segundo será el `id` del registro. Como vimos antes, en facturas sería el id o el código, en contactos el codcontacto...
  - El terecero será el `data` del evento. En los ejemplos anteriores sería la propia factura o contacto en forma de diccionario.

- Ejemplo:

```python
def calcular_iva(self, codigo_factura, factura):
  idfactura = factura["idfactura"]
  self.calcular_iva_factura(idfactura)
```

## Gestión de errores:

---

- Cuando se publique un evento que tenga suscriptores, se ejecutará la función que se suscribió.
- En caso de que falle, se volverá a ejecutar X veces (5 por defecto) con distintos tiempos de espera entre cada una de ellas.
- En caso de que termine fallando, se quedará un registro con `status = 'dead'` en la tabla `queue`.

## Más

- [Volver al índice de manuales](../README.md)
