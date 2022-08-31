# Quimera / Componentes

Hemos creado distintos componentes para homogeneizar las páginas de quimera y ahorrar trabajo de desarrollo.

## QBox
[to do]

## QListModel
Crea una lista de items de tipo *ItemComponent* basada en una estructura (*data*) que contiene un diccionario y un array.

La propiedad *modelName* se usa para generar nombres de acciones a llamar (p.e. *onModelNameItemChanged*).

```html
<QListModel data={pedidos} modelName='pedidos' ItemComponent={ListItemMisPedidos}
>
```

### Más

  * [Volver al Índice](./index.md)
