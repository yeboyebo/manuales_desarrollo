# runTransaction

La función sys.runTransaction ejecuta una función bajo una transacción. Si la función devuelve *true*, la transacción se guarda, si devuelve *false*, se cancela.

Parámetros:
* Función a ejecutar
* Diccionario de parámetros

```js
if (!sys.runTransaction(formco_asientos.iface.copiarAsiento, oParam)) {
    return false;
}
```

### Más

- [Volver al Índice](./index.md)
