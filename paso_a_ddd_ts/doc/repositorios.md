# Repositorios

Aunque podemos crear repositorios para persistir nuestros datos en distintos sistemas de ficheros, bases de datoe, etc. en nuestro caso nos concentraremos en la persistencia de datos en nuestras bases de datos legacy.

## Repositorios SQL
Cada repositorio debe cumplir su interfaz, que incluiremos en
```sh
domain/MiAgregadoRepositorio.ts
```
```ts
import { EjercicioFiscal } from "./EjercicioFiscal.js";

export interface EjercicioFiscalRepository {
	save(ejercicioFiscal: EjercicioFiscal): Promise<void>;
}
```

Los repositorios legacy que van contra una tabla cuya clave primaria se obtiene de una secuencia, deben definir una función para obtener dicha secuencia:
```ts
import { VentaTpv } from "./VentaTpv.js";

export interface VentaTpvRepository {
    // ...
	nextId(): Promise<string>;
    // ...
}
```

