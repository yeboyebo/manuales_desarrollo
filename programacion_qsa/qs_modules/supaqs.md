# SupaQS

## Descripción

SupaQs es un cliente de base de datos que permite simplificar el acceso a BD desde QSA.

## Inicialización

```js
SupaQs = formImport.from("qs_modules/contexts/supaqs/SupaQs.qs");

const client = SupaQs.createClient();
```

En el futuro es posible que la función createClient acepte un connection string y una api key para conectar a bases de datos remotas.

## Descripción de uso

Todos los result son un array de objetos (salvo con el modifier "single"). Cada objeto tiene como clave el nombre de la columna.

Ejemplo:

```js
SupaQs = formImport.from("qs_modules/contexts/supaqs/SupaQs.qs");
const client = SupaQs.createClient();

const result = client.from("flfiles").select("nombre, sha").limit(3).run();

for (row in result) {
  debug("");
  for (column in result[row]) {
    debug("  " + column + ": " + result[row][column]);
  }
}

/*
    Prints:

    ---> 
    --->   nombre: fltestqs.xml
    --->   sha: ABAAEE55C770048FFCF04484926AF04C76DACFCB
    ---> 
    --->   nombre: fltestqs.mod
    --->   sha: FA431B7B26DFF18902495966EB8730B5B46213B7
    ---> 
    --->   nombre: fltestqs.xpm
    --->   sha: 1641C7B44EF5B8450E73C1ACE62506C4060B75F9
*/
```

## API

### Select

```js
// All
const result = client.from("facturascli").select().run();

// Specific columns
const result = client.from("facturascli").select("codigo, codcliente").run();
```

### Filters

Se pueden utilizar tanto en el select, como en update o delete.

Se pueden concatenar e incluso aplicar dentro de un if.

```js
// Igual
const result = client.from("facturascli").select().eq("id", 25).run();

// Distinto
const result = client.from("facturascli").select().neq("id", 25).run();

// Mayor que
const result = client.from("facturascli").select().gt("id", 25).run();

// De igual manera mayor o igual que (gte), menor que (lt) y menor o igual que (lte)

// Like
const result = client
  .from("facturascli")
  .select()
  .like("codigo", "%0A000%")
  .run();

// De igual manera Like case-insensitive (ilike)

// Is
const result = client.from("articulos").select().is("sevende", "false").run();

// De igual manera sirve para null y booleanos

// Includes
const result = client
  .from("facturascli")
  .select()
  .includes("codimpuesto", ["RED", "SRED"])
  .run();

// Match (Para queries complejas que utilizan varios "eq")
const result = client
  .from("facturascli")
  .select()
  .match({
    codigo: "20230A000001",
    codcliente: "256420",
  })
  .run();
```

### Modifiers

```js
// Order
const result = client
  .from("facturascli")
  .select()
  .order("codigo", { ascending: true })
  .run();

// Limit
const result = client.from("facturascli").select().limit(10).run();

// Range (offset, limit)
const result = client.from("facturascli").select().range(10, 20).run();

// Single (primer resultado como objeto en lugar de array de objetos)
const result = client.from("facturascli").select().single().run();
```

### Insert

```js
client
  .from("facturascli")
  .insert({ id: 456789, codigo: "20230A000001", codcliente: "256420" })
  .run();
```

### Update

```js
client
  .from("facturascli")
  .update({ codigo: "20230A000002" })
  .eq("id", 456789)
  .run();
```

### Upsert

Intenta crear el registro y si ya existe, lo modifica. Es necesario incluir la clave primaria.

```js
client
  .from("facturascli")
  .upsert({ id: 456780, codigo: "20230A000002", codcliente: "256420" })
  .run();
```

### Delete One

```js
client.from("facturascli").deleteOne().eq("id", 456789).run();
```

### Delete Many

```js
client.from("facturascli").deleteMany().gt("id", 456000).run();
```

- [Volver al índice](./index.md)
