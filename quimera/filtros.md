# Quimera / Filtros


## FilterBox
TODO


## InfiniteScroll
TODO

## Otros Filtros

Para filtrar texto ignorando acentos, podemos utilizar like_ua:
```sql
["nombre", "like_ua", search]
```
Que automaticamente filtrara como:
```sql
filtro += "UNACCENT(" + left + ")" + " ILIKE UNACCENT('%" + str(right) + "%')"
```