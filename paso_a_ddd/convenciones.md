# Convenciones

## Claves de dependencias

## Clases

## Ficheros

## Variables y atributos
Usaremos _camelCase_.

### Atributos privados
**No** usamos el guión bajo para indicar que el atributo es privado
```js
const v = this._miAtributo // Mal
const v = this.miAtributo  // Bien
```

### Acrónimos y siglas
En el caso de palabras formadas por iniciales (_IVA_, _IRPF_) indicamos solo la primera mayúscula. Ej:
```js
const codGrupoIvaNegocio = "A"
```

## Funciones y métodos
Usaremos _camelCase_.

### Métodos privados
**No** usamos el guión bajo para indicar que el método es privado
```js
const v = this._miMetodo() // Mal
const v = this.miMetodo()  // Bien
```

### Acrónimos y siglas
En el caso de palabras formadas por iniciales (_IVA_, _IRPF_) indicamos solo la primera mayúscula. Ej:
```js
const g = getGrupoIvaNegocio()
```

## Claves de diccionarios
Usaremos _camelCase_.
```js
const valores = {
  "valorUno": 1,
  "valorDos": 2,
}
```

### Excepciones
+ Nombres de campos en los mapper

## Otros

### Trailing comma
Dejaremos siempre la _trailing comma_ (coma al final del último elemento) en diccionarios y listas, para facilitar su ampliación.
```js
const valoresDic = {
  "valorUno": 1,
  "valorDos": 2,
}

const valoresArr = [
  1,
  2,
]
```
