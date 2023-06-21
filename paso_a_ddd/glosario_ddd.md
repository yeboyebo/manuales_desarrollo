# Glosario DDD

## Diseño guiado por el Dominio (Domain Driven Design)

Es una metodología de diseño de software que se centra en comprender y modelar el dominio de negocio en el que se utilizará el software, mediante la colaboración cercana entre los expertos en el dominio y los desarrolladores de software. Se busca crear un modelo de dominio bien definido y coherente que permita a los desarrolladores trabajar de manera eficiente y eficaz, utilizando técnicas y patrones específicos para lograr este objetivo. Esto permite garantizar la mantenibilidad, escalabilidad y testeabilidad del software.

## Lenguaje Ubicuo (Ubiquitous Language)

Es un lenguaje común y compartido por todos los miembros de un equipo de desarrollo de software, incluyendo desarrolladores, diseñadores, analistas de negocio y expertos en el dominio.

El lenguaje ubicuo se basa en la idea de que la comunicación clara y efectiva es fundamental para el éxito de cualquier proyecto de software. Al establecer un vocabulario compartido y específico para el dominio del problema, se reduce la ambigüedad y se mejora la comprensión y colaboración entre los miembros del equipo.

Tanto el código como las conversaciones diarias deben compartir el mismo lenguaje.

## Contexto delimitado (Bounded Context)

Es una porción del dominio de un problema que está claramente definida y separada de otros contextos dentro del mismo dominio. Se utiliza para separar y organizar el diseño de una aplicación en módulos cohesivos y altamente acoplados para ayudar a gestionar la complejidad de los sistemas, reducir la ambigüedad y mejorar la calidad de la solución de software en general.

La separación puede efectuarse por equipos de trabajo o por distintas áreas del dominio.

## Arquitectura Hexagonal (Hexagonal Architecture)

También conocida como Arquitectura de Puertos y Adaptadores. Se enfoca en separar la lógica de negocio de la aplicación de la infraestructura técnica subyacente.

Tiene 3 capas definidas: negocio, aplicación e infrastructura. Cada capa tiene acceso restringido a sus capas exteriores, por lo que encapsula un aspecto concreto de nuestro diseño.

## Dominio (Domain)

Es el ámbito o campo de conocimiento en el que se encuentra un problema que necesita ser resuelto mediante el desarrollo de software. El dominio se compone de conceptos, reglas, procesos y operaciones que son relevantes para ese problema en particular. En esta capa se modelan las entidades y sus relaciones.

El dominio está desacoplado de la infraestructura o capas de entrada/salida (bases de datos, lectura de ficheros, lectura de memoria, etc...)

## Servicios de Aplicación (Application Services)

Son responsables de ejecutar las operaciones de negocio y coordinar la interacción entre los objetos de dominio para satisfacer las solicitudes de la interfaz de usuario. Los servicios de aplicación no contienen lógica de negocio específica, sino que coordinan la ejecución de las operaciones de negocio entre los objetos de dominio.

## Infraestructura (Infrastructure)

Se refiere a los componentes y servicios subyacentes que son necesarios para que una aplicación funcione, pero que no están directamente relacionados con el dominio del problema. Esto puede incluir cosas como el sistema operativo, la base de datos, el servidor web, las bibliotecas de terceros, y cualquier otra tecnología o herramienta que se necesite para que la aplicación se ejecute.

## Entidad (Entity)

Es un objeto que tiene una identidad única (duradera en el tiempo) y que se distingue de otros objetos por sus atributos (primitivos o Value Objects) y su comportamiento. Las entidades son objetos importantes en la capa de dominio de una aplicación, ya que representan los conceptos centrales del negocio.

## Objeto de valor (Value Object)

Es un objeto inmutable que representa un valor o conjunto de valores que son importantes en el dominio del problema y que carecen de identidad propia. A diferencia de las entidades, los objetos de valor no tienen una identidad única que los distinga de otros objetos, sino que se definen por sus atributos y su comportamiento.

## Raíz de Agregado (Aggregate Root)

Es una entidad que actúa como la raíz de un grupo de objetos relacionados. El Aggregate Root es el único objeto dentro del agregado al que se puede acceder directamente desde fuera del mismo, y es responsable de garantizar la coherencia de todo el conjunto y de que se cumplan las reglas de negocio que lo definen.

## Repositorio (Repository)

Es un patrón de diseño que se utiliza para abstraer el acceso a datos de la capa de aplicación. El Repository proporciona una interfaz para que las capas de aplicación interactúen con el almacenamiento de datos sin tener que conocer los detalles de implementación subyacentes.
