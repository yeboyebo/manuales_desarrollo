# Quimera / Shortcuts

Los shortcuts son conjuntos parametrizables de grapes que podemos incluir en nuestro controlador y que definen comportamientos comunes que solemos necesitar implementar.

## Model
El shortcut de *Model* gestiona una lista de elementos provenientes del servidor de API.

### Estado
La estructura que se monta en el estado para un shortcut con name "categorias" es:

```json
{
  "categorias": {
    "dict": {
      "cat1": {
        "idCategoria": "cat1",
        "nombre": "Categoria 1"
      },
       "cat2": {
        "idCategoria": "cat2",
        "nombre": "Categoria 2"
      }
      // Diccionario de items por clave de cada elemento
    },
    "idList": [
      "cat2", "cat1"
      // Lista ordenada de claves de los elementos
    ],
    "current": "cat1" // Clave del elemento actual,
    // Otros elementos secundarios e control
  }
}
```

### Grapes llamables (slots)
**get{Modelo}**: Lanza la búsqueda de la primera página, si va bien carga la estructura de datos y llama a *onGet{Modelo}Succeded

**onNext{Modelo}**: Lanza la búsqueda de la siguiente página, si va bien agrega la estructura de datos y llama a onGet{Modelo}Succeded

**on{Modelo}FilterChanged**: Modifica el filtro y llama a get{Modelo}

**on{Modelo}ColumnClicked**: Modifica la columna de ordenación y llama a get{Modelo}
**onId{Modelo}Prop**: Cambia el valor de current y llama a onId{Modelo}Changed

**on{Modelo}Clicked**: Navega a la instancia seleccionada con click si hay URL o llama a onId{Modelo}Prop

**reloadOne{Modelo}**: Recarga un registro y lo modifica o incorpora en la estructura de datos. Llama a onReloadOne{Modelo}Succeded

**deleteKey{Modelo}**: Elimina un elemento de la lista y el diccionario, y pone el current a nulo si coincide con el elemento eliminado

### Grapes llamables (signals)
**onGet{Modelo}Succeded**: Es llamada cuando se carga con éxito una página de elementos.

**onId{Modelo}Changed**: Es la llamada cuando se cambio un elemento

**onReloadOne{Modelo}Succeded**: Es la llamada cuando se ha recargado un elemento con éxito


## DetailBuffer
El shortcut de *DetailBuffer* gestiona un registro, tanto en alta como en edición, y sincroniza sus cambios con la lógica del servidor asociada.

### Estado
La estructura que se monta en el estado para un shortcut con name "ejemplo" es:

```json
{
  "ejemplo": {
    "data": {
      "idejemplo": "cat1",
      "dato1": "Categoria 1"
    },
    "buffer": {
      "idejemplo": "cat1",
      "dato1": "Categoria 1"
    }
  }
}
```

### Declaración

Creamos el shortcut indicando:
* **type**: *DetailBiffer*
* **name**: nombre de la clave de estado que representa al registro
* **id**: campo clave del registro
* **schemaName**: Nombre del esquema
* **mode**: (opcional), el valor *insert* especifica que el buffer se usará para inserción
* **deleteConfirmQuestion**: (opcional) textos a mostrar para confirmar el borrado

Ejemplo de fichero UI con detailBuffer
```json
{
  "shortcuts": [
    {
      "type": "DetailBuffer",
      "name": "categoria",
      "id": "idCategoria",
      "schemaName": "categorias",
      "mode": "insert",
      "deleteConfirmQuestion": {
        "titulo": "Borrar categoría",
        "cuerpo": "La categoría se borrará"
      }
    }
  ],
  "state": {},
  "bunch": {}
}
```

### Grapes llamables (slots)
**TO DO{Modelo}**: TO DO

### Grapes llamables (signals)
**onTO DO{Modelo}**: TO DO

### Más

  * [Volver al Índice](./index.md)
