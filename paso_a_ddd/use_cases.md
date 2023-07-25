# Casos de uso

Los casos de uso son clases usadas para orquestar lógica de negocio que afecta a varios agregados (la que afecta a solo un agregado debe estar _dentro_ del agregado).

Los casos de uso se definen en la parte de aplicación.

## Repositorios
La gran mayoría de casos de uso usarán uno o más repositorios para leer datos y/o modificarlos. Los _repositorios_ se definen como atributos del caso de uso y se inicializan en su constructor.
``` js
    var ejercicioFiscalRepository;

    function CrearEjercicioFiscal(ejercicioFiscalRepository) {
        this.ejercicioFiscalRepository = ejercicioFiscalRepository;
    }
```
### Dependencias
En función del proyecto (cliente) o el entorno (test, producción) en el que estemos, podemos usar un repositorio u otro. Para definir esto cargamos el caso de uso con el gestor de dependencias:
``` js
const useCase = formDependencyContainer.get("empresa.ejerciciofiscal.application.CrearEjercicioFiscal")
```
Ejemplo de repositorio en producción (_empresa.deps.js_):
```json
    "empresa.ejerciciofiscal.application.CrearEjercicioFiscal": {
        "dep": "contexts/empresa/ejerciciofiscal/application/CrearEjercicioFiscal.qs",
        "args": [
            "@empresa.ejerciciofiscal.domain.ejercicioFiscalRepository",
        ]
    },
    "empresa.ejerciciofiscal.domain.ejercicioFiscalRepository": {
        "dep": "contexts/empresa/ejerciciofiscal/infrastructure/persistence/CursorEjercicioFiscalRepository.qs",
        "args": [
            "@empresa.ejerciciofiscal.domain.mapper",
        ]
    },
empresa;
```
Ejemplo de repositorio en test (_test.deps.js_):
```json
    "empresa.ejerciciofiscal.domain.repository": {
        "dep": "contexts/empresa/ejerciciofiscal/test/mocks/MockedEjercicioFiscalRepository.qs",
        "args": []
    },
```
## Función _run_
La función _run_ es la que ejecutará el caso de uso. No deberíamos necesitar acceder a una instancia del caso de uso por ninguna otra vía.

El funcionamiento típico de la función _run_ será ejecutar lógica de negocio en función de los parámetros recibidos y de lecturas en los repositorios, para luego devolver datos o crear/modificar algún agregado (a través también de su correspondiente repositorio).
```js
function run(params) {
    const ejercicioData = {
        "id": new EjercicioFiscalId(params["id"]),
        "fechaInicio": FechaHora.creaFecha(ejercicioData["fechaInicio"]),
        "fechaFin": FechaHora.creaFecha(ejercicioData["fechaFin"]),
        "idEmpresa": new EmpresaId["idEmpresa"]
    }
    if ("nombre" in params) {
        ejercicioData["nombre"] = params["nombre"];
    }
    if ("estado" in params) {
        ejercicioData["estado"] = params["estado"];
    }
    if ("longSubcuenta" in params) {
        ejercicioData["longSubcuenta"] = new WholeNumber(params["longSubcuenta"]);
    }
    const ejercicio = EjercicioFiscal.create(ejercicioData);
    this.ejercicioFiscalRepository.save(ejercicio);
}
```
Nota: El caso de uso es el responsable de crear, si no se especifica en los parámetros, los identificadores para las nuevas entidades a crear. Esto incluye los identificadores persisitidos en campos de tipo _serial_.


