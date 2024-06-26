# Como Crear Una API

Vamos a crear un fichero en el que declararemos las llamadas o requests que utilizaremos posteriormente.

> **NOTA**: Este fichero debe crearse en la carpeta **build** dentro del módulo de nuestra extensión. Posteriormente generaremos los ficheros/parches para que se apliquen los cambios.


## Creación Fichero

Para el ejemplo crearemos el fichero tpv_viajesmultitransstock_api.py dentro de la extension **codebase/extensiones_2.5.0/fun_elganso_ctr/build/src/facturacion/tpv/restapi/tpv_viajesmultitransstock_api.py**


## Declarar Fichero

Para que todo nos funcione correctamente, debemos declarar una accion al final del fichero xml del módulo. En nuestro caso en:
**codebase/extensiones_2.5.0/fun_elganso_ctr/build/src/facturacion/tpv/flfact_tpv.xml**
```
	<action>
		<name>tpv_viajesmultitransstock_api</name>
		<scriptform>tpv_viajesmultitransstock_api</scriptform>
	</action>
```

## Creación Clase Schema
Primero crearemos una clase de tipo **Schema** donde declararemos los campos que devolveran nuestras llamadas.

```py
    class viajesSchema(Schema):
        idviajemultitrans = fields.String(allow_none=True)
        enviocompletado = fields.Boolean(allow_none=True)
        fecha = fields.Date(allow_none=True)
        cantidad = fields.Float(allow_none=True)

        @post_load
        def make_viaje(self, data, **kwargs):
            Viajes = qsa.orm.tpv_viajesmultitransstock
            if "idviajemultitrans" in data:
                viaje = Viajes.get(data["idviajemultitrans"])
                for field in data:
                    setattr(viaje, field, data[field])
            else:
                viaje = None
            
            
            return viaje
```

Debemos declarar cada campo junto a su tipo. Además, podemos añadir **(allow_none=True)** para aceptar campos nulos.


## Creación Clase Oficial

Esta clase contendra la declaración de las llamadas o request. Podremos hacer cuatro tipos de llamadas o requests:
* **get**: Para leer
* **post**: Para crear
* **patch**: Para modificar
* **del**: Para borrar

Tambien en esta tenemos la función get_mapa donde deberemos realizarmeos la consulta que nos traera los datos de la bbdd. Los campos que tiene son los siguientes:
* **join**: La tabla en la que consultaremos.
* **order**: El campo de la tabla que utilizaremos para ordenar los resultados.
* **map**: Objeto donde declararemos cada campo indicando el campo de la tabla y su tipo.

Para modificar el where de la consulta se enviara un objeto filter dentro del parametro **params**.

```py
    def get_mapa(self, username):
        return {
            'join': 'tpv_viajesmultitransstock',
            'order': 'fecha',
            'map': {
                'idviajemultitrans': {'field': 'tpv_viajesmultitransstock.idviajemultitrans', 'type': 'string'},
                'enviocompletado': {'field': 'tpv_viajesmultitransstock.enviocompletado', 'type': 'boolean'},
                'fecha': {'field': 'tpv_viajesmultitransstock.fecha', 'type': 'date'},
                'cantidad': {'field': 'tpv_viajesmultitransstock.cantidad', 'type': 'float'}
            }
        }   
```

## Compilar datos

Para que todos estos cambios se apliquen debemos compilar con el siguiente comando:

```
eneboo-assembler save fun_elganso_ctr
```


> **NOTA**: Después de bajarnos los cambios de Git, tenemos que ejcutar el siguiente comando para poder visualizar los ficheros nuevos:

```
eneboo-assembler dbupdate
```


## Probar llamadas

Podemos comprobar que las llamadas que hemos creado funcionen correctamente ejecutandolas desde **Postman**.

