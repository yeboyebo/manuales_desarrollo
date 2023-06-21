# Proyectos y extensiones

Las extensiones son conjuntos de código que implementan una determinada funcionalidad. Una extensión puede depender de una o más extensiones.

Los proyectos son conjuntos de extensiones dirigidos a un cliente en concreto.

## Creación de proyectos y extensiones
Las órdenes de creación están documentadas en el fichero README.md del proyecto Quimera mono.

https://github.com/yeboyebo/quimera-mono/blob/master/README.md

### Soporte para YAML
Para poder usar los ficheros con extensión _yaml_ hay que configurar el proyecto de la siguiente forma:
1. Crear un fichero _webpack.config.js_ con este contenido en la carpeta raíz del proyecto.
    ```js
      const nrwlConfig = require('@nrwl/react/plugins/webpack')

      module.exports = (config, _context) => {
        nrwlConfig(config)

        return {
          ...config,
          module: {
            ...config.module,
            rules: [
              ...config.module.rules,
              {
                test: /\.ya?ml$/,
                use: 'yaml-loader',
              },
            ],
          },
        }
      }
    ```
1. En el fichero _workspace.json_, en la clave asociada al proyecto, cambiar la clave _webpackConfig_ a:
    ```json
    { ...
      "mi_proyecto": {
        ...
        "webpackConfig": "apps/mi_proyecto/webpack.config.js"
      }
    }
    ```

### Más

  * [Volver al Índice](./index.md)
