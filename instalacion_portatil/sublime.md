# Sublime

Primero descargaremos e instalaremos la clave GPG ejecutando el comando
```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
```

Después nos aseguramos de que https esté instalado en nuestro equipo:
```
sudo apt install apt-transport-https
```

El siguiente paso es añadimos el repositorio de sublime
```
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
```
Con el siguiente comando lo instalamos:
```
sudo apt-get install sublime-text
```

Después debemos establecer algunas configuraciones. Para ello abrimos **Preferences / Settings - User** y copiamos lo siguiente:
```json
{
	"default_encoding": "Western (ISO 8859-15)",
	"detect_indentation": false,
	"file_exclude_patterns":
    [
        ".*",
        "*~",
        "*.pyc",
        "*.pyo",
        "*.exe",
        "*.dll",
        "*.obj",
        "*.o",
        "*.a",
        "*.lib",
        "*.so",
        "*.dylib",
        "*.ncb",
        "*.sdf",
        "*.suo",
        "*.pdb",
        "*.idb",
        ".DS_Store",
        "*.class",
        "*.psd",
        "*.db",
        "*.sublime-workspace",
        "webpack-stats.json",
        "main.js",
        "main.css",
        "xkclient.sh",
        "xkrun.sh",
        "xkend.sh",
        "xktranslate.sh",
        "xkdeploy.sh"
    ],
    "folder_exclude_patterns":
    [
        ".*",
        ".svn",
        ".git",
        ".hg",
        "CVS",
        "bower_components",
        "node_modules",
        "dist-packages",
        "logs",
        "bundles",
        "git/motor",
        "__pycache__"
    ],
	"fallback_encoding": "Western (ISO 8859-15)",
	"show_encoding": true,
	"theme": "Default.sublime-theme",
	"dark_theme": "Adaptive.sublime-theme",
	"light_theme": "Adaptive.sublime-theme",
	"color_scheme": "Monokai.sublime-color-scheme",
	"font_size": 11,
	"ignored_packages":
    [
        "Vintage"
    ],
    "translate_tabs_to_spaces": true,
	"use_tab_stops": true,
    "word_separators": "./\\()\"'-:,.;<>~!@#$%^&*|+=[]{}`~?_",
    "word_wrap": "true",
}
```

  * [Volver al Índice](./index.md)