* **Url Base**. La url de nuestro servidor: http://127.0.0.1:8005/api/
* **Path de la llamada**. Parte de la URL que identifica la llamada (p.e. "*tpv_viajesmultitransstock*")
* **Objeto de datos**. Son los datos que se enviarán al servidor, deben estar estructurados tal y como la API los necesite.
* **Objeto de parámetros** (opcional): Se usará para indicar opciones de la llamada, como por ejemplo para usar una API alternativa a la de *Pineboo Server*

En la cabecera de la llamada debemos pasarle el **Authorization Token** del usuario de Eneboo que estamos utilizando.

Ejemplo de llamada GET:
```
    http://127.0.0.1:8005/api/tpv_viajesmultitransstock/**
```

Si queremos llamar a un metodo en concreto podemos utilizar el parametro *-static-* y llamar a la funcion que queremos
```
    http://127.0.0.1:8005/api/articulos/-static-/getProductsPda
```

## Resultado Fichero 
El fichero nos debe de quedar así:
  ```py
    # -*- coding: utf-8 -*-
    # Translated with pineboolib v0.45.3
    from typing import TYPE_CHECKING, Any
    from pineboolib.qsa import qsa 
    import json
    import datetime
    import time
    import hashlib
    from marshmallow import Schema, fields, pprint, post_load, ValidationError, validate

    orm = qsa.orm

    class viajesSchema(Schema):
        idviajemultitrans = fields.String(allow_none=True)
        enviocompletado = fields.Boolean(allow_none=True)
        fecha = fields.Date(allow_none=True)
        cantidad = fields.Float(allow_none=True)

        @post_load
        def make_viaje(self, data, **kwargs):
            Viajes = qsa.orm.tpv_viajesmultitransstock
            if "idviajemultitrans" in data:
                viaje = Viajes.get(data["idviajemultitrans"])
                for field in data:
                    setattr(viaje, field, data[field])
            else:
                viaje = None
            
            
            return viaje

    # @class_declaration Base */
    class Base(qsa.FormDBWidget):
        pass

    # @class_declaration Oficial */
    class Oficial(Base):

        def get(self, pk=None, params={}, username=None):
            print(params)
            mapa = self.get_mapa(username) 
            obj = None

            if pk != None:
                params["filter"] = json.dumps(["idviajemultitrans", "eq", str(pk)])
            
            obj = qsa.from_project("formAPI").get_resources('tpv_viajesmultitransstock', params, mapa, username)    
            params["filter"] = "[]" # Limpio filtros anteriores

            return obj
        
        def patch(self, pk, params={}, username=None):
            schema = viajesSchema()
            viaje = schema.load(params, partial=True)
            viaje.save()
            return True

        def delete(self, pk, username=None):
            viaje = viaje.get(pk, username)
            viaje.delete()
            return True
        
        def deleteEvent(self, params, username=None):
            if 'idviajemultitrans' in params:
                Viaje = qsa.orm.tpv_viajesmultitransstock
                viaje = Viaje.get(params['idviajemultitrans'], username)
                viaje.delete()
                return True
            return False

        def post(self, params, username=None):
            schema = viajesSchema()
            viaje = schema.load(params)
            viaje.save()
            return {"pk": viaje.idviajemultitrans}
        
        def get_mapa(self, username):
            return {
                'join': 'tpv_viajesmultitransstock',
                'order': 'fecha',
                'map': {
                    'idviajemultitrans': {'field': 'tpv_viajesmultitransstock.idviajemultitrans', 'type': 'string'},
                    'enviocompletado': {'field': 'tpv_viajesmultitransstock.enviocompletado', 'type': 'boolean'},
                    'fecha': {'field': 'tpv_viajesmultitransstock.fecha', 'type': 'date'},
                    'cantidad': {'field': 'tpv_viajesmultitransstock.cantidad', 'type': 'float'}
                }
            }
        
    # @class_declaration FormInternalObj */
    class FormInternalObj(Oficial):
        pass

    if TYPE_CHECKING:
        form: FormInternalObj = FormInternalObj()
        iface = form.iface
    else:
        form = None
  ```


### Más

  * [Volver al Índice](./index.md)