# I.A. Aplicada a la navegación en ERP y otras aplicaciones web

## Objetivo
El objetivo del proyecto es incluir en los desarrollos de aplicaciones web y de nuestro ERP una opción o plugin que permita interactuar con la aplicación usando lenguaje natural.

Ventajas a conseguir:
+ Mejorar la productividad de los usuarios de la aplicación.
+ Reducir la curva de aprendizaje de nuevos usuarios.
+ Evitar la necesidad de memorizar y conocer la localización de cada una de las opciones de la aplicación.

## Concepto
Llamaremos _aplicación_ a cualquier desarrollo convencional basado en páginas web que tienen una jerarquía y sobre las que un usuario puede navegar, ver información y ejecutar acciones. Pueden estar aplicadas a nuestro ERP o a desarrollos a medida para clientes.

Podemos definir una aplicación como una gran máquina de estados en la que el usuario u otros agentes provocan eventos que hacen que su estado actual cambie. 

Así, podemos tener un estado _En Menú Principal_, que un evento _Ir a Facturación_ haría que la aplicación pasase a _En Submenú Facturación_, o que un evento _Crear Nuevo Presupuesto_ pasase a _Creando Presupuesto_.

Estado actual: _En Menú Principal_
+ (evento _Ir a Facturación_) > Nuevo estado: _En Submenú Facturación_
+ (evento _Crear Nuevo Presupuesto_) > Nuevo estado: _Creando Presupuesto_

Cada estado necesita un contexto de datos asociados, y solo un conjunto finito de eventos pueden provocar la transición a un nuevo estado.

La premisa de este proyecto es que podemos llegar a crear una interfaz gráfica de aplicación que:
+ Describa de forma oral o visual los datos relacionados con el estado actual de la aplicación.
+ Permita que usando lenguaje natural el usuario pueda dar las instrucciones para enriquecer el contexto de un estado o pasar a un nuevo estado.

## Fases
Para desarrollar el proyecto hemos definido las siguientes fases, que se aplicarán a un prototipo de aplicación sencilla (con pocos pero representativos estados y posibles transiciones entre ellos)

### Definición de contextos y funciones
Definición de un _mapa de estados_ que represente la aplicación en cuanto a:
+ Posibles estados
+ Eventos y transiciones
+ Contextos por estado

Cada nueva opción o desarrollo de la aplicación debe enriquecer el mapa de estados, de forma que dicha opción esté disponible para la nueva interfaz.

### Power bar de navegación y ejecución de acciones
Una vez definido el mapa de estados, podemos generar una herramienta de navegación determinista (sin aplicar IA) en la que:
+ Sea posible visualizar el estado en el que estamos, así como los datos necesarios de su contexto.
+ Se posible escoger el evento a disparar, y aportar los datos realacionados con dicho evento desde un control básico y común a toda la aplicación.

Este control puede ser lo que se llama una power bar, un control de texto con autocompletado que en función del estado de la aplicación permite al usuario escoger entre las opciones apropiadas.

