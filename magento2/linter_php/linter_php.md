# Linter php (php codesniffer)
PHP_CodeSniffer es un conjunto de dos scripts PHP; el script **phpcs** principal que tokeniza los archivos PHP, JavaScript y CSS para detectar violaciones de un estándar de codificación definido, y un segundo script **phpcbf** para corregir automáticamente las violaciones del estándar de codificación. PHP_CodeSniffer es una herramienta de desarrollo que garantiza que su código permanezca limpio y consistente.

## 1. Instalación
composer global require squizlabs/php_codesniffer

composer require --dev squizlabs/php_codesniffer

## 2. Creación fichero phpcs.xml
Si el proyecto no contiente el fichero phpcs.xml, crear fichero phpcs.xml en la raiz del proyecto con el contenido:

```
<?xml version="1.0"?>
<ruleset name="MyRuleset">
    <!-- Scan all files in directory -->
    <file>.</file>

    <!-- Ignore Composer dependencies -->
    <exclude-pattern>vendor/</exclude-pattern>

    <!-- Show colors in console -->
    <arg value="-colors"/>

    <!-- Show sniff codes in all reports -->
    <arg value="ns"/>

    <!-- Use PSR-12 as a base -->
    <rule ref="PSR12"/>

    <rule ref="Generic.Files.LineLength.TooLong">
        <severity>0</severity>
    </rule>
    <rule ref="PSR2.Methods.MethodDeclaration.Underscore">
        <severity>0</severity>
    </rule>
</ruleset>
```

El listado de reglas: https://gist.github.com/andreyAndrienko/19941c4b621f3212976ae7e47607e864

## 3. Ejecución por consola
Hay dos formas de ejecutar por consola, si la primera no funciona utilizar la segunda.

phpcs **"ruta de archivo o carpeta para realizar la comprobación"** ejemplo app/code/Yeboyebo/Sync/Helper/Data.php

O

vendor/bin/phpcs  **"ruta de archivo o carpeta para realizar la comprobación"** ejemplo app/code/Yeboyebo/Sync/Helper/Data.php

## 4. Extensión vscode
Instalar extensión en vscode:

PHP Sniffer & Beautifier

Para que la extension integre la reglas definidas en el phpcs.xml, en settings.json de la extensión poner:

"phpsab.allowedAutoRulesets": [
	".phpcs.xml",
	".phpcs.xml.dist",
	"phpcs.xml",
	"phpcs.xml.dist",
	"phpcs.ruleset.xml",
	"ruleset.xml"
]

## 5. Formeateo desde extensión vscode
Para formatear desde vscode hay tres opciones:

- F1 -> PHPCBF: Fix this file
- Atajo del teclado alt+shift+f
- Botón derecho context menu Format Document
