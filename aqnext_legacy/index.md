# AQNext Legacy

---
AQNext se mantiene desde repositorios git.

Hay que ir poco a poco pasando la funcionalidad de servidor de AQNext a Pinebooapi.

## Llamadas a PinebooAPI

Hay que incluir en el fichero */models/flfactppal/flfactppal_def.py*
```py
def llamaAPI(self, url, verbo, params=None):
    res = {}
    api_url = "http://127.0.0.1:8005/api/"
    # api_url = "http://172.65.0.1:8005/api/"
    token = 'd12e36e5b04b5c060451722c460c47a1178fd61e'
    header = {"Content-Type": "application/json", "Authorization": "Token {}".format(token)}
    if verbo == "post":
        res = requests.post(api_url + url, headers=header, data=params)
    elif verbo == "get":
        # Esta sin probar de momento. Fecha 06-10-2022
        res = requests.get(api_url + url, headers=header, params=params)

    return res
```
La sintaxis de las llamadas es así
```py
from models.flfactppal import flfactppal_def
...
url = "pedidosproveedor/{0}/llama_generar_albaran".format(idpedido)
res = flfactppal_def.iface.llamaAPI(url, "post")
```

## Más

- [Volver al índice de manuales](../README.md)