Por ejemplo, si estando en el estado _Creando presupuesto_ escribimos en la barra "_Cambiar_", la barra nos propone entonces la lista de posibles del presupuesto valores a cambiar ("Cliente, Divisa, Forma de pago, etc.). Si escogiéramos '_Divisa_', la barra nos ofrecería la lista de divisas. De igual forma, si escribimos 'Cancelar', nos ofrecerá confirmar la cancelación de la creación del presupuesto y si confirmamos nos sacará a un estado anterior.

+ _Creando Presupuesto_ > Lista de posibles acciones ('Cambiar', 'Guardar', 'Cancelar')
    + 'Cambiar' > Lista de posibles valores a cambiar
        + 'Divisa' > Lista de posibles divisas a escoger
            + 'USD' > Cambio del valor en el presupuesto y permanecemos en estado _Creando Presupuesto_.
    + 'Cancelar' > 'Cancelar ¿Está seguro? (Sí / No)
        + Sí > Se cancela la creación y pasamos al estado anterior.

Cada una de estas acciones debe provocar también el redibujo de la zona de contexto de la aplicación, para que el usuario compruebe que la acción solicitada ha surtido efecto y de los posibles efectos secundarios de la acción (por ejemplo, si cambiamos la divisa, el valor _Total en Euros_ se recalcula).

### Aplicación de IA en la power bar, integración de voz
Herramientas como la API de autocompletado o de asistentes de OpenAI, permiten que un modelo LLM (Large Language Model) pueda ser invocado con:
+ El texto asociado a una frase de lenguaje natural (_prompt_)
+ Un conjunto de posibles funciones a ejecutar

y dar como respuesta la función y parámetros serializados que debemos usar para llamar a la función correcta de la forma solicitada en el prompt.

Un ejemplo simplificado sería
```js
respuesta = IA_API.obtener_respuesta({
    prompt: 'La moneda es dólares',
    functions: [
        {
            name: 'cancel',
            params: [],
            desc: 'Cancela la creación del documento'
        },
        {
            name: 'save',
            params: [],
            desc: 'Guarda del documento'
        },
        {
            name: 'set_divisa',
            params: [{ name:'divisa', type: 'string'}],
            desc: 'Establece la divisa o moneda del documento'
        }
        {
            name: 'set_cliente',
            params: [{ name:'cliente', type: 'string'}],
            desc: 'Establece el cliente del documento'
        },
        {
            name: 'set_forma_pago',
            params: [{ name:'forma_pago', type: 'string'}],
            desc: 'Establece la forma de pago del documento'
        }
    ]
})
/// La respuesta correcta sería:
respuesta = {
    function: 'set_divisa',
    params: {
        divisa: 'USD'
    }
}
```
Lógicamente esto se complica más que lo que el ejemplo indica, ya que es necesario especificar el formato de los parámetros requeridos (código ISO para la divisa, buscar el cliente en la base de datos por su nombre, etc.).

Dado que la IA puede alucinar los parámetros, será necesario pedir confirmación al usuario de todas aquellas acciones irreversibles o potencialmente peligrosas.

Dado que las APIs de IA siguen un modelo de facturación por uso (tokens) y las llamadas necesarias para ejecutarlas son más lentas que si se ejecutasen en el servidor de la aplicación, es interesante estudiar vías para reducir este tipo de llamdas. Para ello se considerará crear un sistema de caché que, dados un conjunto mínimo de entradas / salidas correctas de la IA (confirmadas por un usuario), memorice los resultados y los aplique directamente a futuras entradas con la misma estructura. También puede considerarse ejecutar un modelo de IA local que haga la función de esta caché y complemente al LLM, entrenándose con sus llamadas y respuestas.

### Aplicación de IA en la power bar para petición libre de datos
Otra situación común para el usuario de la aplicación es la petición de datos a consultar.

Para ello se creará un entorno que permitirá recoger peticiones en lenguaje natural y traducirlas a llamadas a la base de datos de la aplicación, que se mostrarán en uno de los formatos disponibles (tablas, gráficos de distintos tipos).

Los datos ofrecidos deberán ser interactivos, de forma que el usuario pueda profundizar en ellos (drill down). Por ejemplo, de un listado de facturas debemos poder ir a la ficha de una de ellas, o de un total podemos ir al desglose de dicho total viendo la lista de los documentos o entidades a partir de las que se ha calculado.

## Perfiles necesarios y plazos

+ Experto en IA Externo (Consultoría por Universidad de Valencia u otros expertos)
+ Analista Senior
+ Desarrollador Senior

### Definición de contextos y funciones
+ Analista Senior: 3 meses
+ Desarrollador Senior: 3 meses

### Power bar de navegación y ejecución de acciones
+ Analista Senior: 6 meses
+ Desarrollador Senior: 6 meses

### Aplicación de IA en la power bar, integración de voz
+ Experto en IA Externo: 0.5 mes
+ Analista Senior: 6 meses
+ Desarrollador Senior: 6 meses

### Aplicación de IA en la power bar para petición libre de datos
+ Experto en IA Externo: 0.5 mes
+ Analista Senior: 6 meses
+ Desarrollador Senior: 6 meses
