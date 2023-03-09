# Eneboo tools / Configuración

### Configuración

Ejecutamos una vez
`
	eneboo-assembler dbupdate
	`
Abrimos el fichero ~/.eneboo-tools/assembler-config.ini y añadimos las rutas de las carpeta de modulos y extensiones

```
	[module]
	modulefolders =
		~/ruta_modulos ← Cambiamos esta ruta por la correcta
	featurefolders =
		~/ruta_extensiones ← Cambiamos esta ruta por la correcta
	buildcache = ~/.eneboo-tools/buildcache

	[mergetool]
	patch_qs_rewrite = warn
	patch_qs_style_name = legacy
	verbosity_delta = 0
	patch_xml_style_name = legacy1
	diff_xml_search_move = False
```

Ejecutamos nuevamente. Ahora se indexarán todos los módulos y extensiones disponibles, para porder usarlas en el futuro.
`
	eneboo-assembler dbupdate
	`
Este paso ( **eneboo-assembler dbupdate** ) hay que realizarlo cada vez se añadan/eliminen módulos / extensiones.

### Más

- [Volver al Índice](./index.md)
