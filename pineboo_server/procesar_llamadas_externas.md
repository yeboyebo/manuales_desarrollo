# Pineboo Server / Procesar llamadas externas

## Introducción

Algunos servicios externos disponen de la posibilidad de informarnos de cambios de estado en procesos de los que queremos estar informados.

Estos cambios podemos obtenerlos de 2 maneras:

- Llamada bajo demanda. Realizamos consultas manuales.
- Llamada externa. El servicio externo nos avisa del cambio en el proceso cuando se realiza.

Vamos a utilizar este segundo punto (Llamada externa).

## Punto de entrada

Para hacer una llamada se puede usar la siguiente estructura:
`http://localhost:8005/end_point/name/action/`

Donde nombre es el nombre de ese punto de entrada, por ejemplo 'clickandsign' y action es la acción a ejecutar, por ejemplo 'change_state'. Los datos adjunto se adjuntan por POST, o en el body de la llamada.

`http://localhost:8005/end_point/clickandsign/change_state/`

payload = `signature_id=1111000000&signatory_id=1111000002&contract_id=CompanyID1233456&status=evidence_generated&status_date=1522111485`

## Proceso de datos

Los datos se procesan en API.py del módulo librería:

```python

    def externa_entry_point(self, name, action, params):
        result = False
        if name == "clickandsign":
            if action == "change_state":
                result = qsa.from_project("flrrhhppal").iface.procesaEstadoClickandSign(params)
        return result
```

Esta función puede ser sobrecargada por otras extensiones para redireccionar las llamadas a las funciones que procesan los datos.

### Más

- [Volver al Índice](./index.md)
