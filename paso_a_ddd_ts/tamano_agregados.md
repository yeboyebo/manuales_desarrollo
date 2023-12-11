# Grandes

### Pros

Lógica encapsulada en el agregado

Más fáciles de guardar en repos

### Contras

Eventos de las partes (p.e. líneas) enterrados en el agregado. (Venta -> Linea 2 borrada)

Repos complicados (Venta + Líneas + Pagos)

# Pequeños

### Pros

Repos sencillos (Venta, Línea, Pago)

Eventos sencillos (Línea borrada)

### Contras

Mayor complejidad al crear los Mother (VentaMother + LineasMother + PagosMother + totalización por separado)

ValueObject distribuidos entre padre e hijos (Stock, Dinero)

## Desplazando lógica a application

### Pros

### Contras

Lógica distribuida en ficheros de application (creo/borro/modifico una línea tengo que totalizar)

## Desplazando lógica a application con máquinas de estado

### Pros

Lógica de negocio orquestada en application desde un punto único

Facilidad para diseñar / entender / comunicar (el diseño es ya una fase del desarrollo)

¿Facilidad para inyectar lógica personalizada? machine.provide()

Distinguimos eventos "internos" o transaccionales del módulo (ventas) de externos, que generalmente pueden no ser transaccionales

### Contras

Mayor complejidad estructural. Una capa / librería más

## Usando eventos de dominio

### Pros

### Contras

Lógica distribuida en ficheros de application (creo/borro/modifico una línea > Evento)

Posibles restricciones incumplidas (crear un pago cuya venta no existe)

¿Más accesos a BD? (Nuevo pago > Guardo > Evento > Cargo venta y pagos > Totalizo > Guardo venta)

