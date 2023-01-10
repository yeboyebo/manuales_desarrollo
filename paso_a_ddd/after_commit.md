# Eliminación de Before / After commit
---------------------------

## Repositorios por defecto
Los repositorios por defecto hacen una grabación que implica la ejecución de los beforeCommit / afterCommit en el código traducido

Ver *legacyRepository.py* en el módulo de *libreria*.

## Repositorios por agregado
Para ciertos agregados podemos crear un repositorio personalizado (lo ideal es hacer lo con todos ellos) en el que gestionemos el momento en el que llamamos a las funciones de *after / beforeCommit*.

Ver *docfacturacion_repo.py* y *facturascli_repo.py* en el módulo de *facturación*.

## Evitar la llamada no explícita a afterCommits 
Hay una forma de saber si estamos en el nuevo entorno de entidades y repositorios de DDD, con lo que podemos saber si una llamada debe hacerse de la forma tradicional, en el transcurso del *afterCommit*, o va a ser lanzada de forma explícita desde el respositorio o el gestor de eventos.

*formCURSOR.isFake(cursor)* nos indica si el cursor es en realidad una instancia de la clase *legacyEntity*, que comparte su interfaz.

```js
if (!formCURSOR.isFake(curFactura)) {
    if (curFactura.modeAccess() == curFactura.Edit) {
        if (!formRecordfacturascli.iface.pub_actualizarLineasIva(curFactura)) {
            return false;
        }
    }

    if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
        if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
            if (_i.generarAsientoFacturaCli(curFactura) == false) {
                return false;
            }
        }
    }
}
```
