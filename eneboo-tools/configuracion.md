# Eneboo tools / Configuración

### Configuración

Ejecutamos una vez
`
	eneboo-assembler dbupdate
	`
Abrimos el fichero ~/.eneboo-tools/assembler-config.ini y añadimos las rutas de las carpeta de modulos y extensiones

```ini
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

Ejemplo (suponiendo _codebase_ en nuestro home):

```ini
[module]
modulefolders =
	~/codebase/modulos_yby
	~/codebase/modulos_mon
	~/codebase/modulos_eur
	~/codebase/modulos_otros
	~/codebase/modulos_2.4.0
	~/codebase/modulos_2.5.0

featurefolders =
	~/codebase/extensiones_aulla
	~/codebase/extensiones_2.4.0
	~/codebase/extensiones_2.5.0
buildcache = ~/.eneboo-tools/buildcache

[mergetool]
patch_qs_rewrite = warn
patch_xml_style_name = legacy1
patch_qs_style_name = legacy
diff_xml_search_move = False
verbosity_delta = 0
```
¡OJO!. En caso de existir un módulo en 2 carpeta diferentes , siempre recojerá la copia de la carpeta que se ha declarado mas tarde. Si queremos recoger una copia previa, tendremos que especificar en required_modules el nombre de la carpeta (ejemplo modulos_mon/prueba/prueba).

Ejecutamos nuevamente. Ahora se indexarán todos los módulos y extensiones disponibles, para porder usarlas en el futuro.
`
	eneboo-assembler dbupdate
	`
Este paso ( **eneboo-assembler dbupdate** ) hay que realizarlo cada vez se añadan/eliminen módulos / extensiones.

### Más

- [Volver al Índice](./index.md)
